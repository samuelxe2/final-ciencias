// Behavior aspect: Workflow implements ScopeProvider; getScope restricts every
// reference to the elements declared in the same Workflow (scoping).
'use strict';
module.exports.build = ({ G, decl, DEVKIT, USE, ids, models, fileOf, LANG_DIR }) => {
  const path = require('path');
  const { N, X } = G;
  const STUB = `${ids.reasoner}/java:wvdl.reasoner.mps(wvdl.reasoner/)`;
  const CORE_BH = 'r:00000000-0000-4000-0000-011c89590282(jetbrains.mps.lang.core.behavior)';
  const SCOPE = 'r:314576fc-3aee-4386-a0a5-a38348ac317d(jetbrains.mps.scope)';

  const m = new G.Model('wvdl.behavior', { devkits: [DEVKIT.behavior], uses: [USE('bh', 2)] });

  const kind = N('bl:ParameterDeclaration', { name: 'kind', type: N('sm:SConceptType') });
  const child = N('bl:ParameterDeclaration', { name: 'child', type: N('sm:SNodeType') });
  const getScope = N('bh:ConceptMethodDeclaration', {
    isAbstract: 'false', isVirtual: 'false', name: 'getScope',
    overriddenMethod: X(CORE_BH, '52_Geb4QDV$', 'getScope'),
    visibility: N('bl:PublicVisibility'),
    body: N('bl:StatementList', {
      statement: N('bl:ReturnStatement', {
        expression: N('bl:StaticMethodCall', {
          classConcept: X(STUB, '~WvdlScopes', 'WvdlScopes'),
          baseMethodDeclaration: X(STUB, '~WvdlScopes.getScope(org.jetbrains.mps.openapi.model.SNode,org.jetbrains.mps.openapi.language.SAbstractConcept,org.jetbrains.mps.openapi.model.SNode)', 'getScope'),
          actualArgument: [
            N('bh:ThisNodeExpression'),
            N('bl:VariableReference', { variableDeclaration: kind }),
            N('bl:VariableReference', { variableDeclaration: child }),
          ],
        }),
      }),
    }),
    parameter: [kind, child],
    returnType: N('bl:ClassifierType', { classifier: X(SCOPE, '3fifI_xCtN$', 'Scope') }),
  });
  m.add(N('bh:ConceptBehavior', {
    concept: decl.Workflow,
    constructor: N('bh:ConceptConstructorDeclaration', { body: N('bl:StatementList') }),
    method: getScope,
  }));
  models.push(m);
  fileOf.set(m, path.join(LANG_DIR, 'models', 'behavior.mps'));
};
