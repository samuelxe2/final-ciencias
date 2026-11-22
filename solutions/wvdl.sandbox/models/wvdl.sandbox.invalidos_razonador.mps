<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:267e3232-4448-4480-a562-e0e07d211984(wvdl.sandbox.invalidos_razonador)">
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
        <child id="3742483036895970086" name="roles" index="x3" />
        <child id="2311448109575635965" name="variables" index="x4" />
        <child id="2442891784385824884" name="activities" index="x5" />
      </concept>
      <concept id="3773931177927761670" name="wvdl.structure.InitialState" flags="ng" index="x8" />
      <concept id="4548869926607402224" name="wvdl.structure.FinalState" flags="ng" index="x9" />
      <concept id="4340915256483426058" name="wvdl.structure.OrdinaryState" flags="ng" index="xa" />
      <concept id="3444469126383335239" name="wvdl.structure.Transition" flags="ng" index="xb">
        <child id="3546178691603644048" name="from" index="xc" />
        <child id="4557479502343562840" name="to" index="xd" />
        <child id="2595902392752590344" name="via" index="xe" />
        <child id="318163487345883580" name="guard" index="xf" />
      </concept>
      <concept id="910489418711293754" name="wvdl.structure.SourceRef" flags="ng" index="xg" />
      <concept id="2318847045543514830" name="wvdl.structure.StateRef" flags="ng" index="xh">
        <reference id="1644665000982416978" name="state" index="xi" />
      </concept>
      <concept id="1148869055518526258" name="wvdl.structure.TargetRef" flags="ng" index="xj" />
      <concept id="4580885630124225313" name="wvdl.structure.HumanRole" flags="ng" index="xk" />
      <concept id="1984639994254280242" name="wvdl.structure.Variable" flags="ng" index="xl">
        <child id="1116711506113754239" name="type" index="xm" />
      </concept>
      <concept id="2211624816874732235" name="wvdl.structure.IntegerType" flags="ng" index="xn" />
      <concept id="298054231284038334" name="wvdl.structure.ManualActivity" flags="ng" index="xo" />
      <concept id="4100242238858238349" name="wvdl.structure.Activity" flags="ng" index="xp">
        <reference id="3951339498872278184" name="role" index="xq" />
      </concept>
      <concept id="4065621737641222821" name="wvdl.structure.ActivityRef" flags="ng" index="xr">
        <reference id="2523441023518024119" name="activity" index="xs" />
      </concept>
      <concept id="3474567488466545183" name="wvdl.structure.Guard" flags="ng" index="xt">
        <child id="4202132126237685012" name="condition" index="xu" />
      </concept>
      <concept id="3832905274808341295" name="wvdl.structure.AndExpr" flags="ng" index="xv" />
      <concept id="2503589227462995725" name="wvdl.structure.IBinaryOperation" flags="ngI" index="xw">
        <child id="3597341855276219803" name="left" index="xx" />
        <child id="4307423801848415733" name="right" index="xy" />
      </concept>
      <concept id="4006625772246302066" name="wvdl.structure.LtExpr" flags="ng" index="xz" />
      <concept id="448228914353461423" name="wvdl.structure.VarRef" flags="ng" index="x10">
        <reference id="3618521687389199141" name="variable" index="x11" />
      </concept>
      <concept id="4356461840986708983" name="wvdl.structure.IntLiteral" flags="ng" index="x12">
        <property id="2764001242192483827" name="value" index="x13" />
      </concept>
      <concept id="2874916540859629813" name="wvdl.structure.EqExpr" flags="ng" index="x14" />
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x6">
        <property id="1169194664001" name="name" index="x7" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="1l31olAPXM">
    <property role="x7" value="IR1_Inalcanzable" />
    <node concept="x8" id="1s7Q5gn2fM" role="x1">
      <property role="x7" value="Inicio" />
    </node>
    <node concept="x9" id="1brZd4Drm6" role="x1">
      <property role="x7" value="Fin" />
    </node>
    <node concept="xa" id="16FgtADbyw" role="x1">
      <property role="x7" value="Archivado" />
    </node>
    <node concept="xb" id="1i4VaK1Rg8" role="x2">
      <property role="x7" value="T1" />
      <node concept="xg" id="18x2gyYjZ6" role="xc">
        <ref role="xi" node="1s7Q5gn2fM" resolve="Inicio" />
      </node>
      <node concept="xj" id="1LdQxy6UfJ" role="xd">
        <ref role="xi" node="1brZd4Drm6" resolve="Fin" />
      </node>
    </node>
    <node concept="xb" id="1EXHGE2u75" role="x2">
      <property role="x7" value="T2" />
      <node concept="xg" id="152bD6DTd2" role="xc">
        <ref role="xi" node="16FgtADbyw" resolve="Archivado" />
      </node>
      <node concept="xj" id="1X70FOCSD1" role="xd">
        <ref role="xi" node="1brZd4Drm6" resolve="Fin" />
      </node>
    </node>
  </node>
  <node concept="x0" id="1v3dHR19lb">
    <property role="x7" value="IR2_Deadlock" />
    <node concept="x8" id="1x1i7rzePH" role="x1">
      <property role="x7" value="Inicio" />
    </node>
    <node concept="xa" id="1lopNfK1dE" role="x1">
      <property role="x7" value="Espera" />
    </node>
    <node concept="xa" id="1YUcuFCZAk" role="x1">
      <property role="x7" value="Revision" />
    </node>
    <node concept="x9" id="1KBlRhPlXJ" role="x1">
      <property role="x7" value="Fin" />
    </node>
    <node concept="xb" id="1HpY0JuPXo" role="x2">
      <property role="x7" value="T1" />
      <node concept="xg" id="1ZBLNGz1f5" role="xc">
        <ref role="xi" node="1x1i7rzePH" resolve="Inicio" />
      </node>
      <node concept="xj" id="1pn0Cfw02N" role="xd">
        <ref role="xi" node="1YUcuFCZAk" resolve="Revision" />
      </node>
    </node>
    <node concept="xb" id="1pVz0D3SE0" role="x2">
      <property role="x7" value="T2" />
      <node concept="xg" id="1Jrex8bhH1" role="xc">
        <ref role="xi" node="1YUcuFCZAk" resolve="Revision" />
      </node>
      <node concept="xj" id="11ciiC49by" role="xd">
        <ref role="xi" node="1KBlRhPlXJ" resolve="Fin" />
      </node>
    </node>
    <node concept="xb" id="1BgRcYQP7D" role="x2">
      <property role="x7" value="T3" />
      <node concept="xg" id="1b5eq41GSj" role="xc">
        <ref role="xi" node="1YUcuFCZAk" resolve="Revision" />
      </node>
      <node concept="xj" id="1HMfl3ACQH" role="xd">
        <ref role="xi" node="1lopNfK1dE" resolve="Espera" />
      </node>
    </node>
  </node>
  <node concept="x0" id="1Oa2EL4S9n">
    <property role="x7" value="IR3_Livelock" />
    <node concept="x8" id="1acIablNUv" role="x1">
      <property role="x7" value="Inicio" />
    </node>
    <node concept="xa" id="1MuucLMPU1" role="x1">
      <property role="x7" value="Revision" />
    </node>
    <node concept="xa" id="1WVKEED6El" role="x1">
      <property role="x7" value="Correccion" />
    </node>
    <node concept="x9" id="1HWUJsBcEY" role="x1">
      <property role="x7" value="Fin" />
    </node>
    <node concept="xb" id="16UmbJcDlb" role="x2">
      <property role="x7" value="T1" />
      <node concept="xg" id="1U7YlY7py7" role="xc">
        <ref role="xi" node="1acIablNUv" resolve="Inicio" />
      </node>
      <node concept="xj" id="1zdd0JV23n" role="xd">
        <ref role="xi" node="1HWUJsBcEY" resolve="Fin" />
      </node>
    </node>
    <node concept="xb" id="15FvDxP72J" role="x2">
      <property role="x7" value="T2" />
      <node concept="xg" id="1SIpVNY3z5" role="xc">
        <ref role="xi" node="1acIablNUv" resolve="Inicio" />
      </node>
      <node concept="xj" id="1G1Cj1mIaK" role="xd">
        <ref role="xi" node="1MuucLMPU1" resolve="Revision" />
      </node>
    </node>
    <node concept="xb" id="1RjkR6OToF" role="x2">
      <property role="x7" value="T3" />
      <node concept="xg" id="1icd3z55eq" role="xc">
        <ref role="xi" node="1MuucLMPU1" resolve="Revision" />
      </node>
      <node concept="xj" id="1hj5JQPTaZ" role="xd">
        <ref role="xi" node="1WVKEED6El" resolve="Correccion" />
      </node>
    </node>
    <node concept="xb" id="12tZKCA5ap" role="x2">
      <property role="x7" value="T4" />
      <node concept="xg" id="1LIT8Tjytr" role="xc">
        <ref role="xi" node="1WVKEED6El" resolve="Correccion" />
      </node>
      <node concept="xj" id="1l2Q0C71bp" role="xd">
        <ref role="xi" node="1MuucLMPU1" resolve="Revision" />
      </node>
    </node>
  </node>
  <node concept="x0" id="1Ap5K0fQcJ">
    <property role="x7" value="IR4_GuardaMuertaYRol" />
    <node concept="x8" id="16jm7on2aL" role="x1">
      <property role="x7" value="Inicio" />
    </node>
    <node concept="x9" id="1OcN3Mm2EW" role="x1">
      <property role="x7" value="Fin" />
    </node>
    <node concept="x9" id="140L8ufW89" role="x1">
      <property role="x7" value="Excepcion" />
    </node>
    <node concept="xk" id="11D5vbUQWW" role="x3">
      <property role="x7" value="Auditor" />
    </node>
    <node concept="xl" id="17hsK8XCOK" role="x4">
      <property role="x7" value="x" />
      <node concept="xn" id="1GzIYlsUyW" role="xm" />
    </node>
    <node concept="xo" id="1SU2WjNVBt" role="x5">
      <property role="x7" value="Auditar" />
      <ref role="xq" node="11D5vbUQWW" resolve="Auditor" />
    </node>
    <node concept="xb" id="1FvAas0Ju2" role="x2">
      <property role="x7" value="T1" />
      <node concept="xg" id="1rMFIkYOk3" role="xc">
        <ref role="xi" node="16jm7on2aL" resolve="Inicio" />
      </node>
      <node concept="xj" id="1JslWuT63j" role="xd">
        <ref role="xi" node="1OcN3Mm2EW" resolve="Fin" />
      </node>
      <node concept="xr" id="1nTEOEpxKi" role="xe">
        <ref role="xs" node="1SU2WjNVBt" resolve="Auditar" />
      </node>
    </node>
    <node concept="xb" id="1P123n0E1R" role="x2">
      <property role="x7" value="T2" />
      <node concept="xg" id="1kwjMNTX7o" role="xc">
        <ref role="xi" node="16jm7on2aL" resolve="Inicio" />
      </node>
      <node concept="xj" id="1AGfz7XMJy" role="xd">
        <ref role="xi" node="140L8ufW89" resolve="Excepcion" />
      </node>
      <node concept="xt" id="1DNlPWRtbn" role="xf">
        <node concept="xv" id="1uVVDwh4nV" role="xu">
          <node concept="xz" id="16usXoMK92" role="xx">
            <node concept="x10" id="12DCF9bqkB" role="xx">
              <ref role="x11" node="17hsK8XCOK" resolve="x" />
            </node>
            <node concept="x12" id="1wULZ9rYW1" role="xy">
              <property role="x13" value="1" />
            </node>
          </node>
          <node concept="x14" id="13p0qpmOa2" role="xy">
            <node concept="x10" id="16vK6OMRNp" role="xx">
              <ref role="x11" node="17hsK8XCOK" resolve="x" />
            </node>
            <node concept="x12" id="13dhiw4j0y" role="xy">
              <property role="x13" value="5" />
            </node>
          </node>
        </node>
      </node>
    </node>
  </node>
</model>
