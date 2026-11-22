// TextGen aspect: every Workflow root produces <name>.json, the structured
// report of the reasoner (static findings, verified properties, inferences
// and a deterministic simulation trace).
'use strict';
module.exports.build = ({ G, decl, DEVKIT, USE, ids, models, fileOf, LANG_DIR }) => {
  const path = require('path');
  const { N, X } = G;
  const STUB = `${ids.reasoner}/java:wvdl.reasoner.mps(wvdl.reasoner/)`;
  const m = new G.Model('wvdl.textGen', { devkits: [DEVKIT.textGen], uses: [USE('tg', 1)] });
  m.add(N('tg:ConceptTextGenDeclaration', {
    conceptDeclaration: decl.Workflow,
    extension: N('tg:ExtensionDeclaration', {
      body: N('bl:StatementList', { statement: N('bl:ExpressionStatement', { expression: N('bl:StringLiteral', { value: 'json' }) }) }),
    }),
    textGenBlock: N('tg:GenerateTextDeclaration', {
      body: N('bl:StatementList', {
        statement: N('tg:AppendOperation', {
          part: N('tg:NodeAppendPart', {
            value: N('bl:StaticMethodCall', {
              classConcept: X(STUB, '~WvdlReport', 'WvdlReport'),
              baseMethodDeclaration: X(STUB, '~WvdlReport.json(org.jetbrains.mps.openapi.model.SNode)', 'json'),
              actualArgument: N('tg:NodeParameter'),
            }),
          }),
        }),
      }),
    }),
  }));
  models.push(m);
  fileOf.set(m, path.join(LANG_DIR, 'models', 'textGen.mps'));
};
