package wvdl.reasoner.mps;

import java.util.List;
import jetbrains.mps.lang.editor.table.runtime.AbstractTableModel;
import org.jetbrains.mps.openapi.language.SConcept;
import org.jetbrains.mps.openapi.language.SContainmentLink;
import org.jetbrains.mps.openapi.language.SReferenceLink;
import org.jetbrains.mps.openapi.model.SNode;

/**
 * Matriz Actor × Rol (notación matricial). La fila 0 muestra los roles y la
 * columna 0 los actores; la celda (i, j) es el Assignment del actor i al rol j,
 * o una celda vacía que al editarse crea la asignación.
 */
public class AssignmentMatrixModel extends AbstractTableModel {
  private final SNode workflow;

  public AssignmentMatrixModel(SNode workflow) { this.workflow = workflow; }

  private List<SNode> actors() { return MpsAdapter.children(workflow, "actors"); }
  private List<SNode> roles() { return MpsAdapter.children(workflow, "roles"); }

  @Override public int getRowCount() { return actors().size() + 1; }
  @Override public int getColumnCount() { return roles().size() + 1; }

  @Override public SNode getValueAt(int row, int column) {
    if (row == 0 && column == 0) return null;
    List<SNode> as = actors(), rs = roles();
    if (row == 0) return column - 1 < rs.size() ? rs.get(column - 1) : null;
    if (column == 0) return row - 1 < as.size() ? as.get(row - 1) : null;
    if (row - 1 >= as.size() || column - 1 >= rs.size()) return null;
    return find(as.get(row - 1), rs.get(column - 1));
  }

  private SNode find(SNode actor, SNode role) {
    for (SNode a : MpsAdapter.children(workflow, "assignments"))
      if (MpsAdapter.ref(a, "actor") == actor && MpsAdapter.ref(a, "role") == role) return a;
    return null;
  }

  @Override public void createElement(int row, int column) {
    if (row == 0 || column == 0) return;
    List<SNode> as = actors(), rs = roles();
    if (row - 1 >= as.size() || column - 1 >= rs.size()) return;
    SNode actor = as.get(row - 1), role = rs.get(column - 1);
    if (find(actor, role) != null) return;
    SContainmentLink link = MpsAdapter.link(workflow, "assignments");
    SNode a = workflow.getModel().createNode((SConcept) link.getTargetConcept());
    a.setReferenceTarget(refLink(a, "actor"), actor);
    a.setReferenceTarget(refLink(a, "role"), role);
    workflow.addChild(link, a);
  }

  private static SReferenceLink refLink(SNode n, String name) {
    for (SReferenceLink l : n.getConcept().getReferenceLinks()) if (name.equals(l.getName())) return l;
    throw new IllegalStateException("no reference " + name);
  }
}
