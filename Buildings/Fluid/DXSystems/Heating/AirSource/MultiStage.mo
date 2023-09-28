within Buildings.Fluid.DXSystems.Heating.AirSource;
model MultiStage
    extends
    Buildings.Fluid.DXSystems.Heating.BaseClasses.PartialDXHeatingCoil(
    dxCoi(
      final variableSpeedCoil=true,
      redeclare Buildings.Fluid.DXSystems.BaseClasses.CapacityAirSource coiCap));

  Modelica.Blocks.Interfaces.IntegerInput stage
    "Stage of cooling coil (0: off, 1: first stage, 2: second stage...)"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}}),
      iconTransformation(extent={{-120,70},{-100,90}})));

  Buildings.Fluid.DXSystems.Cooling.BaseClasses.SpeedSelect speSel(
    final nSta=datCoi.nSta, speSet=datCoi.sta.spe)
    "Normalize the speed signal based on the compressor stage input"
    annotation (Placement(transformation(extent={{-80,60},{-68,72}})));

equation
  connect(stage, speSel.stage) annotation (Line(
      points={{-110,80},{-92,80},{-92,66},{-80.6,66}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(speSel.speRat,dxCoi.speRat)  annotation (Line(
      points={{-67.4,66},{-40,66},{-40,59.6},{-21,59.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stage,dxCoi.stage)  annotation (Line(
      points={{-110,80},{-30,80},{-30,62},{-21,62}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiStage;
