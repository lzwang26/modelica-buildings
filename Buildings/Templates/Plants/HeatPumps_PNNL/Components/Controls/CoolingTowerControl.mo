within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block CoolingTowerControl
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 32.2)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Interface.CoolingTowerWHEBus bus annotation (Placement(transformation(extent={
            {-20,-120},{20,-80}}), iconTransformation(extent={{-128,-36},{-88,4}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(reverseActing=false)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(k=false)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)
    annotation (Placement(transformation(extent={{-8,20},{12,40}})));
  Modelica.Blocks.Routing.BooleanPassThrough booleanPassThrough
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
equation
  connect(con1.y, bus.condenserPumpBus.y1) annotation (Line(points={{-38,10},
          {0.1,10},{0.1,-99.9}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(con.y, conPID.u_s) annotation (Line(points={{-38,-30},{10,-30},{10,-10},
          {18,-10}}, color={0,0,127}));
  connect(bus.coolingTowerOutputTemp, conPID.u_m) annotation (Line(
      points={{0,-100},{0,-32},{30,-32},{30,-22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con1.y, logSwi.u1) annotation (Line(points={{-38,10},{-10,10},{-10,78},
          {-2,78}}, color={255,0,255}));
  connect(con2.y, logSwi.u3)
    annotation (Line(points={{-38,50},{-2,50},{-2,62}}, color={255,0,255}));
  connect(swi.y, bus.heatExchBus.y) annotation (Line(points={{42,40},{48,40},{
          48,-74},{0.1,-74},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID.y, swi.u1) annotation (Line(points={{42,-10},{50,-10},{50,56},
          {18,56},{18,48}}, color={0,0,127}));
  connect(swi.u3, con3.y)
    annotation (Line(points={{18,32},{18,30},{14,30}}, color={0,0,127}));
  connect(booleanPassThrough.y, logSwi.u2) annotation (Line(points={{-69,-10},{
          -20,-10},{-20,70},{-2,70}}, color={255,0,255}));
  connect(booleanPassThrough.y, swi.u2) annotation (Line(points={{-69,-10},{-20,
          -10},{-20,40},{18,40}}, color={255,0,255}));
  connect(bus.uEna, booleanPassThrough.u) annotation (Line(
      points={{0,-100},{0,-44},{-98,-44},{-98,-10},{-92,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end CoolingTowerControl;
