within Buildings.Examples;
model PressureDropTest

  extends Modelica.Icons.Example;

  package Medium = Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal = 24.61
    "Nominal flowrate in primary energy loop";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal_junctions[3] = {0.1, 0.1, -0.2}
    "Nominal flowrate in primary energy loop for junctions";
  parameter Modelica.Units.SI.Pressure dp_priEnergyFlow_nominal = 71737
    "Nominal pressure drop in primary energy loop";
  parameter Modelica.Units.SI.Pressure dp_priEnergyFlow_nominal_junctions[3] = {1, 2, 3}
    "Nominal pressure drop in primary energy loop for junctions";

  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 371700,
    nPorts=1)
    annotation (Placement(transformation(extent={{62,30},{42,50}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{64,-36},{44,-16}})));
  Fluid.FixedResistances.PressureDrop res(
  redeclare package Medium = Medium,
  m_flow_nominal = m_priEnergyFlow_nominal,
  dp_nominal = dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-14,-2},{6,18}})));
equation
  connect(bou.ports[1], res.port_a) annotation (Line(points={{42,40},{8,40},{8,
          32},{-26,32},{-26,8},{-14,8}},
                                       color={0,127,255}));
  connect(res.port_b, bou1.ports[1]) annotation (Line(points={{6,8},{26,8},{26,
          -26},{44,-26}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PressureDropTest;
