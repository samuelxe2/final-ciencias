// WVDL metamodel (Structure aspect). Each entry becomes a ConceptDeclaration /
// InterfaceConceptDeclaration in languages/wvdl/models/structure.mps and is
// registered in mpsgen so other models can instantiate the concept.
'use strict';
const G = require('../mpsgen');
const { N, T, longIdFor, defineLanguage, defineConcept } = G;

const LANG = 'wvdl';
const LANG_ID = G.uuidFor('wvdl-language');
defineLanguage(LANG, LANG_ID);

const CORE = 'jetbrains.mps.lang.core.structure';
const coreT = n => T(CORE, n);

// name: { kind: 'concept'|'interface', ext, impl:[], abstract, root, alias,
//         props: [[name, 'string'|'integer'|'boolean']], children: [[role, target, card]], refs: [[role, target, card]] }
const D = {
  // ---- interfaces
  IWorkflowElement: { kind: 'interface', doc: 'Elemento declarado dentro de un Workflow (resuelto por scoping).' },
  IBinaryOperation: { kind: 'interface', children: [['left', 'Expression', '1'], ['right', 'Expression', '1']] },

  // ---- dominio
  Workflow: { root: true, alias: 'workflow', impl: ['core:INamedConcept', 'core:ScopeProvider'],
    children: [['states', 'State', '1..n'], ['roles', 'Role', '0..n'], ['actors', 'Actor', '0..n'], ['assignments', 'Assignment', '0..n'],
      ['variables', 'Variable', '0..n'], ['activities', 'Activity', '0..n'], ['transitions', 'Transition', '0..n'], ['checks', 'Check', '0..n']] },
  State: { abstract: true, impl: ['core:INamedConcept', 'IWorkflowElement'] },
  InitialState: { ext: 'State', alias: 'inicial' },
  OrdinaryState: { ext: 'State', alias: 'estado' },
  FinalState: { ext: 'State', alias: 'final' },
  Role: { abstract: true, impl: ['core:INamedConcept', 'IWorkflowElement'] },
  HumanRole: { ext: 'Role', alias: 'rol humano' },
  SystemRole: { ext: 'Role', alias: 'rol sistema' },
  Actor: { alias: 'actor', impl: ['core:INamedConcept', 'IWorkflowElement'] },
  Assignment: { alias: 'asignacion', impl: ['IWorkflowElement'], refs: [['actor', 'Actor', '1'], ['role', 'Role', '1']] },
  Activity: { abstract: true, impl: ['core:INamedConcept', 'IWorkflowElement'], refs: [['role', 'Role', '1']] },
  ManualActivity: { ext: 'Activity', alias: 'manual' },
  AutomatedActivity: { ext: 'Activity', alias: 'automatica' },
  Transition: { alias: 'transicion', impl: ['core:INamedConcept', 'IWorkflowElement'],
    children: [['from', 'SourceRef', '1'], ['to', 'TargetRef', '1'], ['via', 'ActivityRef', '0..1'], ['guard', 'Guard', '0..1']] },
  StateRef: { abstract: true, refs: [['state', 'State', '1']] },
  SourceRef: { ext: 'StateRef' },
  TargetRef: { ext: 'StateRef' },
  ActivityRef: { refs: [['activity', 'Activity', '1']] },
  Guard: { alias: 'si', children: [['condition', 'Expression', '1']] },
  Variable: { alias: 'var', impl: ['core:INamedConcept', 'IWorkflowElement'], children: [['type', 'Type', '1'], ['init', 'Expression', '0..1']] },

  // ---- verificaciones (propiedades que el razonador debe confirmar)
  Check: { abstract: true, impl: ['IWorkflowElement'] },
  ReachableCheck: { ext: 'Check', alias: 'verificar alcanzable', refs: [['state', 'State', '1']] },
  SoundCheck: { ext: 'Check', alias: 'verificar sound' },
  PathCheck: { ext: 'Check', alias: 'verificar ruta', refs: [['state', 'State', '1']], children: [['steps', 'TransitionRef', '0..n']] },
  ActorsCheck: { ext: 'Check', alias: 'verificar actores', refs: [['activity', 'Activity', '1']], children: [['actors', 'ActorRef', '0..n']] },
  SimulationCheck: { ext: 'Check', alias: 'verificar simulacion', refs: [['state', 'State', '1']] },
  TransitionRef: { refs: [['transition', 'Transition', '1']] },
  ActorRef: { refs: [['actor', 'Actor', '1']] },

  // ---- tipos
  Type: { abstract: true },
  BooleanType: { ext: 'Type', alias: 'Boolean' },
  IntegerType: { ext: 'Type', alias: 'Integer' },
  StringType: { ext: 'Type', alias: 'String' },

  // ---- expresiones (guardas)
  Expression: { abstract: true },
  BoolLiteral: { ext: 'Expression', alias: 'booleano', props: [['value', 'boolean']] },
  IntLiteral: { ext: 'Expression', alias: 'entero', props: [['value', 'integer']] },
  StringLiteral: { ext: 'Expression', alias: 'texto', props: [['value', 'string']] },
  VarRef: { ext: 'Expression', refs: [['variable', 'Variable', '1']] },
  EqExpr: { ext: 'Expression', alias: '==', impl: ['IBinaryOperation'] },
  LtExpr: { ext: 'Expression', alias: '<', impl: ['IBinaryOperation'] },
  AndExpr: { ext: 'Expression', alias: 'and', impl: ['IBinaryOperation'] },
  OrExpr: { ext: 'Expression', alias: 'or', impl: ['IBinaryOperation'] },
  NotExpr: { ext: 'Expression', alias: 'not', children: [['operand', 'Expression', '1']] },
};

