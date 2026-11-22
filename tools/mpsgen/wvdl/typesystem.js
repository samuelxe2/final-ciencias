// Typesystem aspect: checking rules (NonTypesystemRule) that report on each
// node the errors and warnings computed by the WVDL reasoner:
// static semantics (I1-I3, T-ROLE, T-GUARD, T-EQ, T-LT, T-AND/OR, T-NOT, T-INIT)
// and verification (deadlock, livelock, unreachable, dead guards, roles).
'use strict';
module.exports.build = ({ G, decl, DEVKIT, USE, ids, models, fileOf, LANG_DIR }) => {
  const path = require('path');
  const { N, X } = G;
  const STUB = `${ids.reasoner}/java:wvdl.reasoner.mps(wvdl.reasoner/)`;
  const m = new G.Model('wvdl.typesystem', { devkits: [DEVKIT.typesystem], uses: [USE('ts', 5)] });

  const call = (method, applicable) => N('bl:StaticMethodCall', {
    classConcept: X(STUB, '~WvdlChecks', 'WvdlChecks'),
    baseMethodDeclaration: X(STUB, `~WvdlChecks.${method}(org.jetbrains.mps.openapi.model.SNode)`, method),
    actualArgument: N('ts:ApplicableNodeReference', { applicableNode: applicable }),
  });

  const rule = (ruleName, conceptName, varName) => {
    const applicable = N('ts:ConceptReference', { name: varName, concept: decl[conceptName] });
    const local = (n, method) => N('bl:LocalVariableDeclaration', { name: n, type: N('bl:StringType'), initializer: call(method, applicable) });
    const e = local('errors', 'errors'), w = local('warnings', 'warnings');
    const notNull = v => N('bl:NotEqualsExpression', { leftExpression: N('bl:VariableReference', { variableDeclaration: v }), rightExpression: N('bl:NullLiteral') });
    const ref = () => N('ts:ApplicableNodeReference', { applicableNode: applicable });
    return N('ts:NonTypesystemRule', {
      name: ruleName,
      body: N('bl:StatementList', {
        statement: [
          N('bl:LocalVariableDeclarationStatement', { localVariableDeclaration: e }),
          N('bl:IfStatement', {
            condition: notNull(e),
            ifTrue: N('bl:StatementList', { statement: N('ts:ReportErrorStatement', { errorString: N('bl:VariableReference', { variableDeclaration: e }), nodeToReport: ref() }) }),
          }),
          N('bl:LocalVariableDeclarationStatement', { localVariableDeclaration: w }),
          N('bl:IfStatement', {
            condition: notNull(w),
            ifTrue: N('bl:StatementList', { statement: N('ts:WarningStatement', { warningText: N('bl:VariableReference', { variableDeclaration: w }), nodeToReport: ref() }) }),
          }),
        ],
      }),
      applicableNode: applicable,
    });
  };

  m.add(
    rule('check_Workflow', 'Workflow', 'workflow'),
    rule('check_WorkflowElement', 'IWorkflowElement', 'element'),
    rule('check_Guard', 'Guard', 'guard'),
    rule('check_Expression', 'Expression', 'expression'),
  );
  models.push(m);
  fileOf.set(m, path.join(LANG_DIR, 'models', 'typesystem.mps'));
};
