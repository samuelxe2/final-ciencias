// mpsgen: tiny library that emits JetBrains MPS persistence-9 models (.mps)
// from a JavaScript description. Meta-ids for MPS' own languages come from
// registry.json (see harvest.js); ids for the WVDL language are declared here.
'use strict';
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const REG = require('./registry.json');

const LANG_ALIASES = {
  core: 'jetbrains.mps.lang.core',
  st: 'jetbrains.mps.lang.structure',
  ed: 'jetbrains.mps.lang.editor',
  tbl: 'jetbrains.mps.lang.editor.table',
  bl: 'jetbrains.mps.baseLanguage',
  bh: 'jetbrains.mps.lang.behavior',
  sm: 'jetbrains.mps.lang.smodel',
  ts: 'jetbrains.mps.lang.typesystem',
  tg: 'jetbrains.mps.lang.textGen',
  test: 'jetbrains.mps.lang.test',
  col: 'jetbrains.mps.baseLanguage.collections',
  cl: 'jetbrains.mps.baseLanguage.closures',
  q: 'jetbrains.mps.lang.quotation',
  sc: 'jetbrains.mps.lang.scopes',
  cons: 'jetbrains.mps.lang.constraints',
};

// ---------------------------------------------------------------- languages
const languages = {}; // name -> {id, name, concepts: {short -> concept}}
for (const [id, L] of Object.entries(REG.langs)) {
  const entry = languages[L.name] || (languages[L.name] = { id, name: L.name, concepts: {} });
  for (const [fqn, c] of Object.entries(L.concepts)) {
    const short = fqn.split('.').pop();
    const prev = entry.concepts[short];
    if (prev) { Object.assign(prev.props, c.props); Object.assign(prev.children, c.children); Object.assign(prev.refs, c.refs); if (c.supers) prev.supers = c.supers; }
    else entry.concepts[short] = { fqn, id: c.id, flags: c.flags, props: { ...c.props }, children: { ...c.children }, refs: { ...c.refs }, lang: entry, supers: c.supers || [] };
  }
}

// Declares (or extends) a language/concept known only to this generator.
function defineLanguage(name, id) {
  return languages[name] || (languages[name] = { id, name, concepts: {} });
}
function defineConcept(langName, short, spec) {
  const L = languages[langName];
  const c = L.concepts[short] || (L.concepts[short] = { fqn: `${langName}.structure.${short}`, props: {}, children: {}, refs: {}, lang: L, supers: [] });
  Object.assign(c, { id: spec.id, flags: spec.flags || 'ng' });
  Object.assign(c.props, spec.props || {});
  Object.assign(c.children, spec.children || {});
  Object.assign(c.refs, spec.refs || {});
  c.supers = spec.supers || c.supers;
  return c;
}

// Super-concept hints for features declared in ancestors (feature lookup).
const COMMON_SUPERS = [['jetbrains.mps.lang.core', 'INamedConcept'], ['jetbrains.mps.lang.core', 'BaseConcept']];
const CELL = ['ed:EditorCellModel', 'ed:IStyleContainer'];
const SUPERS = {
  'ed:ConceptEditorDeclaration': ['ed:AbstractComponent', 'ed:BaseEditorComponent'],
  'ed:CellModel_Collection': CELL, 'ed:CellModel_Constant': CELL, 'ed:CellModel_Component': CELL,
  'ed:CellModel_ReadOnlyModelAccessor': CELL, 'ed:CellModel_Empty': CELL, 'tbl:CellModel_Table': CELL,
  'ed:CellModel_Property': ['ed:CellModel_WithRole', ...CELL], 'ed:CellModel_RefNode': ['ed:CellModel_WithRole', ...CELL],
  'ed:CellModel_RefCell': ['ed:CellModel_WithRole', ...CELL],
  'ed:CellModel_RefNodeList': ['ed:CellModel_ListWithRole', 'ed:CellModel_WithRole', ...CELL],
  'ts:NonTypesystemRule': ['ts:AbstractCheckingRule', 'ts:AbstractRule'],
  'bh:ConceptMethodDeclaration': ['bl:BaseMethodDeclaration', 'bl:IVisible'],
  'bl:LocalVariableDeclaration': ['bl:VariableDeclaration', 'bl:BaseVariableDeclaration'],
  'bl:ParameterDeclaration': ['bl:BaseVariableDeclaration'],
  'bl:StaticMethodCall': ['bl:IMethodCall'], 'bl:ClassCreator': ['bl:IMethodCall'], 'bl:InstanceMethodCallOperation': ['bl:IMethodCall'],
  'bl:NotEqualsExpression': ['bl:BinaryOperation'], 'bl:EqualsExpression': ['bl:BinaryOperation'],
  'tg:GenerateTextDeclaration': ['bl:ConceptFunction'], 'tg:ExtensionDeclaration': ['bl:ConceptFunction'],
  'tbl:QueryFunction_TableModel': ['bl:ConceptFunction'], 'bh:ConceptConstructorDeclaration': ['bl:ConceptFunction'],
};

