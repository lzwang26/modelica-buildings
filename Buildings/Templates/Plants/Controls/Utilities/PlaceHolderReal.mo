within Buildings.Templates.Plants.Controls.Utilities;
block PlaceHolderReal "Output a placeholder signal"
  parameter Boolean have_inp=true
    "Set to true if input signal is available"
    annotation(Evaluate=true);
  parameter Boolean have_inpPla=false
    "Set to true if placeholder value is provided with input signal"
    annotation(Evaluate=true);
  parameter Real u_internal(start=0)
    "Placeholder value if input signal is not available"
    annotation(Dialog(enable=not have_inpPla));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u
    if have_inp
    "Input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uPla
    if not have_inp and have_inpPla
    "Input"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y
    "Output"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant pla(
    final k=u_internal)
    if not have_inp and not have_inpPla
    "Placeholder signal if input signal is not available"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
equation
  connect(u, y) annotation (Line(points={{-120,0},{120,0}}, color={0,0,127}));
  connect(pla.y, y) annotation (Line(points={{12,-80},{80,-80},{80,0},{120,0}},
        color={0,0,127}));
  connect(uPla, y) annotation (Line(points={{-120,-40},{60,-40},{60,0},{120,0}},
        color={0,0,127}));
annotation (
    defaultComponentName="pla",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=5.0,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235},
            if y then
              {0,255,0}
            else
              {235,235,235}),
          fillColor=DynamicSelect({235,235,235},
            if y then
              {0,255,0}
            else
              {235,235,235}),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-120,140},{-120,140}},
          lineColor={28,108,200}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}));
end PlaceHolderReal;
