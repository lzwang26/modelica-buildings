within Buildings.Fluid.DXSystems.Heating.AirSource;
model SingleSpeed
  "Single speed DX heating coil"
  extends Buildings.Fluid.DXSystems.Heating.BaseClasses.PartialDXHeatingCoil;

  Modelica.Blocks.Interfaces.BooleanInput on
    "Set to true to enable compressor, or false to disable compressor"
    annotation (Placement(transformation(extent={{-120,110},{-100,130}}),
      iconTransformation(extent={{-120,70},{-100,90}})));

protected
  Modelica.Blocks.Sources.Constant speRat(
    final k=1)
    "Speed ratio 1 constant source"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  Modelica.Blocks.Math.BooleanToInteger onSwi(
    final integerTrue=1,
    final integerFalse=0)
    "On/off switch"
    annotation (Placement(transformation(extent={{-60,130},{-40,150}})));

initial equation
  assert(datCoi.nSta == 1, "Must have one stage only for single speed performance data.");

equation
  connect(speRat.y,dxCoi.speRat)  annotation (Line(
      points={{-59,80},{-32,80},{-32,59.6},{-21,59.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(on, onSwi.u) annotation (Line(
      points={{-110,120},{-80,120},{-80,140},{-62,140}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(onSwi.y,dxCoi.stage)  annotation (Line(
      points={{-39,140},{-24,140},{-24,62},{-21,62}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (defaultComponentName="sinSpeDXHea", Documentation(info="<html>
<p>
This model can be used to simulate an air-source DX heating coil with single speed compressor.
</p>
<p>
See
<a href=\"modelica://Buildings.Fluid.DXSystems.Heating.UsersGuide\">
Buildings.Fluid.DXSystems.Heating.UsersGuide</a>
for an explanation of the model.
</p>
</html>",
revisions="<html>
<ul>
<li>
May 31, 2023, by Michael Wetter:<br/>
Changed implementation to use <code>phi</code> rather than water vapor concentration
as input because the latter is not available on the weather data bus.
</li>
<li>
March 8, 2023, by Xing Lu and Karthik Devaprasad:<br/>
Initial implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={Text(
          extent={{-132,110},{-92,90}},
          textColor={0,0,255},
          textString="on"),Line(points={{-120,80},{-90,80},{-90,23.8672},{-4,24},
              {-4,2.0215},{8,2}},                                     color={217,
              67,180})}),
    Diagram(coordinateSystem(extent={{-100,-60},{100,160}})));
end SingleSpeed;
