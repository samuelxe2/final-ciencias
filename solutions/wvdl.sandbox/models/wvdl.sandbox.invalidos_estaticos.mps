<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:b37ff01f-2359-4017-a6ea-223f9a37514d(wvdl.sandbox.invalidos_estaticos)">
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
        <child id="4297088327742399859" name="transitions" index="x2" />
        <child id="2311448109575635965" name="variables" index="x3" />
        <child id="3742483036895970086" name="roles" index="x4" />
        <child id="2514821820973565857" name="actors" index="x5" />
        <child id="3059050193924877675" name="assignments" index="x6" />
        <child id="2442891784385824884" name="activities" index="x7" />
      </concept>
      <concept id="3773931177927761670" name="wvdl.structure.InitialState" flags="ng" index="xa" />
      <concept id="4548869926607402224" name="wvdl.structure.FinalState" flags="ng" index="xb" />
      <concept id="3444469126383335239" name="wvdl.structure.Transition" flags="ng" index="xc">
        <child id="3546178691603644048" name="from" index="xd" />
        <child id="4557479502343562840" name="to" index="xe" />
        <child id="318163487345883580" name="guard" index="xf" />
        <child id="2595902392752590344" name="via" index="xg" />
      </concept>
      <concept id="910489418711293754" name="wvdl.structure.SourceRef" flags="ng" index="xh" />
      <concept id="2318847045543514830" name="wvdl.structure.StateRef" flags="ng" index="xi">
        <reference id="1644665000982416978" name="state" index="xj" />
      </concept>
      <concept id="1148869055518526258" name="wvdl.structure.TargetRef" flags="ng" index="xk" />
      <concept id="1984639994254280242" name="wvdl.structure.Variable" flags="ng" index="xl">
        <child id="1116711506113754239" name="type" index="xm" />
      </concept>
      <concept id="2211624816874732235" name="wvdl.structure.IntegerType" flags="ng" index="xn" />
      <concept id="3474567488466545183" name="wvdl.structure.Guard" flags="ng" index="xo">
        <child id="4202132126237685012" name="condition" index="xp" />
      </concept>
      <concept id="448228914353461423" name="wvdl.structure.VarRef" flags="ng" index="xq">
        <reference id="3618521687389199141" name="variable" index="xr" />
      </concept>
      <concept id="4580885630124225313" name="wvdl.structure.HumanRole" flags="ng" index="xs" />
      <concept id="1575272884437960782" name="wvdl.structure.Actor" flags="ng" index="xt" />
      <concept id="2754388617126347878" name="wvdl.structure.Assignment" flags="ng" index="xu">
        <reference id="3435594342687597196" name="actor" index="xv" />
        <reference id="4297639191499006525" name="role" index="xw" />
      </concept>
      <concept id="1480812486812752603" name="wvdl.structure.AutomatedActivity" flags="ng" index="xx" />
      <concept id="4100242238858238349" name="wvdl.structure.Activity" flags="ng" index="xy">
        <reference id="3951339498872278184" name="role" index="xz" />
      </concept>
      <concept id="4065621737641222821" name="wvdl.structure.ActivityRef" flags="ng" index="x10">
        <reference id="2523441023518024119" name="activity" index="x11" />
      </concept>
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x8">
        <property id="1169194664001" name="name" index="x9" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="1P4PYrki5Z">
    <property role="x9" value="Otro_Workflow" />
    <node concept="xa" id="16HTims8yQ" role="x1">
      <property role="x9" value="Inicio" />
    </node>
    <node concept="xb" id="1BBCJnG0ey" role="x1">
      <property role="x9" value="Externo" />
    </node>
    <node concept="xc" id="1INKl9ZIsL" role="x2">
      <property role="x9" value="T1" />
      <node concept="xh" id="1fi5hOOWvq" role="xd">
        <ref role="xj" node="16HTims8yQ" resolve="Inicio" />
      </node>
      <node concept="xk" id="1eSZxAkEQT" role="xe">
        <ref role="xj" node="1BBCJnG0ey" resolve="Externo" />
      </node>
    </node>
  </node>
  <node concept="x0" id="1TnK8yTWC8">
    <property role="x9" value="IS1_ReferenciaAjena" />
    <node concept="xa" id="14b6iHqO4x" role="x1">
      <property role="x9" value="Inicio" />
    </node>
    <node concept="xb" id="1qStuDFyUH" role="x1">
      <property role="x9" value="Fin" />
    </node>
    <node concept="xc" id="138q06V4KM" role="x2">
      <property role="x9" value="T1" />
      <node concept="xh" id="1DnFMDuStM" role="xd">
        <ref role="xj" node="14b6iHqO4x" resolve="Inicio" />
      </node>
      <node concept="xk" id="1sUcGugk95" role="xe">
        <ref role="xj" node="1qStuDFyUH" resolve="Fin" />
      </node>
    </node>
    <node concept="xc" id="1x672lOm21" role="x2">
      <property role="x9" value="T2" />
      <node concept="xh" id="17F3NSOv5L" role="xd">
        <ref role="xj" node="14b6iHqO4x" resolve="Inicio" />
      </node>
      <node concept="xk" id="1txa2sj5O6" role="xe">
        <ref role="xj" node="1BBCJnG0ey" resolve="Externo" />
      </node>
    </node>
  </node>
  <node concept="x0" id="1WjdGfpk3u">
    <property role="x9" value="IS2_GuardaNoBooleana" />
    <node concept="xa" id="1aqp42XCxI" role="x1">
      <property role="x9" value="Inicio" />
    </node>
    <node concept="xb" id="1mF7Qi6MTZ" role="x1">
      <property role="x9" value="Fin" />
    </node>
    <node concept="xl" id="16WUVQGn56" role="x3">
      <property role="x9" value="monto" />
      <node concept="xn" id="1zuO1ATY2M" role="xm" />
    </node>
    <node concept="xc" id="1pDlParsoh" role="x2">
      <property role="x9" value="T1" />
      <node concept="xh" id="1afWQ1YNEJ" role="xd">
        <ref role="xj" node="1aqp42XCxI" resolve="Inicio" />
      </node>
      <node concept="xk" id="12tY9y93qq" role="xe">
        <ref role="xj" node="1mF7Qi6MTZ" resolve="Fin" />
      </node>
      <node concept="xo" id="1EwPdDGSu9" role="xf">
        <node concept="xq" id="1hwS7kzBvv" role="xp">
          <ref role="xr" node="16WUVQGn56" resolve="monto" />
        </node>
      </node>
    </node>
  </node>
  <node concept="x0" id="1r1VzT8wy5">
    <property role="x9" value="IS3_RolIncompatible" />
    <node concept="xa" id="19Csp4R5OQ" role="x1">
      <property role="x9" value="Inicio" />
    </node>
    <node concept="xa" id="1StG6K03NM" role="x1">
      <property role="x9" value="Inicio2" />
    </node>
    <node concept="xb" id="1LAhgs1E6Q" role="x1">
      <property role="x9" value="Fin" />
    </node>
    <node concept="xs" id="1uEQW2nUI4" role="x4">
      <property role="x9" value="Revisor" />
    </node>
    <node concept="xt" id="17OTjCvdh3" role="x5">
      <property role="x9" value="Ana" />
    </node>
    <node concept="xu" id="1umfFKhHIm" role="x6">
      <ref role="xv" node="17OTjCvdh3" resolve="Ana" />
      <ref role="xw" node="1uEQW2nUI4" resolve="Revisor" />
    </node>
    <node concept="xx" id="1nQcb0d4TA" role="x7">
      <property role="x9" value="Calcular" />
      <ref role="xz" node="1uEQW2nUI4" resolve="Revisor" />
    </node>
    <node concept="xc" id="1Ie4FQ3ivB" role="x2">
      <property role="x9" value="T1" />
      <node concept="xh" id="1dHu4A5a2s" role="xd">
        <ref role="xj" node="19Csp4R5OQ" resolve="Inicio" />
      </node>
      <node concept="xk" id="1Sqqn9SSvQ" role="xe">
        <ref role="xj" node="1LAhgs1E6Q" resolve="Fin" />
      </node>
      <node concept="x10" id="1knsm6ZcdO" role="xg">
        <ref role="x11" node="1nQcb0d4TA" resolve="Calcular" />
      </node>
    </node>
    <node concept="xc" id="1YwQOn1JIt" role="x2">
      <property role="x9" value="T2" />
      <node concept="xh" id="15sBD5f14F" role="xd">
        <ref role="xj" node="1StG6K03NM" resolve="Inicio2" />
      </node>
      <node concept="xk" id="12X5gdCjhl" role="xe">
        <ref role="xj" node="1LAhgs1E6Q" resolve="Fin" />
      </node>
    </node>
  </node>
</model>
