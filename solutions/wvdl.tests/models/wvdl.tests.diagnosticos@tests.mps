<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:616ea3eb-6aff-4ba7-a8d9-6e142e0bd7fa(wvdl.tests.diagnosticos@tests)">
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
      </concept>
      <concept id="1215507671101" name="jetbrains.mps.lang.test.structure.NodeErrorCheckOperation" flags="ng" index="x27" />
      <concept id="1215511704609" name="jetbrains.mps.lang.test.structure.NodeWarningCheckOperation" flags="ng" index="x28" />
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
      <concept id="1984639994254280242" name="wvdl.structure.Variable" flags="ng" index="x1m">
        <child id="1116711506113754239" name="type" index="x1n" />
        <child id="3342385426935315388" name="init" index="x1o" />
      </concept>
      <concept id="2211624816874732235" name="wvdl.structure.IntegerType" flags="ng" index="x1p" />
      <concept id="4356461840986708983" name="wvdl.structure.IntLiteral" flags="ng" index="x1q">
        <property id="2764001242192483827" name="value" index="x1r" />
      </concept>
      <concept id="3474567488466545183" name="wvdl.structure.Guard" flags="ng" index="x1s">
        <child id="4202132126237685012" name="condition" index="x1t" />
      </concept>
      <concept id="4006625772246302066" name="wvdl.structure.LtExpr" flags="ng" index="x1u" />
      <concept id="2503589227462995725" name="wvdl.structure.IBinaryOperation" flags="ngI" index="x1v">
        <child id="3597341855276219803" name="left" index="x1w" />
        <child id="4307423801848415733" name="right" index="x1x" />
      </concept>
      <concept id="448228914353461423" name="wvdl.structure.VarRef" flags="ng" index="x1y">
        <reference id="3618521687389199141" name="variable" index="x1z" />
      </concept>
      <concept id="2935791979113318278" name="wvdl.structure.NotExpr" flags="ng" index="x20">
        <child id="4235839573527162062" name="operand" index="x21" />
      </concept>
      <concept id="1727450827697905204" name="wvdl.structure.SystemRole" flags="ng" index="x22" />
      <concept id="932772402753431168" name="wvdl.structure.BooleanType" flags="ng" index="x23" />
      <concept id="3341333894158794751" name="wvdl.structure.BoolLiteral" flags="ng" index="x24">
        <property id="448872718996398809" name="value" index="x25" />
      </concept>
      <concept id="1480812486812752603" name="wvdl.structure.AutomatedActivity" flags="ng" index="x26" />
      <concept id="3832905274808341295" name="wvdl.structure.AndExpr" flags="ng" index="x29" />
      <concept id="2874916540859629813" name="wvdl.structure.EqExpr" flags="ng" index="x2a" />
      <concept id="1887490964949997474" name="wvdl.structure.StringType" flags="ng" index="x2b" />
      <concept id="2142532025266201015" name="wvdl.structure.StringLiteral" flags="ng" index="x2c">
        <property id="3067358161925164103" name="value" index="x2d" />
      </concept>
      <concept id="218929957572760305" name="wvdl.structure.OrExpr" flags="ng" index="x2e" />
    </language>
  </registry>
  <node concept="x0" id="1JaiO3hpHD">
    <property role="x3" value="SemanticaEstatica" />
    <node concept="x4" id="14Mx1y21eH" role="x1">
      <node concept="x6" id="1LKQ0XuRqm" role="x5">
        <property role="x3" value="V01_Lineal" />
        <node concept="xh" id="1I8ydUllXL" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1b4W10Esfy" role="x7">
          <property role="x3" value="Revision" />
        </node>
        <node concept="xj" id="1A4eAhcsEL" role="x7">
          <property role="x3" value="Aprobado" />
        </node>
        <node concept="xk" id="1qikdmf3zQ" role="x8">
          <property role="x3" value="Revisor" />
        </node>
        <node concept="xl" id="1kyNigO6Er" role="x9">
          <property role="x3" value="Ana" />
        </node>
        <node concept="xm" id="1403j3Uj9c" role="xa">
          <ref role="xn" node="1kyNigO6Er" resolve="Ana" />
          <ref role="xo" node="1qikdmf3zQ" resolve="Revisor" />
        </node>
        <node concept="xp" id="1ggtfAq0MI" role="xb">
          <property role="x3" value="Revisar" />
          <ref role="xr" node="1qikdmf3zQ" resolve="Revisor" />
        </node>
        <node concept="xs" id="1bg6PG7qSm" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1IQqb6zNA5" role="xt">
            <ref role="xz" node="1I8ydUllXL" resolve="Inicio" />
          </node>
          <node concept="x10" id="1k6OuhnS7A" role="xu">
            <ref role="xz" node="1b4W10Esfy" resolve="Revision" />
          </node>
        </node>
        <node concept="xs" id="1BW65BP7WM" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1z9wU50Hrk" role="xt">
            <ref role="xz" node="1b4W10Esfy" resolve="Revision" />
          </node>
          <node concept="x10" id="1ZWaBrVgky" role="xu">
            <ref role="xz" node="1A4eAhcsEL" resolve="Aprobado" />
          </node>
          <node concept="x11" id="1Qw5RjB5Pq" role="xv">
            <ref role="x12" node="1ggtfAq0MI" resolve="Revisar" />
          </node>
        </node>
        <node concept="x13" id="19tz2xQOwo" role="xd" />
        <node concept="x14" id="1iTDVErcUQ" role="xd">
          <ref role="x15" node="1A4eAhcsEL" resolve="Aprobado" />
        </node>
        <node concept="x16" id="1G2SRqs7J2" role="xd">
          <ref role="x17" node="1A4eAhcsEL" resolve="Aprobado" />
          <node concept="x19" id="1lVPhlpYBd" role="x18">
            <ref role="x1a" node="1bg6PG7qSm" resolve="T1" />
          </node>
          <node concept="x19" id="1pJr0UoWUq" role="x18">
            <ref role="x1a" node="1BW65BP7WM" resolve="T2" />
          </node>
        </node>
        <node concept="x1b" id="1njOLyPWfM" role="xd">
          <ref role="x1c" node="1ggtfAq0MI" resolve="Revisar" />
          <node concept="x1e" id="1GIeVJ9SI9" role="x1d">
            <ref role="x1f" node="1kyNigO6Er" resolve="Ana" />
          </node>
        </node>
        <node concept="x1g" id="1mGxpv9MIn" role="xd">
          <ref role="x1h" node="1A4eAhcsEL" resolve="Aprobado" />
        </node>
        <node concept="x1i" id="1WBm78fC5g" role="xg">
          <node concept="x1k" id="1PGvhJs87l" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1bI2VfWl91" role="x1">
      <node concept="x6" id="1H9WhO1HQo" role="x5">
        <property role="x3" value="V02_Ramificacion" />
        <node concept="xh" id="150Vih4WW3" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1rS7Q52rRs" role="x7">
          <property role="x3" value="Validacion" />
        </node>
        <node concept="xj" id="1CXmNEgCkv" role="x7">
          <property role="x3" value="Aprobado" />
        </node>
        <node concept="xj" id="10FVOXJOXo" role="x7">
          <property role="x3" value="Rechazado" />
        </node>
        <node concept="xk" id="1JMY3R7Qxl" role="x8">
          <property role="x3" value="Validador" />
        </node>
        <node concept="xl" id="1wGpydk7s1" role="x9">
          <property role="x3" value="Luis" />
        </node>
        <node concept="xm" id="1OU2xA7mTt" role="xa">
          <ref role="xn" node="1wGpydk7s1" resolve="Luis" />
          <ref role="xo" node="1JMY3R7Qxl" resolve="Validador" />
        </node>
        <node concept="x1m" id="1bvoI7hfma" role="xe">
          <property role="x3" value="monto" />
          <node concept="x1p" id="1B8z9iwvpt" role="x1n" />
          <node concept="x1q" id="1IhypidVb8" role="x1o">
            <property role="x1r" value="500" />
          </node>
        </node>
        <node concept="xp" id="1OflMySjUk" role="xb">
          <property role="x3" value="Validar" />
          <ref role="xr" node="1JMY3R7Qxl" resolve="Validador" />
        </node>
        <node concept="xs" id="1TwWkAMplv" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1b3lahRJNJ" role="xt">
            <ref role="xz" node="150Vih4WW3" resolve="Inicio" />
          </node>
          <node concept="x10" id="1iY1Umq4cM" role="xu">
            <ref role="xz" node="1rS7Q52rRs" resolve="Validacion" />
          </node>
        </node>
        <node concept="xs" id="1AoIuTlA81" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1jiMJCb9yb" role="xt">
            <ref role="xz" node="1rS7Q52rRs" resolve="Validacion" />
          </node>
          <node concept="x10" id="1hjBP269kN" role="xu">
            <ref role="xz" node="1CXmNEgCkv" resolve="Aprobado" />
          </node>
          <node concept="x11" id="1m9VXw4TD8" role="xv">
            <ref role="x12" node="1OflMySjUk" resolve="Validar" />
          </node>
          <node concept="x1s" id="1db7Zp9y9q" role="xw">
            <node concept="x1u" id="1iP09aUzuA" role="x1t">
              <node concept="x1y" id="1gwmC3DbKm" role="x1w">
                <ref role="x1z" node="1bvoI7hfma" resolve="monto" />
              </node>
              <node concept="x1q" id="1FO4cnCkV3" role="x1x">
                <property role="x1r" value="1000" />
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1om415J3QR" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1lk12Vbeem" role="xt">
            <ref role="xz" node="1rS7Q52rRs" resolve="Validacion" />
          </node>
          <node concept="x10" id="1OUk6lwyAF" role="xu">
            <ref role="xz" node="10FVOXJOXo" resolve="Rechazado" />
          </node>
          <node concept="x11" id="1m98Fvzi5f" role="xv">
            <ref role="x12" node="1OflMySjUk" resolve="Validar" />
          </node>
          <node concept="x1s" id="1XbOxSHMgR" role="xw">
            <node concept="x20" id="1g0O6eT57x" role="x1t">
              <node concept="x1u" id="1ztfaAtzXh" role="x21">
                <node concept="x1y" id="1N9H7LMUuK" role="x1w">
                  <ref role="x1z" node="1bvoI7hfma" resolve="monto" />
                </node>
                <node concept="x1q" id="1CDgIdGwrX" role="x1x">
                  <property role="x1r" value="1000" />
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="x13" id="15Hi2rHJIQ" role="xd" />
        <node concept="x16" id="1LrPM47Fyx" role="xd">
          <ref role="x17" node="10FVOXJOXo" resolve="Rechazado" />
          <node concept="x19" id="1dTelQlnKK" role="x18">
            <ref role="x1a" node="1TwWkAMplv" resolve="T1" />
          </node>
          <node concept="x19" id="1yA2ipLdW4" role="x18">
            <ref role="x1a" node="1om415J3QR" resolve="T3" />
          </node>
        </node>
        <node concept="x1g" id="1X0ny5Z14y" role="xd">
          <ref role="x1h" node="1CXmNEgCkv" resolve="Aprobado" />
        </node>
        <node concept="x1i" id="1ERFOuev1t" role="xg">
          <node concept="x1k" id="1BtYLX1iH5" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1mBlEkwQBt" role="x1">
      <node concept="x6" id="1Ncsrt2pko" role="x5">
        <property role="x3" value="V03_Automatizado" />
        <node concept="xh" id="1z3liBgIWG" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1V4vQh82Gw" role="x7">
          <property role="x3" value="Revision" />
        </node>
        <node concept="xj" id="12fhFuoU8f" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="x22" id="1BEvekiw9r" role="x8">
          <property role="x3" value="MotorReglas" />
        </node>
        <node concept="xk" id="1A5byeFilC" role="x8">
          <property role="x3" value="Revisor" />
        </node>
        <node concept="xl" id="1JEPNjJoMG" role="x9">
          <property role="x3" value="Bot" />
        </node>
        <node concept="xl" id="1r3BWeZlyJ" role="x9">
          <property role="x3" value="Ana" />
        </node>
        <node concept="xm" id="1oAB36dYPY" role="xa">
          <ref role="xn" node="1JEPNjJoMG" resolve="Bot" />
          <ref role="xo" node="1BEvekiw9r" resolve="MotorReglas" />
        </node>
        <node concept="xm" id="10nSP23bjt" role="xa">
          <ref role="xn" node="1r3BWeZlyJ" resolve="Ana" />
          <ref role="xo" node="1A5byeFilC" resolve="Revisor" />
        </node>
        <node concept="x1m" id="1r3cRAtpgm" role="xe">
          <property role="x3" value="aprobado" />
          <node concept="x23" id="1pYPVB9CfP" role="x1n" />
          <node concept="x24" id="1BfZlM0BuR" role="x1o">
            <property role="x25" value="true" />
          </node>
        </node>
        <node concept="x26" id="1m8JItWOFw" role="xb">
          <property role="x3" value="CalcularRiesgo" />
          <ref role="xr" node="1BEvekiw9r" resolve="MotorReglas" />
        </node>
        <node concept="xp" id="1wmgLlnqL7" role="xb">
          <property role="x3" value="Revisar" />
          <ref role="xr" node="1A5byeFilC" resolve="Revisor" />
        </node>
        <node concept="xs" id="12Q8kRFjPP" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1yUSsARMhN" role="xt">
            <ref role="xz" node="1z3liBgIWG" resolve="Inicio" />
          </node>
          <node concept="x10" id="1GExddF7g8" role="xu">
            <ref role="xz" node="1V4vQh82Gw" resolve="Revision" />
          </node>
          <node concept="x11" id="1z1XHc85xi" role="xv">
            <ref role="x12" node="1m8JItWOFw" resolve="CalcularRiesgo" />
          </node>
        </node>
        <node concept="xs" id="1dhZD89f7E" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1d0zXH3NBR" role="xt">
            <ref role="xz" node="1V4vQh82Gw" resolve="Revision" />
          </node>
          <node concept="x10" id="12Y3aE4ZKL" role="xu">
            <ref role="xz" node="1V4vQh82Gw" resolve="Revision" />
          </node>
          <node concept="x11" id="1OlvUnKgIU" role="xv">
            <ref role="x12" node="1wmgLlnqL7" resolve="Revisar" />
          </node>
          <node concept="x1s" id="10srTDaJzp" role="xw">
            <node concept="x20" id="1ZBYcqyFg4" role="x1t">
              <node concept="x1y" id="1ZUffSiAPm" role="x21">
                <ref role="x1z" node="1r3cRAtpgm" resolve="aprobado" />
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="19aKvnx81q" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1a91TcZaSW" role="xt">
            <ref role="xz" node="1V4vQh82Gw" resolve="Revision" />
          </node>
          <node concept="x10" id="1AA2GP1v0N" role="xu">
            <ref role="xz" node="12fhFuoU8f" resolve="Fin" />
          </node>
          <node concept="x11" id="1rJrtTl3Vx" role="xv">
            <ref role="x12" node="1wmgLlnqL7" resolve="Revisar" />
          </node>
          <node concept="x1s" id="1P0EsfT3Yp" role="xw">
            <node concept="x1y" id="1pli7pVMtB" role="x1t">
              <ref role="x1z" node="1r3cRAtpgm" resolve="aprobado" />
            </node>
          </node>
        </node>
        <node concept="x13" id="11KYOVJxMh" role="xd" />
        <node concept="x1b" id="157mL81X67" role="xd">
          <ref role="x1c" node="1m8JItWOFw" resolve="CalcularRiesgo" />
          <node concept="x1e" id="1jv9vaseRj" role="x1d">
            <ref role="x1f" node="1JEPNjJoMG" resolve="Bot" />
          </node>
        </node>
        <node concept="x1g" id="1sDz35UlBp" role="xd">
          <ref role="x1h" node="12fhFuoU8f" resolve="Fin" />
        </node>
        <node concept="x1i" id="1U7vbnQHM7" role="xg">
          <node concept="x1k" id="1u7OBfy46p" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1JCBYoP1pu" role="x1">
      <node concept="x6" id="1jG5JGOrUb" role="x5">
        <property role="x3" value="Otro_Workflow" />
        <node concept="xh" id="18Bk8pKUGv" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xj" id="14zXAa1aod" role="x7">
          <property role="x3" value="Externo" />
        </node>
        <node concept="xs" id="16rcY4JoHk" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1IpCpt8ulp" role="xt">
            <ref role="xz" node="18Bk8pKUGv" resolve="Inicio" />
          </node>
          <node concept="x10" id="18tomrV6go" role="xu">
            <ref role="xz" node="14zXAa1aod" resolve="Externo" />
          </node>
        </node>
        <node concept="x1i" id="1aq0JhfPDw" role="xg">
          <node concept="x1k" id="1u6q7X6Qg1" role="x1j">
            <property role="x1l" value="true" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1wbthCnlET" role="x1">
      <node concept="x6" id="1k6unL9xMZ" role="x5">
        <property role="x3" value="IS1_ReferenciaAjena" />
        <node concept="xh" id="1MY18x14f9" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xj" id="1ke9qSBJ7F" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xs" id="1fWzmMfItc" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1GyBKs5m5c" role="xt">
            <ref role="xz" node="1MY18x14f9" resolve="Inicio" />
          </node>
          <node concept="x10" id="1LLmN1gon0" role="xu">
            <ref role="xz" node="1ke9qSBJ7F" resolve="Fin" />
          </node>
        </node>
        <node concept="xs" id="1ugDjrJ3Y6" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1kAyjAV2hX" role="xt">
            <ref role="xz" node="1MY18x14f9" resolve="Inicio" />
          </node>
          <node concept="x10" id="1PKsV3T0C1" role="xu">
            <ref role="xz" node="14zXAa1aod" resolve="Externo" />
          </node>
          <node concept="x1i" id="1UxtXwDr4r" role="xg">
            <node concept="x27" id="1iGUXsIcd5" role="x1j" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1eYZzAwn1i" role="x1">
      <node concept="x6" id="1jBU251V6I" role="x5">
        <property role="x3" value="IS2_GuardaNoBooleana" />
        <node concept="xh" id="11lF12iSyJ" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xj" id="1A0YyHw89w" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="x1m" id="1GjLX5S80A" role="xe">
          <property role="x3" value="monto" />
          <node concept="x1p" id="1LufoWcwXT" role="x1n" />
        </node>
        <node concept="xs" id="1wqMhCupy8" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1DAkRcmHHW" role="xt">
            <ref role="xz" node="11lF12iSyJ" resolve="Inicio" />
          </node>
          <node concept="x10" id="1qd5IDdyqu" role="xu">
            <ref role="xz" node="1A0YyHw89w" resolve="Fin" />
          </node>
          <node concept="x1s" id="1Z25eMbliV" role="xw">
            <node concept="x1y" id="1RgnMikYjE" role="x1t">
              <ref role="x1z" node="1GjLX5S80A" resolve="monto" />
            </node>
            <node concept="x1i" id="1RxG9qaW9q" role="xg">
              <node concept="x27" id="1LCjJZxD2k" role="x1j" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1267lg6TKT" role="x1">
      <node concept="x6" id="1zKIEZK3Bn" role="x5">
        <property role="x3" value="IS3_RolIncompatible" />
        <node concept="xh" id="1E66saHiK6" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xh" id="161MoI4ikd" role="x7">
          <property role="x3" value="Inicio2" />
          <node concept="x1i" id="1s3Gjx7ETx" role="xg">
            <node concept="x27" id="1UUo7ff7VJ" role="x1j" />
          </node>
        </node>
        <node concept="xj" id="1g5iZmkouE" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xk" id="1sP4adSXUf" role="x8">
          <property role="x3" value="Revisor" />
        </node>
        <node concept="xl" id="1rUjr6eM0P" role="x9">
          <property role="x3" value="Ana" />
        </node>
        <node concept="xm" id="1SDpr42z4z" role="xa">
          <ref role="xn" node="1rUjr6eM0P" resolve="Ana" />
          <ref role="xo" node="1sP4adSXUf" resolve="Revisor" />
        </node>
        <node concept="x26" id="1ePVQUe7ms" role="xb">
          <property role="x3" value="Calcular" />
          <ref role="xr" node="1sP4adSXUf" resolve="Revisor" />
          <node concept="x1i" id="1wWABjZJMo" role="xg">
            <node concept="x27" id="1a6sBNTFPZ" role="x1j" />
          </node>
        </node>
        <node concept="xs" id="14yFf08Zbd" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1ttC3Llb5W" role="xt">
            <ref role="xz" node="1E66saHiK6" resolve="Inicio" />
          </node>
          <node concept="x10" id="1MSxpLd5h4" role="xu">
            <ref role="xz" node="1g5iZmkouE" resolve="Fin" />
          </node>
          <node concept="x11" id="1o5FqHEKTa" role="xv">
            <ref role="x12" node="1ePVQUe7ms" resolve="Calcular" />
          </node>
        </node>
        <node concept="xs" id="1fZDCyYTdk" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1sifWN2Jqf" role="xt">
            <ref role="xz" node="161MoI4ikd" resolve="Inicio2" />
          </node>
          <node concept="x10" id="1MQqWz6lHc" role="xu">
            <ref role="xz" node="1g5iZmkouE" resolve="Fin" />
          </node>
        </node>
      </node>
    </node>
  </node>
  <node concept="x0" id="15uy7VgTms">
    <property role="x3" value="Razonador" />
    <node concept="x4" id="1I8vpkkWdm" role="x1">
      <node concept="x6" id="1UC2RWIjqk" role="x5">
        <property role="x3" value="IR1_Inalcanzable" />
        <node concept="xh" id="1UuttLZym8" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xj" id="1JmwqcCUVG" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xi" id="1x7mhYICt0" role="x7">
          <property role="x3" value="Archivado" />
          <node concept="x1i" id="1wv5l1BqAG" role="xg">
            <node concept="x28" id="1SWJSBSFwr" role="x1j" />
          </node>
        </node>
        <node concept="xs" id="1K38snElzv" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="15ms5igJVG" role="xt">
            <ref role="xz" node="1UuttLZym8" resolve="Inicio" />
          </node>
          <node concept="x10" id="1eNncN5F6k" role="xu">
            <ref role="xz" node="1JmwqcCUVG" resolve="Fin" />
          </node>
        </node>
        <node concept="xs" id="18mSs8r0PE" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1ae8AfXDGv" role="xt">
            <ref role="xz" node="1x7mhYICt0" resolve="Archivado" />
          </node>
          <node concept="x10" id="1MTLCYEKwZ" role="xu">
            <ref role="xz" node="1JmwqcCUVG" resolve="Fin" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1xBiqRVsyN" role="x1">
      <node concept="x6" id="1mngUC1Uq0" role="x5">
        <property role="x3" value="IR2_Deadlock" />
        <node concept="xh" id="1NzwGBADUc" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="16eKxO49lT" role="x7">
          <property role="x3" value="Espera" />
          <node concept="x1i" id="1l0yShKtM5" role="xg">
            <node concept="x27" id="1KtSQ308ni" role="x1j" />
          </node>
        </node>
        <node concept="xi" id="1cqhpDhJTE" role="x7">
          <property role="x3" value="Revision" />
        </node>
        <node concept="xj" id="1sbkZhNwBE" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xs" id="1e0dq887a9" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="19u2dw6sP9" role="xt">
            <ref role="xz" node="1NzwGBADUc" resolve="Inicio" />
          </node>
          <node concept="x10" id="1pxQWwY1cr" role="xu">
            <ref role="xz" node="1cqhpDhJTE" resolve="Revision" />
          </node>
        </node>
        <node concept="xs" id="1sFAE00snl" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="188PpGzO7W" role="xt">
            <ref role="xz" node="1cqhpDhJTE" resolve="Revision" />
          </node>
          <node concept="x10" id="1LOd6vFaQy" role="xu">
            <ref role="xz" node="1sbkZhNwBE" resolve="Fin" />
          </node>
        </node>
        <node concept="xs" id="1ahSrGZpwq" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1k61OMkX82" role="xt">
            <ref role="xz" node="1cqhpDhJTE" resolve="Revision" />
          </node>
          <node concept="x10" id="1Qm5dzarES" role="xu">
            <ref role="xz" node="16eKxO49lT" resolve="Espera" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1pZt6cVym3" role="x1">
      <node concept="x6" id="19ApooRVRC" role="x5">
        <property role="x3" value="IR3_Livelock" />
        <node concept="xh" id="1Whf4z97TP" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1NmRygzi9K" role="x7">
          <property role="x3" value="Revision" />
          <node concept="x1i" id="1Aa39Dg76b" role="xg">
            <node concept="x27" id="18fqy62JMh" role="x1j" />
          </node>
        </node>
        <node concept="xi" id="1kdpWTXjdx" role="x7">
          <property role="x3" value="Correccion" />
          <node concept="x1i" id="1WcmQ7Ps3s" role="xg">
            <node concept="x27" id="1KZLbIk9UM" role="x1j" />
          </node>
        </node>
        <node concept="xj" id="1P4JLsaUR4" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xs" id="1ne3hS6rES" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1rxKR8YuiZ" role="xt">
            <ref role="xz" node="1Whf4z97TP" resolve="Inicio" />
          </node>
          <node concept="x10" id="1y4HWg4mLM" role="xu">
            <ref role="xz" node="1P4JLsaUR4" resolve="Fin" />
          </node>
        </node>
        <node concept="xs" id="1f6E5ZAQC6" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1JWVX4TB5L" role="xt">
            <ref role="xz" node="1Whf4z97TP" resolve="Inicio" />
          </node>
          <node concept="x10" id="1CygVGLkbP" role="xu">
            <ref role="xz" node="1NmRygzi9K" resolve="Revision" />
          </node>
        </node>
        <node concept="xs" id="1jx59MrPqg" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1H1VVlO6Nz" role="xt">
            <ref role="xz" node="1NmRygzi9K" resolve="Revision" />
          </node>
          <node concept="x10" id="1jdfB1Zx6w" role="xu">
            <ref role="xz" node="1kdpWTXjdx" resolve="Correccion" />
          </node>
        </node>
        <node concept="xs" id="1Yv865uiqN" role="xc">
          <property role="x3" value="T4" />
          <node concept="xx" id="1Jty3Q81bq" role="xt">
            <ref role="xz" node="1kdpWTXjdx" resolve="Correccion" />
          </node>
          <node concept="x10" id="148MDJcgHQ" role="xu">
            <ref role="xz" node="1NmRygzi9K" resolve="Revision" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="16lp4D4ESl" role="x1">
      <node concept="x6" id="1BothkXat7" role="x5">
        <property role="x3" value="IR4_GuardaMuertaYRol" />
        <node concept="xh" id="1WHzrTiDmA" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xj" id="1AE129HPZM" role="x7">
          <property role="x3" value="Fin" />
        </node>
        <node concept="xj" id="1skaSRTXiK" role="x7">
          <property role="x3" value="Excepcion" />
          <node concept="x1i" id="1omFRdUITo" role="xg">
            <node concept="x28" id="1hybrSsIFe" role="x1j" />
          </node>
        </node>
        <node concept="xk" id="1voIWOrVjq" role="x8">
          <property role="x3" value="Auditor" />
        </node>
        <node concept="x1m" id="1VPkyD0Zse" role="xe">
          <property role="x3" value="x" />
          <node concept="x1p" id="1jCw3cbixf" role="x1n" />
        </node>
        <node concept="xp" id="1rFgsYmfG2" role="xb">
          <property role="x3" value="Auditar" />
          <ref role="xr" node="1voIWOrVjq" resolve="Auditor" />
          <node concept="x1i" id="161VkEJTO3" role="xg">
            <node concept="x28" id="1XBtX3PUKg" role="x1j" />
          </node>
        </node>
        <node concept="xs" id="1PAFk6J19L" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1AB8iotrfP" role="xt">
            <ref role="xz" node="1WHzrTiDmA" resolve="Inicio" />
          </node>
          <node concept="x10" id="1cXK9H9Ns8" role="xu">
            <ref role="xz" node="1AE129HPZM" resolve="Fin" />
          </node>
          <node concept="x11" id="1nrx96pifh" role="xv">
            <ref role="x12" node="1rFgsYmfG2" resolve="Auditar" />
          </node>
        </node>
        <node concept="xs" id="1GwcWXCI6G" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1icDUKc2hr" role="xt">
            <ref role="xz" node="1WHzrTiDmA" resolve="Inicio" />
          </node>
          <node concept="x10" id="1RIg5vYeHc" role="xu">
            <ref role="xz" node="1skaSRTXiK" resolve="Excepcion" />
          </node>
          <node concept="x1s" id="1cXOEdcTzw" role="xw">
            <node concept="x29" id="1XLVidCbwY" role="x1t">
              <node concept="x1u" id="1VBFrh6eQ0" role="x1w">
                <node concept="x1y" id="1NI64JOCou" role="x1w">
                  <ref role="x1z" node="1VPkyD0Zse" resolve="x" />
                </node>
                <node concept="x1q" id="16Zn1YABx0" role="x1x">
                  <property role="x1r" value="1" />
                </node>
              </node>
              <node concept="x2a" id="1uvupxk2gx" role="x1x">
                <node concept="x1y" id="1z40K5idVQ" role="x1w">
                  <ref role="x1z" node="1VPkyD0Zse" resolve="x" />
                </node>
                <node concept="x1q" id="1WSyLFbbX3" role="x1x">
                  <property role="x1r" value="5" />
                </node>
              </node>
            </node>
            <node concept="x1i" id="1ZnfNHyGf4" role="xg">
              <node concept="x28" id="1Ax9MVafJh" role="x1j" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x4" id="1z1Vqye5OS" role="x1">
      <node concept="x6" id="1AoIUiTrTL" role="x5">
        <property role="x3" value="SolicitudCompra" />
        <node concept="xh" id="1ebpufS3kf" role="x7">
          <property role="x3" value="Inicio" />
        </node>
        <node concept="xi" id="1DtvOED3qc" role="x7">
          <property role="x3" value="EnRevision" />
        </node>
        <node concept="xi" id="1iQUZ2wLFu" role="x7">
          <property role="x3" value="RevisionDirector" />
        </node>
        <node concept="xi" id="1pefmmpBJD" role="x7">
          <property role="x3" value="OrdenEmitida" />
        </node>
        <node concept="xj" id="1kW41EE30D" role="x7">
          <property role="x3" value="Aprobada" />
        </node>
        <node concept="xj" id="1DqZkpGTPj" role="x7">
          <property role="x3" value="Rechazada" />
        </node>
        <node concept="xi" id="1rlnSKetT3" role="x7">
          <property role="x3" value="Archivada" />
          <node concept="x1i" id="1nvsHiXCVY" role="xg">
            <node concept="x28" id="1GXTnyMz0a" role="x1j" />
          </node>
        </node>
        <node concept="xk" id="1HXnRI8EtX" role="x8">
          <property role="x3" value="Solicitante" />
        </node>
        <node concept="xk" id="1cr0JIGW7s" role="x8">
          <property role="x3" value="Aprobador" />
        </node>
        <node concept="xk" id="1yaeuYi3sp" role="x8">
          <property role="x3" value="Director" />
        </node>
        <node concept="x22" id="1ZzIXMRoBD" role="x8">
          <property role="x3" value="ERP" />
        </node>
        <node concept="xl" id="1B2GWzS3cp" role="x9">
          <property role="x3" value="Carla" />
        </node>
        <node concept="xl" id="1WMsVYyAiO" role="x9">
          <property role="x3" value="Mario" />
        </node>
        <node concept="xl" id="1bkx1ZnDk8" role="x9">
          <property role="x3" value="Sofia" />
        </node>
        <node concept="xl" id="1ZoC0YjZJy" role="x9">
          <property role="x3" value="SAP" />
        </node>
        <node concept="xm" id="1EXjv5pM4a" role="xa">
          <ref role="xn" node="1B2GWzS3cp" resolve="Carla" />
          <ref role="xo" node="1HXnRI8EtX" resolve="Solicitante" />
        </node>
        <node concept="xm" id="1QOJsJQ9FF" role="xa">
          <ref role="xn" node="1WMsVYyAiO" resolve="Mario" />
          <ref role="xo" node="1cr0JIGW7s" resolve="Aprobador" />
        </node>
        <node concept="xm" id="1jFOhX0dwz" role="xa">
          <ref role="xn" node="1bkx1ZnDk8" resolve="Sofia" />
          <ref role="xo" node="1yaeuYi3sp" resolve="Director" />
        </node>
        <node concept="xm" id="1Jlc15HZ38" role="xa">
          <ref role="xn" node="1ZoC0YjZJy" resolve="SAP" />
          <ref role="xo" node="1ZzIXMRoBD" resolve="ERP" />
        </node>
        <node concept="x1m" id="1XS1hyQ8ZX" role="xe">
          <property role="x3" value="monto" />
          <node concept="x1p" id="1t2gbwbT9Y" role="x1n" />
          <node concept="x1q" id="1Vqgkc3L08" role="x1o">
            <property role="x1r" value="2500" />
          </node>
        </node>
        <node concept="x1m" id="10jRb9NJEe" role="xe">
          <property role="x3" value="urgente" />
          <node concept="x23" id="157Oh7KU4C" role="x1n" />
          <node concept="x24" id="1OmAvUo71H" role="x1o">
            <property role="x25" value="false" />
          </node>
        </node>
        <node concept="x1m" id="17lqQbxwzC" role="xe">
          <property role="x3" value="area" />
          <node concept="x2b" id="1y4k9Qm4Be" role="x1n" />
          <node concept="x2c" id="1cLGmrkT4Y" role="x1o">
            <property role="x2d" value="TI" />
          </node>
        </node>
        <node concept="xp" id="1NtgXt5EyD" role="xb">
          <property role="x3" value="RegistrarSolicitud" />
          <ref role="xr" node="1HXnRI8EtX" resolve="Solicitante" />
        </node>
        <node concept="xp" id="1eOfG5obIt" role="xb">
          <property role="x3" value="RevisarSolicitud" />
          <ref role="xr" node="1cr0JIGW7s" resolve="Aprobador" />
        </node>
        <node concept="xp" id="1D8yMCkIY2" role="xb">
          <property role="x3" value="AutorizarGasto" />
          <ref role="xr" node="1yaeuYi3sp" resolve="Director" />
        </node>
        <node concept="x26" id="1kUBZvQeob" role="xb">
          <property role="x3" value="EmitirOrden" />
          <ref role="xr" node="1ZzIXMRoBD" resolve="ERP" />
        </node>
        <node concept="xs" id="12cUDlySL7" role="xc">
          <property role="x3" value="T1" />
          <node concept="xx" id="1eXSCyCwcR" role="xt">
            <ref role="xz" node="1ebpufS3kf" resolve="Inicio" />
          </node>
          <node concept="x10" id="1M23DP9JMB" role="xu">
            <ref role="xz" node="1DtvOED3qc" resolve="EnRevision" />
          </node>
          <node concept="x11" id="1YLxlpP3sd" role="xv">
            <ref role="x12" node="1NtgXt5EyD" resolve="RegistrarSolicitud" />
          </node>
        </node>
        <node concept="xs" id="1cQhXTa1dq" role="xc">
          <property role="x3" value="T2" />
          <node concept="xx" id="1vkv9b7C2l" role="xt">
            <ref role="xz" node="1DtvOED3qc" resolve="EnRevision" />
          </node>
          <node concept="x10" id="1RT5SiDSam" role="xu">
            <ref role="xz" node="1pefmmpBJD" resolve="OrdenEmitida" />
          </node>
          <node concept="x11" id="18DepGZr22" role="xv">
            <ref role="x12" node="1eOfG5obIt" resolve="RevisarSolicitud" />
          </node>
          <node concept="x1s" id="1S2a8qgKtl" role="xw">
            <node concept="x1u" id="1X7s2cFMMO" role="x1t">
              <node concept="x1y" id="1KjhQGRhvC" role="x1w">
                <ref role="x1z" node="1XS1hyQ8ZX" resolve="monto" />
              </node>
              <node concept="x1q" id="1tKur1n40w" role="x1x">
                <property role="x1r" value="1000" />
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1XnOTSBo42" role="xc">
          <property role="x3" value="T3" />
          <node concept="xx" id="1JCMlfqc0j" role="xt">
            <ref role="xz" node="1DtvOED3qc" resolve="EnRevision" />
          </node>
          <node concept="x10" id="1kZbHwiMBe" role="xu">
            <ref role="xz" node="1iQUZ2wLFu" resolve="RevisionDirector" />
          </node>
          <node concept="x11" id="1dzaAFbmft" role="xv">
            <ref role="x12" node="1eOfG5obIt" resolve="RevisarSolicitud" />
          </node>
          <node concept="x1s" id="1XfakkP0j2" role="xw">
            <node concept="x20" id="11N5zgLlAf" role="x1t">
              <node concept="x1u" id="1pCUbJVTw1" role="x21">
                <node concept="x1y" id="1iVy5ys8H3" role="x1w">
                  <ref role="x1z" node="1XS1hyQ8ZX" resolve="monto" />
                </node>
                <node concept="x1q" id="17cjHrXsO1" role="x1x">
                  <property role="x1r" value="1000" />
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1HY6wLNeFl" role="xc">
          <property role="x3" value="T4" />
          <node concept="xx" id="1o0t46liZO" role="xt">
            <ref role="xz" node="1iQUZ2wLFu" resolve="RevisionDirector" />
          </node>
          <node concept="x10" id="1lAKAW8HTG" role="xu">
            <ref role="xz" node="1pefmmpBJD" resolve="OrdenEmitida" />
          </node>
          <node concept="x11" id="1YuYZLxv3J" role="xv">
            <ref role="x12" node="1D8yMCkIY2" resolve="AutorizarGasto" />
          </node>
          <node concept="x1s" id="107F2pEBCW" role="xw">
            <node concept="x2e" id="1meVyOjwCc" role="x1t">
              <node concept="x1y" id="1IntO8SBGC" role="x1w">
                <ref role="x1z" node="10jRb9NJEe" resolve="urgente" />
              </node>
              <node concept="x2a" id="13zKfJ0wnh" role="x1x">
                <node concept="x1y" id="1XaTbK1RMe" role="x1w">
                  <ref role="x1z" node="17lqQbxwzC" resolve="area" />
                </node>
                <node concept="x2c" id="1TT0lo2b8T" role="x1x">
                  <property role="x2d" value="TI" />
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1Vl9xrbZd1" role="xc">
          <property role="x3" value="T5" />
          <node concept="xx" id="1e0vYPjVuf" role="xt">
            <ref role="xz" node="1iQUZ2wLFu" resolve="RevisionDirector" />
          </node>
          <node concept="x10" id="1tE0lzmcZS" role="xu">
            <ref role="xz" node="1DqZkpGTPj" resolve="Rechazada" />
          </node>
          <node concept="x11" id="1U0D291owV" role="xv">
            <ref role="x12" node="1D8yMCkIY2" resolve="AutorizarGasto" />
          </node>
          <node concept="x1s" id="1nG31VXxk7" role="xw">
            <node concept="x20" id="1rrvQqU9Rl" role="x1t">
              <node concept="x2e" id="14GbMWlzkI" role="x21">
                <node concept="x1y" id="1GohoXyABp" role="x1w">
                  <ref role="x1z" node="10jRb9NJEe" resolve="urgente" />
                </node>
                <node concept="x2a" id="1op3699hnP" role="x1x">
                  <node concept="x1y" id="1oGcdts4nE" role="x1w">
                    <ref role="x1z" node="17lqQbxwzC" resolve="area" />
                  </node>
                  <node concept="x2c" id="1wHAP9tjrh" role="x1x">
                    <property role="x2d" value="TI" />
                  </node>
                </node>
              </node>
            </node>
          </node>
        </node>
        <node concept="xs" id="1DFNT1YpXM" role="xc">
          <property role="x3" value="T6" />
          <node concept="xx" id="1cNTStS7iH" role="xt">
            <ref role="xz" node="1pefmmpBJD" resolve="OrdenEmitida" />
          </node>
          <node concept="x10" id="1UDa0a7kNE" role="xu">
            <ref role="xz" node="1kW41EE30D" resolve="Aprobada" />
          </node>
          <node concept="x11" id="1Cg7VuDHqo" role="xv">
            <ref role="x12" node="1kUBZvQeob" resolve="EmitirOrden" />
          </node>
        </node>
        <node concept="x13" id="17Wod0shcs" role="xd" />
        <node concept="x14" id="1mkz6DI6Z0" role="xd">
          <ref role="x15" node="1DqZkpGTPj" resolve="Rechazada" />
        </node>
        <node concept="x16" id="1L2OEhdHuo" role="xd">
          <ref role="x17" node="1kW41EE30D" resolve="Aprobada" />
          <node concept="x19" id="1ZNskJH3z0" role="x18">
            <ref role="x1a" node="12cUDlySL7" resolve="T1" />
          </node>
          <node concept="x19" id="1sRJFg16SJ" role="x18">
            <ref role="x1a" node="1cQhXTa1dq" resolve="T2" />
          </node>
          <node concept="x19" id="1Hal56GY3n" role="x18">
            <ref role="x1a" node="1DFNT1YpXM" resolve="T6" />
          </node>
        </node>
        <node concept="x1b" id="17WVG1pbwp" role="xd">
          <ref role="x1c" node="1D8yMCkIY2" resolve="AutorizarGasto" />
          <node concept="x1e" id="1u0BDWslc7" role="x1d">
            <ref role="x1f" node="1bkx1ZnDk8" resolve="Sofia" />
          </node>
        </node>
        <node concept="x1g" id="1WfI6oUebT" role="xd">
          <ref role="x1h" node="1kW41EE30D" resolve="Aprobada" />
        </node>
      </node>
    </node>
  </node>
</model>
