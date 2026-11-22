<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:9acc6dcd-0d04-4a47-aa73-089368ab4e3f(wvdl.sandbox.caso_estudio)">
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
        <child id="2311448109575635965" name="variables" index="x5" />
        <child id="2442891784385824884" name="activities" index="x6" />
        <child id="4297088327742399859" name="transitions" index="x7" />
        <child id="1630146823895602108" name="checks" index="x8" />
      </concept>
      <concept id="3773931177927761670" name="wvdl.structure.InitialState" flags="ng" index="xb" />
      <concept id="4340915256483426058" name="wvdl.structure.OrdinaryState" flags="ng" index="xc" />
      <concept id="4548869926607402224" name="wvdl.structure.FinalState" flags="ng" index="xd" />
      <concept id="4580885630124225313" name="wvdl.structure.HumanRole" flags="ng" index="xe" />
      <concept id="1727450827697905204" name="wvdl.structure.SystemRole" flags="ng" index="xf" />
      <concept id="1575272884437960782" name="wvdl.structure.Actor" flags="ng" index="xg" />
      <concept id="2754388617126347878" name="wvdl.structure.Assignment" flags="ng" index="xh">
        <reference id="3435594342687597196" name="actor" index="xi" />
        <reference id="4297639191499006525" name="role" index="xj" />
      </concept>
      <concept id="1984639994254280242" name="wvdl.structure.Variable" flags="ng" index="xk">
        <child id="1116711506113754239" name="type" index="xl" />
        <child id="3342385426935315388" name="init" index="xm" />
      </concept>
      <concept id="2211624816874732235" name="wvdl.structure.IntegerType" flags="ng" index="xn" />
      <concept id="4356461840986708983" name="wvdl.structure.IntLiteral" flags="ng" index="xo">
        <property id="2764001242192483827" name="value" index="xp" />
      </concept>
      <concept id="932772402753431168" name="wvdl.structure.BooleanType" flags="ng" index="xq" />
      <concept id="3341333894158794751" name="wvdl.structure.BoolLiteral" flags="ng" index="xr">
        <property id="448872718996398809" name="value" index="xs" />
      </concept>
      <concept id="1887490964949997474" name="wvdl.structure.StringType" flags="ng" index="xt" />
      <concept id="2142532025266201015" name="wvdl.structure.StringLiteral" flags="ng" index="xu">
        <property id="3067358161925164103" name="value" index="xv" />
      </concept>
      <concept id="298054231284038334" name="wvdl.structure.ManualActivity" flags="ng" index="xw" />
      <concept id="4100242238858238349" name="wvdl.structure.Activity" flags="ng" index="xx">
        <reference id="3951339498872278184" name="role" index="xy" />
      </concept>
      <concept id="1480812486812752603" name="wvdl.structure.AutomatedActivity" flags="ng" index="xz" />
      <concept id="3444469126383335239" name="wvdl.structure.Transition" flags="ng" index="x10">
        <child id="3546178691603644048" name="from" index="x11" />
        <child id="4557479502343562840" name="to" index="x12" />
        <child id="2595902392752590344" name="via" index="x13" />
        <child id="318163487345883580" name="guard" index="x14" />
      </concept>
      <concept id="910489418711293754" name="wvdl.structure.SourceRef" flags="ng" index="x15" />
      <concept id="2318847045543514830" name="wvdl.structure.StateRef" flags="ng" index="x16">
        <reference id="1644665000982416978" name="state" index="x17" />
      </concept>
      <concept id="1148869055518526258" name="wvdl.structure.TargetRef" flags="ng" index="x18" />
      <concept id="4065621737641222821" name="wvdl.structure.ActivityRef" flags="ng" index="x19">
        <reference id="2523441023518024119" name="activity" index="x1a" />
      </concept>
      <concept id="3474567488466545183" name="wvdl.structure.Guard" flags="ng" index="x1b">
        <child id="4202132126237685012" name="condition" index="x1c" />
      </concept>
      <concept id="4006625772246302066" name="wvdl.structure.LtExpr" flags="ng" index="x1d" />
      <concept id="2503589227462995725" name="wvdl.structure.IBinaryOperation" flags="ngI" index="x1e">
        <child id="3597341855276219803" name="left" index="x1f" />
        <child id="4307423801848415733" name="right" index="x1g" />
      </concept>
      <concept id="448228914353461423" name="wvdl.structure.VarRef" flags="ng" index="x1h">
        <reference id="3618521687389199141" name="variable" index="x1i" />
      </concept>
      <concept id="2935791979113318278" name="wvdl.structure.NotExpr" flags="ng" index="x1j">
        <child id="4235839573527162062" name="operand" index="x1k" />
      </concept>
      <concept id="218929957572760305" name="wvdl.structure.OrExpr" flags="ng" index="x1l" />
      <concept id="2874916540859629813" name="wvdl.structure.EqExpr" flags="ng" index="x1m" />
      <concept id="3458926237492019812" name="wvdl.structure.SoundCheck" flags="ng" index="x1n" />
      <concept id="4461490874048664151" name="wvdl.structure.ReachableCheck" flags="ng" index="x1o">
        <reference id="1001593753963161797" name="state" index="x1p" />
      </concept>
      <concept id="1645384556473442200" name="wvdl.structure.PathCheck" flags="ng" index="x1q">
        <reference id="2811859192094200142" name="state" index="x1r" />
        <child id="3494199751501289366" name="steps" index="x1s" />
      </concept>
      <concept id="506719079257640917" name="wvdl.structure.TransitionRef" flags="ng" index="x1t">
        <reference id="2600406349640642610" name="transition" index="x1u" />
      </concept>
      <concept id="1810144407881132328" name="wvdl.structure.ActorsCheck" flags="ng" index="x1v">
        <reference id="2003057994849096830" name="activity" index="x1w" />
        <child id="1944458948576600817" name="actors" index="x1x" />
      </concept>
      <concept id="3945133872824800573" name="wvdl.structure.ActorRef" flags="ng" index="x1y">
        <reference id="2607128528215628765" name="actor" index="x1z" />
      </concept>
      <concept id="1801005092375930339" name="wvdl.structure.SimulationCheck" flags="ng" index="x20">
        <reference id="2407784877938928023" name="state" index="x21" />
      </concept>
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x9">
        <property id="1169194664001" name="name" index="xa" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="1Kzmb6X9hG">
    <property role="xa" value="SolicitudCompra" />
    <node concept="xb" id="1i0mWeymc4" role="x1">
      <property role="xa" value="Inicio" />
    </node>
    <node concept="xc" id="1xVvlZNJnC" role="x1">
      <property role="xa" value="EnRevision" />
    </node>
    <node concept="xc" id="115vd76gLT" role="x1">
      <property role="xa" value="RevisionDirector" />
    </node>
    <node concept="xc" id="11HVMJCJY0" role="x1">
      <property role="xa" value="OrdenEmitida" />
    </node>
    <node concept="xd" id="1Ax6zfAWPA" role="x1">
      <property role="xa" value="Aprobada" />
    </node>
    <node concept="xd" id="1dyE27CySp" role="x1">
      <property role="xa" value="Rechazada" />
    </node>
    <node concept="xc" id="1zIOKnD6il" role="x1">
      <property role="xa" value="Archivada" />
    </node>
    <node concept="xe" id="1J23iqgwsJ" role="x2">
      <property role="xa" value="Solicitante" />
    </node>
    <node concept="xe" id="16INIIPVvy" role="x2">
      <property role="xa" value="Aprobador" />
    </node>
    <node concept="xe" id="15xxZ68B7r" role="x2">
      <property role="xa" value="Director" />
    </node>
    <node concept="xf" id="14e5ZNb94r" role="x2">
      <property role="xa" value="ERP" />
    </node>
    <node concept="xg" id="1bSDMIT9GN" role="x3">
      <property role="xa" value="Carla" />
    </node>
    <node concept="xg" id="173fd9WZk4" role="x3">
      <property role="xa" value="Mario" />
    </node>
    <node concept="xg" id="1CkvY83xgu" role="x3">
      <property role="xa" value="Sofia" />
    </node>
    <node concept="xg" id="1MHykQFC2V" role="x3">
      <property role="xa" value="SAP" />
    </node>
    <node concept="xh" id="1DIpQ5ED7X" role="x4">
      <ref role="xi" node="1bSDMIT9GN" resolve="Carla" />
      <ref role="xj" node="1J23iqgwsJ" resolve="Solicitante" />
    </node>
    <node concept="xh" id="1ZBPTGvyUR" role="x4">
      <ref role="xi" node="173fd9WZk4" resolve="Mario" />
      <ref role="xj" node="16INIIPVvy" resolve="Aprobador" />
    </node>
    <node concept="xh" id="1f3gsNzZDO" role="x4">
      <ref role="xi" node="1CkvY83xgu" resolve="Sofia" />
      <ref role="xj" node="15xxZ68B7r" resolve="Director" />
    </node>
    <node concept="xh" id="1BjziK5fif" role="x4">
      <ref role="xi" node="1MHykQFC2V" resolve="SAP" />
      <ref role="xj" node="14e5ZNb94r" resolve="ERP" />
    </node>
    <node concept="xk" id="1ogtuf3aH6" role="x5">
      <property role="xa" value="monto" />
      <node concept="xn" id="1DE9vEJAgf" role="xl" />
      <node concept="xo" id="16RV8Gg5p1" role="xm">
        <property role="xp" value="2500" />
      </node>
    </node>
    <node concept="xk" id="1AalQDuLnB" role="x5">
      <property role="xa" value="urgente" />
      <node concept="xq" id="1O3LvHZjdD" role="xl" />
      <node concept="xr" id="1tGjF7YXk5" role="xm">
        <property role="xs" value="false" />
      </node>
    </node>
    <node concept="xk" id="14tDKqSr77" role="x5">
      <property role="xa" value="area" />
      <node concept="xt" id="1vkbf3lI5e" role="xl" />
      <node concept="xu" id="1Fm6qmYqQK" role="xm">
        <property role="xv" value="TI" />
      </node>
    </node>
    <node concept="xw" id="1XIXz2bDEk" role="x6">
      <property role="xa" value="RegistrarSolicitud" />
      <ref role="xy" node="1J23iqgwsJ" resolve="Solicitante" />
    </node>
    <node concept="xw" id="16yTaMXEc6" role="x6">
      <property role="xa" value="RevisarSolicitud" />
      <ref role="xy" node="16INIIPVvy" resolve="Aprobador" />
    </node>
    <node concept="xw" id="1GSm4s7R8I" role="x6">
      <property role="xa" value="AutorizarGasto" />
      <ref role="xy" node="15xxZ68B7r" resolve="Director" />
    </node>
    <node concept="xz" id="1sGz0lIOZ8" role="x6">
      <property role="xa" value="EmitirOrden" />
      <ref role="xy" node="14e5ZNb94r" resolve="ERP" />
    </node>
    <node concept="x10" id="1Mp9cLx0oE" role="x7">
      <property role="xa" value="T1" />
      <node concept="x15" id="1cT5owsCQY" role="x11">
        <ref role="x17" node="1i0mWeymc4" resolve="Inicio" />
      </node>
      <node concept="x18" id="1X43D6pN9k" role="x12">
        <ref role="x17" node="1xVvlZNJnC" resolve="EnRevision" />
      </node>
      <node concept="x19" id="14YrLuN8G6" role="x13">
        <ref role="x1a" node="1XIXz2bDEk" resolve="RegistrarSolicitud" />
      </node>
    </node>
    <node concept="x10" id="1MSHKgqOX3" role="x7">
      <property role="xa" value="T2" />
      <node concept="x15" id="1qOivCxJlN" role="x11">
        <ref role="x17" node="1xVvlZNJnC" resolve="EnRevision" />
      </node>
      <node concept="x18" id="17Fq2Ypa6x" role="x12">
        <ref role="x17" node="11HVMJCJY0" resolve="OrdenEmitida" />
      </node>
      <node concept="x19" id="1H2SjoD1a3" role="x13">
        <ref role="x1a" node="16yTaMXEc6" resolve="RevisarSolicitud" />
      </node>
      <node concept="x1b" id="1iAq1OFv0I" role="x14">
        <node concept="x1d" id="1Jhn3aeI8l" role="x1c">
          <node concept="x1h" id="1w6JaWeVeR" role="x1f">
            <ref role="x1i" node="1ogtuf3aH6" resolve="monto" />
          </node>
          <node concept="xo" id="1o8dkefY2c" role="x1g">
            <property role="xp" value="1000" />
          </node>
        </node>
      </node>
    </node>
    <node concept="x10" id="1UlDxEY3km" role="x7">
      <property role="xa" value="T3" />
      <node concept="x15" id="1WgY4lXmcR" role="x11">
        <ref role="x17" node="1xVvlZNJnC" resolve="EnRevision" />
      </node>
      <node concept="x18" id="1nUDRSS57p" role="x12">
        <ref role="x17" node="115vd76gLT" resolve="RevisionDirector" />
      </node>
      <node concept="x19" id="1KIk6qxu1k" role="x13">
        <ref role="x1a" node="16yTaMXEc6" resolve="RevisarSolicitud" />
      </node>
      <node concept="x1b" id="1gJGw8yBLQ" role="x14">
        <node concept="x1j" id="1duRDwnCFF" role="x1c">
          <node concept="x1d" id="15IzYzv703" role="x1k">
            <node concept="x1h" id="1KJUHiXBKQ" role="x1f">
              <ref role="x1i" node="1ogtuf3aH6" resolve="monto" />
            </node>
            <node concept="xo" id="1Xyuvk9WGG" role="x1g">
              <property role="xp" value="1000" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x10" id="1RqOrzlUks" role="x7">
      <property role="xa" value="T4" />
      <node concept="x15" id="1Otwr5iHfr" role="x11">
        <ref role="x17" node="115vd76gLT" resolve="RevisionDirector" />
      </node>
      <node concept="x18" id="1JfuDJlRh0" role="x12">
        <ref role="x17" node="11HVMJCJY0" resolve="OrdenEmitida" />
      </node>
      <node concept="x19" id="1G4opt2lDi" role="x13">
        <ref role="x1a" node="1GSm4s7R8I" resolve="AutorizarGasto" />
      </node>
      <node concept="x1b" id="1vu4XUfe8Z" role="x14">
        <node concept="x1l" id="1Nn4Lw4apf" role="x1c">
          <node concept="x1h" id="1JvBlGs7CR" role="x1f">
            <ref role="x1i" node="1AalQDuLnB" resolve="urgente" />
          </node>
          <node concept="x1m" id="1069Ok1l9i" role="x1g">
            <node concept="x1h" id="1ujLURdz2N" role="x1f">
              <ref role="x1i" node="14tDKqSr77" resolve="area" />
            </node>
            <node concept="xu" id="1pgdb3YFy9" role="x1g">
              <property role="xv" value="TI" />
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x10" id="1dw37oq2So" role="x7">
      <property role="xa" value="T5" />
      <node concept="x15" id="1MFINqs75Z" role="x11">
        <ref role="x17" node="115vd76gLT" resolve="RevisionDirector" />
      </node>
      <node concept="x18" id="1cJitKxCi0" role="x12">
        <ref role="x17" node="1dyE27CySp" resolve="Rechazada" />
      </node>
      <node concept="x19" id="1pCIsfYJ2t" role="x13">
        <ref role="x1a" node="1GSm4s7R8I" resolve="AutorizarGasto" />
      </node>
      <node concept="x1b" id="1fkIj6AWGn" role="x14">
        <node concept="x1j" id="165TwV4si8" role="x1c">
          <node concept="x1l" id="1wQgv3go31" role="x1k">
            <node concept="x1h" id="1qqAZyMNVl" role="x1f">
              <ref role="x1i" node="1AalQDuLnB" resolve="urgente" />
            </node>
            <node concept="x1m" id="14ivyzRIha" role="x1g">
              <node concept="x1h" id="1pElJNEEur" role="x1f">
                <ref role="x1i" node="14tDKqSr77" resolve="area" />
              </node>
              <node concept="xu" id="12iGIl72qU" role="x1g">
                <property role="xv" value="TI" />
              </node>
            </node>
          </node>
        </node>
      </node>
    </node>
    <node concept="x10" id="16sY5nJD61" role="x7">
      <property role="xa" value="T6" />
      <node concept="x15" id="1eu4ZcYRSk" role="x11">
        <ref role="x17" node="11HVMJCJY0" resolve="OrdenEmitida" />
      </node>
      <node concept="x18" id="1JCPMdLiO8" role="x12">
        <ref role="x17" node="1Ax6zfAWPA" resolve="Aprobada" />
      </node>
      <node concept="x19" id="10yFSa63CM" role="x13">
        <ref role="x1a" node="1sGz0lIOZ8" resolve="EmitirOrden" />
      </node>
    </node>
    <node concept="x1n" id="12vGKn1qfx" role="x8" />
    <node concept="x1o" id="1CyCBvL04e" role="x8">
      <ref role="x1p" node="1dyE27CySp" resolve="Rechazada" />
    </node>
    <node concept="x1q" id="1YSbwxJNS2" role="x8">
      <ref role="x1r" node="1Ax6zfAWPA" resolve="Aprobada" />
      <node concept="x1t" id="17pn8z6e7T" role="x1s">
        <ref role="x1u" node="1Mp9cLx0oE" resolve="T1" />
      </node>
      <node concept="x1t" id="1SiAKYCGyk" role="x1s">
        <ref role="x1u" node="1MSHKgqOX3" resolve="T2" />
      </node>
      <node concept="x1t" id="1cJVkyA41C" role="x1s">
        <ref role="x1u" node="16sY5nJD61" resolve="T6" />
      </node>
    </node>
    <node concept="x1v" id="1xd2zUBcZc" role="x8">
      <ref role="x1w" node="1GSm4s7R8I" resolve="AutorizarGasto" />
      <node concept="x1y" id="1Qcrfpd5xO" role="x1x">
        <ref role="x1z" node="1CkvY83xgu" resolve="Sofia" />
      </node>
    </node>
    <node concept="x20" id="1gE0MfT2ix" role="x8">
      <ref role="x21" node="1Ax6zfAWPA" resolve="Aprobada" />
    </node>
  </node>
</model>