function concept(spec) {
  let langName, short;
  if (spec.includes(':')) { const [a, s] = spec.split(':'); langName = LANG_ALIASES[a] || a; short = s; }
  else throw new Error('concept needs a language prefix: ' + spec);
  const L = languages[langName];
  if (!L) throw new Error('unknown language ' + langName);
  const c = L.concepts[short];
  if (!c) throw new Error(`unknown concept ${langName}.${short}`);
  return c;
}

const own = (o, k) => Object.prototype.hasOwnProperty.call(o, k);
// Finds the declaring concept of a feature; returns {kind, owner, id, name}.
function feature(c, name) {
  let explicitOwner = null;
  if (name.includes('.')) { const i = name.lastIndexOf('.'); explicitOwner = name.slice(0, i); name = name.slice(i + 1); }
  const candidates = [];
  const visit = (cc, seen = new Set()) => {
    if (!cc || seen.has(cc)) return; seen.add(cc);
    candidates.push(cc);
    const hinted = Object.entries(SUPERS).find(([k]) => { try { return concept(k) === cc; } catch (e) { return false; } });
    const resolve = s => { if (typeof s !== 'string') return s; try { return concept(s); } catch (e) { return null; } }; // unknown supers carry no features
    for (const s of [...(cc.supers || []), ...(hinted ? hinted[1] : [])]) visit(resolve(s), seen);
  };
  if (explicitOwner) visit(concept(explicitOwner)); else visit(c);
  for (const [ln, s] of COMMON_SUPERS) candidates.push(languages[ln].concepts[s]);
  for (const cc of candidates) for (const kind of ['props', 'children', 'refs']) if (own(cc[kind], name)) return { kind, owner: cc, id: cc[kind][name], name };
  // last resort: unique match within the same language
  const hits = [];
  for (const cc of Object.values(c.lang.concepts)) for (const kind of ['props', 'children', 'refs']) if (own(cc[kind], name)) hits.push({ kind, owner: cc, id: cc[kind][name], name });
  let uniq = [...new Map(hits.map(h => [h.owner.fqn + h.kind, h])).values()];
  if (uniq.length === 1) return uniq[0];
  if (!uniq.length) { // unique match in any language
    const all = [];
    for (const L of Object.values(languages)) for (const cc of Object.values(L.concepts)) for (const kind of ['props', 'children', 'refs']) if (own(cc[kind], name)) all.push({ kind, owner: cc, id: cc[kind][name], name });
    uniq = [...new Map(all.map(h => [h.owner.fqn + h.kind, h])).values()];
    if (uniq.length === 1) return uniq[0];
  }
  throw new Error(`feature ${name} not found (or ambiguous: ${uniq.map(h => h.owner.fqn).join(', ')}) for ${c.fqn}`);
}

// ---------------------------------------------------------------- node ids
// Fixed-length strings over [0-9a-zA-Z] are unique ids for MPS' id decoder.
const ALPH = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
function nodeIdFor(seed) {
  const h = crypto.createHash('sha1').update(seed).digest();
  let s = '1';
  for (let i = 0; i < 9; i++) s += ALPH[h[i] % 62];
  return s;
}
function longIdFor(seed) {
  const h = crypto.createHash('sha1').update('long:' + seed).digest();
  let v = 0n;
  for (let i = 0; i < 8; i++) v = (v << 8n) | BigInt(h[i]);
  v = v & 0x3fffffffffffffffn; // positive, < 2^62
  if (v < 1000000000000000n) v += 1000000000000000n;
  return v.toString();
}
function uuidFor(seed) {
  const h = crypto.createHash('sha1').update('uuid:' + seed).digest('hex');
  return `${h.slice(0, 8)}-${h.slice(8, 12)}-4${h.slice(13, 16)}-a${h.slice(17, 20)}-${h.slice(20, 32)}`;
}

