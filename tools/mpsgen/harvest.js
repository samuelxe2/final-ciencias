// Harvests MPS meta-information (concept/feature ids and well-known node targets)
// from existing .mps model files (e.g. the MPS bundled samples), so that the
// generator can emit persistence-9 models with correct ids.
// Usage: node harvest.js <dir-with-mps-files>... > registry.json
'use strict';
const fs = require('fs');
const path = require('path');

const langs = {};   // langId -> {name, concepts: {fqn -> concept}}
const targets = {}; // "modelRef|resolveName" -> {nodeId, count}

function walk(dir, out) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) { if (e.name !== 'source_gen' && e.name !== 'classes_gen') walk(p, out); }
    else if (e.name.endsWith('.mps')) out.push(p);
  }
  return out;
}

const attr = (s, n) => { const m = s.match(new RegExp('\\b' + n + '="([^"]*)"')); return m ? m[1] : undefined; };

function harvest(file) {
  const txt = fs.readFileSync(file, 'utf8');
  const reg = txt.match(/<registry>([\s\S]*?)<\/registry>/);
  if (reg) {
    const langRe = /<language id="([^"]+)" name="([^"]+)">([\s\S]*?)<\/language>/g;
    let lm;
    while ((lm = langRe.exec(reg[1]))) {
      const L = langs[lm[1]] || (langs[lm[1]] = { name: lm[2], concepts: {} });
      const cRe = /<concept ([^>]*?)(\/>|>([\s\S]*?)<\/concept>)/g;
      let cm;
      while ((cm = cRe.exec(lm[3]))) {
        const head = cm[1];
        const fqn = attr(head, 'name');
        const C = L.concepts[fqn] || (L.concepts[fqn] = { id: attr(head, 'id'), flags: attr(head, 'flags'), props: {}, children: {}, refs: {} });
        const body = cm[3] || '';
        const fRe = /<(property|child|reference) ([^>]*?)\/>/g;
        let fm;
        while ((fm = fRe.exec(body))) {
          const kind = fm[1] === 'property' ? 'props' : fm[1] === 'child' ? 'children' : 'refs';
          C[kind][attr(fm[2], 'name')] = attr(fm[2], 'id');
        }
      }
    }
  }
  // imports: index -> model ref
  const imports = {};
  const iRe = /<import index="([^"]+)" ref="([^"]+)"/g;
  let im;
  while ((im = iRe.exec(txt))) imports[im[1]] = im[2];
  const tRe = /to="([^":]+):([^"]+)" resolve="([^"]*)"/g;
  let tm;
  while ((tm = tRe.exec(txt))) {
    const mref = imports[tm[1]];
    if (!mref) continue;
    const k = mref + '|' + tm[3];
    const T = targets[k] || (targets[k] = { nodeId: tm[2], count: 0 });
    T.count++;
  }
}

const files = [];
for (const d of process.argv.slice(2)) walk(d, files);
files.forEach(harvest);
process.stdout.write(JSON.stringify({ langs, targets }, null, 1));
process.stderr.write(`harvested ${files.length} files, ${Object.keys(langs).length} languages, ${Object.keys(targets).length} targets\n`);
