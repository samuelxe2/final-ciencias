<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:a9484c32-c7fe-4482-a6d1-c4113cf018f6(wvdl.sandbox.contraejemplo)">
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
      </concept>
      <concept id="3773931177927761670" name="wvdl.structure.InitialState" flags="ng" index="xa" />
      <concept id="4340915256483426058" name="wvdl.structure.OrdinaryState" flags="ng" index="xb" />
      <concept id="4548869926607402224" name="wvdl.structure.FinalState" flags="ng" index="xc" />
      <concept id="4580885630124225313" name="wvdl.structure.HumanRole" flags="ng" index="xd" />
      <concept id="1575272884437960782" name="wvdl.structure.Actor" flags="ng" index="xe" />
      <concept id="2754388617126347878" name="wvdl.structure.Assignment" flags="ng" index="xf">
        <reference id="3435594342687597196" name="actor" index="xg" />
        <reference id="4297639191499006525" name="role" index="xh" />
      </concept>
      <concept id="298054231284038334" name="wvdl.structure.ManualActivity" flags="ng" index="xi" />
      <concept id="4100242238858238349" name="wvdl.structure.Activity" flags="ng" index="xj">
        <reference id="3951339498872278184" name="role" index="xk" />
      </concept>
      <concept id="3444469126383335239" name="wvdl.structure.Transition" flags="ng" index="xl">
        <child id="3546178691603644048" name="from" index="xm" />
        <child id="4557479502343562840" name="to" index="xn" />
        <child id="2595902392752590344" name="via" index="xo" />
      </concept>
      <concept id="910489418711293754" name="wvdl.structure.SourceRef" flags="ng" index="xp" />
      <concept id="2318847045543514830" name="wvdl.structure.StateRef" flags="ng" index="xq">
        <reference id="1644665000982416978" name="state" index="xr" />
      </concept>
      <concept id="1148869055518526258" name="wvdl.structure.TargetRef" flags="ng" index="xs" />
      <concept id="4065621737641222821" name="wvdl.structure.ActivityRef" flags="ng" index="xt">
        <reference id="2523441023518024119" name="activity" index="xu" />
      </concept>
      <concept id="4461490874048664151" name="wvdl.structure.ReachableCheck" flags="ng" index="xv">
        <reference id="1001593753963161797" name="state" index="xw" />
      </concept>
      <concept id="3458926237492019812" name="wvdl.structure.SoundCheck" flags="ng" index="xx" />
      <concept id="1645384556473442200" name="wvdl.structure.PathCheck" flags="ng" index="xy">
        <reference id="2811859192094200142" name="state" index="xz" />
        <child id="3494199751501289366" name="steps" index="x10" />
      </concept>
      <concept id="506719079257640917" name="wvdl.structure.TransitionRef" flags="ng" index="x11">
        <reference id="2600406349640642610" name="transition" index="x12" />
      </concept>
      <concept id="1810144407881132328" name="wvdl.structure.ActorsCheck" flags="ng" index="x13">
        <reference id="2003057994849096830" name="activity" index="x14" />
        <child id="1944458948576600817" name="actors" index="x15" />
      </concept>
      <concept id="3945133872824800573" name="wvdl.structure.ActorRef" flags="ng" index="x16">
        <reference id="2607128528215628765" name="actor" index="x17" />
      </concept>
      <concept id="1801005092375930339" name="wvdl.structure.SimulationCheck" flags="ng" index="x18">
        <reference id="2407784877938928023" name="state" index="x19" />
      </concept>
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x8">
        <property id="1169194664001" name="name" index="x9" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="1VIJKybgaK">
    <property role="x9" value="CE_VerificacionesFalsas" />
    <node concept="xa" id="1RORuktqNd" role="x1">
      <property role="x9" value="Inicio" />
    </node>
    <node concept="xb" id="1lxsUaNG8C" role="x1">
      <property role="x9" value="Revision" />
    </node>
    <node concept="xb" id="1CLmp41ImG" role="x1">
      <property role="x9" value="Bucle" />
    </node>
    <node concept="xc" id="1N8LTcBWzP" role="x1">
      <property role="x9" value="Fin" />
    </node>
    <node concept="xb" id="1OdH4wDvtb" role="x1">
      <property role="x9" value="Olvidado" />
    </node>
    <node concept="xd" id="1jTS9gtpf3" role="x2">
      <property role="x9" value="Revisor" />
    </node>
    <node concept="xe" id="1TEJ2bujg7" role="x3">
      <property role="x9" value="Ana" />
    </node>
    <node concept="xe" id="1CGe9QnDc4" role="x3">
      <property role="x9" value="Luis" />
    </node>
    <node concept="xf" id="1RNF5z8M1f" role="x4">
      <ref role="xg" node="1TEJ2bujg7" resolve="Ana" />
      <ref role="xh" node="1jTS9gtpf3" resolve="Revisor" />
    </node>
    <node concept="xi" id="1ux3aCohtB" role="x5">
      <property role="x9" value="Revisar" />
      <ref role="xk" node="1jTS9gtpf3" resolve="Revisor" />
    </node>
    <node concept="xl" id="1wdrsEEyOj" role="x6">
      <property role="x9" value="T1" />
      <node concept="xp" id="1QzU7o03x6" role="xm">
        <ref role="xr" node="1RORuktqNd" resolve="Inicio" />
      </node>
      <node concept="xs" id="1d7k9KBcPx" role="xn">
        <ref role="xr" node="1lxsUaNG8C" resolve="Revision" />
      </node>
    </node>
    <node concept="xl" id="1eNgJ15lRu" role="x6">
      <property role="x9" value="T2" />
      <node concept="xp" id="1quCi8vHfF" role="xm">
        <ref role="xr" node="1lxsUaNG8C" resolve="Revision" />
      </node>
      <node concept="xs" id="1DML3FlIeW" role="xn">
        <ref role="xr" node="1N8LTcBWzP" resolve="Fin" />
      </node>
      <node concept="xt" id="1J9jRVBFY1" role="xo">
        <ref role="xu" node="1ux3aCohtB" resolve="Revisar" />
      </node>
    </node>
    <node concept="xl" id="1XD4jgkwpy" role="x6">
      <property role="x9" value="T3" />
      <node concept="xp" id="1mv7OFxnen" role="xm">
        <ref role="xr" node="1lxsUaNG8C" resolve="Revision" />
      </node>
      <node concept="xs" id="1ZmIKruXlH" role="xn">
        <ref role="xr" node="1CLmp41ImG" resolve="Bucle" />
      </node>
    </node>
    <node concept="xl" id="1CSEOxDsrq" role="x6">
      <property role="x9" value="T4" />
      <node concept="xp" id="1V3vNP6bRV" role="xm">
        <ref role="xr" node="1CLmp41ImG" resolve="Bucle" />
      </node>
      <node concept="xs" id="14gg44SZYE" role="xn">
        <ref role="xr" node="1CLmp41ImG" resolve="Bucle" />
      </node>
    </node>
    <node concept="xv" id="1a5Xu7lywr" role="x7">
      <ref role="xw" node="1OdH4wDvtb" resolve="Olvidado" />
    </node>
    <node concept="xx" id="1jMy0MfZaJ" role="x7" />
    <node concept="xy" id="1rmtK4iRYD" role="x7">
      <ref role="xz" node="1N8LTcBWzP" resolve="Fin" />
      <node concept="x11" id="1j2HA4Xz3z" role="x10">
        <ref role="x12" node="1wdrsEEyOj" resolve="T1" />
      </node>
      <node concept="x11" id="1OcBUX8zHr" role="x10">
        <ref role="x12" node="1XD4jgkwpy" resolve="T3" />
      </node>
    </node>
    <node concept="x13" id="1IXSmGmaT6" role="x7">
      <ref role="x14" node="1ux3aCohtB" resolve="Revisar" />
      <node concept="x16" id="1qAvDyF715" role="x15">
        <ref role="x17" node="1TEJ2bujg7" resolve="Ana" />
      </node>
      <node concept="x16" id="1uUaOBEAe8" role="x15">
        <ref role="x17" node="1CGe9QnDc4" resolve="Luis" />
      </node>
    </node>
    <node concept="x18" id="1sP0m8wWIy" role="x7">
      <ref role="x19" node="1CLmp41ImG" resolve="Bucle" />
    </node>
  </node>
</model>
