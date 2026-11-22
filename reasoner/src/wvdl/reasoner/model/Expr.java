package wvdl.reasoner.model;

/**
 * Guard expressions:
 * Expr ::= BoolLit | IntLit | StrLit | VarRef | Expr == Expr | Expr &lt; Expr
 *        | Expr and Expr | Expr or Expr | not Expr
 * Each node keeps its origin (SNode) for error reporting.
 */
public abstract class Expr {
  public final Object origin;
  protected Expr(Object origin) { this.origin = origin; }

  public static final class BoolLit extends Expr {
    public final boolean value;
    public BoolLit(boolean v, Object o) { super(o); value = v; }
    public String toString() { return String.valueOf(value); }
  }
  public static final class IntLit extends Expr {
    public final long value;
    public IntLit(long v, Object o) { super(o); value = v; }
    public String toString() { return String.valueOf(value); }
  }
  public static final class StrLit extends Expr {
    public final String value;
    public StrLit(String v, Object o) { super(o); value = v == null ? "" : v; }
    public String toString() { return "\"" + value + "\""; }
  }
  public static final class VarRef extends Expr {
    public final WfModel.Variable variable; // null if unresolved
    public VarRef(WfModel.Variable v, Object o) { super(o); variable = v; }
    public String toString() { return variable == null ? "?" : variable.name; }
  }
  public enum Op {
    EQ("=="), LT("<"), AND("and"), OR("or");
    public final String sym;
    Op(String s) { sym = s; }
  }
  public static final class Binary extends Expr {
    public final Op op;
    public final Expr left, right; // may be null when incomplete
    public Binary(Op op, Expr l, Expr r, Object o) { super(o); this.op = op; left = l; right = r; }
    public String toString() { return "(" + left + " " + op.sym + " " + right + ")"; }
  }
  public static final class Not extends Expr {
    public final Expr operand;
    public Not(Expr e, Object o) { super(o); operand = e; }
    public String toString() { return "not " + operand; }
  }
}
