// Editor aspect: projectional notation of WVDL (textual sections + two tables).
'use strict';
module.exports.build = ({ G, S, decl, DEVKIT, USE, ids, models, fileOf, LANG_DIR }) => {
  const path = require('path');
  const { N, T, X } = G;
  const F = decl.$feat;
  const NAME = T('jetbrains.mps.lang.core.structure', 'name');
  const STUB = `${ids.reasoner}/java:wvdl.reasoner.mps(wvdl.reasoner/)`;

  const m = new G.Model('wvdl.editor', {
    devkits: [DEVKIT.editor],
    uses: [USE('ed', 15), USE('tbl', 0)],
  });

  // ---- style helpers
  const flag = (c) => N(c, { flag: 'true' });
  const NL = () => flag('ed:IndentLayoutNewLineStyleClassItem');
  const IND = () => flag('ed:IndentLayoutIndentStyleClassItem');
  const NLCH = () => flag('ed:IndentLayoutNewLineChildrenStyleClassItem');
  const withStyle = (cell, styles) => { for (const s of styles || []) cell.children.push([G.feature(cell.c, 'styleItem'), s]); return cell; };

  // ---- cell helpers
  const k = (text, ...styles) => withStyle(N('ed:CellModel_Constant', { text }), styles);
  const prop = (feat, ...styles) => withStyle(N('ed:CellModel_Property', { relationDeclaration: feat }), styles);
  const name = (...styles) => prop(NAME, ...styles);
  const child = (feat, ...styles) => withStyle(N('ed:CellModel_RefNode', { relationDeclaration: feat }), styles);
  const vlist = (feat, ...styles) => withStyle(N('ed:CellModel_RefNodeList', {
    relationDeclaration: feat, 'ed:CellModel_ListWithRole.cellLayout': N('ed:CellLayout_Vertical'),
  }), styles);
  const hlist = (feat, sep) => N('ed:CellModel_RefNodeList', {
    relationDeclaration: feat, separatorText: sep, 'ed:CellModel_ListWithRole.cellLayout': N('ed:CellLayout_Horizontal'),
  });
  const refName = (feat, ...styles) => withStyle(N('ed:CellModel_RefCell', {
    relationDeclaration: feat,
    editorComponent: N('ed:InlineEditorComponent', { cellModel: N('ed:CellModel_Property', { relationDeclaration: NAME, readOnly: 'true' }) }),
  }), styles);
  const row = (...cells) => N('ed:CellModel_Collection', { 'ed:CellModel_Collection.cellLayout': N('ed:CellLayout_Indent'), childCellModel: cells });
  const table = (cls) => N('tbl:CellModel_Table', {
    tableModel: N('tbl:QueryFunction_TableModel', {
      body: N('bl:StatementList', {
        statement: N('bl:ExpressionStatement', {
          expression: N('bl:GenericNewExpression', {
            creator: N('bl:ClassCreator', {
              baseMethodDeclaration: X(STUB, `~${cls}.<init>(org.jetbrains.mps.openapi.model.SNode)`, cls),
              actualArgument: N('ed:ConceptFunctionParameter_node'),
            }),
          }),
        }),
      }),
    }),
  });
  const editor = (conceptName, cell) => N('ed:ConceptEditorDeclaration', { conceptDeclaration: decl[conceptName], cellModel: cell });

  // section: header line, then an indented block
  const section = (title, body) => [k(title, NL()), withStyle(body, [IND(), NL()])];

  m.add(
    editor('Workflow', row(
      k('workflow'), name(NL()),
      k('', NL()),
      ...section('estados:', vlist(F['Workflow.states'])),
      ...section('roles:', vlist(F['Workflow.roles'])),
      ...section('actores:', vlist(F['Workflow.actors'])),
      ...section('asignaciones (actor x rol):', table('AssignmentMatrixModel')),
      ...section('variables:', vlist(F['Workflow.variables'])),
      ...section('actividades:', vlist(F['Workflow.activities'])),
      ...section('transiciones (nombre | origen | destino | actividad | guarda):', table('TransitionTableModel')),
      ...section('verificaciones:', vlist(F['Workflow.checks'])),
    )),
    editor('ReachableCheck', row(k('verificar alcanzable'), refName(F['ReachableCheck.state']))),
    editor('SoundCheck', k('verificar sound')),
    editor('PathCheck', row(k('verificar ruta hacia'), refName(F['PathCheck.state']), k('='), hlist(F['PathCheck.steps'], ','))),
    editor('ActorsCheck', row(k('verificar actores de'), refName(F['ActorsCheck.activity']), k('='), hlist(F['ActorsCheck.actors'], ','))),
    editor('SimulationCheck', row(k('verificar simulacion termina en'), refName(F['SimulationCheck.state']))),
    editor('TransitionRef', refName(F['TransitionRef.transition'])),
    editor('ActorRef', refName(F['ActorRef.actor'])),
    editor('InitialState', row(k('inicial'), name())),
    editor('OrdinaryState', row(k('estado'), name())),
    editor('FinalState', row(k('final'), name())),
    editor('HumanRole', row(k('rol humano'), name())),
    editor('SystemRole', row(k('rol sistema'), name())),
    editor('Actor', row(k('actor'), name())),
    editor('Assignment', k('✔')),
    editor('ManualActivity', row(k('manual'), name(), k('por'), refName(F['Activity.role']))),
    editor('AutomatedActivity', row(k('automatica'), name(), k('por'), refName(F['Activity.role']))),
    editor('Transition', name()),
    editor('SourceRef', refName(F['StateRef.state'])),
    editor('TargetRef', row(k('→'), refName(F['StateRef.state']))),
    editor('ActivityRef', row(k('por'), refName(F['ActivityRef.activity']))),
    editor('Guard', row(k('si'), child(F['Guard.condition']))),
    editor('Variable', row(name(), k(':'), child(F['Variable.type']), k('='), child(F['Variable.init']))),
    editor('BooleanType', k('Boolean')),
    editor('IntegerType', k('Integer')),
    editor('StringType', k('String')),
    editor('BoolLiteral', prop(F['BoolLiteral.value'])),
    editor('IntLiteral', prop(F['IntLiteral.value'])),
    editor('StringLiteral', row(k('"'), prop(F['StringLiteral.value']), k('"'))),
    editor('VarRef', refName(F['VarRef.variable'])),
    editor('EqExpr', row(child(F['IBinaryOperation.left']), k('=='), child(F['IBinaryOperation.right']))),
    editor('LtExpr', row(child(F['IBinaryOperation.left']), k('<'), child(F['IBinaryOperation.right']))),
    editor('AndExpr', row(k('('), child(F['IBinaryOperation.left']), k('and'), child(F['IBinaryOperation.right']), k(')'))),
    editor('OrExpr', row(k('('), child(F['IBinaryOperation.left']), k('or'), child(F['IBinaryOperation.right']), k(')'))),
    editor('NotExpr', row(k('not'), child(F['NotExpr.operand']))),
  );
  models.push(m);
  fileOf.set(m, path.join(LANG_DIR, 'models', 'editor.mps'));
};
