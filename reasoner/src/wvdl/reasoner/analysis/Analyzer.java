package wvdl.reasoner.analysis;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import wvdl.reasoner.analysis.Finding.Severity;
import wvdl.reasoner.model.WfModel;
import wvdl.reasoner.model.WfModel.Activity;
import wvdl.reasoner.model.WfModel.State;
import wvdl.reasoner.model.WfModel.Transition;

/**
 * Razonador de WVDL.
 *
 * Fase 1 (semántica estática): integridad I1–I3, estados finales absorbentes,
 * T-ROLE y reglas de tipos de las guardas. Si hay errores, el modelo es
 * inválido y la fase 2 no se ejecuta.
 *
 * Fase 2 (verificación): el Workflow se interpreta como el autómata finito
 * M = (S, Σ, δ, s₀, F), donde Σ son las transiciones con guarda satisfacible.
 * <pre>
 *   Reach   = μX. {s₀} ∪ post(X)        (BFS desde s₀)
 *   CoReach = μX. F ∪ pre(X)            (BFS multi-fuente sobre el grafo inverso)
 *   Trapped = Reach \ CoReach
 *   Deadlock(s) ⇔ s ∈ Reach \ F ∧ post({s}) = ∅
 *   Livelock    = SCC no trivial C ⊆ Trapped   (Tarjan)
 *   L(M) = ∅    ⇔ F ∩ Reach = ∅
 * </pre>
 * Todo en O(|S| + |T|) salvo la satisfacibilidad de guardas (ver GuardSolver).
 */
public final class Analyzer {

  /** Resultado completo del análisis (también alimenta el reporte JSON). */
  public static final class Result {
    public final WfModel model;
    public final List<Finding> findings = new ArrayList<>();
    public boolean staticallyValid;
    public State initial;
    public final Set<State> reachable = new LinkedHashSet<>();
    public final Set<State> coReachable = new LinkedHashSet<>();
    public final Set<State> trapped = new LinkedHashSet<>();
    public final Set<State> deadlocks = new LinkedHashSet<>();
    public final List<List<State>> livelocks = new ArrayList<>();
    public final Set<Transition> deadTransitions = new LinkedHashSet<>();
    /** Ruta más corta (BFS) desde s₀ hasta cada estado final alcanzable. */
    public final Map<State, List<Transition>> pathsToFinals = new LinkedHashMap<>();
    /** Actores habilitados por actividad (inferencia por asignaciones de rol). */
    public final Map<Activity, List<WfModel.Actor>> actorsByActivity = new LinkedHashMap<>();
    public Simulator.Trace simulation;
    public final List<CheckResult> checkResults = new ArrayList<>();

    Result(WfModel m) { model = m; }

    public boolean hasErrors() { for (Finding f : findings) if (f.severity == Severity.ERROR) return true; return false; }
    public boolean hasWarnings() { for (Finding f : findings) if (f.severity == Severity.WARNING) return true; return false; }
    public String status() { return hasErrors() ? "INVALID" : hasWarnings() ? "WARNING" : "VALID"; }

    /** Hallazgos asociados a un nodo de origen concreto. */
    public List<Finding> findingsFor(Object origin) {
      List<Finding> r = new ArrayList<>();
      for (Finding f : findings) if (f.origin == origin) r.add(f);
      return r;
    }
    public Set<State> useful() { Set<State> u = new LinkedHashSet<>(reachable); u.retainAll(coReachable); return u; }
  }

  private Analyzer() {}

  public static Result analyze(WfModel m) {
    Result r = new Result(m);
    staticChecks(m, r);
    r.staticallyValid = !r.hasErrors();
    if (r.staticallyValid) verify(m, r);
    Collections.sort(r.findings);
    return r;
  }