const CARD = { '1': 'fLJekj4/1', '0..n': 'fLJekj5/0..n', '1..n': 'fLJekj6/1..n', '0..1': undefined };

// register concepts in mpsgen (ids are stable hashes of the names)
const ids = {};
for (const [name, d] of Object.entries(D)) {
  const props = {}, children = {}, refs = {};
  for (const [p] of d.props || []) props[p] = longIdFor(`wvdl.${name}.prop.${p}`);
  for (const [r] of d.children || []) children[r] = longIdFor(`wvdl.${name}.link.${r}`);
  for (const [r] of d.refs || []) refs[r] = longIdFor(`wvdl.${name}.link.${r}`);
  ids[name] = longIdFor(`wvdl.concept.${name}`);
  defineConcept(LANG, name, { id: ids[name], flags: d.kind === 'interface' ? 'ngI' : 'ng', props, children, refs });
}
// super-concepts so inherited features resolve (e.g. Transition.name)
for (const [name, d] of Object.entries(D)) {
  const c = G.languages[LANG].concepts[name];
  c.supers = [d.ext ? `wvdl:${d.ext}` : null, ...(d.impl || []).map(i => i.includes(':') ? i : `wvdl:${i}`)].filter(Boolean);
}

// ---- structure model
function buildStructureModel(model) {
  const decl = {};
  const feat = {};
  for (const [name, d] of Object.entries(D)) {
    const isI = d.kind === 'interface';
    decl[name] = N(isI ? 'st:InterfaceConceptDeclaration' : 'st:ConceptDeclaration', {
      conceptId: ids[name],
      name,
      rootable: d.root ? 'true' : undefined,
      abstract: d.abstract ? 'true' : undefined,
      conceptAlias: d.alias,
    }, G.nodeIdFor('wvdl-struct:' + name));
  }
  const tgt = s => s.startsWith('core:') ? coreT(s.slice(5)) : decl[s];
  for (const [name, d] of Object.entries(D)) {
    const n = decl[name];
    const add = (k, v) => n.children.push([G.feature(n.c, k), v]);
    if (d.kind !== 'interface') n.refs.push([G.feature(n.c, 'extends'), d.ext ? decl[d.ext] : coreT('BaseConcept')]);
    for (const i of d.impl || []) add('implements', N('st:InterfaceConceptReference', { intfc: tgt(i) }));
    for (const [p, ty] of d.props || []) add('propertyDeclaration', N('st:PropertyDeclaration', { propertyId: longIdFor(`wvdl.${name}.prop.${p}`), name: p, dataType: coreT(ty) }, G.nodeIdFor(`wvdl-struct:${name}.${p}`)));
    for (const [r, t, card] of d.children || []) add('linkDeclaration', N('st:LinkDeclaration', { linkId: longIdFor(`wvdl.${name}.link.${r}`), role: r, metaClass: 'fLJjDmT/aggregation', sourceCardinality: CARD[card], target: decl[t] }, G.nodeIdFor(`wvdl-struct:${name}.${r}`)));
    for (const [r, t, card] of d.refs || []) add('linkDeclaration', N('st:LinkDeclaration', { linkId: longIdFor(`wvdl.${name}.link.${r}`), role: r, sourceCardinality: CARD[card], target: decl[t] }, G.nodeIdFor(`wvdl-struct:${name}.${r}`)));
  }
  for (const [name] of Object.entries(D)) for (const [f, ch] of decl[name].children) if (f.name !== 'implements') feat[`${name}.${ch.props.find(([pf]) => pf.name === 'name' || pf.name === 'role')[1]}`] = ch;
  model.add(...Object.values(decl));
  decl.$feat = feat;
  return decl;
}

module.exports = { LANG, LANG_ID, D, ids, buildStructureModel };