// ---------------------------------------------------------------- nodes
let seq = 0;
class Node {
  constructor(conceptSpec, features, id) {
    this.c = typeof conceptSpec === 'string' ? concept(conceptSpec) : conceptSpec;
    this.props = []; this.refs = []; this.children = [];
    this.explicitId = id;
    for (const [k, v] of Object.entries(features || {})) {
      if (v === undefined || v === null) continue;
      const f = feature(this.c, k);
      if (f.kind === 'props') this.props.push([f, String(v)]);
      else if (f.kind === 'refs') this.refs.push([f, v]);
      else for (const ch of [].concat(v)) { if (!(ch instanceof Node)) throw new Error(`child ${k} of ${this.c.fqn} is not a node`); this.children.push([f, ch]); }
    }
  }
  get name() { const p = this.props.find(([f]) => f.name === 'name'); return p ? p[1] : undefined; }
}
const N = (c, f, id) => new Node(c, f, id);

// External node target: {model: 'r:...(name)', id: '...', resolve: '...'}.
const X = (model, id, resolve) => ({ external: true, model, id, resolve });

// Looks a well-known target up in the harvested samples.
function T(modelName, resolve) {
  const hits = Object.entries(REG.targets).filter(([k]) => { const [m, r] = k.split('|'); return r === resolve && m.includes('(' + modelName + ')'); });
  if (!hits.length) throw new Error(`no harvested target ${modelName}|${resolve}`);
  hits.sort((a, b) => b[1].count - a[1].count);
  const [k, v] = hits[0];
  return X(k.split('|')[0], v.nodeId, resolve);
}

// ---------------------------------------------------------------- models
class Model {
  constructor(name, opts = {}) {
    this.name = name;
    this.uuid = opts.uuid || uuidFor('model:' + name);
    this.ref = opts.ref || `r:${this.uuid}(${name})`;
    this.devkits = opts.devkits || [];
    this.uses = opts.uses || []; // [{id,name,version}]
    this.roots = [];
    this.extraImports = opts.imports || [];
  }
  add(...roots) { for (const r of roots) this.roots.push(r); return this; }
}

function assignIds(model) {
  const used = new Set();
  const walk = (n, pathKey) => {
    n.model = model;
    let id = n.explicitId || nodeIdFor(model.name + '/' + pathKey);
    while (used.has(id)) id = nodeIdFor(id + '+');
    used.add(id); n.id = id;
    const counters = {};
    for (const [f, ch] of n.children) { const k = f.name; counters[k] = (counters[k] || 0) + 1; walk(ch, `${pathKey}/${k}[${counters[k]}]${ch.name ? ':' + ch.name : ''}`); }
  };
  model.roots.forEach((r, i) => walk(r, `root${i}:${r.c.fqn}:${r.name || ''}`));
}

const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/\n/g, '&#10;');

