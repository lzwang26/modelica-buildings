within Buildings.Controls.OBC.CDL.Discrete;
block TriggeredMovingMean
  "Triggered discrete moving mean of a sampled input signal"

  parameter Integer n(min=2)
    "Number of samples over which the input is averaged";
  parameter Modelica.SIunits.Time samplePeriod(min=1E-3)
    "Sampling period of component";

  Interfaces.RealInput u "Continuous input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.BooleanInput trigger
    "Input signal that triggers the block"
    annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-118})));
  Interfaces.RealOutput y "Discrete averaged signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));

protected
  parameter Modelica.SIunits.Time t0(fixed=false) "First sample time instant";
  Boolean sampleTrigger "Trigger samples at each sampling instant";
  Integer iSample(start=0, fixed=true) "Sample numbering in the simulation";
  Integer counter(start=0, fixed=true)
      "Number of samples used for averaging calculation";
  Integer index(start=0, fixed=true) "Index of the vector ySample";
  discrete Real ySample[n](
    start=vector(zeros(n,1)),
    each fixed=true)
      "Vector of samples to be averaged";

initial equation
  t0 = time;
  y = u;

equation
  sampleTrigger = sample(t0, samplePeriod);

algorithm
  when trigger and sampleTrigger then
    index := mod(iSample, n) + 1;
    ySample[index] := u;
    counter := if counter == n then n else counter + 1;
    y := sum(ySample)/counter;
    iSample := iSample + 1;
  end when;

  annotation (
  defaultComponentName="triMovMea",
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
       graphics={
       Rectangle(
       extent={{-100,-100},{100,100}},
       lineColor={0,0,127},
       fillColor={223,211,169},
       lineThickness=5.0,
       borderPattern=BorderPattern.Raised,
       fillPattern=FillPattern.Solid),
       Text(
       extent={{-150,150},{150,110}},
       textString="%name",
       lineColor={0,0,255}),
       Line(points={{-88,0},{70,0}}, color={192,192,192}),
       Polygon(
          points={{92,0},{70,8},{70,-8},{92,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
       Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
       Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
       Line(points={{-80,0},{-52,0}}, color={217,67,180}),
       Line(
          points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
              {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
              {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
              {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
              57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}},
          smooth=Smooth.Bezier,
          color={28,108,200}),
       Line(points={{-52,36},{-24,36}}, color={217,67,180}),
       Line(points={{-52,0},{-52,36}}, color={217,67,180}, smooth=Smooth.Bezier),
       Line(points={{-24,36},{-24,46}}, color={217,67,180}, smooth=Smooth.Bezier),
       Line(points={{-24,46},{4,46}}, color={217,67,180}),
       Line(points={{4,4},{32,4}}, color={217,67,180}),
       Line(points={{4,46},{4,4}}, color={217,67,180}, smooth=Smooth.Bezier),
       Line(points={{32,-32},{60,-32}}, color={217,67,180}),
       Line(points={{32,4},{32,-32}}, color={217,67,180}, smooth=Smooth.Bezier),
       Line(points={{60,-58},{82,-58}}, color={217,67,180}),
       Line(points={{60,-32},{60,-58}}, color={217,67,180},smooth=Smooth.Bezier),
        Ellipse(
          extent={{-25,-10},{-45,10}},
          lineColor={176,181,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{45,-10},{25,10}},
          lineColor={176,181,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-45,0}}, color={176,181,255}),
        Line(points={{45,0},{100,0}}, color={176,181,255}),
        Line(points={{-35,0},{28,-48}}, color={176,181,255}),
        Line(points={{0,-100},{0,-26}}, color={255,0,255})}),
Documentation(info="<html>
<p>
Block that outputs the sampled moving mean value of an input signal.
At each sampling instant, the block outputs the average value of the past <i>n</i>
samples including the current sample.
</p>
<p>
At the first sample, the block outputs the first sampled input. At the next
sample, it outputs the average of the past two samples, then the past three
samples and so on up to <i>n</i> samples.
</p>
<p>
The moving mean calculation of this block is the same as the block  <a href=\"modelica://Buildings.Controls.OBC.CDL.Discrete.MovingMean\">
Buildings.Controls.OBC.CDL.Discrete.MovingMean</a> except that this block does the calculation 
only when the trigger input signal is true. When the trigger signal is false, the block outputs 
the last calculated moving mean value.
</p>
</html>",
revisions="<html>
<ul>
<li>
October 16, 2019, by Kun Zhang:<br/>
First implementation. This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1588\">issue 1588</a>.
</li>
</ul>
</html>"));
end TriggeredMovingMean;
