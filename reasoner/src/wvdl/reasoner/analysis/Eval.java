package wvdl.reasoner.analysis;

import java.util.Map;
import java.util.Objects;
import wvdl.reasoner.model.Expr;
import wvdl.reasoner.model.WfModel;

/** Evaluador de expresiones bien tipadas bajo una valuación σ (σ ⊨ e). */
public final class Eval {
  private Eval() {}

  /** Devuelve Boolean/Long/String, o null si la expresión está incompleta. */
  public static Object eval(Expr e, Map<WfModel.Variable, Object> sigma) {
    if (e == null) return null;
    if (e instanceof Expr.BoolLit) return ((Expr.BoolLit) e).value;
    if (e instanceof Expr.IntLit) return ((Expr.IntLit) e).value;
    if (e instanceof Expr.StrLit) return ((Expr.StrLit) e).value;
    if (e instanceof Expr.VarRef) return sigma.get(((Expr.VarRef) e).variable);
    if (e instanceof Expr.Not) {
      Object v = eval(((Expr.Not) e).operand, sigma);
      return v instanceof Boolean ? !(Boolean) v : null;
    }
    Expr.Binary b = (Expr.Binary) e;
    Object l = eval(b.left, sigma);
    if (l == null) return null;
    // evaluación en cortocircuito para and/or
    if (b.op == Expr.Op.AND && Boolean.FALSE.equals(l)) return false;
    if (b.op == Expr.Op.OR && Boolean.TRUE.equals(l)) return true;
    Object r = eval(b.right, sigma);
    if (r == null) return null;
    switch (b.op) {
      case EQ: return Objects.equals(l, r);
      case LT: return (l instanceof Long && r instanceof Long) ? (Long) l < (Long) r : null;
      case AND:
      case OR: return r instanceof Boolean ? r : null;
      default: return null;
    }
  }

  /** σ ⊨ guard; una guarda ausente es verdadera. */
  public static Boolean holds(Expr guard, Map<WfModel.Variable, Object> sigma) {
    if (guard == null) return true;
    Object v = eval(guard, sigma);
    return v instanceof Boolean ? (Boolean) v : null;
  }
}
