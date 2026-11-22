<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:6d4935f8-7a97-423f-af43-815bbf5c2d25(wvdl.tests.inferencias@tests)">
  <persistence version="9" />
  <languages>
    <use id="8585453e-6bfb-4d80-98de-b16074f1d86c" name="jetbrains.mps.lang.test" version="6" />
    <use id="f61473f9-130f-42f6-b98d-6c438812c2f6" name="jetbrains.mps.baseLanguage.unitTest" version="1" />
    <use id="f3061a53-9226-4cc5-a443-f952ceaf5816" name="jetbrains.mps.baseLanguage" version="12" />
    <use id="4efe485e-f38f-4368-a336-dbc2552833bf" name="wvdl" version="0" />
  </languages>
  <imports>
  </imports>
  <registry>
    <language id="8585453e-6bfb-4d80-98de-b16074f1d86c" name="jetbrains.mps.lang.test">
      <concept id="1216913645126" name="jetbrains.mps.lang.test.structure.NodesTestCase" flags="lg" index="x0">
        <child id="1217501822150" name="nodesToCheck" index="x1" />
      </concept>
      <concept id="1216989428737" name="jetbrains.mps.lang.test.structure.TestNode" flags="ng" index="x4">
        <child id="1216989461394" name="nodeToCheck" index="x5" />
      </concept>
      <concept id="1215603922101" name="jetbrains.mps.lang.test.structure.NodeOperationsContainer" flags="ng" index="x1i">
        <child id="1215604436604" name="nodeOperations" index="x1j" />
      </concept>
      <concept id="1215607067978" name="jetbrains.mps.lang.test.structure.CheckNodeForErrorMessagesOperation" flags="ng" index="x1k">
        <property id="3743352646565420194" name="includeSelf" index="x1l" />
        <property id="852155438140865198" name="allowWarnings" index="x1m" />
      </concept>
      <concept id="1215507671101" name="jetbrains.mps.lang.test.structure.NodeErrorCheckOperation" flags="ng" index="x2d" />
      <concept id="1215511704609" name="jetbrains.mps.lang.test.structure.NodeWarningCheckOperation" flags="ng" index="x2e" />
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x2">
        <property id="1169194664001" name="name" index="x3" />
      </concept>
      <concept id="1133920641626" name="jetbrains.mps.lang.core.structure.BaseConcept" flags="ng" index="xf">
        <child id="5169995583184591170" name="smodelAttribute" index="xg" />
      </concept>
    </language>
    <language id="4efe485e-f38f-4368-a336-dbc2552833bf" name="wvdl">
      <concept id="1412782381407505714" name="wvdl.structure.Workflow" flags="ng" index="x6">
        <child id="1528467127056001332" name="states" index="x7" />
        <child id="3742483036895970086" name="roles" index="x8" />
        <child id="2514821820973565857" name="actors" index="x9" />
        <child id="3059050193924877675" name="assignments" index="xa" />
        <child id="2442891784385824884" name="activities" index="xb" />
        <child id="4297088327742399859" name="transitions" index="xc" />
        <child id="1630146823895602108" name="checks" index="xd" />
        <child id="2311448109575635965" name="variables" index="xe" />
      </concept>
      <concept id="3773931177927761670" name="wvdl.structure.InitialState" flags="ng" index="xh" />
      <concept id="4340915256483426058" name="wvdl.structure.OrdinaryState" flags="ng" index="xi" />
      <concept id="4548869926607402224" name="wvdl.structure.FinalState" flags="ng" index="xj" />
      <concept id="4580885630124225313" name="wvdl.structure.HumanRole" flags="ng" index="xk" />
      <concept id="1575272884437960782" name="wvdl.structure.Actor" flags="ng" index="xl" />
      <concept id="2754388617126347878" name="wvdl.structure.Assignment" flags="ng" index="xm">
        <reference id="3435594342687597196" name="actor" index="xn" />
        <reference id="4297639191499006525" name="role" index="xo" />
      </concept>
      <concept id="298054231284038334" name="wvdl.structure.ManualActivity" flags="ng" index="xp" />
      <concept id="4100242238858238349" name="wvdl.structure.Activity" flags="ng" index="xq">
        <reference id="3951339498872278184" name="role" index="xr" />
      </concept>
      <concept id="3444469126383335239" name="wvdl.structure.Transition" flags="ng" index="xs">
        <child id="3546178691603644048" name="from" index="xt" />
        <child id="4557479502343562840" name="to" index="xu" />
        <child id="2595902392752590344" name="via" index="xv" />
        <child id="318163487345883580" name="guard" index="xw" />
      </concept>
      <concept id="910489418711293754" name="wvdl.structure.SourceRef" flags="ng" index="xx" />
      <concept id="2318847045543514830" name="wvdl.structure.StateRef" flags="ng" index="xy">
        <reference id="1644665000982416978" name="state" index="xz" />
      </concept>
      <concept id="1148869055518526258" name="wvdl.structure.TargetRef" flags="ng" index="x10" />
      <concept id="4065621737641222821" name="wvdl.structure.ActivityRef" flags="ng" index="x11">
        <reference id="2523441023518024119" name="activity" index="x12" />
      </concept>
      <concept id="3458926237492019812" name="wvdl.structure.SoundCheck" flags="ng" index="x13" />
      <concept id="4461490874048664151" name="wvdl.structure.ReachableCheck" flags="ng" index="x14">
        <reference id="1001593753963161797" name="state" index="x15" />
      </concept>
      <concept id="1645384556473442200" name="wvdl.structure.PathCheck" flags="ng" index="x16">
        <reference id="2811859192094200142" name="state" index="x17" />
        <child id="3494199751501289366" name="steps" index="x18" />
      </concept>
      <concept id="506719079257640917" name="wvdl.structure.TransitionRef" flags="ng" index="x19">
        <reference id="2600406349640642610" name="transition" index="x1a" />
      </concept>
      <concept id="1810144407881132328" name="wvdl.structure.ActorsCheck" flags="ng" index="x1b">
        <reference id="2003057994849096830" name="activity" index="x1c" />
        <child id="1944458948576600817" name="actors" index="x1d" />
      </concept>
      <concept id="3945133872824800573" name="wvdl.structure.ActorRef" flags="ng" index="x1e">
        <reference id="2607128528215628765" name="actor" index="x1f" />
      </concept>
      <concept id="1801005092375930339" name="wvdl.structure.SimulationCheck" flags="ng" index="x1g">
        <reference id="2407784877938928023" name="state" index="x1h" />
      </concept>
      <concept id="1984639994254280242" name="wvdl.structure.Variable" flags="ng" index="x1n">
        <child id="1116711506113754239" name="type" index="x1o" />
        <child id="3342385426935315388" name="init" index="x1p" />
      </concept>
      <concept id="2211624816874732235" name="wvdl.structure.IntegerType" flags="ng" index="x1q" />
      <concept id="4356461840986708983" name="wvdl.structure.IntLiteral" flags="ng" index="x1r">
        <property id="2764001242192483827" name="value" index="x1s" />
      </concept>
      <concept id="3474567488466545183" name="wvdl.structure.Guard" flags="ng" index="x1t">
        <child id="4202132126237685012" name="condition" index="x1u" />
      </concept>
      <concept id="4006625772246302066" name="wvdl.structure.LtExpr" flags="ng" index="x1v" />
      <concept id="2503589227462995725" name="wvdl.structure.IBinaryOperation" flags="ngI" index="x1w">
        <child id="3597341855276219803" name="left" index="x1x" />
        <child id="4307423801848415733" name="right" index="x1y" />
      </concept>
      <concept id="448228914353461423" name="wvdl.structure.VarRef" flags="ng" index="x1z">
        <reference id="3618521687389199141" name="variable" index="x20" />
      </concept>
      <concept id="2935791979113318278" name="wvdl.structure.NotExpr" flags="ng" index="x21">
        <child id="4235839573527162062" name="operand" index="x22" />
      </concept>
      <concept id="1727450827697905204" name="wvdl.structure.SystemRole" flags="ng" index="x23" />
      <concept id="932772402753431168" name="wvdl.structure.BooleanType" flags="ng" index="x24" />
      <concept id="3341333894158794751" name="wvdl.structure.BoolLiteral" flags="ng" index="x25">
        <property id="448872718996398809" name="value" index="x26" />
      </concept>
      <concept id="1480812486812752603" name="wvdl.structure.AutomatedActivity" flags="ng" index="x27" />
      <concept id="1887490964949997474" name="wvdl.structure.StringType" flags="ng" index="x28" />
      <concept id="2142532025266201015" name="wvdl.structure.StringLiteral" flags="ng" index="x29">
        <property id="3067358161925164103" name="value" index="x2a" />
      </concept>
      <concept id="218929957572760305" name="wvdl.structure.OrExpr" flags="ng" index="x2b" />
      <concept id="2874916540859629813" name="wvdl.structure.EqExpr" flags="ng" index="x2c" />
    </language>
  </registry>
  <node concept="x0" id="1wuCTt96Es">
    <property role="x3" value="Inferencias" />
    <node concept="x4" id="18IeUl7FLG" role="x1">
      <node concept="x6" id="180YAI4482" role="x5">
        <property role="x3" value="V01_Lineal" />
        <node concept="xh" id="1GzY1SJbC7" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1004RWlkQe" role="x7">
          <property role="x3" value="Revision" />
        </node>
        <node concept="xj" id="1T1TmeQ0VD" role="x7">
          <property role="x3" value="Aprobado" />
        </node>
        <node concept="xk" id="1CNiMzaJmh" role="x8">
          <property role="x3" value="Revisor" />
        </node>
        <node concept="xl" id="16OTauXhIU" role="x9">
          <property role="x3" value="Ana" />
        </node>
        <node concept="xm" id="1CRYm5rVXI" role="xa">
          <ref role="xn" node="16OTauXhIU" resolve="Ana" />
          <ref role="xo" node="1CNiMzaJmh" resolve="Revisor" />
        </node>
        <node concept="xp" id="1pqiQIrvMD" role="xb">
          <property role="x3" value="Revisar" />
          <ref role="xr" node="1CNiMzaJmh" resolve="Revisor" />
        </node>
        <node concept="xs" id="1eADMyG4vG" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="12toKamUvp" role="xt">
            <ref role="xz" node="1GzY1SJbC7" resolve="Inicio" />
          </node>
          <node concept="x10" id="1Y5foaaG2L" role="xu">
            <ref role="xz" node="1004RWlkQe" resolve="Revision" />
          </node>
        </node>
        <node concept="xs" id="1PylRKrS5P" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1ENQ0eIq9C" role="xt">
            <ref role="xz" node="1004RWlkQe" resolve="Revision" />
          </node>
          <node concept="x10" id="1VHcnQyhcV" role="xu">
            <ref role="xz" node="1T1TmeQ0VD" resolve="Aprobado" />
          </node>
          <node concept="x11" id="1sVVscUek1" role="xv">
            <ref role="x12" node="1pqiQIrvMD" resolve="Revisar" />
          </node>
        </node>
        <node concept="x13" id="1JRgsEBeWn" role="xd" />
        <node concept="x14" id="1Y9uTl0Wsc" role="xd">
          <ref role="x15" node="1T1TmeQ0VD" resolve="Aprobado" />
        </node>
        <node concept="x16" id="136O9ocNtj" role="xd">
          <ref role="x17" node="1T1TmeQ0VD" resolve="Aprobado" />
          <node concept="x19" id="1eucek1N6k" role="x18">
            <ref role="x1a" node="1eADMyG4vG" resolve="T1" />
          </node>
          <node concept="x19" id="1G59vH19lO" role="x18">
            <ref role="x1a" node="1PylRKrS5P" resolve="T2" />
          </node>
        </node>
        <node concept="x1b" id="1TFH9IdkEs" role="xd">
          <ref role="x1c" node="1pqiQIrvMD" resolve="Revisar" />
          <node concept="x1e" id="1eGQhViTuG" role="x1d">
            <ref role="x1f" node="16OTauXhIU" resolve="Ana" />
          </node>
        </node>
        <node concept="x1g" id="1yb9PtT0zF" role="xd">
          <ref role="x1h" node="1T1TmeQ0VD" resolve="Aprobado" />
        </node>
        <node concept="x1i" id="1Cb3vUOFkk" role="xg">
          <node concept="x1k" id="1Y4GFoCpwo" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1kZwtAXrCP" role="x1">
      <node concept="x6" id="1MG94cfcor" role="x5">
        <property role="x3" value="V02_Ramificacion" />
        <node concept="xh" id="1oFmT4V5Yv" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1mG7f2hACZ" role="x7">
          <property role="x3" value="Validacion" />
        </node>
        <node concept="xj" id="1PizQFOa4P" role="x7">
          <property role="x3" value="Aprobado" />
        </node>
        <node concept="xj" id="1A4RnQd1XC" role="x7">
          <property role="x3" value="Rechazado" />
        </node>
        <node concept="xk" id="11PxsOBGHY" role="x8">
          <property role="x3" value="Validador" />
        </node>
        <node concept="xl" id="155Xqmw2P2" role="x9">
          <property role="x3" value="Luis" />
        </node>
        <node concept="xm" id="1T4JbBZbiC" role="xa">
          <ref role="xn" node="155Xqmw2P2" resolve="Luis" />
          <ref role="xo" node="11PxsOBGHY" resolve="Validador" />
        </node>
        <node concept="x1n" id="1C9fG1xOG2" role="xe">
          <property role="x3" value="monto" />
          <node concept="x1q" id="1Dcu2UrV12" role="x1o" />
          <node concept="x1r" id="10RgBQGnbq" role="x1p">
            <property role="x1s" value="500" />
          </node>
        </node>
        <node concept="xp" id="1KJcUWLlF7" role="xb">
          <property role="x3" value="Validar" />
          <ref role="xr" node="11PxsOBGHY" resolve="Validador" />
        </node>
        <node concept="xs" id="1Iagg2qEZ3" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1ygttzlb6G" role="xt">
            <ref role="xz" node="1oFmT4V5Yv" resolve="Inicio" />
          </node>
          <node concept="x10" id="149q23DbAr" role="xu">
            <ref role="xz" node="1mG7f2hACZ" resolve="Validacion" />
          </node>
        </node>
        <node concept="xs" id="1roBYvua55" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1Nb0Vq9ujY" role="xt">
            <ref role="xz" node="1mG7f2hACZ" resolve="Validacion" />
          </node>
          <node concept="x10" id="138o8xk7HA" role="xu">
            <ref role="xz" node="1PizQFOa4P" resolve="Aprobado" />
          </node>
          <node concept="x11" id="1egyKP539D" role="xv">
            <ref role="x12" node="1KJcUWLlF7" resolve="Validar" />
          </node>
          <node concept="x1t" id="1DWHpRwzn0" role="xw">
            <node concept="x1v" id="1m7hJPhI6W" role="x1u">
              <node concept="x1z" id="12CroaP36T" role="x1x">
                <ref role="x20" node="1C9fG1xOG2" resolve="monto" />
              </node>
              <node concept="x1r" id="1Qn9Eira3p" role="x1y">
                <property role="x1s" value="1000" />
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1zNCMnAsS4" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="19yGOvqKtW" role="xt">
            <ref role="xz" node="1mG7f2hACZ" resolve="Validacion" />
          </node>
          <node concept="x10" id="11WmgCg0r0" role="xu">
            <ref role="xz" node="1A4RnQd1XC" resolve="Rechazado" />
          </node>
          <node concept="x11" id="1xjQTXDxl7" role="xv">
            <ref role="x12" node="1KJcUWLlF7" resolve="Validar" />
          </node>
          <node concept="x1t" id="1rwiT9fr2Q" role="xw">
            <node concept="x21" id="1rIRl71bVp" role="x1u">
              <node concept="x1v" id="1G2Asq71ES" role="x22">
                <node concept="x1z" id="1yMvCmvcsK" role="x1x">
                  <ref role="x20" node="1C9fG1xOG2" resolve="monto" />
                </node>
                <node concept="x1r" id="1y7DbkC4tq" role="x1y">
                  <property role="x1s" value="1000" />
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="x13" id="1BLEVlmBuu" role="xd" />
        <node concept="x16" id="1tOtaFJLzz" role="xd">
          <ref role="x17" node="1A4RnQd1XC" resolve="Rechazado" />
          <node concept="x19" id="11HYQ1KyuU" role="x18">
            <ref role="x1a" node="1Iagg2qEZ3" resolve="T1" />
          </node>
          <node concept="x19" id="1yMitN2KPc" role="x18">
            <ref role="x1a" node="1zNCMnAsS4" resolve="T3" />
          </node>
        </node>
        <node concept="x1g" id="14Idi0oFuq" role="xd">
          <ref role="x1h" node="1PizQFOa4P" resolve="Aprobado" />
        </node>
        <node concept="x1i" id="13tWLhcf2E" role="xg">
          <node concept="x1k" id="15C2rr1U04" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1QbWmeR9YW" role="x1">
      <node concept="x6" id="1OlwNsLJFZ" role="x5">
        <property role="x3" value="V03_Automatizado" />
        <node concept="xh" id="1QunIDQ5SD" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1it9YVvoIW" role="x7">
          <property role="x3" value="Revision" />
        </node>
        <node concept="xj" id="1YzcUBSKjd" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="x23" id="1URhD9Lcf9" role="x8">
          <property role="x3" value="MotorReglas" />
        </node>
        <node concept="xk" id="1aq3bgdbeb" role="x8">
          <property role="x3" value="Revisor" />
        </node>
        <node concept="xl" id="15srO6BYAI" role="x9">
          <property role="x3" value="Bot" />
        </node>
        <node concept="xl" id="1f2p3H7t3d" role="x9">
          <property role="x3" value="Ana" />
        </node>
        <node concept="xm" id="1ompnJsb5L" role="xa">
          <ref role="xn" node="15srO6BYAI" resolve="Bot" />
          <ref role="xo" node="1URhD9Lcf9" resolve="MotorReglas" />
        </node>
        <node concept="xm" id="1tPF17gUcs" role="xa">
          <ref role="xn" node="1f2p3H7t3d" resolve="Ana" />
          <ref role="xo" node="1aq3bgdbeb" resolve="Revisor" />
        </node>
        <node concept="x1n" id="12iRD1Ls5m" role="xe">
          <property role="x3" value="aprobado" />
          <node concept="x24" id="1K5ylR1pvA" role="x1o" />
          <node concept="x25" id="1hckcW57EC" role="x1p">
            <property role="x26" value="true" />
          </node>
        </node>
        <node concept="x27" id="1GMl2CJPG2" role="xb">
          <property role="x3" value="CalcularRiesgo" />
          <ref role="xr" node="1URhD9Lcf9" resolve="MotorReglas" />
        </node>
        <node concept="xp" id="1hY2Fccti0" role="xb">
          <property role="x3" value="Revisar" />
          <ref role="xr" node="1aq3bgdbeb" resolve="Revisor" />
        </node>
        <node concept="xs" id="1PKyjptMEz" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1dOiueW2Iv" role="xt">
            <ref role="xz" node="1QunIDQ5SD" resolve="Inicio" />
          </node>
          <node concept="x10" id="19pHzAk2pS" role="xu">
            <ref role="xz" node="1it9YVvoIW" resolve="Revision" />
          </node>
          <node concept="x11" id="17kzM8lwpR" role="xv">
            <ref role="x12" node="1GMl2CJPG2" resolve="CalcularRiesgo" />
          </node>
        </node>
        <node concept="xs" id="1dqMDvvv9h" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="15hwKw7dJH" role="xt">
            <ref role="xz" node="1it9YVvoIW" resolve="Revision" />
          </node>
          <node concept="x10" id="1025E6vOkl" role="xu">
            <ref role="xz" node="1it9YVvoIW" resolve="Revision" />
          </node>
          <node concept="x11" id="1DLuma3QcL" role="xv">
            <ref role="x12" node="1hY2Fccti0" resolve="Revisar" />
          </node>
          <node concept="x1t" id="1a94Ou5oHa" role="xw">
            <node concept="x21" id="1NF33CXf0U" role="x1u">
              <node concept="x1z" id="1mGmpbMcUk" role="x22">
                <ref role="x20" node="12iRD1Ls5m" resolve="aprobado" />
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1t7zN723WA" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1ftYc3tdVI" role="xt">
            <ref role="xz" node="1it9YVvoIW" resolve="Revision" />
          </node>
          <node concept="x10" id="1qxSxxCe1f" role="xu">
            <ref role="xz" node="1YzcUBSKjd" resolve="Fin" />
          </node>
          <node concept="x11" id="1vVDp0ylms" role="xv">
            <ref role="x12" node="1hY2Fccti0" resolve="Revisar" />
          </node>
          <node concept="x1t" id="17Fc3eB432" role="xw">
            <node concept="x1z" id="1Oab6ZYWfr" role="x1u">
              <ref role="x20" node="12iRD1Ls5m" resolve="aprobado" />
            </node>
          </node>
        </node>
        <node concept="x13" id="19tsNDwDa6" role="xd" />
        <node concept="x1b" id="1gJLnkAmPC" role="xd">
          <ref role="x1c" node="1GMl2CJPG2" resolve="CalcularRiesgo" />
          <node concept="x1e" id="1w5p5z1vjz" role="x1d">
            <ref role="x1f" node="15srO6BYAI" resolve="Bot" />
          </node>
        </node>
        <node concept="x1g" id="1F0uwavtFl" role="xd">
          <ref role="x1h" node="1YzcUBSKjd" resolve="Fin" />
        </node>
        <node concept="x1i" id="1koVgkJNWx" role="xg">
          <node concept="x1k" id="1s8QnR5xMp" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="14dR0UppnF" role="x1">
      <node concept="x6" id="1QqCOsad2K" role="x5">
        <property role="x3" value="SolicitudCompra" />
        <node concept="xh" id="12KP4LX4MK" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1JDRvtL3Fk" role="x7">
          <property role="x3" value="EnRevision" />
        </node>
        <node concept="xi" id="1rVJdIyhVQ" role="x7">
          <property role="x3" value="RevisionDirector" />
        </node>
        <node concept="xi" id="1A21XzgkvR" role="x7">
          <property role="x3" value="OrdenEmitida" />
        </node>
        <node concept="xj" id="11lBo4uc9L" role="x7">
          <property role="x3" value="Aprobada" />
        </node>
        <node concept="xj" id="1rVgn7BP81" role="x7">
          <property role="x3" value="Rechazada" />
        </node>
        <node concept="xi" id="1pU7LLaOS7" role="x7">
          <property role="x3" value="Archivada" />
        </node>
        <node concept="xk" id="1wPoRAEVBp" role="x8">
          <property role="x3" value="Solicitante" />
        </node>
        <node concept="xk" id="19DHSLTdZd" role="x8">
          <property role="x3" value="Aprobador" />
        </node>
        <node concept="xk" id="1XF574p4Ow" role="x8">
          <property role="x3" value="Director" />
        </node>
        <node concept="x23" id="1ZGkICP4VD" role="x8">
          <property role="x3" value="ERP" />
        </node>
        <node concept="xl" id="1GEVKBdmx9" role="x9">
          <property role="x3" value="Carla" />
        </node>
        <node concept="xl" id="1aM2LcoPQA" role="x9">
          <property role="x3" value="Mario" />
        </node>
        <node concept="xl" id="1xJvQg2k32" role="x9">
          <property role="x3" value="Sofia" />
        </node>
        <node concept="xl" id="15CYg0rLlr" role="x9">
          <property role="x3" value="SAP" />
        </node>
        <node concept="xm" id="19Ie6LPhVl" role="xa">
          <ref role="xn" node="1GEVKBdmx9" resolve="Carla" />
          <ref role="xo" node="1wPoRAEVBp" resolve="Solicitante" />
        </node>
        <node concept="xm" id="1U0FQcQyrg" role="xa">
          <ref role="xn" node="1aM2LcoPQA" resolve="Mario" />
          <ref role="xo" node="19DHSLTdZd" resolve="Aprobador" />
        </node>
        <node concept="xm" id="1GVGkOOJRY" role="xa">
          <ref role="xn" node="1xJvQg2k32" resolve="Sofia" />
          <ref role="xo" node="1XF574p4Ow" resolve="Director" />
        </node>
        <node concept="xm" id="1VlFxAEEbR" role="xa">
          <ref role="xn" node="15CYg0rLlr" resolve="SAP" />
          <ref role="xo" node="1ZGkICP4VD" resolve="ERP" />
        </node>
        <node concept="x1n" id="1AIMY6SH89" role="xe">
          <property role="x3" value="monto" />
          <node concept="x1q" id="16vQkDmOd2" role="x1o" />
          <node concept="x1r" id="1O1ceWywKX" role="x1p">
            <property role="x1s" value="2500" />
          </node>
        </node>
        <node concept="x1n" id="1RrkmFMzxJ" role="xe">
          <property role="x3" value="urgente" />
          <node concept="x24" id="1liYnAseF9" role="x1o" />
          <node concept="x25" id="1UieGK11VL" role="x1p">
            <property role="x26" value="false" />
          </node>
        </node>
        <node concept="x1n" id="1JournflyW" role="xe">
          <property role="x3" value="area" />
          <node concept="x28" id="15gN2Zml8C" role="x1o" />
          <node concept="x29" id="1wHvqgcUne" role="x1p">
            <property role="x2a" value="TI" />
          </node>
        </node>
        <node concept="xp" id="121R4I4JJA" role="xb">
          <property role="x3" value="RegistrarSolicitud" />
          <ref role="xr" node="1wPoRAEVBp" resolve="Solicitante" />
        </node>
        <node concept="xp" id="1NQT5nkCTk" role="xb">
          <property role="x3" value="RevisarSolicitud" />
          <ref role="xr" node="19DHSLTdZd" resolve="Aprobador" />
        </node>
        <node concept="xp" id="1jlhHo027Y" role="xb">
          <property role="x3" value="AutorizarGasto" />
          <ref role="xr" node="1XF574p4Ow" resolve="Director" />
        </node>
        <node concept="x27" id="17nwrAsdtu" role="xb">
          <property role="x3" value="EmitirOrden" />
          <ref role="xr" node="1ZGkICP4VD" resolve="ERP" />
        </node>
        <node concept="xs" id="1gyXCAgNIZ" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1MPgzOX4iW" role="xt">
            <ref role="xz" node="12KP4LX4MK" resolve="Inicio" />
          </node>
          <node concept="x10" id="1B3Fej1EYy" role="xu">
            <ref role="xz" node="1JDRvtL3Fk" resolve="EnRevision" />
          </node>
          <node concept="x11" id="106aStDOg1" role="xv">
            <ref role="x12" node="121R4I4JJA" resolve="RegistrarSolicitud" />
          </node>
        </node>
        <node concept="xs" id="1vfDG15lOr" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1jIkI75r37" role="xt">
            <ref role="xz" node="1JDRvtL3Fk" resolve="EnRevision" />
          </node>
          <node concept="x10" id="1nUMaMPu8G" role="xu">
            <ref role="xz" node="1A21XzgkvR" resolve="OrdenEmitida" />
          </node>
          <node concept="x11" id="1NEZWwHzxO" role="xv">
            <ref role="x12" node="1NQT5nkCTk" resolve="RevisarSolicitud" />
          </node>
          <node concept="x1t" id="10b7yhARIc" role="xw">
            <node concept="x1v" id="16x4AifMTT" role="x1u">
              <node concept="x1z" id="1IdLysuu5q" role="x1x">
                <ref role="x20" node="1AIMY6SH89" resolve="monto" />
              </node>
              <node concept="x1r" id="1Q8NW0oKuF" role="x1y">
                <property role="x1s" value="1000" />
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1acI3zn7Od" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1Y6wTo6yR6" role="xt">
            <ref role="xz" node="1JDRvtL3Fk" resolve="EnRevision" />
          </node>
          <node concept="x10" id="1mKuJRrtQN" role="xu">
            <ref role="xz" node="1rVJdIyhVQ" resolve="RevisionDirector" />
          </node>
          <node concept="x11" id="1YHiaWCO7O" role="xv">
            <ref role="x12" node="1NQT5nkCTk" resolve="RevisarSolicitud" />
          </node>
          <node concept="x1t" id="1HM98MlO87" role="xw">
            <node concept="x21" id="1jmQIu4ZPX" role="x1u">
              <node concept="x1v" id="183Nk0606e" role="x22">
                <node concept="x1z" id="1pscbeFqtr" role="x1x">
                  <ref role="x20" node="1AIMY6SH89" resolve="monto" />
                </node>
                <node concept="x1r" id="17zpoZxZfK" role="x1y">
                  <property role="x1s" value="1000" />
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1L0Per6ZPZ" role="xc">
          <property role="x3" value="T4" />
          <node concept="xx" id="1VivLV2VD5" role="xt">
            <ref role="xz" node="1rVJdIyhVQ" resolve="RevisionDirector" />
          </node>
          <node concept="x10" id="19w9xcaEF2" role="xu">
            <ref role="xz" node="1A21XzgkvR" resolve="OrdenEmitida" />
          </node>
          <node concept="x11" id="1Air4MS12f" role="xv">
            <ref role="x12" node="1jlhHo027Y" resolve="AutorizarGasto" />
          </node>
          <node concept="x1t" id="14xYUEf77F" role="xw">
            <node concept="x2b" id="1U2NtZN09w" role="x1u">
              <node concept="x1z" id="1kNRD7OLPG" role="x1x">
                <ref role="x20" node="1RrkmFMzxJ" resolve="urgente" />
              </node>
              <node concept="x2c" id="1CiMDxg0wu" role="x1y">
                <node concept="x1z" id="1L17GPQiQv" role="x1x">
                  <ref role="x20" node="1JournflyW" resolve="area" />
                </node>
                <node concept="x29" id="1RDX5rrLwz" role="x1y">
                  <property role="x2a" value="TI" />
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1RfEIl0H6q" role="xc">
          <property role="x3" value="T5" />
          <node concept="xx" id="1jTAVVVCaK" role="xt">
            <ref role="xz" node="1rVJdIyhVQ" resolve="RevisionDirector" />
          </node>
          <node concept="x10" id="19dRSPqujV" role="xu">
            <ref role="xz" node="1rVgn7BP81" resolve="Rechazada" />
          </node>
          <node concept="x11" id="18GVPpbFlU" role="xv">
            <ref role="x12" node="1jlhHo027Y" resolve="AutorizarGasto" />
          </node>
          <node concept="x1t" id="104tZToEgz" role="xw">
            <node concept="x21" id="1LMvHRx7g4" role="x1u">
              <node concept="x2b" id="1f2Qvg0qhq" role="x22">
                <node concept="x1z" id="1mBFCcfla3" role="x1x">
                  <ref role="x20" node="1RrkmFMzxJ" resolve="urgente" />
                </node>
                <node concept="x2c" id="1U1OVDt4ca" role="x1y">
                  <node concept="x1z" id="1h4lh2VI8D" role="x1x">
                    <ref role="x20" node="1JournflyW" resolve="area" />
                  </node>
                  <node concept="x29" id="1Q5xREJn7A" role="x1y">
                    <property role="x2a" value="TI" />
                  </node>
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="17fj1w91DC" role="xc">
          <property role="x3" value="T6" />
          <node concept="xx" id="1P1Us2BG2q" role="xt">
            <ref role="xz" node="1A21XzgkvR" resolve="OrdenEmitida" />
          </node>
          <node concept="x10" id="1W5WJTMAx0" role="xu">
            <ref role="xz" node="11lBo4uc9L" resolve="Aprobada" />
          </node>
          <node concept="x11" id="1pVkjjD8g5" role="xv">
            <ref role="x12" node="17nwrAsdtu" resolve="EmitirOrden" />
          </node>
        </node>
        <node concept="x13" id="1Roinm6IaN" role="xd" />
        <node concept="x14" id="1jQtHWjyS6" role="xd">
          <ref role="x15" node="1rVgn7BP81" resolve="Rechazada" />
        </node>
        <node concept="x16" id="1eoSbiGYZp" role="xd">
          <ref role="x17" node="11lBo4uc9L" resolve="Aprobada" />
          <node concept="x19" id="11GzbjR1P2" role="x18">
            <ref role="x1a" node="1gyXCAgNIZ" resolve="T1" />
          </node>
          <node concept="x19" id="1Ym2GkOuIp" role="x18">
            <ref role="x1a" node="1vfDG15lOr" resolve="T2" />
          </node>
          <node concept="x19" id="14EE0YJl04" role="x18">
            <ref role="x1a" node="17fj1w91DC" resolve="T6" />
          </node>
        </node>
        <node concept="x1b" id="1s219uj1jV" role="xd">
          <ref role="x1c" node="1jlhHo027Y" resolve="AutorizarGasto" />
          <node concept="x1e" id="1aqOqx3He7" role="x1d">
            <ref role="x1f" node="1xJvQg2k32" resolve="Sofia" />
          </node>
        </node>
        <node concept="x1g" id="1aKmLLwpIf" role="xd">
          <ref role="x1h" node="11lBo4uc9L" resolve="Aprobada" />
        </node>
        <node concept="x1i" id="1sDVScp379" role="xg">
          <node concept="x1k" id="11BXCuf32P" role="x1j">
            <property role="x1l" value="true" />
            <property role="x1m" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="18W3UnshYs" role="x1">
      <node concept="x6" id="1BosZ3RRmG" role="x5">
        <property role="x3" value="CE_VerificacionesFalsas" />
        <node concept="xh" id="1pWnkz1eoN" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1nphSOcB2W" role="x7">
          <property role="x3" value="Revision" />
        </node>
        <node concept="xi" id="1D3u7DgRB1" role="x7">
          <property role="x3" value="Bucle" />
          <node concept="x1i" id="1gTtYhIm7J" role="xg">
            <node concept="x2d" id="1POsz3hDxS" role="x1j" />
          </node>
        </node>
        <node concept="xj" id="1iZi12IqIo" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xi" id="1JVuTMQVs4" role="x7">
          <property role="x3" value="Olvidado" />
          <node concept="x1i" id="1kX8n0Ip7j" role="xg">
            <node concept="x2e" id="119lJuHg5R" role="x1j" />
          </node>
        </node>
        <node concept="xk" id="1GTGPknT22" role="x8">
          <property role="x3" value="Revisor" />
        </node>
        <node concept="xl" id="16dXrXrZML" role="x9">
          <property role="x3" value="Ana" />
        </node>
        <node concept="xl" id="1OgJGJNp71" role="x9">
          <property role="x3" value="Luis" />
        </node>
        <node concept="xm" id="1NWER85CXY" role="xa">
          <ref role="xn" node="16dXrXrZML" resolve="Ana" />
          <ref role="xo" node="1GTGPknT22" resolve="Revisor" />
        </node>
        <node concept="xp" id="12qg062tNN" role="xb">
          <property role="x3" value="Revisar" />
          <ref role="xr" node="1GTGPknT22" resolve="Revisor" />
        </node>
        <node concept="xs" id="1e4zG66dLn" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1Jg6ubcTNn" role="xt">
            <ref role="xz" node="1pWnkz1eoN" resolve="Inicio" />
          </node>
          <node concept="x10" id="1tG9Bc98pB" role="xu">
            <ref role="xz" node="1nphSOcB2W" resolve="Revision" />
          </node>
        </node>
        <node concept="xs" id="1YQWgsUasQ" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1HUfu3Q7nd" role="xt">
            <ref role="xz" node="1nphSOcB2W" resolve="Revision" />
          </node>
          <node concept="x10" id="1an7ePNFgq" role="xu">
            <ref role="xz" node="1iZi12IqIo" resolve="Fin" />
          </node>
          <node concept="x11" id="16Xfm5K4Io" role="xv">
            <ref role="x12" node="12qg062tNN" resolve="Revisar" />
          </node>
        </node>
        <node concept="xs" id="1ObJxMA60O" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1FYT3KqXxF" role="xt">
            <ref role="xz" node="1nphSOcB2W" resolve="Revision" />
          </node>
          <node concept="x10" id="1WTAxlm9Hl" role="xu">
            <ref role="xz" node="1D3u7DgRB1" resolve="Bucle" />
          </node>
        </node>
        <node concept="xs" id="1Qw0Rmvrhr" role="xc">
          <property role="x3" value="T4" />
          <node concept="xx" id="19gtVQxdvZ" role="xt">
            <ref role="xz" node="1D3u7DgRB1" resolve="Bucle" />
          </node>
          <node concept="x10" id="1IuftMG0FC" role="xu">
            <ref role="xz" node="1D3u7DgRB1" resolve="Bucle" />
          </node>
        </node>
        <node concept="x14" id="1VY4BCCxbm" role="xd">
          <ref role="x15" node="1JVuTMQVs4" resolve="Olvidado" />
          <node concept="x1i" id="1PnSoSmj8l" role="xg">
            <node concept="x2d" id="1pwW6ddhV5" role="x1j" />
          </node>
        </node>
        <node concept="x13" id="13drEG96Kf" role="xd">
          <node concept="x1i" id="1LzzxxuBaH" role="xg">
            <node concept="x2d" id="1maQ4xPtt3" role="x1j" />
          </node>
        </node>
        <node concept="x16" id="1qvCVZsAX7" role="xd">
          <ref role="x17" node="1iZi12IqIo" resolve="Fin" />
          <node concept="x19" id="1qwmhUoA9w" role="x18">
            <ref role="x1a" node="1e4zG66dLn" resolve="T1" />
          </node>
          <node concept="x19" id="1j0i4sB5l5" role="x18">
            <ref role="x1a" node="1ObJxMA60O" resolve="T3" />
          </node>
          <node concept="x1i" id="1phLUhG59c" role="xg">
            <node concept="x2d" id="1Inl4M3Agz" role="x1j" />
          </node>
        </node>
        <node concept="x1b" id="1XveJ62tK2" role="xd">
          <ref role="x1c" node="12qg062tNN" resolve="Revisar" />
          <node concept="x1e" id="1MwmiMEovO" role="x1d">
            <ref role="x1f" node="16dXrXrZML" resolve="Ana" />
          </node>
          <node concept="x1e" id="1GvfbyFcKj" role="x1d">
            <ref role="x1f" node="1OgJGJNp71" resolve="Luis" />
          </node>
          <node concept="x1i" id="1UEuu99NJp" role="xg">
            <node concept="x2d" id="1awZWp0Ujw" role="x1j" />
          </node>
        </node>
        <node concept="x1g" id="1hnw6H8nwU" role="xd">
          <ref role="x1h" node="1D3u7DgRB1" resolve="Bucle" />
          <node concept="x1i" id="16VPCFWLeM" role="xg">
            <node concept="x2d" id="1pu5lsu50t" role="x1j" />
          </node>
        </node>
      </node>
    </node>
  </node>
</model>
