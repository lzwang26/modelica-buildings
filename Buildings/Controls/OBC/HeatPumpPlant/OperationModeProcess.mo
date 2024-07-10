within Buildings.Controls.OBC.HeatPumpPlant;
model OperationModeProcess "Sequences for operation mode process"

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod
    "Operation mode status signal"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHru
    "Heat recovery unit (HRU) enable command"
    annotation (Placement(transformation(extent={{80,60},{120,100}}),
      iconTransformation(extent={{80,20},{120,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yExtHea
    "External heating source enable command"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yExtCoo
    "External cooling source enable command"
    annotation (Placement(transformation(extent={{80,-100},{120,-60}}),
      iconTransformation(extent={{80,-60},{120,-20}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    "Check if current operation mode is Heating-1 mode"
    annotation (Placement(transformation(extent={{-20,140},{0,160}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1)
    "Heating-1 mode"
    annotation (Placement(transformation(extent={{-60,140},{-40,160}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2)
    "Heating-2 mode"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3)
    "Heating-3 mode"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1)
    "Cooling-1 mode"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
.Buildings.Controls.OBC.CDL.Integers.Sources.Constant  conInt4(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2)
    "Cooling-2 mode"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt5(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3)
    "Cooling-3mode"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt6(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4)
    "Cooling-4 mode"
    annotation (Placement(transformation(extent={{-60,-118},{-40,-98}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt7(
    k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_5)
    "Cooling-5 mode"
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    "Check if current operation mode is Heating-1 mode"
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    "Check if current operation mode is Heating-1 mode"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu3
    "Check if current operation mode is Cooling-1 mode"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu4
    "Check if current operation mode is Cooling-2 mode"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu5
    "Check if current operation mode is Cooling-3 mode"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu6
    "Check if current operation mode is Cooling-4 mode"
    annotation (Placement(transformation(extent={{-20,-118},{0,-98}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu7
    "Check if current operation mode is Cooling-5 mode"
    annotation (Placement(transformation(extent={{-20,-160},{0,-140}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(nin=6)
    "Check if one of inputs is true"
    annotation (Placement(transformation(extent={{50,70},{70,90}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr1(nin=2)
    "Check if one of inputs is true"
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr2(nin=4)
    "Check if one of inputs is true"
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));

equation
  connect(uOpeMod, intEqu.u2) annotation (Line(points={{-100,0},{-30,0},{-30,142},
          {-22,142}},  color={255,127,0}));
  connect(conInt.y, intEqu.u1) annotation (Line(points={{-38,150},{-22,150}},
                                                  color={255,127,0}));
  connect(uOpeMod, intEqu1.u2) annotation (Line(points={{-100,0},{-30,0},{-30,102},
          {-22,102}}, color={255,127,0}));
  connect(uOpeMod, intEqu2.u2) annotation (Line(points={{-100,0},{-30,0},{-30,62},
          {-22,62}},  color={255,127,0}));
  connect(uOpeMod, intEqu3.u2) annotation (Line(points={{-100,0},{-30,0},{-30,22},
          {-22,22}}, color={255,127,0}));
  connect(conInt4.y, intEqu4.u1)
    annotation (Line(points={{-38,-30},{-22,-30}}, color={255,127,0}));
  connect(conInt5.y, intEqu5.u1)
    annotation (Line(points={{-38,-70},{-22,-70}},   color={255,127,0}));
  connect(conInt3.y, intEqu3.u1)
    annotation (Line(points={{-38,30},{-22,30}}, color={255,127,0}));
  connect(conInt1.y, intEqu1.u1)
    annotation (Line(points={{-38,110},{-22,110}}, color={255,127,0}));
  connect(conInt2.y, intEqu2.u1)
    annotation (Line(points={{-38,70},{-22,70}},   color={255,127,0}));
  connect(conInt7.y, intEqu7.u1)
    annotation (Line(points={{-38,-150},{-22,-150}}, color={255,127,0}));
  connect(conInt6.y, intEqu6.u1)
    annotation (Line(points={{-38,-108},{-22,-108}}, color={255,127,0}));
  connect(uOpeMod, intEqu4.u2) annotation (Line(points={{-100,0},{-30,0},{-30,-38},
          {-22,-38}}, color={255,127,0}));
  connect(uOpeMod, intEqu5.u2) annotation (Line(points={{-100,0},{-30,0},{-30,-78},
          {-22,-78}},  color={255,127,0}));
  connect(uOpeMod, intEqu6.u2) annotation (Line(points={{-100,0},{-30,0},{-30,-116},
          {-22,-116}}, color={255,127,0}));
  connect(uOpeMod, intEqu7.u2) annotation (Line(points={{-100,0},{-30,0},{-30,-158},
          {-22,-158}}, color={255,127,0}));
  connect(mulOr.y, yHru)
    annotation (Line(points={{72,80},{100,80}},  color={255,0,255}));
  connect(mulOr1.y, yExtHea)
    annotation (Line(points={{72,0},{100,0}},  color={255,0,255}));
  connect(mulOr2.y, yExtCoo)
    annotation (Line(points={{72,-80},{100,-80}},  color={255,0,255}));
  connect(intEqu.y, mulOr.u[1]) annotation (Line(points={{2,150},{40,150},{40,
          77.0833},{48,77.0833}}, color={255,0,255}));
  connect(intEqu1.y, mulOr.u[2]) annotation (Line(points={{2,110},{30,110},{30,78.25},
          {48,78.25}},        color={255,0,255}));
  connect(intEqu2.y, mulOr.u[3]) annotation (Line(points={{2,70},{20,70},{20,
          79.4167},{48,79.4167}},
                         color={255,0,255}));
  connect(intEqu4.y, mulOr.u[4]) annotation (Line(points={{2,-30},{26,-30},{26,
          82},{48,82},{48,80.5833}}, color={255,0,255}));
  connect(intEqu5.y, mulOr.u[5]) annotation (Line(points={{2,-70},{40,-70},{40,81.75},
          {48,81.75}},        color={255,0,255}));
  connect(intEqu7.y, mulOr.u[6]) annotation (Line(points={{2,-150},{40,-150},{
          40,82.9167},{48,82.9167}}, color={255,0,255}));
  connect(intEqu1.y, mulOr1.u[1]) annotation (Line(points={{2,110},{30,110},{30,
          -1.75},{48,-1.75}}, color={255,0,255}));
  connect(intEqu2.y, mulOr1.u[2]) annotation (Line(points={{2,70},{20,70},{20,2},
          {34,2},{34,1.75},{48,1.75}},
                            color={255,0,255}));
  connect(intEqu3.y, mulOr2.u[1]) annotation (Line(points={{2,30},{12,30},{12,-82.625},
          {48,-82.625}},          color={255,0,255}));
  connect(intEqu5.y, mulOr2.u[2]) annotation (Line(points={{2,-70},{20,-70},{20,
          -80.875},{48,-80.875}}, color={255,0,255}));
  connect(intEqu6.y, mulOr2.u[3]) annotation (Line(points={{2,-108},{20,-108},{20,
          -79.125},{48,-79.125}},     color={255,0,255}));
  connect(intEqu7.y, mulOr2.u[4]) annotation (Line(points={{2,-150},{30,-150},{30,
          -77.375},{48,-77.375}},     color={255,0,255}));
annotation (
    defaultComponentName="opeModPro",
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-80,-100},{80,100}}),
      graphics={
        Rectangle(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-146,138},{154,98}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-80,-180},{80,180}})),
    Documentation(
      info="<html>
<p>
This block implements the control sequences of operation mode process for water-to-water 
heat pump plants. It includes the sequences for enabling heat recovery unit (HRU), external heating source,
and external cooling source.
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
