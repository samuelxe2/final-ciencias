// Compiles reasoner/src into solutions/wvdl.reasoner/lib/wvdl-reasoner.jar and
// runs the plain-Java self tests. Uses the JDK bundled with MPS.
// Usage: node tools/build-reasoner.js [--mps "C:/Program Files/JetBrains/MPS 2026.2"]
'use strict';
const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const argMps = process.argv.indexOf('--mps');
const MPS = argMps > 0 ? process.argv[argMps + 1] : (process.env.MPS_HOME || 'C:/Program Files/JetBrains/MPS 2026.2');
const JBR = path.join(MPS, 'jbr', 'bin');
const exe = n => path.join(JBR, process.platform === 'win32' ? n + '.exe' : n);

const files = dir => fs.readdirSync(dir, { withFileTypes: true }).flatMap(e => e.isDirectory() ? files(path.join(dir, e.name)) : e.name.endsWith('.java') ? [path.join(dir, e.name)] : []);

const cp = [
  path.join(MPS, 'lib', 'mps-openapi.jar'),
  path.join(MPS, 'lib', 'mps-core.jar'),
  path.join(MPS, 'lib', 'mps-annotations.jar'),
  path.join(MPS, 'lib', 'annotations.jar'),
  path.join(MPS, 'plugins', 'mps-core', 'languages', 'languageDesign', 'jetbrains.mps.lang.editor.table.runtime.jar'),
].filter(f => fs.existsSync(f)).join(path.delimiter);

const out = path.join(ROOT, 'reasoner', 'build', 'classes');
const testOut = path.join(ROOT, 'reasoner', 'build', 'test');
fs.rmSync(path.join(ROOT, 'reasoner', 'build'), { recursive: true, force: true });
fs.mkdirSync(out, { recursive: true });
fs.mkdirSync(testOut, { recursive: true });

const run = (cmd, args) => execFileSync(cmd, args, { stdio: 'inherit' });
console.log('javac (reasoner)...');
run(exe('javac'), ['--release', '21', '-encoding', 'UTF-8', '-nowarn', '-cp', cp, '-d', out, ...files(path.join(ROOT, 'reasoner', 'src'))]);
console.log('javac (tests)...');
run(exe('javac'), ['--release', '21', '-encoding', 'UTF-8', '-cp', out, '-d', testOut, ...files(path.join(ROOT, 'reasoner', 'test'))]);
console.log('self tests...');
run(exe('java'), ['-Dstdout.encoding=UTF-8', '-cp', out + path.delimiter + testOut, 'wvdl.reasoner.ReasonerSelfTest']);

const jar = path.join(ROOT, 'solutions', 'wvdl.reasoner', 'lib', 'wvdl-reasoner.jar');
fs.mkdirSync(path.dirname(jar), { recursive: true });
writeJar(jar, out);
console.log('written', path.relative(ROOT, jar));

// Minimal deterministic jar (zip) writer: the bundled JBR has no `jar` tool.
function writeJar(file, dir) {
  const zlib = require('zlib');
  const crcTable = new Int32Array(256).map((_, n) => { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1; return c; });
  const crc32 = buf => { let c = -1; for (const b of buf) c = crcTable[(c ^ b) & 0xff] ^ (c >>> 8); return (c ^ -1) >>> 0; };
  const all = d => fs.readdirSync(d, { withFileTypes: true }).flatMap(e => e.isDirectory() ? all(path.join(d, e.name)) : [path.join(d, e.name)]);
  const entries = [['META-INF/MANIFEST.MF', Buffer.from('Manifest-Version: 1.0\r\nCreated-By: wvdl build-reasoner\r\n\r\n')]]
    .concat(all(dir).sort().map(f => [path.relative(dir, f).split(path.sep).join('/'), fs.readFileSync(f)]));
  const parts = [], central = [];
  let offset = 0;
  const DOS_TIME = 0, DOS_DATE = (2026 - 1980) << 9 | 1 << 5 | 1; // fixed date => reproducible jar
  for (const [name, data] of entries) {
    const nameBuf = Buffer.from(name, 'utf8');
    const comp = zlib.deflateRawSync(data);
    const crc = crc32(data);
    const local = Buffer.alloc(30);
    local.writeUInt32LE(0x04034b50, 0); local.writeUInt16LE(20, 4); local.writeUInt16LE(0x0800, 6); local.writeUInt16LE(8, 8);
    local.writeUInt16LE(DOS_TIME, 10); local.writeUInt16LE(DOS_DATE, 12); local.writeUInt32LE(crc, 14);
    local.writeUInt32LE(comp.length, 18); local.writeUInt32LE(data.length, 22); local.writeUInt16LE(nameBuf.length, 26); local.writeUInt16LE(0, 28);
    parts.push(local, nameBuf, comp);
    const cen = Buffer.alloc(46);
    cen.writeUInt32LE(0x02014b50, 0); cen.writeUInt16LE(20, 4); cen.writeUInt16LE(20, 6); cen.writeUInt16LE(0x0800, 8); cen.writeUInt16LE(8, 10);
    cen.writeUInt16LE(DOS_TIME, 12); cen.writeUInt16LE(DOS_DATE, 14); cen.writeUInt32LE(crc, 16); cen.writeUInt32LE(comp.length, 20);
    cen.writeUInt32LE(data.length, 24); cen.writeUInt16LE(nameBuf.length, 28); cen.writeUInt32LE(offset, 42);
    central.push(cen, nameBuf);
    offset += 30 + nameBuf.length + comp.length;
  }
  const cenSize = central.reduce((s, b) => s + b.length, 0);
  const end = Buffer.alloc(22);
  end.writeUInt32LE(0x06054b50, 0); end.writeUInt16LE(entries.length, 8); end.writeUInt16LE(entries.length, 10);
  end.writeUInt32LE(cenSize, 12); end.writeUInt32LE(offset, 16);
  fs.writeFileSync(file, Buffer.concat([...parts, ...central, end]));
}
