within Buildings.Examples;
model PressureDropTestWithPump

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

  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-36,-12},{-16,8}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov(
  redeclare package Medium = Medium,
  m_flow_nominal=24.61,
      dp_nominal=71737)
    annotation (Placement(transformation(extent={{24,-12},{44,8}})));
  Modelica.Blocks.Sources.Constant const3(k=71737)
    annotation (Placement(transformation(extent={{-12,46},{8,66}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Media.Water,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-20},{-76,0}})));
equation
  connect(mov.port_a, res.port_b) annotation (Line(points={{24,-2},{4,-2},{4,-2},
          {-16,-2}}, color={0,127,255}));
  connect(res.port_a, mov.port_b) annotation (Line(points={{-36,-2},{-42,-2},{-42,
          2},{-46,2},{-46,32},{58,32},{58,-2},{44,-2}}, color={0,127,255}));
  connect(const3.y, mov.dp_in)
    annotation (Line(points={{9,56},{34,56},{34,10}}, color={0,0,127}));
  connect(bou2.ports[1], mov.port_a) annotation (Line(points={{-76,-10},{-20,
          -10},{-20,-24},{24,-24},{24,-2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PressureDropTestWithPump;
