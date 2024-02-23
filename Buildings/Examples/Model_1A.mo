within Buildings.Examples;
model Model_1A

  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal = 0.1
    "Nominal flowrate in primary energy loop";
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal_junctions[3] = {0.1, 0.1, -0.2}
    "Nominal flowrate in primary energy loop for junctions";
  parameter Modelica.Units.SI.Pressure p_priEnergyFlow_nominal = 70000
    "Nominal pressure in primary energy loop";
  parameter Modelica.Units.SI.Pressure p_priEnergyFlow_nominal_valve = 0.1
    "Nominal pressure in primary energy loop";
  parameter Modelica.Units.SI.Pressure p_priEnergyFlow_nominal_junctions[3] = {0, 0, 0}
    "Nominal pressure in primary energy loop for junctions";

  Fluid.FixedResistances.Junction jun(redeclare package Medium = Media.Water,
  m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={140,110})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-140,140},{-120,160}})));
  Fluid.FixedResistances.Junction jun1(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{70,100},{90,120}})));
  Fluid.FixedResistances.Junction jun2(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Fluid.FixedResistances.Junction jun3(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-160,110})));
  Fluid.FixedResistances.Junction jun4(redeclare package Medium = Media.Water,
  m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={140,40})));
  Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={140,80})));
  Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium =
        Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={80,2})));
  Fluid.FixedResistances.Junction jun5(redeclare package Medium = Media.Water,
  m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={80,-40})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov1(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{156,-50},{136,-30}})));
  Fluid.FixedResistances.Junction jun6(redeclare package Medium = Media.Water,
  m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{170,30},{190,50}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={180,0})));
  Fluid.FixedResistances.Junction jun7(redeclare package Medium = Media.Water,
  m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={180,-40})));
  Fluid.FixedResistances.PressureDrop
                              res(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{80,140},{100,160}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov2(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-70,40})));
  Fluid.FixedResistances.Junction jun8(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-112,40})));
  Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-110,80})));
  Fluid.Actuators.Valves.TwoWayLinear val4(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-158,0})));
  Fluid.FixedResistances.Junction jun9(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-160,-40})));
  Fluid.FixedResistances.Junction jun10(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-200,30},{-180,50}})));
  Fluid.FixedResistances.Junction jun11(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-190,-40})));
  Fluid.Actuators.Valves.TwoWayLinear val5(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-198,4})));
  Fluid.Actuators.Valves.TwoWayLinear val6(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={310,0})));
  Fluid.FixedResistances.Junction jun12(redeclare package Medium = Media.Water, m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{300,30},{320,50}})));
  Fluid.FixedResistances.Junction jun13(redeclare package Medium = Media.Water, m_flow_nominal=m_priEnergyFlow_nominal_junctions,
  dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={310,-40})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov3(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{340,30},{360,50}})));
  Fluid.FixedResistances.Junction jun14(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-260,-40})));
  Fluid.FixedResistances.Junction jun15(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-270,30},{-250,50}})));
  Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-260,0})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov4(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-300,40})));
  Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Media.Water,
    p=370000,                    nPorts=1)
    annotation (Placement(transformation(extent={{-350,30},{-330,50}})));
  Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water,
    p=300000,                                                            nPorts=
       1)
    annotation (Placement(transformation(extent={{-350,-50},{-330,-30}})));
  Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{200,-100},{220,-80}})));
  Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{240,-100},{260,-80}})));
  Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=-1)
    annotation (Placement(transformation(extent={{-170,-100},{-150,-80}})));
  Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{-130,-100},{-110,-80}})));
  Fluid.FixedResistances.PressureDrop
                              res1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-38,30},{-18,50}})));
  Fluid.FixedResistances.PressureDrop
                              res2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Fluid.FixedResistances.PressureDrop
                              res3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-234,32},{-214,52}})));
  Fluid.FixedResistances.PressureDrop
                              res4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{230,30},{250,50}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-218,70},{-198,90}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{158,136},{178,156}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-98,170},{-78,190}})));
  Modelica.Blocks.Sources.Constant const3(k=70000)
    annotation (Placement(transformation(extent={{-168,172},{-148,192}})));
  Modelica.Blocks.Sources.Constant const4(k=1)
    annotation (Placement(transformation(extent={{-332,-10},{-312,10}})));
  Modelica.Blocks.Sources.Constant const5(k=1)
    annotation (Placement(transformation(extent={{-106,-8},{-86,12}})));
  Modelica.Blocks.Sources.Constant const6(k=70000)
    annotation (Placement(transformation(extent={{290,86},{310,106}})));
  Modelica.Blocks.Sources.Constant const7(k=70000)
    annotation (Placement(transformation(extent={{122,-4},{142,16}})));
  Fluid.FixedResistances.PressureDrop
                              res5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={388,2})));
  Fluid.Actuators.Valves.TwoWayLinear val8(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
        origin={110,110})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{80,166},{100,186}})));
  Fluid.Actuators.Valves.ThreeWayLinear val9( redeclare package Medium =
        Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{266,30},{286,50}})));
  Modelica.Blocks.Sources.Constant const9(k=1)
    annotation (Placement(transformation(extent={{234,88},{254,108}})));