  // ------------------------------------------------------------------ fase 1
  private static void staticChecks(WfModel m, Result r) {
    List<Finding> out = r.findings;
    // I1: exactamente un estado inicial
    List<State> initials = new ArrayList<>();
    for (State s : m.states) if (s.kind == WfModel.StateKind.INITIAL) initials.add(s);
    if (initials.isEmpty()) {
      out.add(new Finding("WF-NO-INITIAL", Severity.ERROR, m.name, m.origin, "el workflow " + m.name + " no tiene estado inicial (I1)", false));
    } else {
      r.initial = initials.get(0);
      for (int i = 1; i < initials.size(); i++) {
        State s = initials.get(i);
        out.add(new Finding("WF-MULTIPLE-INITIAL", Severity.ERROR, s.name, s.origin, "solo puede haber un estado inicial; " + r.initial.name + " ya lo es (I1)", false));
      }
    }
    // I2: al menos un estado final
    boolean anyFinal = false;
    for (State s : m.states) anyFinal |= s.isFinal();
    if (!anyFinal) out.add(new Finding("WF-NO-FINAL", Severity.ERROR, m.name, m.origin, "el workflow " + m.name + " no tiene estados finales (I2)", false));
    // I3: nombres únicos por espacio de nombres
    unique(m.states, out);
    unique(m.roles, out);
    unique(m.actors, out);
    unique(m.activities, out);
    unique(m.variables, out);
    unique(m.transitions, out);
    // asignaciones duplicadas
    Set<String> seen = new HashSet<>();
    for (WfModel.Assignment a : m.assignments) {
      if (a.actor == null || a.role == null) continue;
      if (!seen.add(a.actor.name + "\u0000" + a.role.name))
        out.add(new Finding("WF-DUPLICATE-ASSIGNMENT", Severity.WARNING, a.name, a.origin, "el actor " + a.actor.name + " ya tiene asignado el rol " + a.role.name, false));
    }
    // referencias fuera de alcance (scoping): apuntan a elementos de otro workflow
    Set<Object> foreignOrigins = new HashSet<>();
    for (int i = 0; i < m.foreignRefs.size(); i++) {
      String[] fr = m.foreignRefs.get(i);
      Object origin = m.foreignRefOrigins.get(i);
      foreignOrigins.add(origin);
      out.add(new Finding("WF-OUT-OF-SCOPE", Severity.ERROR, fr[0], origin, fr[0] + " referencia a '" + fr[1] + "', que no está declarado en el workflow " + m.name + " (fuera de alcance)", false));
    }
    // transiciones: completas y finales absorbentes
    for (Transition t : m.transitions) {
      if (t.source == null || t.target == null) {
        if (foreignOrigins.contains(t.origin)) continue;
        out.add(new Finding("WF-INCOMPLETE-TRANSITION", Severity.ERROR, t.name, t.origin, "la transición " + t.name + " necesita origen y destino", false));
        continue;
      }
      if (t.source.isFinal())
        out.add(new Finding("WF-FINAL-SOURCE", Severity.ERROR, t.name, t.origin, "la transición " + t.name + " sale del estado final " + t.source.name + "; los estados finales son absorbentes", false));
    }
    // T-ROLE: compatibilidad actividad–rol
    for (Activity a : m.activities) {
      if (a.role == null) continue;
      if (a.kind == WfModel.ActivityKind.MANUAL && a.role.kind != WfModel.RoleKind.HUMAN)
        out.add(new Finding("T-ROLE", Severity.ERROR, a.name, a.origin, "la actividad manual " + a.name + " requiere un rol humano, pero " + a.role.name + " es un rol de sistema", false));
      if (a.kind == WfModel.ActivityKind.AUTOMATED && a.role.kind != WfModel.RoleKind.SYSTEM)
        out.add(new Finding("T-ROLE", Severity.ERROR, a.name, a.origin, "la actividad automática " + a.name + " requiere un rol de sistema, pero " + a.role.name + " es un rol humano", false));
    }
    // Tipos: T-INIT y T-GUARD (más T-EQ, T-LT, T-AND, T-OR, T-NOT dentro de las expresiones)
    TypeChecker tc = new TypeChecker(out);
    for (WfModel.Variable v : m.variables) tc.checkInit(v.init, v.type, v.origin, v.name);
    for (Transition t : m.transitions) if (t.guard != null) tc.checkGuard(t.guard, t.guardOrigin, t.name);
  }

