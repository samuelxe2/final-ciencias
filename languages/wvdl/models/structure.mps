<?xml version="1.0" encoding="UTF-8"?>
<model ref="r:273ad769-335e-4778-ae24-00972122c65b(wvdl.structure)">
  <persistence version="9" />
  <languages>
    <devkit ref="78434eb8-b0e5-444b-850d-e7c4ad2da9ab(jetbrains.mps.devkit.aspect.structure)" />
  </languages>
  <imports>
    <import index="i000" ref="r:00000000-0000-4000-0000-011c89590288(jetbrains.mps.lang.core.structure)" />
  </imports>
  <registry>
    <language id="c72da2b9-7cce-4447-8389-f407dc1158b7" name="jetbrains.mps.lang.structure">
      <concept id="1169125989551" name="jetbrains.mps.lang.structure.structure.InterfaceConceptDeclaration" flags="ig" index="x0" />
      <concept id="1169125787135" name="jetbrains.mps.lang.structure.structure.AbstractConceptDeclaration" flags="ig" index="x1">
        <property id="6714410169261853888" name="conceptId" index="x2" />
        <child id="1071489727083" name="linkDeclaration" index="x3" />
        <property id="5092175715804935370" name="conceptAlias" index="x4" />
        <property id="4628067390765956802" name="abstract" index="x5" />
        <child id="1071489727084" name="propertyDeclaration" index="x6" />
      </concept>
      <concept id="1071489288298" name="jetbrains.mps.lang.structure.structure.LinkDeclaration" flags="ig" index="x9">
        <property id="241647608299431140" name="linkId" index="xa" />
        <property id="1071599776563" name="role" index="xb" />
        <property id="1071599937831" name="metaClass" index="xc" />
        <property id="1071599893252" name="sourceCardinality" index="xd" />
        <reference id="1071599976176" name="target" index="xe" />
      </concept>
      <concept id="1071489090640" name="jetbrains.mps.lang.structure.structure.ConceptDeclaration" flags="ig" index="xf">
        <property id="1096454100552" name="rootable" index="xg" />
        <reference id="1071489389519" name="extends" index="xh" />
        <child id="1169129564478" name="implements" index="xi" />
      </concept>
      <concept id="1169127622168" name="jetbrains.mps.lang.structure.structure.InterfaceConceptReference" flags="ig" index="xj">
        <reference id="1169127628841" name="intfc" index="xk" />
      </concept>
      <concept id="1071489288299" name="jetbrains.mps.lang.structure.structure.PropertyDeclaration" flags="ig" index="xl">
        <property id="241647608299431129" name="propertyId" index="xm" />
        <reference id="1082985295845" name="dataType" index="xn" />
      </concept>
    </language>
    <language id="ceab5195-25ea-4f22-9b92-103b95ca8c0c" name="jetbrains.mps.lang.core">
      <concept id="1169194658468" name="jetbrains.mps.lang.core.structure.INamedConcept" flags="ngI" index="x7">
        <property id="1169194664001" name="name" index="x8" />
      </concept>
    </language>
  </registry>
  <node concept="x0" id="19kY7PVSC4">
    <property role="x2" value="1812252622945750563" />
    <property role="x8" value="IWorkflowElement" />
  </node>
  <node concept="x0" id="1skcCU7Vkd">
    <property role="x2" value="2503589227462995725" />
    <property role="x8" value="IBinaryOperation" />
    <node concept="x9" id="1Upf8S2fK4" role="x3">
      <property role="xa" value="3597341855276219803" />
      <property role="xb" value="left" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1vP8XF2KrC" resolve="Expression" />
    </node>
    <node concept="x9" id="1kp6PrNldh" role="x3">
      <property role="xa" value="4307423801848415733" />
      <property role="xb" value="right" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1vP8XF2KrC" resolve="Expression" />
    </node>
  </node>
  <node concept="xf" id="1BUnh1SUXz">
    <property role="x2" value="1412782381407505714" />
    <property role="x8" value="Workflow" />
    <property role="xg" value="true" />
    <property role="x4" value="workflow" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1YbGpfuHM2" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="1DxAPzELZC" role="xi">
      <ref role="xk" to="i000:3fifI_xCcJN" resolve="ScopeProvider" />
    </node>
    <node concept="x9" id="1i3CNbIBLQ" role="x3">
      <property role="xa" value="1528467127056001332" />
      <property role="xb" value="states" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj6/1..n" />
      <ref role="xe" node="1Sfmn6y1hW" resolve="State" />
    </node>
    <node concept="x9" id="1R918F7sQI" role="x3">
      <property role="xa" value="3742483036895970086" />
      <property role="xb" value="roles" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1Nh0jwP4PT" resolve="Role" />
    </node>
    <node concept="x9" id="1faHt9nBnL" role="x3">
      <property role="xa" value="2514821820973565857" />
      <property role="xb" value="actors" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1yv6EdUUkj" resolve="Actor" />
    </node>
    <node concept="x9" id="1xLIzrnxdl" role="x3">
      <property role="xa" value="3059050193924877675" />
      <property role="xb" value="assignments" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1WB6b0mnCh" resolve="Assignment" />
    </node>
    <node concept="x9" id="150ApGhM0t" role="x3">
      <property role="xa" value="2311448109575635965" />
      <property role="xb" value="variables" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1qOAp9JyDs" resolve="Variable" />
    </node>
    <node concept="x9" id="15KNOzgmZP" role="x3">
      <property role="xa" value="2442891784385824884" />
      <property role="xb" value="activities" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="18FfuHlCWV" resolve="Activity" />
    </node>
    <node concept="x9" id="1kOc03E1F7" role="x3">
      <property role="xa" value="4297088327742399859" />
      <property role="xb" value="transitions" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1VZt5lKImX" resolve="Transition" />
    </node>
    <node concept="x9" id="1I0kVMUDWe" role="x3">
      <property role="xa" value="1630146823895602108" />
      <property role="xb" value="checks" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="10vhWZC4p6" resolve="Check" />
    </node>
  </node>
  <node concept="xf" id="1Sfmn6y1hW">
    <property role="x2" value="333066075726797411" />
    <property role="x8" value="State" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1VL6CIogRi" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="10rggtNoFg" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
  </node>
  <node concept="xf" id="1Aw09F56Xo">
    <property role="x2" value="3773931177927761670" />
    <property role="x8" value="InitialState" />
    <property role="x4" value="inicial" />
    <ref role="xh" node="1Sfmn6y1hW" resolve="State" />
  </node>
  <node concept="xf" id="1j6DZTtcSO">
    <property role="x2" value="4340915256483426058" />
    <property role="x8" value="OrdinaryState" />
    <property role="x4" value="estado" />
    <ref role="xh" node="1Sfmn6y1hW" resolve="State" />
  </node>
  <node concept="xf" id="1rgce7ApBD">
    <property role="x2" value="4548869926607402224" />
    <property role="x8" value="FinalState" />
    <property role="x4" value="final" />
    <ref role="xh" node="1Sfmn6y1hW" resolve="State" />
  </node>
  <node concept="xf" id="1Nh0jwP4PT">
    <property role="x2" value="4033371280979209837" />
    <property role="x8" value="Role" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1Lvl0Nch42" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="1W2zh6e2Bc" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
  </node>
  <node concept="xf" id="1837purKZs">
    <property role="x2" value="4580885630124225313" />
    <property role="x8" value="HumanRole" />
    <property role="x4" value="rol humano" />
    <ref role="xh" node="1Nh0jwP4PT" resolve="Role" />
  </node>
  <node concept="xf" id="1armEjHZuL">
    <property role="x2" value="1727450827697905204" />
    <property role="x8" value="SystemRole" />
    <property role="x4" value="rol sistema" />
    <ref role="xh" node="1Nh0jwP4PT" resolve="Role" />
  </node>
  <node concept="xf" id="1yv6EdUUkj">
    <property role="x2" value="1575272884437960782" />
    <property role="x8" value="Actor" />
    <property role="x4" value="actor" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1aA411fVXb" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="1pq8rbU35t" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
  </node>
  <node concept="xf" id="1WB6b0mnCh">
    <property role="x2" value="2754388617126347878" />
    <property role="x8" value="Assignment" />
    <property role="x4" value="asignacion" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1f0IoHS0bT" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
    <node concept="x9" id="1h02Gz07lY" role="x3">
      <property role="xa" value="3435594342687597196" />
      <property role="xb" value="actor" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1yv6EdUUkj" resolve="Actor" />
    </node>
    <node concept="x9" id="1m9V0RJbCW" role="x3">
      <property role="xa" value="4297639191499006525" />
      <property role="xb" value="role" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1Nh0jwP4PT" resolve="Role" />
    </node>
  </node>
  <node concept="xf" id="18FfuHlCWV">
    <property role="x2" value="4100242238858238349" />
    <property role="x8" value="Activity" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1I04n36rWT" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="1tWuwtd6wH" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
    <node concept="x9" id="1qudZ7j0lW" role="x3">
      <property role="xa" value="3951339498872278184" />
      <property role="xb" value="role" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1Nh0jwP4PT" resolve="Role" />
    </node>
  </node>
  <node concept="xf" id="128htnKn9X">
    <property role="x2" value="298054231284038334" />
    <property role="x8" value="ManualActivity" />
    <property role="x4" value="manual" />
    <ref role="xh" node="18FfuHlCWV" resolve="Activity" />
  </node>
  <node concept="xf" id="1QSSzp2NMK">
    <property role="x2" value="1480812486812752603" />
    <property role="x8" value="AutomatedActivity" />
    <property role="x4" value="automatica" />
    <ref role="xh" node="18FfuHlCWV" resolve="Activity" />
  </node>
  <node concept="xf" id="1VZt5lKImX">
    <property role="x2" value="3444469126383335239" />
    <property role="x8" value="Transition" />
    <property role="x4" value="transicion" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1bJGL5afqk" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="13WuxrKiTC" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
    <node concept="x9" id="1FawCZ9JcN" role="x3">
      <property role="xa" value="3546178691603644048" />
      <property role="xb" value="from" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1qWfZ4OURe" resolve="SourceRef" />
    </node>
    <node concept="x9" id="1WrXc2K0y9" role="x3">
      <property role="xa" value="4557479502343562840" />
      <property role="xb" value="to" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1mn5icSB20" resolve="TargetRef" />
    </node>
    <node concept="x9" id="1lkTqv3dgc" role="x3">
      <property role="xa" value="2595902392752590344" />
      <property role="xb" value="via" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <ref role="xe" node="1s4AauZDgE" resolve="ActivityRef" />
    </node>
    <node concept="x9" id="1RmG6DnvUa" role="x3">
      <property role="xa" value="318163487345883580" />
      <property role="xb" value="guard" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <ref role="xe" node="1Qfaxng6dZ" resolve="Guard" />
    </node>
  </node>
  <node concept="xf" id="13FKt4Wf5s">
    <property role="x2" value="2318847045543514830" />
    <property role="x8" value="StateRef" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="x9" id="16L6II4CoZ" role="x3">
      <property role="xa" value="1644665000982416978" />
      <property role="xb" value="state" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1Sfmn6y1hW" resolve="State" />
    </node>
  </node>
  <node concept="xf" id="1qWfZ4OURe">
    <property role="x2" value="910489418711293754" />
    <property role="x8" value="SourceRef" />
    <ref role="xh" node="13FKt4Wf5s" resolve="StateRef" />
  </node>
  <node concept="xf" id="1mn5icSB20">
    <property role="x2" value="1148869055518526258" />
    <property role="x8" value="TargetRef" />
    <ref role="xh" node="13FKt4Wf5s" resolve="StateRef" />
  </node>
  <node concept="xf" id="1s4AauZDgE">
    <property role="x2" value="4065621737641222821" />
    <property role="x8" value="ActivityRef" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="x9" id="1MQOg1pht5" role="x3">
      <property role="xa" value="2523441023518024119" />
      <property role="xb" value="activity" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="18FfuHlCWV" resolve="Activity" />
    </node>
  </node>
  <node concept="xf" id="1Qfaxng6dZ">
    <property role="x2" value="3474567488466545183" />
    <property role="x8" value="Guard" />
    <property role="x4" value="si" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="x9" id="1c7fiUUnGB" role="x3">
      <property role="xa" value="4202132126237685012" />
      <property role="xb" value="condition" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1vP8XF2KrC" resolve="Expression" />
    </node>
  </node>
  <node concept="xf" id="1qOAp9JyDs">
    <property role="x2" value="1984639994254280242" />
    <property role="x8" value="Variable" />
    <property role="x4" value="var" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="18QBugns2h" role="xi">
      <ref role="xk" to="i000:h0TrEE$" resolve="INamedConcept" />
    </node>
    <node concept="xj" id="12CMSXvbs5" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
    <node concept="x9" id="1p7ChY6qE7" role="x3">
      <property role="xa" value="1116711506113754239" />
      <property role="xb" value="type" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1HqAvmLVFs" resolve="Type" />
    </node>
    <node concept="x9" id="17zShCQqW2" role="x3">
      <property role="xa" value="3342385426935315388" />
      <property role="xb" value="init" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <ref role="xe" node="1vP8XF2KrC" resolve="Expression" />
    </node>
  </node>
  <node concept="xf" id="10vhWZC4p6">
    <property role="x2" value="4595171764396838333" />
    <property role="x8" value="Check" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="xj" id="1kZZ960vaH" role="xi">
      <ref role="xk" node="19kY7PVSC4" resolve="IWorkflowElement" />
    </node>
  </node>
  <node concept="xf" id="1NrvH2B1up">
    <property role="x2" value="4461490874048664151" />
    <property role="x8" value="ReachableCheck" />
    <property role="x4" value="verificar alcanzable" />
    <ref role="xh" node="10vhWZC4p6" resolve="Check" />
    <node concept="x9" id="1k7rosUgG6" role="x3">
      <property role="xa" value="1001593753963161797" />
      <property role="xb" value="state" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1Sfmn6y1hW" resolve="State" />
    </node>
  </node>
  <node concept="xf" id="1XtnuYzgah">
    <property role="x2" value="3458926237492019812" />
    <property role="x8" value="SoundCheck" />
    <property role="x4" value="verificar sound" />
    <ref role="xh" node="10vhWZC4p6" resolve="Check" />
  </node>
  <node concept="xf" id="1UsLVhWmfa">
    <property role="x2" value="1645384556473442200" />
    <property role="x8" value="PathCheck" />
    <property role="x4" value="verificar ruta" />
    <ref role="xh" node="10vhWZC4p6" resolve="Check" />
    <node concept="x9" id="1YDNu5CnPr" role="x3">
      <property role="xa" value="3494199751501289366" />
      <property role="xb" value="steps" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1VNeFKytpU" resolve="TransitionRef" />
    </node>
    <node concept="x9" id="1lxhuS2hdO" role="x3">
      <property role="xa" value="2811859192094200142" />
      <property role="xb" value="state" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1Sfmn6y1hW" resolve="State" />
    </node>
  </node>
  <node concept="xf" id="1q9sv0efva">
    <property role="x2" value="1810144407881132328" />
    <property role="x8" value="ActorsCheck" />
    <property role="x4" value="verificar actores" />
    <ref role="xh" node="10vhWZC4p6" resolve="Check" />
    <node concept="x9" id="1uNrA8stWm" role="x3">
      <property role="xa" value="1944458948576600817" />
      <property role="xb" value="actors" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj5/0..n" />
      <ref role="xe" node="1FCiA1gU7h" resolve="ActorRef" />
    </node>
    <node concept="x9" id="1P5fYFbZq6" role="x3">
      <property role="xa" value="2003057994849096830" />
      <property role="xb" value="activity" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="18FfuHlCWV" resolve="Activity" />
    </node>
  </node>
  <node concept="xf" id="1WCwbYp1wo">
    <property role="x2" value="1801005092375930339" />
    <property role="x8" value="SimulationCheck" />
    <property role="x4" value="verificar simulacion" />
    <ref role="xh" node="10vhWZC4p6" resolve="Check" />
    <node concept="x9" id="1FlWrd7CPf" role="x3">
      <property role="xa" value="2407784877938928023" />
      <property role="xb" value="state" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1Sfmn6y1hW" resolve="State" />
    </node>
  </node>
  <node concept="xf" id="1VNeFKytpU">
    <property role="x2" value="506719079257640917" />
    <property role="x8" value="TransitionRef" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="x9" id="1TlW4V4tsy" role="x3">
      <property role="xa" value="2600406349640642610" />
      <property role="xb" value="transition" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1VZt5lKImX" resolve="Transition" />
    </node>
  </node>
  <node concept="xf" id="1FCiA1gU7h">
    <property role="x2" value="3945133872824800573" />
    <property role="x8" value="ActorRef" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
    <node concept="x9" id="125TVJz878" role="x3">
      <property role="xa" value="2607128528215628765" />
      <property role="xb" value="actor" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1yv6EdUUkj" resolve="Actor" />
    </node>
  </node>
  <node concept="xf" id="1HqAvmLVFs">
    <property role="x2" value="706829657731694413" />
    <property role="x8" value="Type" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
  </node>
  <node concept="xf" id="1j5qgL7bGi">
    <property role="x2" value="932772402753431168" />
    <property role="x8" value="BooleanType" />
    <property role="x4" value="Boolean" />
    <ref role="xh" node="1HqAvmLVFs" resolve="Type" />
  </node>
  <node concept="xf" id="1ZmQZprBzp">
    <property role="x2" value="2211624816874732235" />
    <property role="x8" value="IntegerType" />
    <property role="x4" value="Integer" />
    <ref role="xh" node="1HqAvmLVFs" resolve="Type" />
  </node>
  <node concept="xf" id="19aybrsBVc">
    <property role="x2" value="1887490964949997474" />
    <property role="x8" value="StringType" />
    <property role="x4" value="String" />
    <ref role="xh" node="1HqAvmLVFs" resolve="Type" />
  </node>
  <node concept="xf" id="1vP8XF2KrC">
    <property role="x2" value="266678742667056361" />
    <property role="x8" value="Expression" />
    <property role="x5" value="true" />
    <ref role="xh" to="i000:gw2VY9q" resolve="BaseConcept" />
  </node>
  <node concept="xf" id="14hmwy2CvD">
    <property role="x2" value="3341333894158794751" />
    <property role="x8" value="BoolLiteral" />
    <property role="x4" value="booleano" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xl" id="1p6xq4ndM5" role="x6">
      <property role="xm" value="448872718996398809" />
      <property role="x8" value="value" />
      <ref role="xn" to="i000:fKAQMTB" resolve="boolean" />
    </node>
  </node>
  <node concept="xf" id="1LPtCWt1oH">
    <property role="x2" value="4356461840986708983" />
    <property role="x8" value="IntLiteral" />
    <property role="x4" value="entero" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xl" id="1ran79P6GB" role="x6">
      <property role="xm" value="2764001242192483827" />
      <property role="x8" value="value" />
      <ref role="xn" to="i000:fKAQMTA" resolve="integer" />
    </node>
  </node>
  <node concept="xf" id="1SNz3hhgA7">
    <property role="x2" value="2142532025266201015" />
    <property role="x8" value="StringLiteral" />
    <property role="x4" value="texto" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xl" id="1SKGal7MNS" role="x6">
      <property role="xm" value="3067358161925164103" />
      <property role="x8" value="value" />
      <ref role="xn" to="i000:fKAOsGN" resolve="string" />
    </node>
  </node>
  <node concept="xf" id="1EkjHvvHFU">
    <property role="x2" value="448228914353461423" />
    <property role="x8" value="VarRef" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="x9" id="1RHsrOnCFk" role="x3">
      <property role="xa" value="3618521687389199141" />
      <property role="xb" value="variable" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1qOAp9JyDs" resolve="Variable" />
    </node>
  </node>
  <node concept="xf" id="1P33KpLVwL">
    <property role="x2" value="2874916540859629813" />
    <property role="x8" value="EqExpr" />
    <property role="x4" value="==" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xj" id="1X8uukUuE6" role="xi">
      <ref role="xk" node="1skcCU7Vkd" resolve="IBinaryOperation" />
    </node>
  </node>
  <node concept="xf" id="1ee1pD1E3D">
    <property role="x2" value="4006625772246302066" />
    <property role="x8" value="LtExpr" />
    <property role="x4" value="&lt;" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xj" id="1vu8GSOmqc" role="xi">
      <ref role="xk" node="1skcCU7Vkd" resolve="IBinaryOperation" />
    </node>
  </node>
  <node concept="xf" id="1wMdjeBw1u">
    <property role="x2" value="3832905274808341295" />
    <property role="x8" value="AndExpr" />
    <property role="x4" value="and" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xj" id="1XZ57ZwenK" role="xi">
      <ref role="xk" node="1skcCU7Vkd" resolve="IBinaryOperation" />
    </node>
  </node>
  <node concept="xf" id="1e4hh7H78f">
    <property role="x2" value="218929957572760305" />
    <property role="x8" value="OrExpr" />
    <property role="x4" value="or" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="xj" id="16jLWZzMxw" role="xi">
      <ref role="xk" node="1skcCU7Vkd" resolve="IBinaryOperation" />
    </node>
  </node>
  <node concept="xf" id="1uDerpIKFG">
    <property role="x2" value="2935791979113318278" />
    <property role="x8" value="NotExpr" />
    <property role="x4" value="not" />
    <ref role="xh" node="1vP8XF2KrC" resolve="Expression" />
    <node concept="x9" id="1w1B7zBV1l" role="x3">
      <property role="xa" value="4235839573527162062" />
      <property role="xb" value="operand" />
      <property role="xc" value="fLJjDmT/aggregation" />
      <property role="xd" value="fLJekj4/1" />
      <ref role="xe" node="1vP8XF2KrC" resolve="Expression" />
    </node>
  </node>
</model>
