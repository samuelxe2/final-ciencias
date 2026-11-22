// Runs the jetbrains.mps.lang.test tests of solutions/wvdl.tests headlessly
// (ant <launchtests>). Generate first with: node tools/mps-generate.js
// Usage: node tools/mps-test.js [--mps <MPS home>]
'use strict';
const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const args = process.argv.slice(2);
const iMps = args.indexOf('--mps');
const MPS = iMps >= 0 ? args[iMps + 1] : (process.env.MPS_HOME || 'C:/Program Files/JetBrains/MPS 2026.2');
const fwd = p => p.split(path.sep).join('/');
const R = fwd(ROOT), SYS = fwd(path.join(ROOT, 'build', 'mps', 'system'));

const xml = `<project name="wvdl-test" default="test">
  <property name="mps_home" location="${fwd(MPS)}"/>
  <property name="mps.home" location="\${mps_home}"/>
  <property name="artifacts.mps" location="\${mps_home}"/>
  <property name="mpsTestingPluginHome" location="\${mps_home}/plugins/mps-testing"/>
  <path id="p"><pathelement location="\${mps_home}/lib/ant/lib/ant-mps.jar"/><pathelement location="\${mps_home}/lib/util-8.jar"/></path>
  <taskdef resource="jetbrains/mps/build/ant/antlib.xml" classpathref="p"/>
  <target name="test">
    <launchtests haltOnFailure="false" failOnError="false">
      <project path="${R}"/>
      <testmodules><file file="${R}/solutions/wvdl.tests/wvdl.tests.msd"/></testmodules>
      <jvmargs>
        <arg value="-ea"/><arg value="-Xmx2048m"/>
        <arg value="-Didea.system.path=${SYS}/system"/><arg value="-Didea.config.path=${SYS}/config"/><arg value="-Didea.log.path=${SYS}/log"/>
      </jvmargs>
      <macro name="mps_home" path="\${mps_home}"/>
    </launchtests>
  </target>
</project>
`;
const work = path.join(ROOT, 'build', 'mps');
fs.mkdirSync(work, { recursive: true });
fs.writeFileSync(path.join(work, 'test.xml'), xml);
const java = path.join(MPS, 'jbr', 'bin', process.platform === 'win32' ? 'java.exe' : 'java');
const r = spawnSync(java, ['-cp', path.join(MPS, 'lib', 'ant', 'lib', 'ant-launcher.jar'), 'org.apache.tools.ant.launch.Launcher',
  '-lib', path.join(MPS, 'lib', 'util-8.jar'), '-f', path.join(work, 'test.xml')], { encoding: 'utf8', maxBuffer: 1 << 28 });
const log = (r.stdout || '') + (r.stderr || '');
fs.writeFileSync(path.join(work, 'test.log'), log);

let total = 0;
const genDir = path.join(ROOT, 'solutions', 'wvdl.tests', 'test_gen');
const walk = d => fs.existsSync(d) && fs.readdirSync(d, { withFileTypes: true }).forEach(e => {
  const p = path.join(d, e.name);
  if (e.isDirectory()) walk(p);
  else if (e.name.endsWith('_Test.java')) { const n = (fs.readFileSync(p, 'utf8').match(/@Test/g) || []).length; total += n; console.log(`${e.name.padEnd(32)} ${n} pruebas`); }
});
walk(genDir);
const failures = log.split(/\r?\n/).filter(l => l.includes('Test failure'));
failures.forEach(l => console.log(l.replace(/^\s*\[launchtests\]\s*/, '').slice(0, 300)));
console.log(`\n${total - failures.length}/${total} pruebas lang.test OK (log: build/mps/test.log)`);
process.exit(failures.length || r.status ? 1 : 0);
