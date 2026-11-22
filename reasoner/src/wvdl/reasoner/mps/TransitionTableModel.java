package wvdl.reasoner.mps;

import java.util.List;
import jetbrains.mps.lang.editor.table.runtime.AbstractTableModel;
import org.jetbrains.mps.openapi.language.SConcept;
import org.jetbrains.mps.openapi.language.SContainmentLink;
import org.jetbrains.mps.openapi.model.SNode;

/**
 * Tabla de transiciones (jetbrains.mps.lang.editor.table):
 * una fila por Transition y las columnas Nombre | Origen | Destino | Actividad | Guarda.
 * Cada celda es un nodo hijo de la transición; las celdas opcionales vacías
 * se crean al editarlas. Enter en una fila inserta una transición nueva.
 */
public class TransitionTableModel extends AbstractTableModel {
  static final String[] COLUMNS = {null, "from", "to", "via", "guard"};

  private final SNode workflow;

  public TransitionTableModel(SNode workflow) { this.workflow = workflow; }

  private List<SNode> rows() { return MpsAdapter.children(workflow, "transitions"); }

  @Override public int getColumnCount() { return COLUMNS.length; }
  @Override public int getRowCount() { return rows().size(); }

  @Override public SNode getValueAt(int row, int column) {
    List<SNode> rs = rows();
    if (row < 0 || row >= rs.size()) return null;
    SNode t = rs.get(row);
    return column == 0 ? t : MpsAdapter.child(t, COLUMNS[column]);
  }

  @Override public void createElement(int row, int column) {
    List<SNode> rs = rows();
    if (column == 0 || row < 0 || row >= rs.size()) return;
    SNode t = rs.get(row);
    if (MpsAdapter.child(t, COLUMNS[column]) == null) t.addChild(MpsAdapter.link(t, COLUMNS[column]), newChild(t, COLUMNS[column]));
  }

  @Override public void insertRow(int rowNumber) {
    SContainmentLink link = MpsAdapter.link(workflow, "transitions");
    SNode t = workflow.getModel().createNode((SConcept) link.getTargetConcept());
    t.setProperty(nameProperty(t), "T" + (rows().size() + 1));
    t.addChild(MpsAdapter.link(t, "from"), newChild(t, "from"));
    t.addChild(MpsAdapter.link(t, "to"), newChild(t, "to"));
    List<SNode> rs = rows();
    workflow.insertChildBefore(link, t, rowNumber >= 0 && rowNumber < rs.size() ? rs.get(rowNumber) : null);
  }

  @Override public void deleteRow(int rowNumber) {
    List<SNode> rs = rows();
    if (rowNumber >= 0 && rowNumber < rs.size()) workflow.removeChild(rs.get(rowNumber));
  }

  static SNode newChild(SNode parent, String role) {
    return parent.getModel().createNode((SConcept) MpsAdapter.link(parent, role).getTargetConcept());
  }

  static org.jetbrains.mps.openapi.language.SProperty nameProperty(SNode n) {
    for (org.jetbrains.mps.openapi.language.SProperty p : n.getConcept().getProperties()) if ("name".equals(p.getName())) return p;
    throw new IllegalStateException("concept without name: " + n.getConcept());
  }
}