  private static void unique(List<? extends WfModel.Element> els, List<Finding> out) {
    Map<String, WfModel.Element> first = new HashMap<>();
    for (WfModel.Element e : els) {
      if (e.name.isEmpty()) continue;
      WfModel.Element prev = first.putIfAbsent(e.name, e);
      if (prev != null)
        out.add(new Finding("WF-DUPLICATE-NAME", Severity.ERROR, e.name, e.origin, "ya existe " + prev.kindLabel() + " con el nombre '" + e.name + "' (I3)", false));
    }
  }

  // ------------------------------------------------------------------ fase 2
  private static void verify(WfModel m, Result r) {
    List<Finding> out = r.findings;
    // Σ: transiciones con guarda satisfacible
    Map<State, List<Transition>> post = new IdentityHashMap<>(), pre = new IdentityHashMap<>(), allOut = new IdentityHashMap<>();
    for (State s : m.states) { post.put(s, new ArrayList<>()); pre.put(s, new ArrayList<>()); allOut.put(s, new ArrayList<>()); }
    for (Transition t : m.transitions) {
      allOut.get(t.source).add(t);
      GuardSolver.Result sat = GuardSolver.satisfiable(t.guard);
      if (sat == GuardSolver.Result.UNSAT) {
        r.deadTransitions.add(t);
        out.add(new Finding("WF-DEAD-GUARD", Severity.WARNING, t.name, t.guardOrigin != null ? t.guardOrigin : t.origin,
            "la guarda de " + t.name + " es insatisfacible (" + t.guard + "); la transición nunca se habilita", true));
        continue;
      }
      post.get(t.source).add(t);
      pre.get(t.target).add(t);
    }

    // Reach: BFS desde s₀, guardando el padre para reconstruir rutas
    Map<State, Transition> parent = new IdentityHashMap<>();
    Deque<State> q = new ArrayDeque<>();
    r.reachable.add(r.initial);
    q.add(r.initial);
    while (!q.isEmpty()) {
      State s = q.poll();
      for (Transition t : post.get(s)) if (r.reachable.add(t.target)) { parent.put(t.target, t); q.add(t.target); }
    }
    // CoReach: BFS multi-fuente desde F sobre el grafo inverso
    for (State s : m.states) if (s.isFinal()) { r.coReachable.add(s); q.add(s); }
    while (!q.isEmpty()) {
      State s = q.poll();
      for (Transition t : pre.get(s)) if (r.coReachable.add(t.source)) q.add(t.source);
    }

    // Estados inalcanzables
    for (State s : m.states) if (!r.reachable.contains(s))
      out.add(new Finding("WF-UNREACHABLE", Severity.WARNING, s.name, s.origin, "el estado " + s.name + " no es alcanzable desde " + r.initial.name, true));

    // Deadlocks
    for (State s : r.reachable) if (!s.isFinal() && post.get(s).isEmpty()) {
      r.deadlocks.add(s);
      String why = allOut.get(s).isEmpty() ? "no tiene transiciones de salida" : "todas sus transiciones de salida tienen guardas insatisfacibles";
      out.add(new Finding("WF-DEADLOCK", Severity.ERROR, s.name, s.origin, "bloqueo: " + s.name + " es alcanzable, no es final y " + why, true));
    }

    // Trapped y livelocks (Tarjan sobre el subgrafo inducido por Trapped)
    for (State s : r.reachable) if (!r.coReachable.contains(s)) r.trapped.add(s);
    Set<State> inLivelock = new HashSet<>();
    for (List<State> scc : tarjan(r.trapped, post)) {
      boolean selfLoop = false;
      if (scc.size() == 1) for (Transition t : post.get(scc.get(0))) selfLoop |= t.target == scc.get(0);
      if (scc.size() > 1 || selfLoop) {
        r.livelocks.add(scc);
        inLivelock.addAll(scc);
        StringBuilder names = new StringBuilder();
        for (State s : scc) names.append(names.length() == 0 ? "" : ", ").append(s.name);
        for (State s : scc)
          out.add(new Finding("WF-LIVELOCK", Severity.ERROR, s.name, s.origin, "livelock: " + s.name + " pertenece al ciclo {" + names + "} del que no se puede llegar a un estado final", true));
      }
    }
    for (State s : r.trapped) if (!r.deadlocks.contains(s) && !inLivelock.contains(s))
      out.add(new Finding("WF-TRAPPED", Severity.WARNING, s.name, s.origin, "desde " + s.name + " no se puede llegar a ningún estado final", true));

    // L(M) = ∅
    boolean finalReachable = false;
    for (State s : r.reachable) finalReachable |= s.isFinal();
    if (!finalReachable)
      out.add(new Finding("WF-NO-TERMINATION", Severity.ERROR, m.name, m.origin, "ningún estado final es alcanzable desde " + r.initial.name + " (L(M) = ∅)", true));

    // Rutas más cortas hasta cada final alcanzable
    for (State s : m.states) if (s.isFinal() && r.reachable.contains(s)) {
      List<Transition> path = new ArrayList<>();
      for (State c = s; parent.containsKey(c); c = parent.get(c).source) path.add(0, parent.get(c));
      r.pathsToFinals.put(s, path);
    }

    // Inferencia de actores habilitados y roles sin actor
    Set<Activity> live = new LinkedHashSet<>();
    for (Transition t : m.transitions) if (t.activity != null && r.reachable.contains(t.source) && !r.deadTransitions.contains(t)) live.add(t.activity);
    for (Activity a : m.activities) {
      List<WfModel.Actor> actors = new ArrayList<>();
      for (WfModel.Assignment as : m.assignments) if (as.role == a.role && as.actor != null && !actors.contains(as.actor)) actors.add(as.actor);
      r.actorsByActivity.put(a, actors);
      if (live.contains(a) && a.role != null && actors.isEmpty())
        out.add(new Finding("WF-UNASSIGNED-ROLE", Severity.WARNING, a.name, a.origin, "ningún actor tiene el rol " + a.role.name + ", necesario para la actividad " + a.name, true));
    }

    r.simulation = Simulator.run(m, r.initial, Simulator.DEFAULT_MAX_STEPS);

    // Verificaciones declaradas por el usuario: cada una se contrasta con lo inferido
    for (WfModel.Check c : m.checks) {
      String inferred;
      boolean pass;
      switch (c.kind) {
        case REACHABLE:
          pass = c.state != null && r.reachable.contains(c.state);
          inferred = c.state == null ? "?" : (pass ? "alcanzable" : "no alcanzable") + " desde " + r.initial.name;
          break;
        case SOUND:
          pass = r.trapped.isEmpty() && !r.pathsToFinals.isEmpty();
          inferred = pass ? "sound" : "no sound (estados sin terminación: " + names(r.trapped) + ")";
          break;
        case PATH: {
          List<Transition> p = c.state == null ? null : r.pathsToFinals.containsKey(c.state) ? r.pathsToFinals.get(c.state) : shortestPath(r, post, c.state);
          pass = p != null && p.equals(c.steps);
          inferred = p == null ? "sin ruta" : "ruta más corta " + transitionNames(p);
          break;
        }
        case ACTORS: {
          List<WfModel.Actor> got = c.activity == null ? List.of() : r.actorsByActivity.getOrDefault(c.activity, List.of());
          pass = c.activity != null && new HashSet<>(got).equals(new HashSet<>(c.actors)) && !c.actors.contains(null);
          inferred = "actores inferidos " + names(got);
          break;
        }
        default:
          pass = c.state != null && r.simulation.last == c.state;
          inferred = "la simulación termina en " + r.simulation.last.name + " (" + r.simulation.outcome + ")";
      }
      r.checkResults.add(new CheckResult(c, pass, inferred));
      if (!pass)
        out.add(new Finding("WF-CHECK-FAILED", Severity.ERROR, c.describe(), c.origin, "la verificación '" + c.describe() + "' no se cumple: " + inferred, true));
    }
  }

