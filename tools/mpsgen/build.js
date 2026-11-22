// Builds the WVDL MPS project files into the repository root.
// Usage: node tools/mpsgen/build.js
'use strict';
const fs = require('fs');
const path = require('path');
const G = require('./mpsgen');
const S = require('./wvdl/structure');

const ROOT = path.resolve(__dirname, '..', '..');
const LANG_DIR = path.join(ROOT, 'languages', 'wvdl');
const w = (rel, txt) => { const f = path.join(ROOT, rel); fs.mkdirSync(path.dirname(f), { recursive: true }); fs.writeFileSync(f, txt); };

const ids = {
  lang: S.LANG_ID,
  sandbox: G.uuidFor('wvdl-sandbox'),
  reasoner: G.uuidFor('wvdl-reasoner'),
  tests: G.uuidFor('wvdl-tests'),
};
module.exports.ids = ids;

const DEVKIT = {
  structure: '78434eb8-b0e5-444b-850d-e7c4ad2da9ab(jetbrains.mps.devkit.aspect.structure)',
  editor: 'fbc25dd2-5da4-483a-8b19-70928e1b62d7(jetbrains.mps.devkit.general-purpose)',
  behavior: 'fbc25dd2-5da4-483a-8b19-70928e1b62d7(jetbrains.mps.devkit.general-purpose)',
  constraints: '00000000-0000-4000-0000-5604ebd4f22c(jetbrains.mps.devkit.aspect.constraints)',
  typesystem: '00000000-0000-4000-0000-1de82b3a4936(jetbrains.mps.devkit.aspect.typesystem)',
  textGen: 'fa73d85a-ac7f-447b-846c-fcdc41caa600(jetbrains.mps.devkit.aspect.textgen)',
  languageDesign: '2677cb18-f558-4e33-bc38-a5139cee06dc(jetbrains.mps.devkit.language-design)',
};
const USE = (alias, version) => {
  const name = { ed: 'jetbrains.mps.lang.editor', tbl: 'jetbrains.mps.lang.editor.table', bh: 'jetbrains.mps.lang.behavior', sc: 'jetbrains.mps.lang.scopes', ts: 'jetbrains.mps.lang.typesystem', tg: 'jetbrains.mps.lang.textGen', test: 'jetbrains.mps.lang.test', bl: 'jetbrains.mps.baseLanguage', sm: 'jetbrains.mps.lang.smodel', core: 'jetbrains.mps.lang.core' }[alias] || alias;
  return { id: G.languages[name].id, name, version };
};

// ------------------------------------------------------------------ models
const structure = new G.Model('wvdl.structure', { devkits: [DEVKIT.structure] });
const decl = S.buildStructureModel(structure);

const models = [structure];
const fileOf = new Map([[structure, path.join(LANG_DIR, 'models', 'structure.mps')]]);

// further aspects are plugged in by the aspect modules
const ctx = { G, S, decl, DEVKIT, USE, ids, models, fileOf, LANG_DIR, ROOT };
for (const aspect of ['editor', 'behavior', 'constraints', 'typesystem', 'textGen', 'sandbox', 'tests']) {
  const f = path.join(__dirname, 'wvdl', aspect + '.js');
  if (fs.existsSync(f)) require(f).build(ctx);
}

G.writeModels(models, m => fileOf.get(m));

// ------------------------------------------------------------------ module descriptors
const langVersions = require('./wvdl/versions').languageVersions;
w('languages/wvdl/wvdl.mpl', `<?xml version="1.0" encoding="UTF-8"?>
<language namespace="wvdl" uuid="${ids.lang}" languageVersion="0" moduleVersion="0">
  <models>
    <modelRoot contentPath="\${module}" type="default">
      <sourceRoot location="models" />
    </modelRoot>
  </models>
  <facets>
    <facet type="java" compile="mps" classes="mps" ext="yes">
      <classes generated="true" path="\${module}/classes_gen" />
    </facet>
  </facets>
  <accessoryModels />
  <generators />
  <dependencies>
    <dependency reexport="false">2d3c70e9-aab2-4870-8d8d-6036800e4103(jetbrains.mps.kernel)</dependency>
    <dependency reexport="false">d7eb0a2a-bd50-4576-beae-e4a89db35f20(jetbrains.mps.lang.scopes.runtime)</dependency>
    <dependency reexport="false">${ids.reasoner}(wvdl.reasoner)</dependency>
  </dependencies>
  <languageVersions>
${langVersions}
  </languageVersions>
  <dependencyVersions>
    <module reference="3f233e7f-b8a6-46d2-a57f-795d56775243(Annotations)" version="0" />
    <module reference="6354ebe7-c22a-4a0f-ac54-50b52ab9b065(JDK)" version="0" />
    <module reference="6ed54515-acc8-4d1e-a16c-9fd6cfe951ea(MPS.Core)" version="0" />
    <module reference="8865b7a8-5271-43d3-884c-6fd1d9cfdd34(MPS.OpenAPI)" version="0" />
    <module reference="2d3c70e9-aab2-4870-8d8d-6036800e4103(jetbrains.mps.kernel)" version="0" />
    <module reference="ceab5195-25ea-4f22-9b92-103b95ca8c0c(jetbrains.mps.lang.core)" version="0" />
    <module reference="a9e4c532-c5f5-4bb7-99ef-42abb73bbb70(jetbrains.mps.lang.descriptor.aspects)" version="0" />
    <module reference="d7eb0a2a-bd50-4576-beae-e4a89db35f20(jetbrains.mps.lang.scopes.runtime)" version="0" />
    <module reference="9ded098b-ad6a-4657-bfd9-48636cfe8bc3(jetbrains.mps.lang.traceable)" version="0" />
    <module reference="${ids.lang}(wvdl)" version="0" />
    <module reference="${ids.reasoner}(wvdl.reasoner)" version="0" />
  </dependencyVersions>
  <extendedLanguages />
</language>
`);

