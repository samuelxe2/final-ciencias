package wvdl.reasoner.mps;

import java.util.List;
import org.jetbrains.mps.openapi.model.SNode;
import wvdl.reasoner.analysis.Analyzer;
import wvdl.reasoner.analysis.Finding;

/**
 * Punto de entrada usado por las reglas de typesystem (checking rules) de WVDL:
 * devuelve los mensajes de error / advertencia del razonador para un nodo.
 */
public final class WvdlChecks {
  private WvdlChecks() {}

  public static Analyzer.Result analyze(SNode anyNodeInWorkflow) {
    SNode wf = MpsAdapter.workflowOf(anyNodeInWorkflow);
    return wf == null ? null : Analyzer.analyze(MpsAdapter.build(wf).model);
  }

  /** Errores para este nodo, unidos con " | ", o null si no hay. */
  public static String errors(SNode node) { return messages(node, Finding.Severity.ERROR); }

  /** Advertencias para este nodo, unidas con " | ", o null si no hay. */
  public static String warnings(SNode node) { return messages(node, Finding.Severity.WARNING); }

  private static String messages(SNode node, Finding.Severity sev) {
    Analyzer.Result r = analyze(node);
    if (r == null) return null;
    List<Finding> fs = r.findingsFor(node);
    StringBuilder sb = new StringBuilder();
    for (Finding f : fs) if (f.severity == sev) sb.append(sb.length() == 0 ? "" : " | ").append(f.text());
    return sb.length() == 0 ? null : sb.toString();
  }
}
