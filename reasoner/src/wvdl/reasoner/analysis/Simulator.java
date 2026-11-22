package wvdl.reasoner.analysis;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import wvdl.reasoner.model.Type;
import wvdl.reasoner.model.WfModel;

/**
 * Semántica operacional: una configuración es (s, σ). La regla de paso es
 * <pre>  (s, σ) → (s', σ)   si (s, t, s') ∈ δ y σ ⊨ guard(t)</pre>
 * El simulador es determinista: toma la primera transición habilitada en
 * orden de declaración. Se detiene al llegar a un estado final, cuando no
 * hay transición habilitada o al superar el límite de pasos (protección,
 * no prueba de terminación).
 */
public final class Simulator {

  public static final int DEFAULT_MAX_STEPS = 50;

  public enum Outcome { FINAL_REACHED, STUCK, STEP_LIMIT }

  public static final class Step {
    public final int n;
    public final WfModel.State from, to;
    public final WfModel.Transition via;
    Step(int n, WfModel.State from, WfModel.Transition via, WfModel.State to) { this.n = n; this.from = from; this.via = via; this.to = to; }
  }

  public static final class Trace {
    public final Map<WfModel.Variable, Object> valuation;
    public final List<Step> steps = new ArrayList<>();
    public WfModel.State last;
    public Outcome outcome;
    Trace(Map<WfModel.Variable, Object> v) { valuation = v; }
  }

  private Simulator() {}

  /** Valuación inicial σ₀: el valor inicial declarado o el valor por defecto del tipo. */
  public static Map<WfModel.Variable, Object> initialValuation(WfModel m) {
    Map<WfModel.Variable, Object> sigma = new LinkedHashMap<>();
    for (WfModel.Variable v : m.variables) {
      Object val = v.init == null ? null : Eval.eval(v.init, sigma);
      if (val == null) val = v.type == Type.INTEGER ? (Object) 0L : v.type == Type.STRING ? (Object) "" : (Object) Boolean.FALSE;
      sigma.put(v, val);
    }
    return sigma;
  }

  public static Trace run(WfModel m, WfModel.State initial, int maxSteps) {
    Trace tr = new Trace(initialValuation(m));
    WfModel.State s = initial;
    for (int n = 1; ; n++) {
      if (s.isFinal()) { tr.outcome = Outcome.FINAL_REACHED; break; }
      if (n > maxSteps) { tr.outcome = Outcome.STEP_LIMIT; break; }
      WfModel.Transition next = null;
      for (WfModel.Transition t : m.transitions)
        if (t.source == s && t.target != null && Boolean.TRUE.equals(Eval.holds(t.guard, tr.valuation))) { next = t; break; }
      if (next == null) { tr.outcome = Outcome.STUCK; break; }
      tr.steps.add(new Step(n, s, next, next.target));
      s = next.target;
    }
    tr.last = s;
    return tr;
  }
}