w('solutions/wvdl.reasoner/wvdl.reasoner.msd', `<?xml version="1.0" encoding="UTF-8"?>
<solution name="wvdl.reasoner" uuid="${ids.reasoner}" moduleVersion="0" compileInMPS="true">
  <models>
    <modelRoot contentPath="\${module}" type="java_classes">
      <sourceRoot location="lib" />
    </modelRoot>
  </models>
  <facets>
    <facet type="java" compile="mps" classes="mps" ext="no">
      <classes generated="true" path="\${module}/classes_gen" />
      <library location="\${module}/lib/wvdl-reasoner.jar" />
    </facet>
  </facets>
  <sourcePath />
  <dependencies>
    <dependency reexport="false">6354ebe7-c22a-4a0f-ac54-50b52ab9b065(JDK)</dependency>
    <dependency reexport="false">8865b7a8-5271-43d3-884c-6fd1d9cfdd34(MPS.OpenAPI)</dependency>
    <dependency reexport="false">6ed54515-acc8-4d1e-a16c-9fd6cfe951ea(MPS.Core)</dependency>
    <dependency reexport="false">1ed103c3-3aa6-49b7-9c21-6765ee11f224(MPS.Editor)</dependency>
    <dependency reexport="false">258bd2f6-0d02-411d-86b2-5a5ea083e6d2(jetbrains.mps.lang.editor.table.runtime)</dependency>
  </dependencies>
  <languageVersions />
  <dependencyVersions>
    <module reference="${ids.reasoner}(wvdl.reasoner)" version="0" />
  </dependencyVersions>
</solution>
`);

w('solutions/wvdl.sandbox/wvdl.sandbox.msd', `<?xml version="1.0" encoding="UTF-8"?>
<solution name="wvdl.sandbox" uuid="${ids.sandbox}" moduleVersion="0">
  <models>
    <modelRoot contentPath="\${module}" type="default">
      <sourceRoot location="models" />
    </modelRoot>
  </models>
  <facets>
    <facet type="java" compile="mps" classes="mps" ext="no">
      <classes generated="true" path="\${module}/classes_gen" />
    </facet>
  </facets>
  <languageVersions>
    <language slang="l:ceab5195-25ea-4f22-9b92-103b95ca8c0c:jetbrains.mps.lang.core" version="2" />
    <language slang="l:${ids.lang}:wvdl" version="0" />
  </languageVersions>
  <dependencyVersions>
    <module reference="${ids.sandbox}(wvdl.sandbox)" version="0" />
  </dependencyVersions>
</solution>
`);

const modules = ['languages/wvdl/wvdl.mpl', 'solutions/wvdl.reasoner/wvdl.reasoner.msd', 'solutions/wvdl.sandbox/wvdl.sandbox.msd'];
if (fs.existsSync(path.join(ROOT, 'solutions/wvdl.tests/wvdl.tests.msd'))) modules.push('solutions/wvdl.tests/wvdl.tests.msd');
w('.mps/modules.xml', `<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="MPSProject">
    <projectModules>
${modules.map(m => `      <modulePath path="$PROJECT_DIR$/${m}" folder="" />`).join('\n')}
    </projectModules>
  </component>
</project>
`);
w('.mps/.name', 'WVDL\n');
w('.mps/encodings.xml', `<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="Encoding">
    <file url="PROJECT" charset="UTF-8" />
  </component>
</project>
`);
w('.mps/version.xml', `<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="ProjectVersion">
    <option name="version" value="3.1" />
  </component>
</project>
`);
w('.mps/migration.xml', fs.readFileSync(path.join(__dirname, 'wvdl', 'migration.xml'), 'utf8'));
console.log('WVDL project written to', ROOT);
