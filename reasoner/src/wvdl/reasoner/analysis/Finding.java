package wvdl.reasoner.analysis;

/** Un hallazgo (diagnóstico) con código estable, severidad y elemento afectado. */
public final class Finding implements Comparable<Finding> {

  public enum Severity { ERROR, WARNING }

  public final String code;
  public final Severity severity;
  public final String element;  // nombre del elemento afectado
  public final Object origin;   // nodo MPS (o null)
  public final String message;
  public final boolean fromReasoner; // false = semántica estática

  public Finding(String code, Severity severity, String element, Object origin, String message, boolean fromReasoner) {
    this.code = code; this.severity = severity; this.element = element == null ? "" : element;
    this.origin = origin; this.message = message; this.fromReasoner = fromReasoner;
  }

  /** Texto mostrado en el editor de MPS. */
  public String text() { return "[" + code + "] " + message; }

  @Override public int compareTo(Finding o) {
    int c = severity.compareTo(o.severity);
    if (c != 0) return c;
    c = code.compareTo(o.code);
    if (c != 0) return c;
    c = element.compareTo(o.element);
    return c != 0 ? c : message.compareTo(o.message);
  }

  @Override public String toString() { return severity + " " + text() + " @" + element; }
}
