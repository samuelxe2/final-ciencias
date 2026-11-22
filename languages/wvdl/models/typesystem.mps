<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:9884dd5f-9c86-4bd0-ae2c-26593323e8a6(wvdl.typesystem)">
  <persistence version="9" />
  <languages>
    <use id="7a5dda62-9140-4668-ab76-d5ed1746f2b2" name="jetbrains.mps.lang.typesystem" version="5" />
    <devkit ref="00000000-0000-4000-0000-1de82b3a4936(jetbrains.mps.devkit.aspect.typesystem)" />
  </languages>
  <imports>
    <import index="i000" ref="1ef5f35c-a65e-4d17-ae43-47ba979c4838/java:wvdl.reasoner.mps(wvdl.reasoner/)" />
    <import index="i001" ref="r:273ad769-335e-4778-ae24-00972122c65b(wvdl.structure)" />
  </imports>
  <registry>
    <language id="7a5dda62-9140-4668-ab76-d5ed1746f2b2" name="jetbrains.mps.lang.typesystem">
      <concept id="1195214364922" name="jetbrains.mps.lang.typesystem.structure.NonTypesystemRule" flags="ig" index="x0" />
      <concept id="1195213580585" name="jetbrains.mps.lang.typesystem.structure.AbstractCheckingRule" flags="ig" index="x3">
        <child id="1195213635060" name="body" index="x4" />
      </concept>
      <concept id="1174648085619" name="jetbrains.mps.lang.typesystem.structure.AbstractRule" flags="ng" index="x5">
        <child id="1174648101952" name="applicableNode" index="x6" />
      </concept>
      <concept id="1174650418652" name="jetbrains.mps.lang.typesystem.structure.ApplicableNodeReference" flags="nn" index="xm">
        <reference id="1174650432090" name="applicableNode" index="xn" />
      </concept>
      <concept id="1175517767210" name="jetbrains.mps.lang.typesystem.structure.ReportErrorStatement" flags="nn" index="xy">
        <child id="1175517851849" name="errorString" index="xz" />
      </concept>
      <concept id="3937244445246642777" name="jetbrains.mps.lang.typesystem.structure.AbstractReportStatement" flags="ng" index="x10">
        <child id="3937244445246642781" name="nodeToReport" index="x11" />
      </concept>
      <concept id="1207055528241" name="jetbrains.mps.lang.typesystem.structure.WarningStatement" flags="nn" index="x12">
        <child id="1207055552304" name="warningText" index="x13" />
      </concept>
      <concept id="1174642788531" name="jetbrains.mps.lang.typesystem.structure.ConceptReference" flags="ig" index="x14">
        <reference id="1174642800329" name="concept" index="x15" />
      </concept>
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x1">
        <property id="1169194664001" name="name" index="x2" />
      </concept>
    </language>
    <language id="f3061a53-9226-4cc5-a443-f952ceaf5816" name="jetbrains.mps.baseLanguage">
      <concept id="1068580123136" name="jetbrains.mps.baseLanguage.structure.StatementList" flags="sn" index="x7">
        <child id="1068581517665" name="statement" index="x8" />
      </concept>
      <concept id="1068581242864" name="jetbrains.mps.baseLanguage.structure.LocalVariableDeclarationStatement" flags="nn" index="x9">
        <child id="1068581242865" name="localVariableDeclaration" index="xa" />
      </concept>
      <concept id="1068581242863" name="jetbrains.mps.baseLanguage.structure.LocalVariableDeclaration" flags="nr" index="xb" />
      <concept id="4972933694980447171" name="jetbrains.mps.baseLanguage.structure.BaseVariableDeclaration" flags="ng" index="xc">
        <child id="5680397130376446158" name="type" index="xd" />
      </concept>
      <concept id="1068431474542" name="jetbrains.mps.baseLanguage.structure.VariableDeclaration" flags="ng" index="xe">
        <child id="1068431790190" name="initializer" index="xf" />
      </concept>
      <concept id="1225271177708" name="jetbrains.mps.baseLanguage.structure.StringType" flags="in" index="xg" />
      <concept id="1081236700937" name="jetbrains.mps.baseLanguage.structure.StaticMethodCall" flags="nn" index="xh">
        <reference id="1144433194310" name="classConcept" index="xi" />
      </concept>
      <concept id="1204053956946" name="jetbrains.mps.baseLanguage.structure.IMethodCall" flags="ngI" index="xj">
        <reference id="1068499141037" name="baseMethodDeclaration" index="xk" />
        <child id="1068499141038" name="actualArgument" index="xl" />
      </concept>
      <concept id="1068580123159" name="jetbrains.mps.baseLanguage.structure.IfStatement" flags="nn" index="xo">
        <child id="1068580123160" name="condition" index="xp" />
        <child id="1068580123161" name="ifTrue" index="xq" />
      </concept>
      <concept id="1073239437375" name="jetbrains.mps.baseLanguage.structure.NotEqualsExpression" flags="nn" index="xr" />
      <concept id="1081773326031" name="jetbrains.mps.baseLanguage.structure.BinaryOperation" flags="nn" index="xs">
        <child id="1081773367580" name="leftExpression" index="xt" />
        <child id="1081773367579" name="rightExpression" index="xu" />
      </concept>
      <concept id="1068498886296" name="jetbrains.mps.baseLanguage.structure.VariableReference" flags="nn" index="xv">
        <reference id="1068581517664" name="variableDeclaration" index="xw" />
      </concept>
      <concept id="1070534058343" name="jetbrains.mps.baseLanguage.structure.NullLiteral" flags="nn" index="xx" />
    </language>
  </registry>
  <node concept="x0" id="1SWCRTOyo3">
    <property role="x2" value="check_Workflow" />
    <node concept="x7" id="140eQExU3f" role="x4">
      <node concept="x9" id="1e4bUzhdVU" role="x8">
        <node concept="xb" id="1lms0ane68" role="xa">
          <property role="x2" value="errors" />
          <node concept="xg" id="1qUtIpnDD1" role="xd" />
          <node concept="xh" id="1lsLlKkp5F" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.errors(org.jetbrains.mps.openapi.model.SNode)" resolve="errors" />
            <node concept="xm" id="1ZUqiK9jsX" role="xl">
              <ref role="xn" node="1jvL257Cpk" resolve="workflow" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1gdyJLVPwc" role="x8">
        <node concept="xr" id="1Q05cvKcv5" role="xp">
          <node concept="xv" id="1FEiL2NpO7" role="xt">
            <ref role="xw" node="1lms0ane68" resolve="errors" />
          </node>
          <node concept="xx" id="1ZGL82qvv7" role="xu" />
        </node>
        <node concept="x7" id="1CXjgvpkbQ" role="xq">
          <node concept="xy" id="1eQoKY59n1" role="x8">
            <node concept="xv" id="1jBwpU621d" role="xz">
              <ref role="xw" node="1lms0ane68" resolve="errors" />
            </node>
            <node concept="xm" id="1v8hBBoc78" role="x11">
              <ref role="xn" node="1jvL257Cpk" resolve="workflow" />
            </node>
          </node>
        </node>
      </node>
      <node concept="x9" id="1aZSqMp7j4" role="x8">
        <node concept="xb" id="1NivDWPBez" role="xa">
          <property role="x2" value="warnings" />
          <node concept="xg" id="1WO3qmPlgM" role="xd" />
          <node concept="xh" id="17FWZZBBgs" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.warnings(org.jetbrains.mps.openapi.model.SNode)" resolve="warnings" />
            <node concept="xm" id="1wOBR8lLrY" role="xl">
              <ref role="xn" node="1jvL257Cpk" resolve="workflow" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1gvyWPUycY" role="x8">
        <node concept="xr" id="1RPnZASmkB" role="xp">
          <node concept="xv" id="1cm0Gkwytg" role="xt">
            <ref role="xw" node="1NivDWPBez" resolve="warnings" />
          </node>
          <node concept="xx" id="1aVhPGgBbb" role="xu" />
        </node>
        <node concept="x7" id="1eZuNYDDPm" role="xq">
          <node concept="x12" id="1CWgDLphdl" role="x8">
            <node concept="xv" id="122c5YHZqk" role="x13">
              <ref role="xw" node="1NivDWPBez" resolve="warnings" />
            </node>
            <node concept="xm" id="17EYjqRp5L" role="x11">
              <ref role="xn" node="1jvL257Cpk" resolve="workflow" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x14" id="1jvL257Cpk" role="x6">
      <property role="x2" value="workflow" />
      <ref role="x15" to="i001:1BUnh1SUXz" resolve="Workflow" />
    </node>
  </node>
  <node concept="x0" id="1hWBi26shn">
    <property role="x2" value="check_WorkflowElement" />
    <node concept="x7" id="1bRNTTeMkT" role="x4">
      <node concept="x9" id="1djZbCLC8j" role="x8">
        <node concept="xb" id="1UtIGjg0dO" role="xa">
          <property role="x2" value="errors" />
          <node concept="xg" id="12Oe7FNJYs" role="xd" />
          <node concept="xh" id="1Q4vks3NlU" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.errors(org.jetbrains.mps.openapi.model.SNode)" resolve="errors" />
            <node concept="xm" id="18ln9ziQh9" role="xl">
              <ref role="xn" node="11lP8vRTuz" resolve="element" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1ZJfTRuqBL" role="x8">
        <node concept="xr" id="1i0F6BMkRJ" role="xp">
          <node concept="xv" id="1zWz4YrV5E" role="xt">
            <ref role="xw" node="1UtIGjg0dO" resolve="errors" />
          </node>
          <node concept="xx" id="1V3IcBZrFN" role="xu" />
        </node>
        <node concept="x7" id="11Iof3hoEy" role="xq">
          <node concept="xy" id="1rjSUFra10" role="x8">
            <node concept="xv" id="1HH06ROmmm" role="xz">
              <ref role="xw" node="1UtIGjg0dO" resolve="errors" />
            </node>
            <node concept="xm" id="1bOIhBhCMs" role="x11">
              <ref role="xn" node="11lP8vRTuz" resolve="element" />
            </node>
          </node>
        </node>
      </node>
      <node concept="x9" id="1O711QXMjN" role="x8">
        <node concept="xb" id="1eaVV0kou7" role="xa">
          <property role="x2" value="warnings" />
          <node concept="xg" id="1lt9sJRgK6" role="xd" />
          <node concept="xh" id="15K8GmdHoG" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.warnings(org.jetbrains.mps.openapi.model.SNode)" resolve="warnings" />
            <node concept="xm" id="1W21z9jyao" role="xl">
              <ref role="xn" node="11lP8vRTuz" resolve="element" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1p6TGRCrmG" role="x8">
        <node concept="xr" id="1jxvZzCtBw" role="xp">
          <node concept="xv" id="1tC9NJ70b6" role="xt">
            <ref role="xw" node="1eaVV0kou7" resolve="warnings" />
          </node>
          <node concept="xx" id="13MYf1DtRx" role="xu" />
        </node>
        <node concept="x7" id="1Z3t4Pk4A3" role="xq">
          <node concept="x12" id="149z1r3l9G" role="x8">
            <node concept="xv" id="1HbM0jycW7" role="x13">
              <ref role="xw" node="1eaVV0kou7" resolve="warnings" />
            </node>
            <node concept="xm" id="1KA2QuSoiA" role="x11">
              <ref role="xn" node="11lP8vRTuz" resolve="element" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x14" id="11lP8vRTuz" role="x6">
      <property role="x2" value="element" />
      <ref role="x15" to="i001:19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
  </node>
  <node concept="x0" id="1WiyiYo4AH">
    <property role="x2" value="check_Guard" />
    <node concept="x7" id="1tWe2CHyYR" role="x4">
      <node concept="x9" id="1vmxUe0oId" role="x8">
        <node concept="xb" id="1aBvDwgs99" role="xa">
          <property role="x2" value="errors" />
          <node concept="xg" id="1lf1DJ17hk" role="xd" />
          <node concept="xh" id="1mfGTqE9pw" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.errors(org.jetbrains.mps.openapi.model.SNode)" resolve="errors" />
            <node concept="xm" id="1Ta1uVHXWI" role="xl">
              <ref role="xn" node="1X3Tt3t0G7" resolve="guard" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1DJxFFxuvJ" role="x8">
        <node concept="xr" id="1gQkToVqd1" role="xp">
          <node concept="xv" id="1P6EJpls2l" role="xt">
            <ref role="xw" node="1aBvDwgs99" resolve="errors" />
          </node>
          <node concept="xx" id="1snJb1mZQI" role="xu" />
        </node>
        <node concept="x7" id="16Y5j2YShA" role="xq">
          <node concept="xy" id="1ldyG0g6K4" role="x8">
            <node concept="xv" id="19ngT0F4WT" role="xz">
              <ref role="xw" node="1aBvDwgs99" resolve="errors" />
            </node>
            <node concept="xm" id="1h9WiaTiFb" role="x11">
              <ref role="xn" node="1X3Tt3t0G7" resolve="guard" />
            </node>
          </node>
        </node>
      </node>
      <node concept="x9" id="1lofhmLhLk" role="x8">
        <node concept="xb" id="1s6DxAr0jj" role="xa">
          <property role="x2" value="warnings" />
          <node concept="xg" id="1tPQu2oQdc" role="xd" />
          <node concept="xh" id="1P2Tnuk6bn" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.warnings(org.jetbrains.mps.openapi.model.SNode)" resolve="warnings" />
            <node concept="xm" id="15y0AGVl30" role="xl">
              <ref role="xn" node="1X3Tt3t0G7" resolve="guard" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="15miHnLdT7" role="x8">
        <node concept="xr" id="1TA5EsbeQK" role="xp">
          <node concept="xv" id="1QHRNiaaWV" role="xt">
            <ref role="xw" node="1s6DxAr0jj" resolve="warnings" />
          </node>
          <node concept="xx" id="1NQTefkfh0" role="xu" />
        </node>
        <node concept="x7" id="1dVsVFS1qP" role="xq">
          <node concept="x12" id="1huSSUlEHX" role="x8">
            <node concept="xv" id="1qbENW8eD4" role="x13">
              <ref role="xw" node="1s6DxAr0jj" resolve="warnings" />
            </node>
            <node concept="xm" id="19Z9nLLzJ0" role="x11">
              <ref role="xn" node="1X3Tt3t0G7" resolve="guard" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x14" id="1X3Tt3t0G7" role="x6">
      <property role="x2" value="guard" />
      <ref role="x15" to="i001:1Qfaxng6dZ" resolve="Guard" />
    </node>
  </node>
  <node concept="x0" id="1c0IuPensN">
    <property role="x2" value="check_Expression" />
    <node concept="x7" id="1231wYIV02" role="x4">
      <node concept="x9" id="1sBTuet2NW" role="x8">
        <node concept="xb" id="10DEUokbv1" role="xa">
          <property role="x2" value="errors" />
          <node concept="xg" id="1rG6ef6kdV" role="xd" />
          <node concept="xh" id="1slH9vgIlx" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.errors(org.jetbrains.mps.openapi.model.SNode)" resolve="errors" />
            <node concept="xm" id="1hIkm1F10D" role="xl">
              <ref role="xn" node="12IiB1JnWJ" resolve="expression" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1NJ987Dwdr" role="x8">
        <node concept="xr" id="1G7Jsk3R6J" role="xp">
          <node concept="xv" id="1l3wNOvljk" role="xt">
            <ref role="xw" node="10DEUokbv1" resolve="errors" />
          </node>
          <node concept="xx" id="1s2mF7X4hu" role="xu" />
        </node>
        <node concept="x7" id="1Bd6AwPVgT" role="xq">
          <node concept="xy" id="19yIIOIhvA" role="x8">
            <node concept="xv" id="14QhyvCyKy" role="xz">
              <ref role="xw" node="10DEUokbv1" resolve="errors" />
            </node>
            <node concept="xm" id="1CIUQWfTGt" role="x11">
              <ref role="xn" node="12IiB1JnWJ" resolve="expression" />
            </node>
          </node>
        </node>
      </node>
      <node concept="x9" id="1jdTzaBHn7" role="x8">
        <node concept="xb" id="1TitOnY2TV" role="xa">
          <property role="x2" value="warnings" />
          <node concept="xg" id="1wEeet9LCJ" role="xd" />
          <node concept="xh" id="1EY2pQXrAS" role="xf">
            <ref role="xi" to="i000:~WvdlChecks" resolve="WvdlChecks" />
            <ref role="xk" to="i000:~WvdlChecks.warnings(org.jetbrains.mps.openapi.model.SNode)" resolve="warnings" />
            <node concept="xm" id="1dBOKr9rj1" role="xl">
              <ref role="xn" node="12IiB1JnWJ" resolve="expression" />
            </node>
          </node>
        </node>
      </node>
      <node concept="xo" id="1GsqyZzNd3" role="x8">
        <node concept="xr" id="14XBqXOoOF" role="xp">
          <node concept="xv" id="1rIUX7KflV" role="xt">
            <ref role="xw" node="1TitOnY2TV" resolve="warnings" />
          </node>
          <node concept="xx" id="1UiinwlZ5C" role="xu" />
        </node>
        <node concept="x7" id="1d50FRWcc4" role="xq">
          <node concept="x12" id="19moB6IEp4" role="x8">
            <node concept="xv" id="1mvmyqTD5B" role="x13">
              <ref role="xw" node="1TitOnY2TV" resolve="warnings" />
            </node>
            <node concept="xm" id="1RY0sJ4LqJ" role="x11">
              <ref role="xn" node="12IiB1JnWJ" resolve="expression" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x14" id="12IiB1JnWJ" role="x6">
      <property role="x2" value="expression" />
      <ref role="x15" to="i001:1vP8XF2KrC" resolve="Expression" />
    </node>
  </node>
</model>
