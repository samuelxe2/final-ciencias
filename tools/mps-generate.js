// Headless MPS make: generates + compiles the WVDL language and solutions with
// the MPS ant tasks (no IDE needed). Output goes to source_gen/classes_gen of
// each module; the sandbox TextGen writes the JSON reports.
// Usage: node tools/mps-generate.js [--mps <MPS home>] [module ...]
'use strict';
const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const args = process.argv.slice(2);
const iMps = args.indexOf('--mps');
const MPS = iMps >= 0 ? args.splice(iMps, 2)[1] : (process.env.MPS_HOME || 'C:/Program Files/JetBrains/MPS 2026.2');
const fwd = p => p.split(path.sep).join('/');

const all = {
  reasoner: 'solutions/wvdl.reasoner/wvdl.reasoner.msd',
  lang: 'languages/wvdl/wvdl.mpl',
  sandbox: 'solutions/wvdl.sandbox/wvdl.sandbox.msd',
  tests: 'solutions/wvdl.tests/wvdl.tests.msd',
};
const wanted = (args.length ? args : ['lang', 'sandbox', 'tests']).filter(k => k !== 'reasoner' && fs.existsSync(path.join(ROOT, all[k])));

const work = path.join(ROOT, 'build', 'mps');
fs.mkdirSync(work, { recursive: true });
const sys = fwd(path.join(work, 'system'));
const chunks = wanted.map(k => `      <chunk><module file="${fwd(path.join(ROOT, all[k]))}"/></chunk>`).join('\n');
const buildXml = `<project name="wvdl-generate" default="gen">
  <property name="mps_home" location="${fwd(MPS)}"/>
  <property name="mps.home" location="\${mps_home}"/>
  <property name="artifacts.mps" location="\${mps_home}"/>
  <path id="p"><pathelement location="\${mps_home}/lib/ant/lib/ant-mps.jar"/><pathelement location="\${mps_home}/lib/util-8.jar"/></path>
  <taskdef resource="jetbrains/mps/build/ant/antlib.xml" classpathref="p"/>
  <generator-settings id="s" strictMode="true" parallelThreads="4" inplaceTransform="false" warnWrongChild="true" createStaticRefs="true" skipUnmodifiedModels="false"/>
  <target name="gen">
    <generate fork="true" logLevel="info" mpsHome="\${mps_home}" targetJavaVersion="21">
      <settings refid="s"/>
      <plugin path="\${mps_home}/plugins/mps-core" id="jetbrains.mps.core"/>
      <plugin path="\${mps_home}/plugins/mps-testing" id="jetbrains.mps.testing"/>
      <repository><module file="${fwd(path.join(ROOT, all.reasoner))}"/></repository>
${chunks}
      <jvmargs>
        <arg value="-ea"/><arg value="-Xmx2048m"/>
        <arg value="-Didea.system.path=${sys}/system"/>
        <arg value="-Didea.config.path=${sys}/config"/>
        <arg value="-Didea.log.path=${sys}/log"/>
      </jvmargs>
      <macro name="mps_home" path="\${mps_home}"/>
    </generate>
  </target>
</project>
`;
fs.writeFileSync(path.join(work, 'build.xml'), buildXml);
const java = path.join(MPS, 'jbr', 'bin', process.platform === 'win32' ? 'java.exe' : 'java');
const r = spawnSync(java, ['-cp', path.join(MPS, 'lib', 'ant', 'lib', 'ant-launcher.jar'), 'org.apache.tools.ant.launch.Launcher',
  '-lib', path.join(MPS, 'lib', 'util-8.jar'), '-f', path.join(work, 'build.xml')], { stdio: ['ignore', 'pipe', 'pipe'], maxBuffer: 1 << 28 });
const noise = /Classpath: \[|Trying to override old definition|^\s*$|Devkit .* has associated plan|Interpreted plan|Generation plan for model/;
for (const line of (String(r.stdout) + String(r.stderr)).split(/\r?\n/)) if (!noise.test(line)) console.log(line.length > 400 ? line.slice(0, 400) + " ..." : line);
// copy the JSON reports produced by the sandbox TextGen to reportes/ (evidence for the deliverable)
const gen = path.join(ROOT, 'solutions', 'wvdl.sandbox', 'source_gen');
const out = path.join(ROOT, 'reportes');
const copyJson = d => fs.existsSync(d) && fs.readdirSync(d, { withFileTypes: true }).forEach(e => {
  const p = path.join(d, e.name);
  if (e.isDirectory()) copyJson(p);
  else if (e.name.endsWith('.json')) { fs.mkdirSync(out, { recursive: true }); fs.copyFileSync(p, path.join(out, e.name)); }
});
if (r.status === 0) { copyJson(gen); console.log('reportes JSON copiados a reportes/'); }
process.exit(r.status === null ? 1 : r.status);
