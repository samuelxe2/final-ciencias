// Tests (jetbrains.mps.lang.test):
//  * SemanticaEstatica / Razonador: test nodes annotated with the errors and
//    warnings that the typesystem rules (i.e. the reasoner) must report;
//    valid workflows are checked to have no errors at all.
//  * Inferencias: test methods asserting the facts inferred by the reasoner
//    (reachability sets, livelocks, shortest paths, actors, simulation).
'use strict';
const fs = require('fs');
const path = require('path');

module.exports.build = ({ G, S, USE, ids, models, fileOf, ROOT }) => {
  const { N, X } = G;
  const STUB = `${ids.reasoner}/java:wvdl.reasoner.mps(wvdl.reasoner/)`;
  const UT = G.languages['jetbrains.mps.baseLanguage.unitTest'];
  const TEST = G.languages['jetbrains.mps.lang.test'];
  const fresh = () => require('./sandbox').cases(G, S); // new nodes for every test model

  const attr = (node, a) => { node.children.push([G.feature(node.c, 'smodelAttribute'), a]); return node; };
  const ops = (node, ...operations) => attr(node, N('test:NodeOperationsContainer', { nodeOperations: operations }));
  const hasError = node => ops(node, N('test:NodeErrorCheckOperation'));
  const hasWarning = node => ops(node, N('test:NodeWarningCheckOperation'));
  const noErrors = (node, allowWarnings) => ops(node, N('test:CheckNodeForErrorMessagesOperation', { includeSelf: 'true', allowWarnings: allowWarnings ? 'true' : undefined }));
  const testNode = node => N('test:TestNode', { nodeToCheck: node });

  // ------------------------------------------------------------ errores esperados
  const a = fresh();
  hasError(a.IS1.trs.T2);                 // WF-OUT-OF-SCOPE
  hasError(a.IS2.guards.T1);              // T-GUARD
  hasError(a.IS3.acts.Calcular);          // T-ROLE
  hasError(a.IS3.states.Inicio2);         // I1
  noErrors(a.V01); noErrors(a.V02); noErrors(a.V03); noErrors(a.otro);
  const estaticos = N('test:NodesTestCase', {
    name: 'SemanticaEstatica',
    nodesToCheck: [a.V01, a.V02, a.V03, a.otro, a.IS1, a.IS2, a.IS3].map(testNode),
  });

  hasWarning(a.IR1.states.Archivado);     // WF-UNREACHABLE
  hasError(a.IR2.states.Espera);          // WF-DEADLOCK
  hasError(a.IR3.states.Revision);        // WF-LIVELOCK
  hasError(a.IR3.states.Correccion);      // WF-LIVELOCK
  hasWarning(a.IR4.guards.T2);            // WF-DEAD-GUARD
  hasWarning(a.IR4.acts.Auditar);         // WF-UNASSIGNED-ROLE
  hasWarning(a.IR4.states.Excepcion);     // WF-UNREACHABLE
  hasWarning(a.caso.states.Archivada);    // WF-UNREACHABLE
  const razonador = N('test:NodesTestCase', {
    name: 'Razonador',
    nodesToCheck: [a.IR1, a.IR2, a.IR3, a.IR4, a.caso].map(testNode),
  });

  // ------------------------------------------------------------ inferencias (verificaciones declaradas)
  // Los workflows válidos declaran propiedades VERDADERAS (sound, alcanzabilidad,
  // ruta más corta, actores inferidos, fin de la simulación): no debe haber errores.
  // El contraejemplo declara propiedades FALSAS: cada una debe reportarse como error.
  const b = fresh();
  for (const root of [b.V01, b.V02, b.V03]) noErrors(root);
  noErrors(b.caso, true); // Archivada es inalcanzable a propósito (advertencia esperada)
  for (const chk of b.CE.checkNodes) hasError(chk);  // WF-CHECK-FAILED
  hasError(b.CE.states.Bucle);                        // WF-LIVELOCK (auto-bucle sin salida)
  hasWarning(b.CE.states.Olvidado);                   // WF-UNREACHABLE
  const inferencias = N('test:NodesTestCase', {
    name: 'Inferencias',
    nodesToCheck: [b.V01, b.V02, b.V03, b.caso, b.CE].map(testNode),
  });

  const uses = [
    { id: TEST.id, name: TEST.name, version: 6 },
    { id: UT.id, name: UT.name, version: 1 },
    { id: G.languages['jetbrains.mps.baseLanguage'].id, name: 'jetbrains.mps.baseLanguage', version: 12 },
    { id: S.LANG_ID, name: 'wvdl', version: 0 },
  ];
  const dir = path.join(ROOT, 'solutions', 'wvdl.tests', 'models');
  const m1 = new G.Model('wvdl.tests.diagnosticos@tests', { uses }).add(estaticos, razonador);
  const m2 = new G.Model('wvdl.tests.inferencias@tests', { uses }).add(inferencias);
  for (const m of [m1, m2]) { models.push(m); fileOf.set(m, path.join(dir, m.name + '.mps')); }

  const msd = `<?xml version="1.0" encoding="UTF-8"?>
<solution name="wvdl.tests" uuid="${ids.tests}" moduleVersion="0">
  <models>
    <modelRoot contentPath="\${module}" type="default">
      <sourceRoot location="models" />
    </modelRoot>
  </models>
  <facets>
    <facet type="java" compile="mps" classes="mps" ext="no">
      <classes generated="true" path="\${module}/classes_gen" />
    </facet>
    <facet type="tests" />
  </facets>
  <dependencies>
    <dependency reexport="false">${S.LANG_ID}(wvdl)</dependency>
    <dependency reexport="false">${ids.reasoner}(wvdl.reasoner)</dependency>
  </dependencies>
  <languageVersions>
    <language slang="l:f3061a53-9226-4cc5-a443-f952ceaf5816:jetbrains.mps.baseLanguage" version="12" />
    <language slang="l:${UT.id}:jetbrains.mps.baseLanguage.unitTest" version="1" />
    <language slang="l:ceab5195-25ea-4f22-9b92-103b95ca8c0c:jetbrains.mps.lang.core" version="2" />
    <language slang="l:${TEST.id}:jetbrains.mps.lang.test" version="6" />
    <language slang="l:9ded098b-ad6a-4657-bfd9-48636cfe8bc3:jetbrains.mps.lang.traceable" version="0" />
    <language slang="l:${S.LANG_ID}:wvdl" version="0" />
  </languageVersions>
  <dependencyVersions>
    <module reference="3f233e7f-b8a6-46d2-a57f-795d56775243(Annotations)" version="0" />
    <module reference="6354ebe7-c22a-4a0f-ac54-50b52ab9b065(JDK)" version="0" />
    <module reference="6ed54515-acc8-4d1e-a16c-9fd6cfe951ea(MPS.Core)" version="0" />
    <module reference="8865b7a8-5271-43d3-884c-6fd1d9cfdd34(MPS.OpenAPI)" version="0" />
    <module reference="ceab5195-25ea-4f22-9b92-103b95ca8c0c(jetbrains.mps.lang.core)" version="0" />
    <module reference="${S.LANG_ID}(wvdl)" version="0" />
    <module reference="${ids.reasoner}(wvdl.reasoner)" version="0" />
    <module reference="${ids.tests}(wvdl.tests)" version="0" />
  </dependencyVersions>
</solution>
`;
  fs.mkdirSync(path.join(ROOT, 'solutions', 'wvdl.tests'), { recursive: true });
  fs.writeFileSync(path.join(ROOT, 'solutions', 'wvdl.tests', 'wvdl.tests.msd'), msd);
};
