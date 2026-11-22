<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:d5837d10-e9c3-4b4a-a4a8-7a6bc77bf14d(wvdl.behavior)">
  <persistence version="9" />
  <languages>
    <use id="af65afd8-f0dd-4942-87d9-63a55f2a9db1" name="jetbrains.mps.lang.behavior" version="2" />
    <devkit ref="fbc25dd2-5da4-483a-8b19-70928e1b62d7(jetbrains.mps.devkit.general-purpose)" />
  </languages>
  <imports>
    <import index="i000" ref="r:273ad769-335e-4778-ae24-00972122c65b(wvdl.structure)" />
    <import index="i001" ref="r:00000000-0000-4000-0000-011c89590282(jetbrains.mps.lang.core.behavior)" />
    <import index="i002" ref="1ef5f35c-a65e-4d17-ae43-47ba979c4838/java:wvdl.reasoner.mps(wvdl.reasoner/)" />
    <import index="i003" ref="r:314576fc-3aee-4386-a0a5-a38348ac317d(jetbrains.mps.scope)" />
  </imports>
  <registry>
    <language id="af65afd8-f0dd-4942-87d9-63a55f2a9db1" name="jetbrains.mps.lang.behavior">
      <concept id="1225194240794" name="jetbrains.mps.lang.behavior.structure.ConceptBehavior" flags="ng" index="x0">
        <reference id="1225194240799" name="concept" index="x1" />
        <child id="1225194240801" name="constructor" index="x2" />
        <child id="1225194240805" name="method" index="x3" />
      </concept>
      <concept id="1225194413805" name="jetbrains.mps.lang.behavior.structure.ConceptConstructorDeclaration" flags="in" index="x4" />
      <concept id="1225194472830" name="jetbrains.mps.lang.behavior.structure.ConceptMethodDeclaration" flags="ng" index="x9">
        <property id="1225194472834" name="isAbstract" index="xa" />
        <property id="1225194472832" name="isVirtual" index="xb" />
        <reference id="1225194472831" name="overriddenMethod" index="xc" />
      </concept>
      <concept id="1225194691553" name="jetbrains.mps.lang.behavior.structure.ThisNodeExpression" flags="nn" index="xt" />
    </language>
    <language id="f3061a53-9226-4cc5-a443-f952ceaf5816" name="jetbrains.mps.baseLanguage">
      <concept id="1137021947720" name="jetbrains.mps.baseLanguage.structure.ConceptFunction" flags="in" index="x5">
        <child id="1137022507850" name="body" index="x6" />
      </concept>
      <concept id="1068580123136" name="jetbrains.mps.baseLanguage.structure.StatementList" flags="sn" index="x7">
        <child id="1068581517665" name="statement" index="x8" />
      </concept>
      <concept id="1178549954367" name="jetbrains.mps.baseLanguage.structure.IVisible" flags="ngI" index="xf">
        <child id="1178549979242" name="visibility" index="xg" />
      </concept>
      <concept id="1068580123132" name="jetbrains.mps.baseLanguage.structure.BaseMethodDeclaration" flags="ng" index="xh">
        <child id="1068580123135" name="body" index="xi" />
        <child id="1068580123134" name="parameter" index="xj" />
        <child id="1068580123133" name="returnType" index="xk" />
      </concept>
      <concept id="1146644602865" name="jetbrains.mps.baseLanguage.structure.PublicVisibility" flags="nn" index="xl" />
      <concept id="1068581242878" name="jetbrains.mps.baseLanguage.structure.ReturnStatement" flags="nn" index="xm">
        <child id="1068581517676" name="expression" index="xn" />
      </concept>
      <concept id="1081236700937" name="jetbrains.mps.baseLanguage.structure.StaticMethodCall" flags="nn" index="xo">
        <reference id="1144433194310" name="classConcept" index="xp" />
      </concept>
      <concept id="1204053956946" name="jetbrains.mps.baseLanguage.structure.IMethodCall" flags="ngI" index="xq">
        <reference id="1068499141037" name="baseMethodDeclaration" index="xr" />
        <child id="1068499141038" name="actualArgument" index="xs" />
      </concept>
      <concept id="1068498886296" name="jetbrains.mps.baseLanguage.structure.VariableReference" flags="nn" index="xu">
        <reference id="1068581517664" name="variableDeclaration" index="xv" />
      </concept>
      <concept id="1068498886292" name="jetbrains.mps.baseLanguage.structure.ParameterDeclaration" flags="ir" index="xw" />
      <concept id="4972933694980447171" name="jetbrains.mps.baseLanguage.structure.BaseVariableDeclaration" flags="ng" index="xx">
        <child id="5680397130376446158" name="type" index="xy" />
      </concept>
      <concept id="1107535904670" name="jetbrains.mps.baseLanguage.structure.ClassifierType" flags="in" index="x11">
        <reference id="1107535924139" name="classifier" index="x12" />
      </concept>
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="xd">
        <property id="1169194664001" name="name" index="xe" />
      </concept>
    </language>
    <language id="7866978e-a0f0-4cc7-81bc-4d213d9375e1" name="jetbrains.mps.lang.smodel">
      <concept id="6677504323281689838" name="jetbrains.mps.lang.smodel.structure.SConceptType" flags="in" index="xz" />
      <concept id="1138055754698" name="jetbrains.mps.lang.smodel.structure.SNodeType" flags="in" index="x10" />
    </language>
  </registry>
  <node concept="x0" id="1Ys5kEaWkt">
    <ref role="x1" to="i000:1BUnh1SUXz" resolve="Workflow" />
    <node concept="x4" id="1nDQy22lDC" role="x2">
      <node concept="x7" id="17VgVWyC3p" role="x6" />
    </node>
    <node concept="x9" id="1SwXEH2u5e" role="x3">
      <property role="xa" value="false" />
      <property role="xb" value="false" />
      <property role="xe" value="getScope" />
      <ref role="xc" to="i001:52_Geb4QDV$" resolve="getScope" />
      <node concept="xl" id="1N6wonSNpW" role="xg" />
      <node concept="x7" id="1DTQRIBXwa" role="xi">
        <node concept="xm" id="1ZQhbSJkuJ" role="x8">
          <node concept="xo" id="1dE94F3HWy" role="xn">
            <ref role="xp" to="i002:~WvdlScopes" resolve="WvdlScopes" />
            <ref role="xr" to="i002:~WvdlScopes.getScope(org.jetbrains.mps.openapi.model.SNode,org.jetbrains.mps.openapi.language.SAbstractConcept,org.jetbrains.mps.openapi.model.SNode)" resolve="getScope" />
            <node concept="xt" id="1AaFHTI1wJ" role="xs" />
            <node concept="xu" id="1cH1OF3lKs" role="xs">
              <ref role="xv" node="1qXbZ0hJQs" resolve="kind" />
            </node>
            <node concept="xu" id="18Nf0QQMJs" role="xs">
              <ref role="xv" node="1PWUeqq0cc" resolve="child" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xw" id="1qXbZ0hJQs" role="xj">
        <property role="xe" value="kind" />
        <node concept="xz" id="1N1CFlJLmo" role="xy" />
      </node>
      <node concept="xw" id="1PWUeqq0cc" role="xj">
        <property role="xe" value="child" />
        <node concept="x10" id="1QJCbTEqx7" role="xy" />
      </node>
      <node concept="x11" id="13Fxhmy9Lw" role="xk">
        <ref role="x12" to="i003:3fifI_xCtN$" resolve="Scope" />
      </node>
    </node>
  </node>
</model>
