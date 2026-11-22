package wvdl.reasoner.mps;

import org.jetbrains.mps.openapi.model.SNode;
import wvdl.reasoner.analysis.Analyzer;
import wvdl.reasoner.report.JsonReport;

/** Usado por el TextGen de Workflow: genera el reporte JSON del razonador. */
public final class WvdlReport {
  private WvdlReport() {}

  public static String json(SNode workflow) {
    return JsonReport.render(Analyzer.analyze(MpsAdapter.build(workflow).model));
  }
}
