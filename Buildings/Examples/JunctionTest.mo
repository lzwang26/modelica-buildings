within Buildings.Examples;
model JunctionTest

  extends Modelica.Icons.Example;

  package Medium = Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal = 0.1
    "Nominal flowrate in primary energy loop";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal_junctions[3] = {0.1, 0.1, -0.2}
    "Nominal flowrate in primary energy loop for junctions";
  parameter Modelica.Units.SI.Pressure dp_priEnergyFlow_nominal = 1
    "Nominal pressure drop in primary energy loop";
  parameter Modelica.Units.SI.Pressure dp_priEnergyFlow_nominal_junctions[3] = {1, 2, 3}
    "Nominal pressure drop in primary energy loop for junctions";

  Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
    p(displayUnit="bar") = 300200,
    nPorts=1)
    annotation (Placement(transformation(extent={{52,20},{32,40}})));
  Fluid.Sources.Boundary_pT bou1( redeclare package Medium = Medium,
    p(displayUnit="bar") = 300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{54,-46},{34,-26}})));

  Fluid.FixedResistances.Junction jun( redeclare package Medium = Medium,
  m_flow_nominal = m_priEnergyFlow_nominal_junctions,
  dp_nominal = dp_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-8,0},{12,20}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 300200,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,12},{-48,32}})));
equation
  connect(bou2.ports[1], jun.port_1) annotation (Line(points={{-48,22},{-28,22},
          {-28,10},{-8,10}}, color={0,127,255}));
  connect(jun.port_2, bou.ports[1]) annotation (Line(points={{12,10},{22,10},{22,
          30},{32,30}}, color={0,127,255}));
  connect(jun.port_3, bou1.ports[1]) annotation (Line(points={{2,0},{18,0},{18,-36},
          {34,-36}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end JunctionTest;
