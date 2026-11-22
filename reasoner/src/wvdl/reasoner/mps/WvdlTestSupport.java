package wvdl.reasoner.mps;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.jetbrains.mps.openapi.model.SNode;
import wvdl.reasoner.analysis.Analyzer;
import wvdl.reasoner.analysis.Finding;
import wvdl.reasoner.analysis.Simulator;
import wvdl.reasoner.model.WfModel;

/**
 * Vistas textuales del resultado del razonador, usadas por las pruebas
 * jetbrains.mps.lang.test (assertEquals sobre inferencias y propiedades).
 */
public final class WvdlTestSupport {
  private WvdlTestSupport() {}

  private static Analyzer.Result r(SNode wf) { return WvdlChecks.analyze(wf); }

  private static String join(Iterable<? extends WfModel.Element> els) {
    List<String> names = new ArrayList<>();
    for (WfModel.Element e : els) names.add(e.name);
    names.sort(null);
    return String.join(", ", names);
  }

  /** VALID, WARNING o INVALID. */
  public static String status(SNode wf) { return r(wf).status(); }

  /** Códigos de los hallazgos con su elemento, p. ej. "WF-DEADLOCK@Espera, WF-UNREACHABLE@Fin". */
  public static String findings(SNode wf) {
    List<String> fs = new ArrayList<>();
    for (Finding f : r(wf).findings) fs.add(f.code + "@" + f.element);
    fs.sort(null);
    return String.join(", ", fs);
  }

  public static String reach(SNode wf) { return join(r(wf).reachable); }
  public static String coReach(SNode wf) { return join(r(wf).coReachable); }
  public static String trapped(SNode wf) { return join(r(wf).trapped); }
  public static String useful(SNode wf) { return join(r(wf).useful()); }
  public static String deadlocks(SNode wf) { return join(r(wf).deadlocks); }

  /** Componentes de livelock, p. ej. "{Correccion, Revision}". */
  public static String livelocks(SNode wf) {
    List<String> out = new ArrayList<>();
    for (List<WfModel.State> scc : r(wf).livelocks) out.add("{" + join(scc) + "}");
    out.sort(null);
    return String.join(" ", out);
  }

  /** Ruta más corta (nombres de transiciones) desde el inicial hasta el final indicado. */
  public static String path(SNode wf, String finalState) {
    for (Map.Entry<WfModel.State, List<WfModel.Transition>> e : r(wf).pathsToFinals.entrySet()) {
      if (!e.getKey().name.equals(finalState)) continue;
      List<String> ts = new ArrayList<>();
      for (WfModel.Transition t : e.getValue()) ts.add(t.name);
      return String.join(",", ts);
    }
    return "<sin ruta>";
  }

  /** Actores habilitados para una actividad (inferidos por asignación de rol). */
  public static String actors(SNode wf, String activity) {
    for (Map.Entry<WfModel.Activity, List<WfModel.Actor>> e : r(wf).actorsByActivity.entrySet())
      if (e.getKey().name.equals(activity)) return join(e.getValue());
    return "<sin actividad>";
  }

  /** Traza de la simulación determinista, p. ej. "Inicio -T1-> Revision [FINAL_REACHED]". */
  public static String simulation(SNode wf) {
    Simulator.Trace tr = r(wf).simulation;
    if (tr == null) return "<no simulado>";
    StringBuilder sb = new StringBuilder();
    sb.append(tr.steps.isEmpty() ? tr.last.name : tr.steps.get(0).from.name);
    for (Simulator.Step s : tr.steps) sb.append(" -").append(s.via.name).append("-> ").append(s.to.name);
    return sb.append(" [").append(tr.outcome).append("]").toString();
  }

  /** true si el workflow es sound: Trapped = ∅ y algún final es alcanzable. */
  public static String sound(SNode wf) {
    Analyzer.Result res = r(wf);
    return String.valueOf(res.staticallyValid && res.trapped.isEmpty() && !res.pathsToFinals.isEmpty());
  }
}
