package wvdl.reasoner.report;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import wvdl.reasoner.analysis.Analyzer;
import wvdl.reasoner.analysis.Finding;
import wvdl.reasoner.analysis.Simulator;
import wvdl.reasoner.model.WfModel;

/**
 * Reporte JSON determinista del razonador: mismas entradas producen
 * exactamente el mismo texto (colecciones ordenadas por nombre).
 */
public final class JsonReport {
  private JsonReport() {}

  public static String render(Analyzer.Result r) {
    WfModel m = r.model;
    J j = new J();
    j.open('{');
    j.key("workflow").str(m.name);
    j.key("status").str(r.status());
    j.key("staticallyValid").raw(String.valueOf(r.staticallyValid));
    j.key("summary").open('{');
    j.key("states").num(m.states.size());
    j.key("transitions").num(m.transitions.size());
    j.key("activities").num(m.activities.size());
    j.key("roles").num(m.roles.size());
    j.key("actors").num(m.actors.size());
    j.key("variables").num(m.variables.size());
    if (r.staticallyValid) {
      j.key("reachableStates").num(r.reachable.size());
      j.key("usefulStates").num(r.useful().size());
      j.key("finalStates").num((int) m.states.stream().filter(WfModel.State::isFinal).count());
      j.key("deadTransitions").num(r.deadTransitions.size());
    }
    j.close('}');

    j.key("findings").open('[');
    for (Finding f : r.findings) {
      j.item().open('{');
      j.key("code").str(f.code);
      j.key("severity").str(f.severity.name());
      j.key("phase").str(f.fromReasoner ? "reasoner" : "static");
      j.key("element").str(f.element);
      j.key("message").str(f.message);
      j.close('}');
    }
    j.close(']');

    if (r.staticallyValid) {
      j.key("properties").open('{');
      j.key("initialState").str(r.initial.name);
      j.key("reach").strs(names(r.reachable));
      j.key("coReach").strs(names(r.coReachable));
      j.key("trapped").strs(names(r.trapped));
      j.key("deadlocks").strs(names(r.deadlocks));
      j.key("livelocks").open('[');
      List<List<String>> ll = new ArrayList<>();
      for (List<WfModel.State> scc : r.livelocks) ll.add(names(scc));
      ll.sort(Comparator.comparing(Object::toString));
      for (List<String> scc : ll) j.item().strs(scc);
      j.close(']');
      j.key("finalReachable").raw(String.valueOf(!r.pathsToFinals.isEmpty()));
      j.key("sound").raw(String.valueOf(r.trapped.isEmpty() && !r.pathsToFinals.isEmpty()));
      j.close('}');

      j.key("inferred").open('{');
      j.key("usefulStates").strs(names(r.useful()));
      j.key("pathsToFinals").open('{');
      List<Map.Entry<WfModel.State, List<WfModel.Transition>>> paths = new ArrayList<>(r.pathsToFinals.entrySet());
      paths.sort(Comparator.comparing(e -> e.getKey().name));
      for (Map.Entry<WfModel.State, List<WfModel.Transition>> e : paths) {
        List<String> ts = new ArrayList<>();
        for (WfModel.Transition t : e.getValue()) ts.add(t.name);
        j.key(e.getKey().name).strs(ts);
      }
      j.close('}');
      j.key("actorsByActivity").open('{');
      List<Map.Entry<WfModel.Activity, List<WfModel.Actor>>> acts = new ArrayList<>(r.actorsByActivity.entrySet());
      acts.sort(Comparator.comparing(e -> e.getKey().name));
      for (Map.Entry<WfModel.Activity, List<WfModel.Actor>> e : acts) j.key(e.getKey().name).strs(names(e.getValue()));
      j.close('}');
      j.close('}');

      j.key("checks").open('[');
      for (Analyzer.CheckResult c : r.checkResults) {
        j.item().open('{');
        j.key("check").str(c.check.describe());
        j.key("result").str(c.pass ? "PASS" : "FAIL");
        j.key("inferred").str(c.inferred);
        j.close('}');
      }
      j.close(']');

      Simulator.Trace tr = r.simulation;
      j.key("simulation").open('{');
      j.key("initialValuation").open('{');
      for (Map.Entry<WfModel.Variable, Object> e : tr.valuation.entrySet()) {
        j.key(e.getKey().name);
        Object v = e.getValue();
        if (v instanceof String) j.str((String) v); else j.raw(String.valueOf(v));
      }
      j.close('}');
      j.key("steps").open('[');
      for (Simulator.Step s : tr.steps) {
        j.item().open('{');
        j.key("step").num(s.n);
        j.key("from").str(s.from.name);
        j.key("transition").str(s.via.name);
        j.key("to").str(s.to.name);
        j.close('}');
      }
      j.close(']');
      j.key("lastState").str(tr.last.name);
      j.key("outcome").str(tr.outcome.name());
      j.close('}');
    }
    j.close('}');
    return j.toString() + "\n";
  }

  private static List<String> names(Iterable<? extends WfModel.Element> els) {
    List<String> r = new ArrayList<>();
    for (WfModel.Element e : els) r.add(e.name);
    r.sort(null);
    return r;
  }

  /** Mini escritor JSON con sangría de 2 espacios. */
  private static final class J {
    private final StringBuilder sb = new StringBuilder();
    private int depth = 0;
    private boolean first = true;

    J open(char c) { sb.append(c); depth++; first = true; return this; }
    J close(char c) { depth--; if (!first) nl(); sb.append(c); first = false; return this; }
    J key(String k) { sep(); quote(k); sb.append(": "); return this; }
    J item() { sep(); return this; }
    J str(String s) { quote(s); first = false; return this; }
    J num(int n) { sb.append(n); first = false; return this; }
    J raw(String s) { sb.append(s); first = false; return this; }
    J strs(List<String> xs) {
      sb.append('[');
      for (int i = 0; i < xs.size(); i++) { if (i > 0) sb.append(", "); quote(xs.get(i)); }
      sb.append(']');
      first = false;
      return this;
    }
    private void sep() { if (!first) sb.append(','); nl(); first = true; }
    private void nl() { sb.append('\n'); for (int i = 0; i < depth; i++) sb.append("  "); }
    private void quote(String s) {
      sb.append('"');
      for (char c : s.toCharArray()) {
        switch (c) {
          case '"': sb.append("\\\""); break;
          case '\\': sb.append("\\\\"); break;
          case '\n': sb.append("\\n"); break;
          case '\r': sb.append("\\r"); break;
          case '\t': sb.append("\\t"); break;
          default: if (c < 0x20) sb.append(String.format("\\u%04x", (int) c)); else sb.append(c);
        }
      }
      sb.append('"');
    }
    @Override public String toString() { return sb.toString(); }
  }
}
