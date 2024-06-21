within Buildings.Controls.OBC.HeatPumpPlant.Validation;
model OperationModeProcess
  "Validation model for system operation mode process"

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro1
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro2
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{60,100},{80,120}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro3
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro4
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro5
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro6
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro7
    "Block outputs enable signal commands based on different operation modes"
    annotation (Placement(transformation(extent={{60,-120},{80,-100}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1)
    "Heating-1 mode"
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3)
    annotation (Placement(transformation(extent={{22,100},{42,120}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt4(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt5(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3)
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt6(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt7(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_5)
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));

equation
  connect(conInt.y, opeModPro.uOpeMod)
    annotation (Line(points={{-78,110},{-62.5,110}}, color={255,127,0}));
  connect(conInt1.y, opeModPro1.uOpeMod)
    annotation (Line(points={{-78,50},{-62.5,50}}, color={255,127,0}));
  connect(conInt2.y, opeModPro2.uOpeMod)
    annotation (Line(points={{44,110},{57.5,110}}, color={255,127,0}));
  connect(conInt3.y, opeModPro3.uOpeMod)
    annotation (Line(points={{42,50},{57.5,50}}, color={255,127,0}));
  connect(conInt4.y, opeModPro4.uOpeMod)
    annotation (Line(points={{-78,-50},{-62.5,-50}}, color={255,127,0}));
  connect(conInt5.y, opeModPro5.uOpeMod)
    annotation (Line(points={{-78,-110},{-62.5,-110}}, color={255,127,0}));
  connect(conInt6.y, opeModPro6.uOpeMod)
    annotation (Line(points={{42,-50},{57.5,-50}}, color={255,127,0}));
  connect(conInt7.y, opeModPro7.uOpeMod)
    annotation (Line(points={{42,-110},{57.5,-110}}, color={255,127,0}));

  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/HeatPumpPlant/Validation/OperationModeProcess.mos"
        "Simulate and plot"),
    experiment(
      StopTime=60,
      Tolerance=1e-06),
    Icon(
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(extent={{-120,-160},{120,160}})),
    Documentation(
      info="<html>
<p>
This model validates
<a href=\"modelica://Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess\">
Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess</a>
the enabling commands for heat reocory unit, external heating sources, 
and external cooling source based on 8 operation modes of Heating-1, 
Heating-2, Heating-3, Cooling-1, Cooling-2, Cooling-3, Cooling-4, and Cooling-5.
</p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end OperationModeProcess;
