within Buildings.Fluid.DXSystems.Heating.AirSource;
model VariableSpeed
    extends
    Buildings.Fluid.DXSystems.Heating.BaseClasses.PartialDXHeatingCoil(
    dxCoi(
      final variableSpeedCoil=true,
      redeclare Buildings.Fluid.DXSystems.BaseClasses.CapacityAirSource coiCap));

  parameter Real minSpeRat(
    final min=0,
    final max=1)
    "Minimum speed ratio";

  parameter Real speRatDeaBan= 0.05
    "Deadband for minimum speed ratio";

  Modelica.Blocks.Interfaces.RealInput speRat(
    final unit="1",
    displayUnit="1")
    "Speed ratio"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}}),
      iconTransformation(extent={{-120,70},{-100,90}})));

protected
  Modelica.Blocks.Logical.Hysteresis deaBan(
    final uLow=minSpeRat - speRatDeaBan/2,
    final uHigh=minSpeRat + speRatDeaBan/2)
    "Speed ratio deadband"
    annotation (Placement(transformation(extent={{-64,64},{-52,76}})));

  Modelica.Blocks.Math.BooleanToInteger onSwi(
    final integerTrue=1,
    final integerFalse=0)
    "On/off switch"
    annotation (Placement(transformation(extent={{-42,64},{-30,76}})));

equation
  connect(speRat,dxCoi.speRat)  annotation (Line(
      points={{-110,80},{-90,80},{-90,59.6},{-21,59.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(speRat, deaBan.u)
                         annotation (Line(
      points={{-110,80},{-90,80},{-90,70},{-65.2,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(onSwi.y,dxCoi.stage)  annotation (Line(
      points={{-29.4,70},{-26,70},{-26,62},{-21,62}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(deaBan.y, onSwi.u) annotation (Line(
      points={{-51.4,70},{-43.2,70}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                   Text(
          extent={{-96,98},{-38,80}},
          textColor={0,0,127},
          textString="speRat")}),
          Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VariableSpeed;
