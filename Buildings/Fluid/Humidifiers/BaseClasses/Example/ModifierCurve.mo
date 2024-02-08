within Buildings.Fluid.Humidifiers.BaseClasses.Example;
model ModifierCurve
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
  Buildings.Fluid.Humidifiers.BaseClasses.ModifierCurve ModifierCurve(per=per)
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
  connect(senTem.T, ModifierCurve.T)
    annotation (Line(points={{-28,1},{-28,28},{34,28}}, color={0,0,127}));
  connect(senRelHum.phi, ModifierCurve.phi)
    annotation (Line(points={{12.1,1},{12.1,20},{34,20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModifierCurve;
