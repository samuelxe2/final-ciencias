// Complements registry.json with the full structure of MPS languages, parsed
// from the generated StructureAspectDescriptor.java files inside the *-src.jar
// archives of an MPS installation (concept ids, features and super-concepts).
// Usage: node harvest-src.js "<MPS home>"   (rewrites registry.json in place)
'use strict';
const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const MPS = process.argv[2] || 'C:/Program Files/JetBrains/MPS 2026.2';
const regFile = path.join(__dirname, 'registry.json');
const REG = JSON.parse(fs.readFileSync(regFile, 'utf8'));

const jars = [];
const walk = d => { for (const e of fs.readdirSync(d, { withFileTypes: true })) { const p = path.join(d, e.name); if (e.isDirectory()) walk(p); else if (e.name.endsWith('-src.jar')) jars.push(p); } };
walk(path.join(MPS, 'languages'));
walk(path.join(MPS, 'plugins'));

const hex = h => BigInt('0x' + h);
const uuid = (hi, lo) => { const s = hex(hi).toString(16).padStart(16, '0') + hex(lo).toString(16).padStart(16, '0'); return `${s.slice(0, 8)}-${s.slice(8, 12)}-${s.slice(12, 16)}-${s.slice(16, 20)}-${s.slice(20)}`; };

const byId = new Map(); // langUuid:conceptId -> [langName, short]
const parsed = [];
let files = 0;
for (const jar of jars) {
  let list;
  try { list = execFileSync('unzip', ['-Z1', jar], { encoding: 'utf8', maxBuffer: 1 << 26 }); } catch (e) { continue; }
  for (const entry of list.split('\n').filter(l => l.endsWith('/structure/StructureAspectDescriptor.java'))) {
    const src = execFileSync('unzip', ['-p', jar, entry], { encoding: 'utf8', maxBuffer: 1 << 26 });
    files++;
    for (const m of src.matchAll(/new ConceptDescriptorBuilder2\("([^"]+)", "([^"]+)", 0x([0-9a-f]+)L, 0x([0-9a-f]+)L, 0x([0-9a-f]+)L\);([\s\S]*?)return b\.create\(\);/g)) {
      const [, lang, short, hi, lo, cid, body] = m;
      const L = uuid(hi, lo);
      const c = { lang, L, short, id: hex(cid).toString(), props: {}, children: {}, refs: {}, superIds: [], iface: /b\.interface_\(\)/.test(body) };
      for (const s of body.matchAll(/b\.(?:super_|parent)\(0x([0-9a-f]+)L, 0x([0-9a-f]+)L, 0x([0-9a-f]+)L\)/g)) c.superIds.push(uuid(s[1], s[2]) + ':' + hex(s[3]).toString());
      for (const p of body.matchAll(/b\.(?:prop|property)\("([^"]+)", 0x([0-9a-f]+)L/g)) c.props[p[1]] = hex(p[2]).toString();
      for (const a of body.matchAll(/b\.aggregate\("([^"]+)", 0x([0-9a-f]+)L/g)) c.children[a[1]] = hex(a[2]).toString();
      for (const a of body.matchAll(/b\.associate\("([^"]+)", 0x([0-9a-f]+)L/g)) c.refs[a[1]] = hex(a[2]).toString();
      byId.set(L + ':' + c.id, [lang, short]);
      parsed.push(c);
    }
  }
}

let added = 0;
for (const c of parsed) {
  const L = REG.langs[c.L] || (REG.langs[c.L] = { name: c.lang, concepts: {} });
  const fqn = `${c.lang}.structure.${c.short}`;
  const e = L.concepts[fqn] || (added++, L.concepts[fqn] = { id: c.id, flags: c.iface ? 'ngI' : 'ng', props: {}, children: {}, refs: {} });
  for (const k of ['props', 'children', 'refs']) for (const [n, v] of Object.entries(c[k])) if (!Object.prototype.hasOwnProperty.call(e[k], n)) e[k][n] = v;
  e.supers = c.superIds.map(s => byId.get(s)).filter(Boolean).map(([ln, sh]) => `${ln}:${sh}`);
}
fs.writeFileSync(regFile, JSON.stringify(REG, null, 1));
console.log(`parsed ${files} descriptors, ${parsed.length} concepts, ${added} new`);