  /** Resultado de una verificación declarada. */
  public static final class CheckResult {
    public final WfModel.Check check;
    public final boolean pass;
    public final String inferred;
    CheckResult(WfModel.Check c, boolean p, String i) { check = c; pass = p; inferred = i; }
  }

  /** BFS desde s₀ hasta {@code goal}; null si no es alcanzable. */
  private static List<Transition> shortestPath(Result r, Map<State, List<Transition>> post, State goal) {
    Map<State, Transition> parent = new IdentityHashMap<>();
    Set<State> seen = new HashSet<>();
    Deque<State> q = new ArrayDeque<>();
    seen.add(r.initial); q.add(r.initial);
    while (!q.isEmpty()) {
      State s = q.poll();
      if (s == goal) break;
      for (Transition t : post.get(s)) if (seen.add(t.target)) { parent.put(t.target, t); q.add(t.target); }
    }
    if (!seen.contains(goal)) return null;
    List<Transition> path = new ArrayList<>();
    for (State c = goal; parent.containsKey(c); c = parent.get(c).source) path.add(0, parent.get(c));
    return path;
  }

  private static String names(Iterable<? extends WfModel.Element> els) {
    List<String> n = new ArrayList<>();
    for (WfModel.Element e : els) n.add(e.name);
    n.sort(null);
    return "{" + String.join(", ", n) + "}";
  }

