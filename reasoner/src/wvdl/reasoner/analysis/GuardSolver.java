package wvdl.reasoner.analysis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import wvdl.reasoner.model.Expr;
import wvdl.reasoner.model.Type;
import wvdl.reasoner.model.WfModel;

/**
 * Decide la satisfacibilidad de una guarda (∃σ. σ ⊨ g).
 *
 * Las guardas de WVDL no tienen aritmética: sus átomos son x == c, x &lt; c,
 * x == y, x &lt; y y literales. La verdad de g sólo depende de la posición
 * relativa de cada variable entera respecto de las constantes de g y entre sí.
 * Basta entonces evaluar g sobre un conjunto finito de representantes:
 * para v variables enteras y constantes c₁ &lt; … &lt; cₖ se toman los enteros
 * c_i − v … c_i + v (si no hay constantes, 0 … v−1). Para String, las
 * constantes de g más v valores frescos; para Boolean, {false, true}.
 * El procedimiento es completo y termina; su costo es O(Π |D_x| · |g|).
 */
public final class GuardSolver {

  public enum Result { SAT, UNSAT, UNKNOWN }

  /** Límite de valuaciones exploradas antes de responder UNKNOWN. */
  public static final int MAX_VALUATIONS = 200_000;

  private GuardSolver() {}

  public static Result satisfiable(Expr g) {
    if (g == null) return Result.SAT;
    Set<WfModel.Variable> vars = new LinkedHashSet<>();
    Set<Long> ints = new TreeSet<>();
    Set<String> strs = new TreeSet<>();
    if (!collect(g, vars, ints, strs)) return Result.UNKNOWN; // expresión incompleta
    int nInt = 0, nStr = 0;
    for (WfModel.Variable v : vars) {
      if (v.type == Type.INTEGER) nInt++;
      else if (v.type == Type.STRING) nStr++;
    }
    List<Object> intDom = new ArrayList<>();
    if (ints.isEmpty()) for (long i = 0; i < Math.max(1, nInt); i++) intDom.add(i);
    else {
      Set<Long> pts = new TreeSet<>();
      for (long c : ints) for (long d = -Math.max(1, nInt); d <= Math.max(1, nInt); d++) pts.add(c + d);
      intDom.addAll(pts);
    }
    List<Object> strDom = new ArrayList<>(strs);
    for (int i = 0; i < Math.max(1, nStr); i++) strDom.add("\u0000fresh" + i);
    List<Object> boolDom = List.of(false, true);

    List<WfModel.Variable> vs = new ArrayList<>(vars);
    List<List<Object>> doms = new ArrayList<>();
    long total = 1;
    for (WfModel.Variable v : vs) {
      if (v.type == null) return Result.UNKNOWN;
      List<Object> d = v.type == Type.INTEGER ? intDom : v.type == Type.STRING ? strDom : boolDom;
      doms.add(d);
      total *= d.size();
      if (total > MAX_VALUATIONS) return Result.UNKNOWN;
    }
    int[] idx = new int[vs.size()];
    Map<WfModel.Variable, Object> sigma = new HashMap<>();
    while (true) {
      for (int i = 0; i < vs.size(); i++) sigma.put(vs.get(i), doms.get(i).get(idx[i]));
      Boolean r = Eval.holds(g, sigma);
      if (r == null) return Result.UNKNOWN;
      if (r) return Result.SAT;
      int k = 0;
      while (k < idx.length && ++idx[k] == doms.get(k).size()) { idx[k] = 0; k++; }
      if (k == idx.length) return Result.UNSAT;
    }
  }

  private static boolean collect(Expr e, Set<WfModel.Variable> vars, Set<Long> ints, Set<String> strs) {
    if (e == null) return false;
    if (e instanceof Expr.IntLit) { ints.add(((Expr.IntLit) e).value); return true; }
    if (e instanceof Expr.StrLit) { strs.add(((Expr.StrLit) e).value); return true; }
    if (e instanceof Expr.BoolLit) return true;
    if (e instanceof Expr.VarRef) {
      WfModel.Variable v = ((Expr.VarRef) e).variable;
      if (v == null) return false;
      vars.add(v);
      return true;
    }
    if (e instanceof Expr.Not) return collect(((Expr.Not) e).operand, vars, ints, strs);
    Expr.Binary b = (Expr.Binary) e;
    return collect(b.left, vars, ints, strs) & collect(b.right, vars, ints, strs);
  }
}
