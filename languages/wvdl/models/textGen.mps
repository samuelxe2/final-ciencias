<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:8c050a0b-7812-46a5-a0e4-ccd4dafeb60a(wvdl.textGen)">
  <persistence version="9" />
  <languages>
    <use id="b83431fe-5c8f-40bc-8a36-65e25f4dd253" name="jetbrains.mps.lang.textGen" version="1" />
    <devkit ref="fa73d85a-ac7f-447b-846c-fcdc41caa600(jetbrains.mps.devkit.aspect.textgen)" />
  </languages>
  <imports>
    <import index="i000" ref="r:273ad769-335e-4778-ae24-00972122c65b(wvdl.structure)" />
    <import index="i001" ref="1ef5f35c-a65e-4d17-ae43-47ba979c4838/java:wvdl.reasoner.mps(wvdl.reasoner/)" />
  </imports>
  <registry>
    <language id="b83431fe-5c8f-40bc-8a36-65e25f4dd253" name="jetbrains.mps.lang.textGen">
      <concept id="1233670071145" name="jetbrains.mps.lang.textGen.structure.ConceptTextGenDeclaration" flags="ig" index="x0">
        <reference id="1233670257997" name="conceptDeclaration" index="x1" />
        <child id="7991274449437422201" name="extension" index="x2" />
        <child id="1233749296504" name="textGenBlock" index="x3" />
      </concept>
      <concept id="8931911391946696733" name="jetbrains.mps.lang.textGen.structure.ExtensionDeclaration" flags="in" index="x4" />
      <concept id="1233749247888" name="jetbrains.mps.lang.textGen.structure.GenerateTextDeclaration" flags="in" index="xd" />
      <concept id="1237306079178" name="jetbrains.mps.lang.textGen.structure.AppendOperation" flags="nn" index="xe">
        <child id="1237306115446" name="part" index="xf" />
      </concept>
      <concept id="1237305334312" name="jetbrains.mps.lang.textGen.structure.NodeAppendPart" flags="ng" index="xg">
        <child id="1237305790512" name="value" index="xh" />
      </concept>
      <concept id="1233748055915" name="jetbrains.mps.lang.textGen.structure.NodeParameter" flags="nn" index="xn" />
    </language>
    <language id="f3061a53-9226-4cc5-a443-f952ceaf5816" name="jetbrains.mps.baseLanguage">
      <concept id="1137021947720" name="jetbrains.mps.baseLanguage.structure.ConceptFunction" flags="in" index="x5">
        <child id="1137022507850" name="body" index="x6" />
      </concept>
      <concept id="1068580123136" name="jetbrains.mps.baseLanguage.structure.StatementList" flags="sn" index="x7">
        <child id="1068581517665" name="statement" index="x8" />
      </concept>
      <concept id="1068580123155" name="jetbrains.mps.baseLanguage.structure.ExpressionStatement" flags="nn" index="x9">
        <child id="1068580123156" name="expression" index="xa" />
      </concept>
      <concept id="1070475926800" name="jetbrains.mps.baseLanguage.structure.StringLiteral" flags="nn" index="xb">
        <property id="1070475926801" name="value" index="xc" />
      </concept>
      <concept id="1081236700937" name="jetbrains.mps.baseLanguage.structure.StaticMethodCall" flags="nn" index="xi">
        <reference id="1144433194310" name="classConcept" index="xj" />
      </concept>
      <concept id="1204053956946" name="jetbrains.mps.baseLanguage.structure.IMethodCall" flags="ngI" index="xk">
        <reference id="1068499141037" name="baseMethodDeclaration" index="xl" />
        <child id="1068499141038" name="actualArgument" index="xm" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="1B5VxPp7xR">
    <ref role="x1" to="i000:1BUnh1SUXz" resolve="Workflow" />
    <node concept="x4" id="1742RVZ62T" role="x2">
      <node concept="x7" id="1ysgxF1vNq" role="x6">
        <node concept="x9" id="1s3SMzN2ZK" role="x8">
          <node concept="xb" id="1lNaf9oWaU" role="xa">
            <property role="xc" value="json" />
          </node>
        </node>
      </node>
    </node>
    <node concept="xd" id="1jaoEERCBZ" role="x3">
      <node concept="x7" id="1ekXOoIIou" role="x6">
        <node concept="xe" id="1WohFsMUKX" role="x8">
          <node concept="xg" id="1S0ot6hGHH" role="xf">
            <node concept="xi" id="1iYNCu05gc" role="xh">
              <ref role="xj" to="i001:~WvdlReport" resolve="WvdlReport" />
              <ref role="xl" to="i001:~WvdlReport.json(org.jetbrains.mps.openapi.model.SNode)" resolve="json" />
              <node concept="xn" id="1mjwahxFRV" role="xm" />
            </node>
          </node>
        </node>
      </node>
    </node>
  </node>
</model>
