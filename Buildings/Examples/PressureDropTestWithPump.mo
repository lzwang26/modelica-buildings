within Buildings.Examples;
model PressureDropTestWithPump

  extends Modelica.Icons.Example;

  package Medium = Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal = 0.1
    "Nominal flowrate in primary energy loop";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal_junctions[3] = {0.1, 0.1, -0.2}
    "Nominal flowrate in primary energy loop for junctions";
  parameter Modelica.Units.SI.Pressure dp_priEnergyFlow_nominal = 71737
    "Nominal pressure drop in primary energy loop";
  parameter Modelica.Units.SI.Pressure dp_priEnergyFlow_nominal_junctions[3] = {0, 0, 0}
    "Nominal pressure drop in primary energy loop for junctions";

  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    from_dp=false,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-36,-12},{-16,8}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov(
  redeclare package Medium = Medium,
  m_flow_nominal=m_priEnergyFlow_nominal,
      dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{24,-12},{44,8}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Media.Water,
    p=300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-34},{-78,-14}})));
  Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-34,-72},{-14,-52}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{20,-72},{40,-52}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    m_flow=0.1,
    nPorts=1)
    annotation (Placement(transformation(extent={{-90,-72},{-70,-52}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,-72},{68,-52}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=10000,
    duration=10,
    offset=70000,
    startTime=20)
    annotation (Placement(transformation(extent={{-30,46},{-10,66}})));
equation
  connect(mov.port_a, res.port_b) annotation (Line(points={{24,-2},{4,-2},{4,-2},
          {-16,-2}}, color={0,127,255}));
  connect(res.port_a, mov.port_b) annotation (Line(points={{-36,-2},{-42,-2},{-42,
          2},{-46,2},{-46,32},{58,32},{58,-2},{44,-2}}, color={0,127,255}));
  connect(bou2.ports[1], mov.port_a) annotation (Line(points={{-78,-24},{24,-24},
          {24,-2}},                         color={0,127,255}));
  connect(boundary.ports[1], res1.port_a)
    annotation (Line(points={{-70,-62},{-34,-62}}, color={0,127,255}));
  connect(res1.port_b, mov1.port_a)
    annotation (Line(points={{-14,-62},{20,-62}}, color={0,127,255}));
  connect(mov1.port_b, bou.ports[1])
    annotation (Line(points={{40,-62},{68,-62}}, color={0,127,255}));
  connect(ramp.y, mov.dp_in)
    annotation (Line(points={{-9,56},{34,56},{34,10}}, color={0,0,127}));
  connect(ramp.y, mov1.dp_in)
    annotation (Line(points={{-9,56},{30,56},{30,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PressureDropTestWithPump;
