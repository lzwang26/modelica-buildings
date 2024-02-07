within Buildings.Fluid.Humidifiers;
package BaseClasses "Package with base classes for Buildings.Fluid.Humidifiers"
    extends Modelica.Icons.BasesPackage;
  block WaterRemovalModifierCurve



    Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
            extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,20},
              {-100,60}})));
    Modelica.Blocks.Interfaces.RealOutput watRemMod
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Modelica.Blocks.Interfaces.RealInput phi
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));


    Examples.Data.DXDehumidifier per
      annotation (Placement(transformation(extent={{22,64},{42,84}})));
  equation
    watRemMod =Buildings.Utilities.Math.Functions.smoothMax(
        x1=Buildings.Utilities.Math.Functions.biquadratic(
          a=per.watRem,
          x1=Modelica.Units.Conversions.to_degC(T),
          x2=phi*100),
        x2=0.001,
        deltaX=0.0001);
            //x1=Modelica.Units.Conversions.to_degC(senTIn.T),
            //x2=senRelHum.phi*100

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end WaterRemovalModifierCurve;

  block EnergyFactorModifierCurve
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end EnergyFactorModifierCurve;

  package Example
    extends Modelica.Icons.ExamplesPackage;

    model WaterRemovalModifierCurve
      extends Modelica.Icons.Example;
      Sources.MassFlowSource_T boundary(
        redeclare package Medium = Media.Air,
        m_flow=1,
        T=293.15,
        nPorts=1) annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      Sources.Boundary_ph bou(redeclare package Medium = Media.Air, nPorts=1)
        annotation (Placement(transformation(extent={{2,-60},{22,-40}})));
      Sensors.TemperatureTwoPort senTem(redeclare package Medium = Media.Air,
          m_flow_nominal=1)
        annotation (Placement(transformation(extent={{-38,-20},{-18,0}})));
      Sensors.RelativeHumidityTwoPort senRelHum(redeclare package Medium =
            Media.Air, m_flow_nominal=1)
        annotation (Placement(transformation(extent={{2,-20},{22,0}})));
      Buildings.Fluid.Humidifiers.BaseClasses.WaterRemovalModifierCurve
        waterRemovalModifierCurve
        annotation (Placement(transformation(extent={{36,14},{56,34}})));
      Examples.Data.DXDehumidifier                             per
        "Data record for DX dehumidifier"
        annotation (Placement(transformation(extent={{42,62},{62,82}})));
    equation
      connect(boundary.ports[1], senTem.port_a)
        annotation (Line(points={{-60,-10},{-38,-10}}, color={0,127,255}));
      connect(senTem.port_b, senRelHum.port_a)
        annotation (Line(points={{-18,-10},{2,-10}}, color={0,127,255}));
      connect(senRelHum.port_b, bou.ports[1]) annotation (Line(points={{22,-10},{42,
              -10},{42,-50},{22,-50}}, color={0,127,255}));
      connect(senTem.T, waterRemovalModifierCurve.T)
        annotation (Line(points={{-28,1},{-28,28},{34,28}}, color={0,0,127}));
      connect(senRelHum.phi, waterRemovalModifierCurve.phi) annotation (Line(
            points={{12.1,1},{12.1,20},{34,20}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end WaterRemovalModifierCurve;
  end Example;
annotation (
  Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://Buildings.Fluid.Humidifiers\">
Buildings.Fluid.Humidifiers</a>.
</p>
</html>"));

end BaseClasses;