  private static String transitionNames(List<Transition> p) {
    List<String> n = new ArrayList<>();
    for (Transition t : p) n.add(t.name);
    return String.join(",", n);
  }

  /** Tarjan iterativo restringido a {@code nodes}; devuelve las SCC en orden de descubrimiento. */
  static List<List<State>> tarjan(Set<State> nodes, Map<State, List<Transition>> post) {
    Map<State, Integer> index = new IdentityHashMap<>(), low = new IdentityHashMap<>();
    Deque<State> stack = new ArrayDeque<>();
    Set<State> onStack = new HashSet<>();
    List<List<State>> sccs = new ArrayList<>();
    int[] counter = {0};
    for (State root : nodes) {
      if (index.containsKey(root)) continue;
      // pila explícita de (estado, siguiente arista)
      Deque<Object[]> work = new ArrayDeque<>();
      work.push(new Object[]{root, 0});
      index.put(root, counter[0]); low.put(root, counter[0]); counter[0]++;
      stack.push(root); onStack.add(root);
      while (!work.isEmpty()) {
        Object[] frame = work.peek();
        State v = (State) frame[0];
        int i = (Integer) frame[1];
        List<Transition> outs = post.get(v);
        if (i < outs.size()) {
          frame[1] = i + 1;
          State w = outs.get(i).target;
          if (!nodes.contains(w)) continue;
          if (!index.containsKey(w)) {
            index.put(w, counter[0]); low.put(w, counter[0]); counter[0]++;
            stack.push(w); onStack.add(w);
            work.push(new Object[]{w, 0});
          } else if (onStack.contains(w)) low.put(v, Math.min(low.get(v), index.get(w)));
        } else {
          work.pop();
          if (!work.isEmpty()) { State u = (State) work.peek()[0]; low.put(u, Math.min(low.get(u), low.get(v))); }
          if (low.get(v).equals(index.get(v))) {
            List<State> scc = new ArrayList<>();
            State w;
            do { w = stack.pop(); onStack.remove(w); scc.add(0, w); } while (w != v);
            sccs.add(scc);
          }
        }
      }
    }
    return sccs;
  }
}
