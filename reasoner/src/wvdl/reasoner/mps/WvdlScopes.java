package wvdl.reasoner.mps;

import java.util.ArrayList;
import java.util.List;
import jetbrains.mps.scope.ListScope;
import jetbrains.mps.scope.Scope;
import org.jetbrains.mps.openapi.language.SAbstractConcept;
import org.jetbrains.mps.openapi.model.SNode;

/**
 * Scoping de WVDL: toda referencia (estado, actividad, rol, actor, variable)
 * solo puede apuntar a elementos declarados en el mismo Workflow.
 * Workflow implementa ScopeProvider y su método getScope delega aquí.
 */
public final class WvdlScopes {
  private WvdlScopes() {}

  public static Scope getScope(SNode workflow, SAbstractConcept kind, SNode child) {
    List<SNode> visible = new ArrayList<>();
    if (workflow != null && kind != null)
      for (SNode c : workflow.getChildren()) if (c.getConcept().isSubConceptOf(kind)) visible.add(c);
    return ListScope.forNamedElements(visible);
  }
}
