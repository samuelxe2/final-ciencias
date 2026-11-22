package wvdl.reasoner.analysis;

import java.util.List;
import wvdl.reasoner.model.Expr;
import wvdl.reasoner.model.Type;

/**
 * Implementa las reglas de tipos de WVDL (Γ = variables del Workflow):
 * <pre>
 *  T-LIT   n:Integer   s:String   b:Boolean
 *  T-VAR   Γ(x)=τ  ⊢ x:τ
 *  T-EQ    a:τ, b:τ        ⊢ a == b : Boolean
 *  T-LT    a:Integer, b:Integer ⊢ a &lt; b : Boolean
 *  T-AND/OR a:Boolean, b:Boolean ⊢ a and/or b : Boolean
 *  T-NOT   a:Boolean       ⊢ not a : Boolean
 *  T-GUARD guard(e) ok  si e:Boolean
 *  T-INIT  var x:τ = e ok  si e:τ
 * </pre>
 * Devuelve el tipo inferido o null cuando no se puede inferir (en cuyo caso
 * ya se emitió un error, o falta un hijo y MPS lo reporta).
 */
public final class TypeChecker {

  private final List<Finding> out;

  public TypeChecker(List<Finding> out) { this.out = out; }

  public Type infer(Expr e) {
    if (e == null) return null;
    if (e instanceof Expr.BoolLit) return Type.BOOLEAN;
    if (e instanceof Expr.IntLit) return Type.INTEGER;
    if (e instanceof Expr.StrLit) return Type.STRING;
    if (e instanceof Expr.VarRef) {
      Expr.VarRef v = (Expr.VarRef) e;
      return v.variable == null ? null : v.variable.type;
    }
    if (e instanceof Expr.Not) {
      Type t = infer(((Expr.Not) e).operand);
      if (t != null && t != Type.BOOLEAN) {
        error("T-NOT", e, "'not' requiere un operando Boolean, se encontró " + t);
        return null;
      }
      return Type.BOOLEAN;
    }
    Expr.Binary b = (Expr.Binary) e;
    Type l = infer(b.left), r = infer(b.right);
    if (l == null || r == null) return Type.BOOLEAN; // error ya reportado o hijo faltante
    switch (b.op) {
      case EQ:
        if (l != r) { error("T-EQ", e, "'==' requiere operandos del mismo tipo: " + l + " vs " + r); return null; }
        return Type.BOOLEAN;
      case LT:
        if (l != Type.INTEGER || r != Type.INTEGER) { error("T-LT", e, "'<' requiere operandos Integer: " + l + " vs " + r); return null; }
        return Type.BOOLEAN;
      default:
        if (l != Type.BOOLEAN || r != Type.BOOLEAN) { error(b.op == Expr.Op.AND ? "T-AND" : "T-OR", e, "'" + b.op.sym + "' requiere operandos Boolean: " + l + " vs " + r); return null; }
        return Type.BOOLEAN;
    }
  }

  /** T-GUARD: la condición de una guarda debe ser Boolean. */
  public boolean checkGuard(Expr condition, Object guardOrigin, String transitionName) {
    int before = out.size();
    Type t = infer(condition);
    if (t != null && t != Type.BOOLEAN) {
      out.add(new Finding("T-GUARD", Finding.Severity.ERROR, transitionName, guardOrigin,
          "la guarda de " + transitionName + " debe ser Boolean, pero es " + t, false));
    }
    return out.size() == before;
  }

  /** T-INIT: el valor inicial de una variable debe tener su tipo declarado. */
  public void checkInit(Expr init, Type declared, Object varOrigin, String varName) {
    if (init == null || declared == null) return;
    Type t = infer(init);
    if (t != null && t != declared) {
      out.add(new Finding("T-INIT", Finding.Severity.ERROR, varName, varOrigin,
          "el valor inicial de " + varName + " es " + t + " pero la variable es " + declared, false));
    }
  }

  private void error(String code, Expr e, String msg) {
    out.add(new Finding(code, Finding.Severity.ERROR, e.toString(), e.origin, msg, false));
  }
}
