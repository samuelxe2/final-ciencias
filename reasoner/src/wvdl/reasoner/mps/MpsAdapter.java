package wvdl.reasoner.mps;

import java.util.ArrayList;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;
import org.jetbrains.mps.openapi.language.SAbstractConcept;
import org.jetbrains.mps.openapi.language.SConcept;
import org.jetbrains.mps.openapi.language.SContainmentLink;
import org.jetbrains.mps.openapi.language.SInterfaceConcept;
import org.jetbrains.mps.openapi.model.SNode;
import wvdl.reasoner.model.Expr;
import wvdl.reasoner.model.Type;
import wvdl.reasoner.model.WfModel;

/** Traduce el AST de MPS (SNode) al modelo plano del razonador. */
public final class MpsAdapter {
  private MpsAdapter() {}

  /** ¿El concepto del nodo es {@code name} o lo extiende/implementa? */
  public static boolean is(SNode n, String name) {
    return n != null && conceptIs(n.getConcept(), name, 0);
  }

  private static boolean conceptIs(SAbstractConcept c, String name, int depth) {
    if (c == null || depth > 32) return false;
    if (name.equals(c.getName())) return true;
    if (c instanceof SConcept) {
      SConcept sc = (SConcept) c;
      if (conceptIs(sc.getSuperConcept(), name, depth + 1)) return true;
      for (SInterfaceConcept i : sc.getSuperInterfaces()) if (conceptIs(i, name, depth + 1)) return true;
    } else if (c instanceof SInterfaceConcept) {
      for (SInterfaceConcept i : ((SInterfaceConcept) c).getSuperInterfaces()) if (conceptIs(i, name, depth + 1)) return true;
    }
    return false;
  }

  /** El Workflow que contiene al nodo (o el propio nodo), o null. */
  public static SNode workflowOf(SNode n) {
    for (SNode c = n; c != null; c = c.getParent()) if (is(c, "Workflow")) return c;
    return null;
  }

  public static List<SNode> children(SNode n, String role) {
    List<SNode> r = new ArrayList<>();
    if (n == null) return r;
    for (SNode c : n.getChildren()) {
      SContainmentLink l = c.getContainmentLink();
      if (l != null && role.equals(l.getName())) r.add(c);
    }
    return r;
  }

  public static SNode child(SNode n, String role) {
    List<SNode> cs = children(n, role);
    return cs.isEmpty() ? null : cs.get(0);
  }

  public static SContainmentLink link(SNode n, String role) {
    for (SContainmentLink l : n.getConcept().getContainmentLinks()) if (role.equals(l.getName())) return l;
    return null;
  }

  @SuppressWarnings("deprecation")
  public static String prop(SNode n, String name) { return n == null ? null : n.getProperty(name); }

  @SuppressWarnings("deprecation")
  public static SNode ref(SNode n, String role) { return n == null ? null : n.getReferenceTarget(role); }

  /** Resultado de la traducción: el modelo y el mapa nodo → elemento. */
  public static final class Built {
    public final WfModel model;
    final Map<SNode, Object> elements = new IdentityHashMap<>();
    Built(WfModel m) { model = m; }
  }

