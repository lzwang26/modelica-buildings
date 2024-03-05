within Buildings.Examples;
model JunctionTest

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

  Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
    p(displayUnit="bar") = 300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{82,66},{62,86}})));
  Fluid.Sources.Boundary_pT bou1( redeclare package Medium = Medium,
    p(displayUnit="bar") = 370000,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,-4},{64,16}})));

  Fluid.FixedResistances.Junction jun( redeclare package Medium = Medium,
    m_flow_nominal={24.61,24.61,-49.22},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-18,66},{2,86}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,38})));
  Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,40})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal={49.22,-24.61,-24.61},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-8,6})));
  Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-48})));
  Fluid.FixedResistances.PressureDrop res3(
    redeclare package Medium = Medium,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=dp_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-46})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 370000,
    nPorts=2)
    annotation (Placement(transformation(extent={{84,-94},{64,-74}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 300000,
    nPorts=2)
    annotation (Placement(transformation(extent={{84,-34},{64,-14}})));
equation
  connect(jun.port_2, bou.ports[1]) annotation (Line(points={{2,76},{62,76}},
                        color={0,127,255}));
  connect(res.port_b, jun.port_1)
    annotation (Line(points={{-70,48},{-70,76},{-18,76}}, color={0,127,255}));
  connect(res1.port_b, jun.port_3)
    annotation (Line(points={{-8,50},{-8,66}},
                                             color={0,127,255}));
  connect(bou1.ports[1], jun1.port_1)
    annotation (Line(points={{64,6},{2,6}},      color={0,127,255}));
  connect(jun1.port_3, res1.port_a)
    annotation (Line(points={{-8,16},{-8,30}}, color={0,127,255}));
  connect(jun1.port_2, res.port_a) annotation (Line(points={{-18,6},{-70,6},{
          -70,28}},  color={0,127,255}));
  connect(bou2.ports[1], res3.port_a) annotation (Line(points={{64,-82},{46,-82},
          {46,-86},{-8,-86},{-8,-56}}, color={0,127,255}));
  connect(bou2.ports[2], res2.port_a) annotation (Line(points={{64,-86},{-68,
          -86},{-68,-58}}, color={0,127,255}));
  connect(res2.port_b, bou3.ports[1]) annotation (Line(points={{-68,-38},{-68,
          -22},{64,-22}}, color={0,127,255}));
  connect(res3.port_b, bou3.ports[2])
    annotation (Line(points={{-8,-36},{-8,-26},{64,-26}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end JunctionTest;
