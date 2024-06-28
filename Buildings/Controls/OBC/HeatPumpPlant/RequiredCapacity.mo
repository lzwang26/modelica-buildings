within Buildings.Controls.OBC.HeatPumpPlant;
block RequiredCapacity "Sequences for calculating required capacity"

  parameter Real rho_default(
    final min=0,
    final unit="kg/m3")=996
    "Density of fluid medium";

  parameter Real cp_default(
    final min=0,
    final unit="J/(kg.K)")=4184
    "Default specific heat capacity of fluid medium";

  parameter Real dtMea(
    final min=0,
    final unit="s")=300
    "Duration used to compute the moving average of required heating or cooling load";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupSet(
    final unit="K",
    displayUnit="degC")
    "Active supply temperature setpoint used to compute required capacity"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRet(
    final unit="K",
    displayUnit="degC")
    "Return temperature used to compute required capacity"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput V_flow(
    final unit="m3/s")
    "Volume flow rate used to compute required capacity"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yCapReq
    "Required capacity"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Reals.Subtract delT
    "Compute ∆T"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));

  Buildings.Controls.OBC.CDL.Reals.Abs absDelT
    "Compute absolute value of ∆T"
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter capFlo(
    final k=rho_default*cp_default)
    "Compute capacity flow rate"
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));

  Buildings.Controls.OBC.CDL.Reals.Multiply capReq
    "Compute required capacity"
    annotation (Placement(transformation(extent={{10,10},{30,30}})));

  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAve(
    final delta=dtMea)
    "Compute moving average"
    annotation (Placement(transformation(extent={{50,10},{70,30}})));

equation
  connect(delT.y,absDelT. u)
    annotation (Line(points={{-48,20},{-32,20}},    color={0,0,127}));
  connect(absDelT.y,capReq. u1)
    annotation (Line(points={{-8,20},{0,20},{0,26},{8,26}},               color={0,0,127}));
  connect(capFlo.y,capReq. u2)
    annotation (Line(points={{-8,-40},{0,-40},{0,14},{8,14}},
      color={0,0,127}));
  connect(TSupSet,delT. u1) annotation (Line(points={{-120,40},{-80,40},{-80,26},
          {-72,26}},             color={0,0,127}));
  connect(TRet,delT. u2) annotation (Line(points={{-120,0},{-80,0},{-80,14},{-72,
          14}},             color={0,0,127}));
  connect(V_flow,capFlo. u) annotation (Line(points={{-120,-40},{-32,-40}},
                                   color={0,0,127}));
  connect(capReq.y,movAve. u)
    annotation (Line(points={{32,20},{48,20}},     color={0,0,127}));
  connect(movAve.y, yCapReq) annotation (Line(points={{72,20},{80,20},{80,0},{120,
          0}}, color={0,0,127}));
  annotation (defaultComponentName="capReq",
    Icon(
      coordinateSystem(preserveAspectRatio=false),
      graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,140},{150,100}},
            textString="%name",
            textColor={0,0,255})}),
    Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(
      info="<html>
<p>
This block calculates the required capacity <code>yCapReq</code> 
based on the volume flow rate <code>V_flow</code>, 
supply temperature setpoint <code>TSupSet</code>, 
and return temperature <code>TRet</code>. 
</p>
</html>", revisions="<html>
<ul>
<li>
June 25, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end RequiredCapacity;