  public static Built build(SNode wf) {
    Built b = new Built(new WfModel(prop(wf, "name"), wf));
    WfModel m = b.model;
    for (SNode s : children(wf, "states")) {
      WfModel.StateKind k = is(s, "InitialState") ? WfModel.StateKind.INITIAL : is(s, "FinalState") ? WfModel.StateKind.FINAL : WfModel.StateKind.ORDINARY;
      put(b, s, new WfModel.State(prop(s, "name"), k, s), m.states);
    }
    for (SNode r : children(wf, "roles"))
      put(b, r, new WfModel.Role(prop(r, "name"), is(r, "SystemRole") ? WfModel.RoleKind.SYSTEM : WfModel.RoleKind.HUMAN, r), m.roles);
    for (SNode a : children(wf, "actors")) put(b, a, new WfModel.Actor(prop(a, "name"), a), m.actors);
    for (SNode a : children(wf, "assignments"))
      put(b, a, new WfModel.Assignment((WfModel.Actor) local(b, a, ref(a, "actor")), (WfModel.Role) local(b, a, ref(a, "role")), a), m.assignments);
    for (SNode v : children(wf, "variables")) {
      SNode t = child(v, "type");
      Type ty = t == null ? null : is(t, "BooleanType") ? Type.BOOLEAN : is(t, "IntegerType") ? Type.INTEGER : is(t, "StringType") ? Type.STRING : null;
      // el valor inicial puede referir variables previas, por eso se traduce en orden
      WfModel.Variable var = new WfModel.Variable(prop(v, "name"), ty, expr(b, child(v, "init")), v);
      put(b, v, var, m.variables);
    }
    for (SNode a : children(wf, "activities")) {
      WfModel.ActivityKind k = is(a, "AutomatedActivity") ? WfModel.ActivityKind.AUTOMATED : WfModel.ActivityKind.MANUAL;
      put(b, a, new WfModel.Activity(prop(a, "name"), k, (WfModel.Role) local(b, a, ref(a, "role")), a), m.activities);
    }
    for (SNode t : children(wf, "transitions")) {
      WfModel.State src = (WfModel.State) local(b, t, ref(child(t, "from"), "state"));
      WfModel.State dst = (WfModel.State) local(b, t, ref(child(t, "to"), "state"));
      WfModel.Activity act = (WfModel.Activity) local(b, t, ref(child(t, "via"), "activity"));
      SNode g = child(t, "guard");
      Expr cond = g == null ? null : expr(b, child(g, "condition"));
      put(b, t, new WfModel.Transition(prop(t, "name"), src, dst, act, cond, g, t), m.transitions);
    }
    for (SNode c : children(wf, "checks")) {
      WfModel.Check.Kind k = is(c, "ReachableCheck") ? WfModel.Check.Kind.REACHABLE : is(c, "SoundCheck") ? WfModel.Check.Kind.SOUND
          : is(c, "PathCheck") ? WfModel.Check.Kind.PATH : is(c, "ActorsCheck") ? WfModel.Check.Kind.ACTORS : WfModel.Check.Kind.SIMULATION;
      WfModel.Check chk = new WfModel.Check(k, (WfModel.State) local(b, c, ref(c, "state")), (WfModel.Activity) local(b, c, ref(c, "activity")), c);
      for (SNode s : children(c, "steps")) chk.steps.add((WfModel.Transition) local(b, c, ref(s, "transition")));
      for (SNode a : children(c, "actors")) chk.actors.add((WfModel.Actor) local(b, c, ref(a, "actor")));
      m.checks.add(chk);
    }
    return b;
  }

  private static <E> void put(Built b, SNode n, E e, List<E> list) { b.elements.put(n, e); list.add(e); }

  private static Object el(Built b, SNode n) { return n == null ? null : b.elements.get(n); }

  /** Resuelve una referencia de {@code owner}; si apunta fuera del workflow la registra como fuera de alcance. */
  private static Object local(Built b, SNode owner, SNode target) {
    Object e = el(b, target);
    if (e == null && target != null && workflowOf(target) != b.model.origin) {
      String who = prop(owner, "name");
      b.model.addForeignRef(owner, who == null ? owner.getConcept().getName() : who, prop(target, "name"));
    }
    return e;
  }

  static Expr expr(Built b, SNode e) {
    if (e == null) return null;
    if (is(e, "BoolLiteral")) return new Expr.BoolLit("true".equals(prop(e, "value")), e);
    if (is(e, "IntLiteral")) {
      long v = 0;
      try { String s = prop(e, "value"); if (s != null) v = Long.parseLong(s.trim()); } catch (NumberFormatException ignored) { }
      return new Expr.IntLit(v, e);
    }
    if (is(e, "StringLiteral")) return new Expr.StrLit(prop(e, "value"), e);
    if (is(e, "VarRef")) return new Expr.VarRef((WfModel.Variable) local(b, e, ref(e, "variable")), e);
    if (is(e, "NotExpr")) return new Expr.Not(expr(b, child(e, "operand")), e);
    Expr.Op op = is(e, "EqExpr") ? Expr.Op.EQ : is(e, "LtExpr") ? Expr.Op.LT : is(e, "AndExpr") ? Expr.Op.AND : is(e, "OrExpr") ? Expr.Op.OR : null;
    if (op == null) return null;
    return new Expr.Binary(op, expr(b, child(e, "left")), expr(b, child(e, "right")), e);
  }
}