function emit(model, allModels) {
  // collect concepts + features
  const concepts = new Map(); // fqn -> {c, feats:Map}
  const featureOwners = new Map();
  const imports = new Map(); // modelRef -> index
  for (const im of model.extraImports) imports.set(im, null);
  const walk = n => {
    const ce = concepts.get(n.c.fqn) || (concepts.set(n.c.fqn, { c: n.c, feats: new Map() }), concepts.get(n.c.fqn));
    for (const [f] of [...n.props, ...n.refs, ...n.children]) {
      const oe = concepts.get(f.owner.fqn) || (concepts.set(f.owner.fqn, { c: f.owner, feats: new Map() }), concepts.get(f.owner.fqn));
      oe.feats.set(f.kind + ':' + f.name, f);
    }
    for (const [, t] of n.refs) {
      if (t instanceof Node) { if (t.model !== model) imports.set(t.model.ref, null); }
      else if (t.external) imports.set(t.model, null);
      else throw new Error('bad ref target in ' + n.c.fqn);
    }
    for (const [, ch] of n.children) walk(ch);
  };
  model.roots.forEach(walk);
  // index strings
  let idx = 0;
  const nextIdx = () => { const s = 'x' + (idx++).toString(36); return s; };
  const cIdx = new Map(), fIdx = new Map();
  for (const [fqn, e] of concepts) { cIdx.set(fqn, nextIdx()); for (const k of e.feats.keys()) fIdx.set(fqn + '|' + k, nextIdx()); }
  let ii = 0;
  for (const k of imports.keys()) imports.set(k, 'i' + (ii++).toString(36).padStart(3, '0'));

  const out = [];
  out.push('<?xml version="1.0" encoding="UTF-8"?>');
  out.push(`<model ref="${esc(model.ref)}">`);
  out.push('  <persistence version="9" />');
  out.push('  <languages>');
  for (const u of model.uses) out.push(`    <use id="${u.id}" name="${u.name}" version="${u.version}" />`);
  for (const d of model.devkits) out.push(`    <devkit ref="${d}" />`);
  out.push('  </languages>');
  out.push('  <imports>');
  for (const [ref, i] of imports) out.push(`    <import index="${i}" ref="${esc(ref)}" />`);
  out.push('  </imports>');
  out.push('  <registry>');
  const byLang = new Map();
  for (const [fqn, e] of concepts) { const L = e.c.lang; if (!byLang.has(L.id)) byLang.set(L.id, { L, list: [] }); byLang.get(L.id).list.push([fqn, e]); }
  for (const { L, list } of byLang.values()) {
    out.push(`    <language id="${L.id}" name="${L.name}">`);
    for (const [fqn, e] of list) {
      const head = `      <concept id="${e.c.id}" name="${fqn}" flags="${e.c.flags || 'ng'}" index="${cIdx.get(fqn)}"`;
      if (!e.feats.size) { out.push(head + ' />'); continue; }
      out.push(head + '>');
      for (const [k, f] of e.feats) {
        const tag = f.kind === 'props' ? 'property' : f.kind === 'refs' ? 'reference' : 'child';
        out.push(`        <${tag} id="${f.id}" name="${f.name}" index="${fIdx.get(fqn + '|' + k)}" />`);
      }
      out.push('      </concept>');
    }
    out.push('    </language>');
  }
  out.push('  </registry>');
  const fi = f => fIdx.get(f.owner.fqn + '|' + f.kind + ':' + f.name);
  const emitNode = (n, role, ind) => {
    const pad = ' '.repeat(ind);
    const head = `${pad}<node concept="${cIdx.get(n.c.fqn)}" id="${n.id}"${role ? ` role="${role}"` : ''}`;
    if (!n.props.length && !n.refs.length && !n.children.length) { out.push(head + ' />'); return; }
    out.push(head + '>');
    for (const [f, v] of n.props) out.push(`${pad}  <property role="${fi(f)}" value="${esc(v)}" />`);
    for (const [f, t] of n.refs) {
      if (t instanceof Node) {
        const res = t.name !== undefined ? ` resolve="${esc(t.name)}"` : '';
        if (t.model === model) out.push(`${pad}  <ref role="${fi(f)}" node="${t.id}"${res} />`);
        else out.push(`${pad}  <ref role="${fi(f)}" to="${imports.get(t.model.ref)}:${t.id}"${res} />`);
      } else out.push(`${pad}  <ref role="${fi(f)}" to="${imports.get(t.model)}:${esc(t.id)}"${t.resolve !== undefined ? ` resolve="${esc(t.resolve)}"` : ''} />`);
    }
    for (const [f, ch] of n.children) emitNode(ch, fi(f), ind + 2);
    out.push(`${pad}</node>`);
  };
  for (const r of model.roots) emitNode(r, null, 2);
  out.push('</model>');
  return out.join('\n') + '\n';
}

function writeModels(models, fileFor) {
  for (const m of models) assignIds(m);
  for (const m of models) {
    const file = fileFor(m);
    fs.mkdirSync(path.dirname(file), { recursive: true });
    fs.writeFileSync(file, emit(m, models));
  }
}

module.exports = { N, X, T, Model, Node, concept, feature, defineLanguage, defineConcept, languages, writeModels, nodeIdFor, longIdFor, uuidFor, esc };
