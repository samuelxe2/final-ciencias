<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:0d330564-76e6-4a35-a14d-5f7a6f88e218(wvdl.sandbox.validos)">
  <persistence version="9" />
  <languages>
    <use id="4efe485e-f38f-4368-a336-dbc2552833bf" name="wvdl" version="0" />
  </languages>
  <imports>
  </imports>
  <registry>
    <language id="4efe485e-f38f-4368-a336-dbc2552833bf" name="wvdl">
      <concept id="1412782381407505714" name="wvdl.structure.Workflow" flags="ng" index="x0">
        <child id="1528467127056001332" name="states" index="x1" />
        <child id="3742483036895970086" name="roles" index="x2" />
        <child id="2514821820973565857" name="actors" index="x3" />
        <child id="3059050193924877675" name="assignments" index="x4" />
        <child id="2442891784385824884" name="activities" index="x5" />
        <child id="4297088327742399859" name="transitions" index="x6" />
        <child id="1630146823895602108" name="checks" index="x7" />
        <child id="2311448109575635965" name="variables" index="x8" />
      </concept>
      <concept id="3773931177927761670" name="wvdl.structure.InitialState" flags="ng" index="xb" />
      <concept id="4340915256483426058" name="wvdl.structure.OrdinaryState" flags="ng" index="xc" />
      <concept id="4548869926607402224" name="wvdl.structure.FinalState" flags="ng" index="xd" />
      <concept id="4580885630124225313" name="wvdl.structure.HumanRole" flags="ng" index="xe" />
      <concept id="1575272884437960782" name="wvdl.structure.Actor" flags="ng" index="xf" />
      <concept id="2754388617126347878" name="wvdl.structure.Assignment" flags="ng" index="xg">
        <reference id="3435594342687597196" name="actor" index="xh" />
        <reference id="4297639191499006525" name="role" index="xi" />
      </concept>
      <concept id="298054231284038334" name="wvdl.structure.ManualActivity" flags="ng" index="xj" />
      <concept id="4100242238858238349" name="wvdl.structure.Activity" flags="ng" index="xk">
        <reference id="3951339498872278184" name="role" index="xl" />
      </concept>
      <concept id="3444469126383335239" name="wvdl.structure.Transition" flags="ng" index="xm">
        <child id="3546178691603644048" name="from" index="xn" />
        <child id="4557479502343562840" name="to" index="xo" />
        <child id="2595902392752590344" name="via" index="xp" />
        <child id="318163487345883580" name="guard" index="xq" />
      </concept>
      <concept id="910489418711293754" name="wvdl.structure.SourceRef" flags="ng" index="xr" />
      <concept id="2318847045543514830" name="wvdl.structure.StateRef" flags="ng" index="xs">
        <reference id="1644665000982416978" name="state" index="xt" />
      </concept>
      <concept id="1148869055518526258" name="wvdl.structure.TargetRef" flags="ng" index="xu" />
      <concept id="4065621737641222821" name="wvdl.structure.ActivityRef" flags="ng" index="xv">
        <reference id="2523441023518024119" name="activity" index="xw" />
      </concept>
      <concept id="3458926237492019812" name="wvdl.structure.SoundCheck" flags="ng" index="xx" />
      <concept id="4461490874048664151" name="wvdl.structure.ReachableCheck" flags="ng" index="xy">
        <reference id="1001593753963161797" name="state" index="xz" />
      </concept>
      <concept id="1645384556473442200" name="wvdl.structure.PathCheck" flags="ng" index="x10">
        <reference id="2811859192094200142" name="state" index="x11" />
        <child id="3494199751501289366" name="steps" index="x12" />
      </concept>
      <concept id="506719079257640917" name="wvdl.structure.TransitionRef" flags="ng" index="x13">
        <reference id="2600406349640642610" name="transition" index="x14" />
      </concept>
      <concept id="1810144407881132328" name="wvdl.structure.ActorsCheck" flags="ng" index="x15">
        <reference id="2003057994849096830" name="activity" index="x16" />
        <child id="1944458948576600817" name="actors" index="x17" />
      </concept>
      <concept id="3945133872824800573" name="wvdl.structure.ActorRef" flags="ng" index="x18">
        <reference id="2607128528215628765" name="actor" index="x19" />
      </concept>
      <concept id="1801005092375930339" name="wvdl.structure.SimulationCheck" flags="ng" index="x1a">
        <reference id="2407784877938928023" name="state" index="x1b" />
      </concept>
      <concept id="1984639994254280242" name="wvdl.structure.Variable" flags="ng" index="x1c">
        <child id="1116711506113754239" name="type" index="x1d" />
        <child id="3342385426935315388" name="init" index="x1e" />
      </concept>
      <concept id="2211624816874732235" name="wvdl.structure.IntegerType" flags="ng" index="x1f" />
      <concept id="4356461840986708983" name="wvdl.structure.IntLiteral" flags="ng" index="x1g">
        <property id="2764001242192483827" name="value" index="x1h" />
      </concept>
      <concept id="3474567488466545183" name="wvdl.structure.Guard" flags="ng" index="x1i">
        <child id="4202132126237685012" name="condition" index="x1j" />
      </concept>
      <concept id="4006625772246302066" name="wvdl.structure.LtExpr" flags="ng" index="x1k" />
      <concept id="2503589227462995725" name="wvdl.structure.IBinaryOperation" flags="ngI" index="x1l">
        <child id="3597341855276219803" name="left" index="x1m" />
        <child id="4307423801848415733" name="right" index="x1n" />
      </concept>
      <concept id="448228914353461423" name="wvdl.structure.VarRef" flags="ng" index="x1o">
        <reference id="3618521687389199141" name="variable" index="x1p" />
      </concept>
      <concept id="2935791979113318278" name="wvdl.structure.NotExpr" flags="ng" index="x1q">
        <child id="4235839573527162062" name="operand" index="x1r" />
      </concept>
      <concept id="1727450827697905204" name="wvdl.structure.SystemRole" flags="ng" index="x1s" />
      <concept id="932772402753431168" name="wvdl.structure.BooleanType" flags="ng" index="x1t" />
      <concept id="3341333894158794751" name="wvdl.structure.BoolLiteral" flags="ng" index="x1u">
        <property id="448872718996398809" name="value" index="x1v" />
      </concept>
      <concept id="1480812486812752603" name="wvdl.structure.AutomatedActivity" flags="ng" index="x1w" />
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x9">
        <property id="1169194664001" name="name" index="xa" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="1i8wpRBrOW">
    <property role="xa" value="V01_Lineal" />
    <node concept="xb" id="1pOyR0y6KE" role="x1">
      <property role="xa" value="Inicio" />
    </node>
    <node concept="xc" id="1fCw7vh0Cu" role="x1">
      <property role="xa" value="Revision" />
    </node>
    <node concept="xd" id="1uNLwAYPkt" role="x1">
      <property role="xa" value="Aprobado" />
    </node>
    <node concept="xe" id="1ZhnjVBWin" role="x2">
      <property role="xa" value="Revisor" />
    </node>
    <node concept="xf" id="1lWSSXOBIN" role="x3">
      <property role="xa" value="Ana" />
    </node>
    <node concept="xg" id="1LNTzzMr2B" role="x4">
      <ref role="xh" node="1lWSSXOBIN" resolve="Ana" />
      <ref role="xi" node="1ZhnjVBWin" resolve="Revisor" />
    </node>
    <node concept="xj" id="1mR8zH6loS" role="x5">
      <property role="xa" value="Revisar" />
      <ref role="xl" node="1ZhnjVBWin" resolve="Revisor" />
    </node>
    <node concept="xm" id="1KWGJiKwkI" role="x6">
      <property role="xa" value="T1" />
      <node concept="xr" id="1eARRtiDr8" role="xn">
        <ref role="xt" node="1pOyR0y6KE" resolve="Inicio" />
      </node>
      <node concept="xu" id="1pQcqVL1v6" role="xo">
        <ref role="xt" node="1fCw7vh0Cu" resolve="Revision" />
      </node>
    </node>
    <node concept="xm" id="14N0lXX3mL" role="x6">
      <property role="xa" value="T2" />
      <node concept="xr" id="1eRbIFxicL" role="xn">
        <ref role="xt" node="1fCw7vh0Cu" resolve="Revision" />
      </node>
      <node concept="xu" id="1CwwV9qBIn" role="xo">
        <ref role="xt" node="1uNLwAYPkt" resolve="Aprobado" />
      </node>
      <node concept="xv" id="1y9N7Nd731" role="xp">
        <ref role="xw" node="1mR8zH6loS" resolve="Revisar" />
      </node>
    </node>
    <node concept="xx" id="1vk1b49cwV" role="x7" />
    <node concept="xy" id="1FhGFFlkdt" role="x7">
      <ref role="xz" node="1uNLwAYPkt" resolve="Aprobado" />
    </node>
    <node concept="x10" id="1Vos7Ve0de" role="x7">
      <ref role="x11" node="1uNLwAYPkt" resolve="Aprobado" />
      <node concept="x13" id="13mU0r6Lz3" role="x12">
        <ref role="x14" node="1KWGJiKwkI" resolve="T1" />
      </node>
      <node concept="x13" id="13pqX8WQ4m" role="x12">
        <ref role="x14" node="14N0lXX3mL" resolve="T2" />
      </node>
    </node>
    <node concept="x15" id="1YiW10V2KY" role="x7">
      <ref role="x16" node="1mR8zH6loS" resolve="Revisar" />
      <node concept="x18" id="1U64InN8dT" role="x17">
        <ref role="x19" node="1lWSSXOBIN" resolve="Ana" />
      </node>
    </node>
    <node concept="x1a" id="1pLf6x1Svo" role="x7">
      <ref role="x1b" node="1uNLwAYPkt" resolve="Aprobado" />
    </node>
  </node>
  <node concept="x0" id="1vX6lZ4cQZ">
    <property role="xa" value="V02_Ramificacion" />
    <node concept="xb" id="1vUOnrf7O5" role="x1">
      <property role="xa" value="Inicio" />
    </node>
    <node concept="xc" id="10q3CJOLcr" role="x1">
      <property role="xa" value="Validacion" />
    </node>
    <node concept="xd" id="1Qx7a2zEzl" role="x1">
      <property role="xa" value="Aprobado" />
    </node>
    <node concept="xd" id="1YZ0URD27u" role="x1">
      <property role="xa" value="Rechazado" />
    </node>
    <node concept="xe" id="10p3f9BNhj" role="x2">
      <property role="xa" value="Validador" />
    </node>
    <node concept="xf" id="167BJwW5F1" role="x3">
      <property role="xa" value="Luis" />
    </node>
    <node concept="xg" id="1qOTTAw5NO" role="x4">
      <ref role="xh" node="167BJwW5F1" resolve="Luis" />
      <ref role="xi" node="10p3f9BNhj" resolve="Validador" />
    </node>
    <node concept="x1c" id="1G6oNt3sQQ" role="x8">
      <property role="xa" value="monto" />
      <node concept="x1f" id="1ckEuimpSF" role="x1d" />
      <node concept="x1g" id="105qtPw0tJ" role="x1e">
        <property role="x1h" value="500" />
      </node>
    </node>
    <node concept="xj" id="1alylGaSo0" role="x5">
      <property role="xa" value="Validar" />
      <ref role="xl" node="10p3f9BNhj" resolve="Validador" />
    </node>
    <node concept="xm" id="1UBkxdRgzc" role="x6">
      <property role="xa" value="T1" />
      <node concept="xr" id="108SmkJJeq" role="xn">
        <ref role="xt" node="1vUOnrf7O5" resolve="Inicio" />
      </node>
      <node concept="xu" id="1ea36lLjpC" role="xo">
        <ref role="xt" node="10q3CJOLcr" resolve="Validacion" />
      </node>
    </node>
    <node concept="xm" id="1OH8RQBo25" role="x6">
      <property role="xa" value="T2" />
      <node concept="xr" id="1Ea1TD98FL" role="xn">
        <ref role="xt" node="10q3CJOLcr" resolve="Validacion" />
      </node>
      <node concept="xu" id="18bIPoNMUW" role="xo">
        <ref role="xt" node="1Qx7a2zEzl" resolve="Aprobado" />
      </node>
      <node concept="xv" id="1qo1UuqTaJ" role="xp">
        <ref role="xw" node="1alylGaSo0" resolve="Validar" />
      </node>
      <node concept="x1i" id="1jZiJLyGAw" role="xq">
        <node concept="x1k" id="1LBs7Fz4s5" role="x1j">
          <node concept="x1o" id="1upSxk1xXZ" role="x1m">
            <ref role="x1p" node="1G6oNt3sQQ" resolve="monto" />
          </node>
          <node concept="x1g" id="17YH2OOxy0" role="x1n">
            <property role="x1h" value="1000" />
          </node>
        </node>
      </node>
    </node>
    <node concept="xm" id="1qFGCx94vo" role="x6">
      <property role="xa" value="T3" />
      <node concept="xr" id="1RV4DPJXSs" role="xn">
        <ref role="xt" node="10q3CJOLcr" resolve="Validacion" />
      </node>
      <node concept="xu" id="1FUrHCX4qS" role="xo">
        <ref role="xt" node="1YZ0URD27u" resolve="Rechazado" />
      </node>
      <node concept="xv" id="1a8JbVSPwJ" role="xp">
        <ref role="xw" node="1alylGaSo0" resolve="Validar" />
      </node>
      <node concept="x1i" id="14z6Kab0z3" role="xq">
        <node concept="x1q" id="1Se3EkSWFK" role="x1j">
          <node concept="x1k" id="1ivIAW34a1" role="x1r">
            <node concept="x1o" id="1ehqiDJZkp" role="x1m">
              <ref role="x1p" node="1G6oNt3sQQ" resolve="monto" />
            </node>
            <node concept="x1g" id="1ASNlm2B3z" role="x1n">
              <property role="x1h" value="1000" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="xx" id="1w7vsgQhTe" role="x7" />
    <node concept="x10" id="1ENhsaO1cX" role="x7">
      <ref role="x11" node="1YZ0URD27u" resolve="Rechazado" />
      <node concept="x13" id="1rCPu47iZs" role="x12">
        <ref role="x14" node="1UBkxdRgzc" resolve="T1" />
      </node>
      <node concept="x13" id="1E758DZTGP" role="x12">
        <ref role="x14" node="1qFGCx94vo" resolve="T3" />
      </node>
    </node>
    <node concept="x1a" id="11vRwsQEDE" role="x7">
      <ref role="x1b" node="1Qx7a2zEzl" resolve="Aprobado" />
    </node>
  </node>
  <node concept="x0" id="1Ql96DUQaq">
    <property role="xa" value="V03_Automatizado" />
    <node concept="xb" id="1TREZTZ772" role="x1">
      <property role="xa" value="Inicio" />
    </node>
    <node concept="xc" id="1YH6L2nS9C" role="x1">
      <property role="xa" value="Revision" />
    </node>
    <node concept="xd" id="1PxzfOkhbF" role="x1">
      <property role="xa" value="Fin" />
    </node>
    <node concept="x1s" id="1zRcGuvJw8" role="x2">
      <property role="xa" value="MotorReglas" />
    </node>
    <node concept="xe" id="16JeMQrYn7" role="x2">
      <property role="xa" value="Revisor" />
    </node>
    <node concept="xf" id="1zOGykRsbN" role="x3">
      <property role="xa" value="Bot" />
    </node>
    <node concept="xf" id="1da3oYWg3L" role="x3">
      <property role="xa" value="Ana" />
    </node>
    <node concept="xg" id="1LL13wk5uz" role="x4">
      <ref role="xh" node="1zOGykRsbN" resolve="Bot" />
      <ref role="xi" node="1zRcGuvJw8" resolve="MotorReglas" />
    </node>
    <node concept="xg" id="16TjNP6T7z" role="x4">
      <ref role="xh" node="1da3oYWg3L" resolve="Ana" />
      <ref role="xi" node="16JeMQrYn7" resolve="Revisor" />
    </node>
    <node concept="x1c" id="18m432yd7m" role="x8">
      <property role="xa" value="aprobado" />
      <node concept="x1t" id="1EFNZBzaY1" role="x1d" />
      <node concept="x1u" id="1hl13jhUc0" role="x1e">
        <property role="x1v" value="true" />
      </node>
    </node>
    <node concept="x1w" id="1HRhsY8Vw7" role="x5">
      <property role="xa" value="CalcularRiesgo" />
      <ref role="xl" node="1zRcGuvJw8" resolve="MotorReglas" />
    </node>
    <node concept="xj" id="1kJaREfRpe" role="x5">
      <property role="xa" value="Revisar" />
      <ref role="xl" node="16JeMQrYn7" resolve="Revisor" />
    </node>
    <node concept="xm" id="15tL5Hu7oT" role="x6">
      <property role="xa" value="T1" />
      <node concept="xr" id="17VRxzPSt2" role="xn">
        <ref role="xt" node="1TREZTZ772" resolve="Inicio" />
      </node>
      <node concept="xu" id="1yjo9OoS3x" role="xo">
        <ref role="xt" node="1YH6L2nS9C" resolve="Revision" />
      </node>
      <node concept="xv" id="1INECkCEVf" role="xp">
        <ref role="xw" node="1HRhsY8Vw7" resolve="CalcularRiesgo" />
      </node>
    </node>
    <node concept="xm" id="1Ei1vN0exK" role="x6">
      <property role="xa" value="T2" />
      <node concept="xr" id="1dpBUjneWA" role="xn">
        <ref role="xt" node="1YH6L2nS9C" resolve="Revision" />
      </node>
      <node concept="xu" id="1HiGXHfj2n" role="xo">
        <ref role="xt" node="1YH6L2nS9C" resolve="Revision" />
      </node>
      <node concept="xv" id="1nne5HuPnB" role="xp">
        <ref role="xw" node="1kJaREfRpe" resolve="Revisar" />
      </node>
      <node concept="x1i" id="1atLDHT4pA" role="xq">
        <node concept="x1q" id="124wernMx6" role="x1j">
          <node concept="x1o" id="1DTb5I7K1A" role="x1r">
            <ref role="x1p" node="18m432yd7m" resolve="aprobado" />
          </node>
        </node>
      </node>
    </node>
    <node concept="xm" id="1vmR6c7iXZ" role="x6">
      <property role="xa" value="T3" />
      <node concept="xr" id="1kqx49sK7K" role="xn">
        <ref role="xt" node="1YH6L2nS9C" resolve="Revision" />
      </node>
      <node concept="xu" id="1oDnONiVNX" role="xo">
        <ref role="xt" node="1PxzfOkhbF" resolve="Fin" />
      </node>
      <node concept="xv" id="12fpK0WXGB" role="xp">
        <ref role="xw" node="1kJaREfRpe" resolve="Revisar" />
      </node>
      <node concept="x1i" id="1OzXecENu1" role="xq">
        <node concept="x1o" id="1erPsWEX9k" role="x1j">
          <ref role="x1p" node="18m432yd7m" resolve="aprobado" />
        </node>
      </node>
    </node>
    <node concept="xx" id="1NDjEkrjbP" role="x7" />
    <node concept="x15" id="1t3E9NizkG" role="x7">
      <ref role="x16" node="1HRhsY8Vw7" resolve="CalcularRiesgo" />
      <node concept="x18" id="1aO2ErbMxJ" role="x17">
        <ref role="x19" node="1zOGykRsbN" resolve="Bot" />
      </node>
    </node>
    <node concept="x1a" id="1ObDA1iGD0" role="x7">
      <ref role="x1b" node="1PxzfOkhbF" resolve="Fin" />
    </node>
  </node>
</model>
