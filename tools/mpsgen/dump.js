// Pretty-prints roots of an .mps file with concept/role names resolved.
// Usage: node dump.js <file.mps> [ConceptShortName] [maxRoots]
'use strict';
const fs = require('fs');
const [file, want, max = '3'] = process.argv.slice(2);
const txt = fs.readFileSync(file, 'utf8');
const idx = {};
for (const m of txt.matchAll(/<(concept|property|child|reference) id="[^"]+" name="([^"]+)"[^>]*index="([^"]+)"/g)) idx[m[3]] = m[2].split('.').pop();
const imports = {};
for (const m of txt.matchAll(/<import index="([^"]+)" ref="([^"]+)"/g)) imports[m[1]] = m[2].replace(/^.*\(/, '(');
let out = [], depth = 0, roots = 0, printing = false;
for (const line of txt.split('\n')) {
  const t = line.trim();
  const ind = line.search(/\S/);
  if (ind === 2 && t.startsWith('<node ')) {
    const c = idx[(t.match(/concept="([^"]+)"/) || [])[1]];
    printing = (!want || c === want) && roots < +max;
    if (printing) roots++;
  }
  if (!printing) continue;
  let s = t
    .replace(/concept="([^"]+)"/, (_, i) => idx[i] || i)
    .replace(/role="([^"]+)"/, (_, i) => 'role=' + (idx[i] || i))
    .replace(/to="([^":]+):([^"]+)"/, (_, i, n) => `to=${imports[i] || i}:${n}`)
    .replace(/ id="[^"]+"/, '');
  out.push(' '.repeat(Math.max(0, ind - 2)) + s);
}
console.log(out.join('\n'));
