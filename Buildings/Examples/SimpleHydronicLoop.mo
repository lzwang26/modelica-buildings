within Buildings.Examples;
model SimpleHydronicLoop


  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal_junctions[3] = {0.1, 0.1, -0.2}
    "Nominal flowrate in primary energy loop for junctions";

  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Media.Water,
    p(displayUnit="bar") = 300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-72,18},{-52,38}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={60,28})));
  Fluid.FixedResistances.Junction jun(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal={1,2,3})
    annotation (Placement(transformation(extent={{-12,18},{8,38}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Media.Water,
    p(displayUnit="bar") = 300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-52},{-48,-32}})));
equation
  connect(bou2.ports[1], jun.port_1)
    annotation (Line(points={{-52,28},{-12,28}}, color={0,127,255}));
  connect(jun.port_2, bou1.ports[1])
    annotation (Line(points={{8,28},{50,28}}, color={0,127,255}));
  connect(bou3.ports[1], jun.port_3) annotation (Line(points={{-48,-42},{-26,-42},
          {-26,18},{-2,18}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleHydronicLoop;