equation
  connect(jun2.port_2, jun1.port_1)
    annotation (Line(points={{-100,110},{70,110}},
                                                color={0,127,255}));
  connect(jun3.port_3, jun2.port_1)
    annotation (Line(points={{-150,110},{-120,110}},
                                                 color={0,127,255}));
  connect(jun3.port_2, mov.port_a) annotation (Line(points={{-160,120},{-160,150},
          {-140,150}},        color={0,127,255}));
  connect(jun4.port_3, val.port_b)
    annotation (Line(points={{140,50},{140,70}},color={0,127,255}));
  connect(val.port_a, jun.port_2)
    annotation (Line(points={{140,90},{140,100}},color={0,127,255}));
  connect(val1.port_a, jun1.port_3)
    annotation (Line(points={{80,12},{80,100}}, color={0,127,255}));
  connect(jun5.port_3, val1.port_b)
    annotation (Line(points={{80,-30},{80,-8}},
                                              color={0,127,255}));
  connect(jun4.port_1, jun6.port_1)
    annotation (Line(points={{150,40},{170,40}},color={0,127,255}));
  connect(val2.port_a, jun6.port_3)
    annotation (Line(points={{180,10},{180,30}},          color={0,127,255}));
  connect(jun7.port_3, val2.port_b)
    annotation (Line(points={{180,-30},{180,-10}},
                                                color={0,127,255}));
  connect(mov.port_b,res. port_a)
    annotation (Line(points={{-120,150},{80,150}}, color={0,127,255}));
  connect(res.port_b, jun.port_1)
    annotation (Line(points={{100,150},{140,150},{140,120}},
                                                          color={0,127,255}));
  connect(jun8.port_1, mov2.port_b)
    annotation (Line(points={{-102,40},{-80,40}},  color={0,127,255}));
  connect(jun8.port_3, val3.port_b)
    annotation (Line(points={{-112,50},{-112,60},{-110,60},{-110,70}},
                                                    color={0,127,255}));
  connect(val3.port_a, jun2.port_3)
    annotation (Line(points={{-110,90},{-110,100}},  color={0,127,255}));
  connect(val4.port_a, jun3.port_1)
    annotation (Line(points={{-158,10},{-158,56},{-160,56},{-160,100}},
                                                    color={0,127,255}));
  connect(jun9.port_3, val4.port_b)
    annotation (Line(points={{-160,-30},{-160,-10},{-158,-10}},
                                                  color={0,127,255}));
  connect(jun10.port_2, jun8.port_2)
    annotation (Line(points={{-180,40},{-122,40}}, color={0,127,255}));
  connect(jun11.port_1, jun9.port_2)
    annotation (Line(points={{-180,-40},{-170,-40}}, color={0,127,255}));
  connect(val5.port_a, jun10.port_3)
    annotation (Line(points={{-198,14},{-198,20},{-190,20},{-190,30}},
                                                   color={0,127,255}));
  connect(val5.port_b, jun11.port_3)
    annotation (Line(points={{-198,-6},{-198,-20},{-190,-20},{-190,-30}},
                                                  color={0,127,255}));
  connect(jun12.port_3, val6.port_a)
    annotation (Line(points={{310,30},{310,10}}, color={0,127,255}));
  connect(jun7.port_1, jun13.port_2)
    annotation (Line(points={{190,-40},{300,-40}}, color={0,127,255}));
  connect(jun13.port_3, val6.port_b)
    annotation (Line(points={{310,-30},{310,-10}},
                                                color={0,127,255}));
  connect(jun12.port_2, mov3.port_a)
    annotation (Line(points={{320,40},{340,40}}, color={0,127,255}));
  connect(jun14.port_1, jun11.port_2)
    annotation (Line(points={{-250,-40},{-200,-40}}, color={0,127,255}));
  connect(val7.port_a, jun15.port_3)
    annotation (Line(points={{-260,10},{-260,30}}, color={0,127,255}));
  connect(val7.port_b, jun14.port_3)
    annotation (Line(points={{-260,-10},{-260,-30}}, color={0,127,255}));
  connect(mov4.port_a, jun15.port_1)
    annotation (Line(points={{-290,40},{-270,40}}, color={0,127,255}));
  connect(bou2.ports[1], mov4.port_b)
    annotation (Line(points={{-330,40},{-310,40}}, color={0,127,255}));
  connect(bou3.ports[1], jun14.port_2)
    annotation (Line(points={{-330,-40},{-270,-40}}, color={0,127,255}));
  connect(gai.u, val2.y_actual) annotation (Line(points={{198,-90},{194,-90},{194,
          -5},{187,-5}}, color={0,0,127}));
  connect(gai.y, addPar.u)
    annotation (Line(points={{222,-90},{238,-90}}, color={0,0,127}));
  connect(addPar.y, val6.y) annotation (Line(points={{262,-90},{340,-90},{340,0},
          {322,0}}, color={0,0,127}));
  connect(val.y_actual, val1.y) annotation (Line(points={{147,75},{147,60},{120,
          60},{120,2},{92,2}},  color={0,0,127}));
  connect(val3.y_actual, val4.y) annotation (Line(points={{-103,75},{-103,60},{-140,
          60},{-140,0},{-146,0}}, color={0,0,127}));
  connect(gai1.y, addPar1.u)
    annotation (Line(points={{-148,-90},{-132,-90}}, color={0,0,127}));
  connect(addPar1.y, val7.y) annotation (Line(points={{-108,-90},{-100,-90},{-100,
          -120},{-240,-120},{-240,0},{-248,0}}, color={0,0,127}));
  connect(val5.y_actual, gai1.u) annotation (Line(points={{-191,-1},{-191,-12},
          {-176,-12},{-176,-90},{-172,-90}},color={0,0,127}));
  connect(mov2.port_a, res1.port_a)
    annotation (Line(points={{-60,40},{-38,40}}, color={0,127,255}));
  connect(res1.port_b, jun9.port_1) annotation (Line(points={{-18,40},{-18,-38},
          {-150,-38},{-150,-40}}, color={0,127,255}));
  connect(res2.port_a, jun5.port_2) annotation (Line(points={{10,40},{10,-40},{70,
          -40}},                 color={0,127,255}));
  connect(jun15.port_2, res3.port_a) annotation (Line(points={{-250,40},{-242,
          40},{-242,42},{-234,42}}, color={0,127,255}));
  connect(res3.port_b, jun10.port_1) annotation (Line(points={{-214,42},{-208,
          42},{-208,40},{-200,40}}, color={0,127,255}));
  connect(const.y, val5.y) annotation (Line(points={{-197,80},{-182,80},{-182,
          76},{-180,76},{-180,4},{-186,4}}, color={0,0,127}));
  connect(const1.y, val2.y) annotation (Line(points={{179,146},{202,146},{202,0},
          {192,0}}, color={0,0,127}));
  connect(const1.y, val.y) annotation (Line(points={{179,146},{188,146},{188,80},
          {152,80}}, color={0,0,127}));
  connect(const2.y, val3.y) annotation (Line(points={{-77,180},{-64,180},{-64,
          80},{-98,80}}, color={0,0,127}));
  connect(const3.y, mov.dp_in) annotation (Line(points={{-147,182},{-138,182},{
          -138,172},{-130,172},{-130,162}}, color={0,0,127}));
  connect(const4.y, mov4.dp_in)
    annotation (Line(points={{-311,0},{-300,0},{-300,28}}, color={0,0,127}));
  connect(const5.y, mov2.dp_in) annotation (Line(points={{-85,2},{-76,2},{-76,
          28},{-70,28}}, color={0,0,127}));
  connect(const6.y, mov3.dp_in)
    annotation (Line(points={{311,96},{350,96},{350,52}}, color={0,0,127}));
  connect(const7.y, mov1.dp_in)
    annotation (Line(points={{143,6},{146,6},{146,-28}},
                                                       color={0,0,127}));
  connect(mov3.port_b, res5.port_a) annotation (Line(points={{360,40},{372,40},{
          372,42},{388,42},{388,12}}, color={0,127,255}));
  connect(res5.port_b, jun13.port_1) annotation (Line(points={{388,-8},{388,-40},
          {320,-40}}, color={0,127,255}));
  connect(jun.port_3, val8.port_b)
    annotation (Line(points={{130,110},{120,110}}, color={0,127,255}));
  connect(val8.port_a, jun1.port_2)
    annotation (Line(points={{100,110},{90,110}}, color={0,127,255}));
  connect(const8.y, val8.y)
    annotation (Line(points={{101,176},{110,176},{110,122}}, color={0,0,127}));
  connect(jun7.port_2, mov1.port_a)
    annotation (Line(points={{170,-40},{156,-40}}, color={0,127,255}));
  connect(mov1.port_b, jun5.port_1)
    annotation (Line(points={{136,-40},{90,-40}}, color={0,127,255}));
  connect(res2.port_b, jun4.port_2)
    annotation (Line(points={{30,40},{130,40}}, color={0,127,255}));
  connect(jun6.port_2, res4.port_a)
    annotation (Line(points={{190,40},{230,40}}, color={0,127,255}));
  connect(res4.port_b, val9.port_1)
    annotation (Line(points={{250,40},{266,40}}, color={0,127,255}));
  connect(val9.port_2, jun12.port_1)
    annotation (Line(points={{286,40},{300,40}}, color={0,127,255}));
  connect(val9.port_3, jun6.port_2) annotation (Line(points={{276,30},{276,16},{
          190,16},{190,40}}, color={0,127,255}));
  connect(const9.y, val9.y)
    annotation (Line(points={{255,98},{276,98},{276,52}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-360,-200},{360,200}})));
end Model_1A;
