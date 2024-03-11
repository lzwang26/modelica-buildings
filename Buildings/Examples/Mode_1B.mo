within Buildings.Examples;
model Mode_1B

  extends Modelica.Icons.Example;
  extends Buildings.Examples.HeatPumpPlant_baseclass(
    final hasSecondary=true);

  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-218,70},{-198,90}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-98,170},{-78,190}})));
  Modelica.Blocks.Sources.Constant const5(k=1)
    annotation (Placement(transformation(extent={{-106,-8},{-86,12}})));
  Modelica.Blocks.Sources.Constant const6(k=70000)
    annotation (Placement(transformation(extent={{290,86},{310,106}})));

  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{80,166},{100,186}})));

  Modelica.Blocks.Sources.Constant const9(k=1)
    annotation (Placement(transformation(extent={{234,88},{254,108}})));

  Modelica.Blocks.Sources.Constant const10(k=1)
    annotation (Placement(transformation(extent={{84,-28},{104,-8}})));

  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{160,120},{180,140}})));
  Modelica.Blocks.Sources.Constant const11(k=0)
    annotation (Placement(transformation(extent={{-340,-10},{-320,10}})));
equation
  connect(const.y, val5.y) annotation (Line(points={{-197,80},{-176,80},{-176,4},
          {-186,4}},                        color={0,0,127}));
  connect(const2.y, val3.y) annotation (Line(points={{-77,180},{-64,180},{-64,
          80},{-98,80}}, color={0,0,127}));
  connect(const5.y, mov2.dp_in) annotation (Line(points={{-85,2},{-76,2},{-76,
          28},{-70,28}}, color={0,0,127}));
  connect(const6.y, mov3.dp_in)
    annotation (Line(points={{311,96},{350,96},{350,32}}, color={0,0,127}));
  connect(const8.y, val8.y)
    annotation (Line(points={{101,176},{110,176},{110,122}}, color={0,0,127}));

  connect(const9.y, val9.y)
    annotation (Line(points={{255,98},{276,98},{276,32}}, color={0,0,127}));

  connect(const10.y, val2.y) annotation (Line(points={{105,-18},{114,-18},{114,-16},
          {66,-16}},
                   color={0,0,127}));

  connect(val5.y_actual, val7.y) annotation (Line(points={{-191,-1},{-191,-12},
          {-174,-12},{-174,-84},{-238,-84},{-238,0},{-248,0}}, color={0,0,127}));
  connect(const7.y, val.y) annotation (Line(points={{181,130},{190,130},{190,80},
          {152,80}}, color={0,0,127}));
  connect(const11.y, mov4.dp_in)
    annotation (Line(points={{-319,0},{-300,0},{-300,28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-360,-200},{360,200}})));
end Mode_1B;
