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

  model SingleObjectiveESCTest
    Utilities.Comfort.Fanger com(use_ICl_in=false, M=60)
      annotation (Placement(transformation(extent={{-16,26},{4,46}})));
    Modelica.Blocks.Continuous.Filter filter(filterType=Modelica.Blocks.Types.FilterType.HighPass,
        f_cut=20)
      annotation (Placement(transformation(extent={{22,22},{42,42}})));
    Modelica.Blocks.Sources.Sine sine(f=10, offset=20 + 273.15)
      annotation (Placement(transformation(extent={{-92,36},{-72,56}})));
    Modelica.Blocks.Sources.Constant TRad(k=273.15 + 22) "Radiation temperature"
      annotation (Placement(transformation(extent={{-92,72},{-72,92}})));
    Modelica.Blocks.Sources.Constant phi(k=0.5) "Relative humidity"
      annotation (Placement(transformation(extent={{-58,80},{-38,100}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{56,-2},{76,18}})));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{134,-40},{154,-20}})));
    Modelica.Blocks.Math.Gain gain(k=1)
      annotation (Placement(transformation(extent={{208,-66},{228,-46}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-46,12},{-26,32}})));
  equation
    connect(TRad.y, com.TRad) annotation (Line(points={{-71,82},{-28,82},{-28,
            42},{-17,42}}, color={0,0,127}));
    connect(phi.y, com.phi) annotation (Line(points={{-37,90},{-30,90},{-30,38},
            {-17,38}}, color={0,0,127}));
    connect(filter.y, product1.u1) annotation (Line(points={{43,32},{48,32},{48,
            14},{54,14}}, color={0,0,127}));
    connect(sine.y, product1.u2) annotation (Line(points={{-71,46},{-62,46},{
            -62,2},{54,2}}, color={0,0,127}));
    connect(com.PPD, filter.u)
      annotation (Line(points={{5,32},{20,32}}, color={0,0,127}));
    connect(gain.y, add.u2) annotation (Line(points={{229,-56},{-66,-56},{-66,
            16},{-48,16}}, color={0,0,127}));
    connect(sine.y, add.u1) annotation (Line(points={{-71,46},{-60,46},{-60,28},
            {-48,28}}, color={0,0,127}));
    connect(add.y, com.TAir) annotation (Line(points={{-25,22},{-20,22},{-20,46},
            {-17,46}}, color={0,0,127}));
    connect(integrator.y, gain.u) annotation (Line(points={{155,-30},{162,-30},
            {162,-56},{206,-56}}, color={0,0,127}));
    connect(product1.y, integrator.u) annotation (Line(points={{77,8},{104,8},{
            104,-30},{132,-30}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
  end SingleObjectiveESCTest;
end ESC;
