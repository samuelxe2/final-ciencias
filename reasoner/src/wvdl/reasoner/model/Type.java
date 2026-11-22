package wvdl.reasoner.model;

/** Tipos de WVDL: Boolean, Integer y String. */
public enum Type {
  BOOLEAN("Boolean"), INTEGER("Integer"), STRING("String");

  public final String label;
  Type(String label) { this.label = label; }
  @Override public String toString() { return label; }
}
