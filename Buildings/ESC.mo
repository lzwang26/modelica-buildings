within Buildings;
package ESC

  model ThermalComfortTest
    Utilities.Comfort.Fanger com(use_ICl_in=false)
      annotation (Placement(transformation(extent={{20,16},{40,36}})));
    Modelica.Blocks.Sources.Ramp TAir(
      duration=1,
      height=10,
      offset=273.15 + 20) "Air temperature"
                          annotation (Placement(
          transformation(extent={{-52,40},{-32,60}})));
    Modelica.Blocks.Sources.Constant TRad(k=273.15 + 22) "Radiation temperature"
      annotation (Placement(transformation(extent={{-50,-2},{-30,18}})));
    Modelica.Blocks.Sources.Constant phi(k=0.5) "Relative humidity"
      annotation (Placement(transformation(extent={{-48,-48},{-28,-28}})));
  equation
    connect(TAir.y, com.TAir) annotation (Line(points={{-31,50},{-6,50},{-6,36},
            {19,36}}, color={0,0,127}));
    connect(TRad.y, com.TRad) annotation (Line(points={{-29,8},{-4,8},{-4,32},{
            19,32}}, color={0,0,127}));
    connect(phi.y, com.phi) annotation (Line(points={{-27,-38},{4,-38},{4,28},{
            19,28}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ThermalComfortTest;

  model ESCTest
    Utilities.Comfort.Fanger com(use_ICl_in=false, M=60)
      annotation (Placement(transformation(extent={{-8,18},{12,38}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=1,
      f=0.001,
      offset=0)
      annotation (Placement(transformation(extent={{-80,32},{-60,52}})));
    Modelica.Blocks.Sources.Constant TRad(k=273.15 + 22) "Radiation temperature"
      annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
    Modelica.Blocks.Sources.Constant phi(k=0.5) "Relative humidity"
      annotation (Placement(visible = true, transformation(origin = {-6, -2}, extent = {{-74, -8}, {-54, 12}}, rotation = 0)));
    Modelica.Blocks.Continuous.Filter filter(filterType=Modelica.Blocks.Types.FilterType.HighPass, f_cut=
          0.0001)
      annotation (Placement(visible = true, transformation(origin={-14,-6},  extent = {{44, 20}, {64, 40}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{86,-10},{106,10}})));
    Modelica.Blocks.Continuous.Integrator integrator(k=-0.01, y_start=20 +
          273.15)
      annotation (Placement(transformation(extent={{134,-10},{154,10}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-32,50},{-12,70}})));
    Modelica.Blocks.Sources.Constant phi1(k=-273.15)
                                                "Relative humidity"
      annotation (Placement(visible = true, transformation(origin = {-54, -24}, extent = {{-26, -26}, {-6, -6}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant phi2(k=0)  "Relative humidity"
      annotation (Placement(visible = true, transformation(origin = {-48, 22}, extent = {{-28, 84}, {-8, 104}}, rotation = 0)));
  equation
    connect(TRad.y, com.TRad) annotation (Line(points={{-59,80},{-40,80},{-40,
            34},{-9,34}}, color={0,0,127}));
    connect(phi.y, com.phi) annotation (Line(points={{-59,0},{-30,0},{-30,30},{
            -9,30}}, color={0,0,127}));
    connect(com.PPD, filter.u) annotation (Line(points={{13,24},{28,24}},  color={0,0,127}));
    connect(filter.y, product1.u1) annotation (Line(points={{51,24},{78,24},{78,
            6},{84,6}},   color={0,0,127}));
    connect(product1.y, integrator.u) annotation (Line(points={{107,0},{132,0}},
                                  color={0,0,127}));
    connect(sine.y, add.u1) annotation (Line(points={{-59,42},{-46,42},{-46,66},
            {-34,66}}, color={0,0,127}));
    connect(add.y, com.TAir)
      annotation (Line(points={{-11,60},{-9,60},{-9,38}}, color={0,0,127}));
    connect(sine.y, product1.u2) annotation (Line(points={{-59,42},{-44,42},{
            -44,-6},{84,-6}},
                            color={0,0,127}));
    connect(integrator.y, add.u2) annotation (Line(points={{155,0},{192,0},{192,
            -78},{-34,-78},{-34,54}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ESCTest;

  model TwoObjectiveESC
    Utilities.Comfort.Fanger com_60(use_ICl_in=false, M=60)
      annotation (Placement(transformation(extent={{-40,18},{20,54}})));
    Utilities.Comfort.Fanger com_100(use_ICl_in=false, M=100)
      annotation (Placement(transformation(extent={{-40,-36},{28,2}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=1,
      f=0.1,
      offset=0)
      annotation (Placement(transformation(extent={{-212,42},{-192,62}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-90,36},{-70,56}})));
    Modelica.Blocks.Continuous.Filter filter(filterType=Modelica.Blocks.Types.FilterType.HighPass,
        f_cut=0.0001)
      annotation (Placement(visible = true, transformation(origin={98,2},    extent = {{44, 20}, {64, 40}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k=0.6)
      annotation (Placement(transformation(extent={{60,28},{80,48}})));
    Modelica.Blocks.Math.Gain gain1(k=0.4)
      annotation (Placement(transformation(extent={{60,-20},{80,0}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{102,22},{122,42}})));
    Modelica.Blocks.Sources.Constant TRad(k=273.15 + 22) "Radiation temperature"
      annotation (Placement(transformation(extent={{-96,-6},{-76,14}})));
    Modelica.Blocks.Sources.Constant phi(k=0.5) "Relative humidity"
      annotation (Placement(visible = true, transformation(origin={-20,-44},  extent = {{-74, -8}, {-54, 12}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{194,28},{214,48}})));
    Modelica.Blocks.Continuous.Integrator integrator(k=-0.05, y_start=20.5 +
          273.15)
      annotation (Placement(transformation(extent={{244,26},{264,46}})));
  equation
    connect(sine.y, add.u1)
      annotation (Line(points={{-191,52},{-92,52}}, color={0,0,127}));
    connect(com_60.PPD, gain.u) annotation (Line(points={{23,28.8},{40.5,28.8},
            {40.5,38},{58,38}}, color={0,0,127}));
    connect(com_100.PPD, gain1.u) annotation (Line(points={{31.4,-24.6},{44.7,
            -24.6},{44.7,-10},{58,-10}}, color={0,0,127}));
    connect(gain.y, add1.u1)
      annotation (Line(points={{81,38},{100,38}}, color={0,0,127}));
    connect(add1.y, filter.u)
      annotation (Line(points={{123,32},{140,32}}, color={0,0,127}));
    connect(gain1.y, add1.u2) annotation (Line(points={{81,-10},{90,-10},{90,26},
            {100,26}}, color={0,0,127}));
    connect(add.y, com_60.TAir) annotation (Line(points={{-69,46},{-56,46},{-56,
            54},{-43,54}}, color={0,0,127}));
    connect(add.y, com_100.TAir) annotation (Line(points={{-69,46},{-56,46},{
            -56,2},{-43.4,2}}, color={0,0,127}));
    connect(TRad.y, com_60.TRad) annotation (Line(points={{-75,4},{-58,4},{-58,
            46.8},{-43,46.8}}, color={0,0,127}));
    connect(TRad.y, com_100.TRad) annotation (Line(points={{-75,4},{-58,4},{-58,
            -5.6},{-43.4,-5.6}}, color={0,0,127}));
    connect(phi.y, com_60.phi) annotation (Line(points={{-73,-42},{-64,-42},{
            -64,39.6},{-43,39.6}}, color={0,0,127}));
    connect(phi.y, com_100.phi) annotation (Line(points={{-73,-42},{-64,-42},{
            -64,-13.2},{-43.4,-13.2}}, color={0,0,127}));
    connect(filter.y, product1.u2)
      annotation (Line(points={{163,32},{192,32}}, color={0,0,127}));
    connect(sine.y, product1.u1) annotation (Line(points={{-191,52},{-162,52},{
            -162,54},{-130,54},{-130,76},{182,76},{182,44},{192,44}}, color={0,
            0,127}));
    connect(product1.y, integrator.u) annotation (Line(points={{215,38},{228,38},
            {228,36},{242,36}}, color={0,0,127}));
    connect(integrator.y, add.u2) annotation (Line(points={{265,36},{268,36},{
            268,-78},{-128,-78},{-128,40},{-92,40}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TwoObjectiveESC;

  model ZoneTest
    ThermalZones.ReducedOrder.RC.OneElement theZon(redeclare package Medium =
          Media.Air)
      annotation (Placement(transformation(extent={{22,22},{70,58}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ZoneTest;
end ESC;
