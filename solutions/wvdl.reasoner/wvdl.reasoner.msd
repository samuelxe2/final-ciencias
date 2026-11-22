<?xml version="1.0" encoding="UTF-8"?>
<solution name="wvdl.reasoner" uuid="1ef5f35c-a65e-4d17-ae43-47ba979c4838" moduleVersion="0" compileInMPS="true">
  <models>
    <modelRoot contentPath="${module}" type="java_classes">
      <sourceRoot location="lib" />
    </modelRoot>
  </models>
  <facets>
    <facet type="java" compile="mps" classes="mps" ext="no">
      <classes generated="true" path="${module}/classes_gen" />
      <library location="${module}/lib/wvdl-reasoner.jar" />
    </facet>
  </facets>
  <sourcePath />
  <dependencies>
    <dependency reexport="false">6354ebe7-c22a-4a0f-ac54-50b52ab9b065(JDK)</dependency>
    <dependency reexport="false">8865b7a8-5271-43d3-884c-6fd1d9cfdd34(MPS.OpenAPI)</dependency>
    <dependency reexport="false">6ed54515-acc8-4d1e-a16c-9fd6cfe951ea(MPS.Core)</dependency>
    <dependency reexport="false">1ed103c3-3aa6-49b7-9c21-6765ee11f224(MPS.Editor)</dependency>
    <dependency reexport="false">258bd2f6-0d02-411d-86b2-5a5ea083e6d2(jetbrains.mps.lang.editor.table.runtime)</dependency>
  </dependencies>
  <languageVersions />
  <dependencyVersions>
    <module reference="1ef5f35c-a65e-4d17-ae43-47ba979c4838(wvdl.reasoner)" version="0" />
  </dependencyVersions>
</solution>
