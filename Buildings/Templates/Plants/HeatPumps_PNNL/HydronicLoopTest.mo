within Buildings.Templates.Plants.HeatPumps_PNNL;
model HydronicLoopTest

  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "HW or CHW medium";

     parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));

  parameter Boolean hasSecondary = false
    "True: Primary-secondary; False: Primary-only";

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
  Fluid.Movers.Preconfigured.SpeedControlled_y mov(redeclare package Medium =
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
        origin={140,20})));
  Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={140,80})));
  Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium =
        Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={80,76})));
  Fluid.FixedResistances.Junction jun5(redeclare package Medium = Media.Water,
  m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={54,-60})));
  Fluid.Movers.Preconfigured.SpeedControlled_y mov1(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{156,-70},{136,-50}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={54,-16})));
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
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal_valve) if not
    hasSecondary
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={310,-20})));
  Fluid.FixedResistances.Junction jun12(redeclare package Medium = Media.Water, m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{300,10},{320,30}})));
  Fluid.FixedResistances.Junction jun13(redeclare package Medium = Media.Water, m_flow_nominal=m_priEnergyFlow_nominal_junctions,
  dp_nominal = p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={310,-60})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov3(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal) if
    hasSecondary
    annotation (Placement(transformation(extent={{340,10},{360,30}})));
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
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
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
    annotation (Placement(transformation(extent={{230,10},{250,30}})));
  Fluid.FixedResistances.PressureDrop
                              res5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={388,-18})));
  Fluid.Actuators.Valves.TwoWayLinear val8(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
        origin={110,110})));
  Fluid.Actuators.Valves.ThreeWayLinear val9( redeclare package Medium =
        Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{266,10},{286,30}})));
  Fluid.FixedResistances.Junction jun16(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{44,10},{64,30}})));
  Fluid.FixedResistances.Junction jun17(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={80,20})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{184,10},{204,30}})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={230,-60})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo1(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={140,48})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo2(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{98,10},{118,30}})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo3(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={350,-60})));
  Fluid.Actuators.Valves.TwoWayLinear val10(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,
        origin={376,-60})));
  Modelica.Blocks.Sources.Constant const12(k=m_priEnergyFlow_nominal/1000)
    annotation (Placement(transformation(extent={{200,-100},{220,-80}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID
    annotation (Placement(transformation(extent={{240,-100},{260,-80}})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo4(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal) if hasSecondary
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={290,-26})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID1 if hasSecondary
    annotation (Placement(transformation(extent={{240,-140},{260,-120}})));
  Modelica.Blocks.Sources.Constant const1(k=0.01*m_priEnergyFlow_nominal) if
    hasSecondary
    annotation (Placement(transformation(extent={{200,-140},{220,-120}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID2
    annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-240,160},{-220,180}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{340,-120},{360,-100}})));
  Modelica.Blocks.Sources.Constant const4(k=1) if not hasSecondary
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Sources.Constant const5(k=0)
    annotation (Placement(transformation(extent={{-82,166},{-62,186}})));
  Modelica.Blocks.Sources.Constant const11(k=0)
    annotation (Placement(transformation(extent={{-342,-18},{-322,2}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-236,64},{-216,84}})));
  Modelica.Blocks.Sources.Constant const6(k=1)
    annotation (Placement(transformation(extent={{-104,-24},{-84,-4}})));
  Modelica.Blocks.Sources.Constant const10(k=1)
    annotation (Placement(transformation(extent={{70,-48},{90,-28}})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{98,164},{118,184}})));
  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{158,126},{178,146}})));
  Modelica.Blocks.Sources.Constant const9(k=1)
    annotation (Placement(transformation(extent={{240,74},{260,94}})));
  Modelica.Blocks.Sources.Constant const13(k=1)
    annotation (Placement(transformation(extent={{314,74},{334,94}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSupSet(k=datHpWw.TChiWatSup_nominal,
      y(final unit="K", displayUnit="degC")) "CHWST setpoint" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-242,-96})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1(
    table=[0,0; 0.5,1],
    timeScale=1000,
    period=3000)
    "Heat pump Enable signal"
    annotation (Placement(transformation(extent={{-354,-130},{-334,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1Hea(
    table=[0,0; 2,1],
    timeScale=1000,
    period=3000)
    "Heat pump heating mode signal"
    annotation (Placement(transformation(extent={{-354,-166},{-334,-146}})));
  Components.HeatPumps.WaterToWater                     hpWw(
    is_rev=true,
    show_T=true,
    redeclare final package MediumHeaWat = Medium,
    final dat=datHpWw,
    final energyDynamics=energyDynamics,
    have_preDroChiHeaWat=false,
    have_preDroSou=false)
    "Reversible WWHP - CHW/HW and source fluid pressure drops computed externally"
    annotation (Placement(transformation(extent={{-62,-306},{-42,-286}})));
  parameter Components.Data.HeatPump                     datHpWw(
    final cpHeaWat_default=hpWw.cpHeaWat_default,
    final cpSou_default=hpWw.cpSou_default,
    final typ=hpWw.typ,
    final is_rev=hpWw.is_rev,
    final typMod=hpWw.typMod,
    mHeaWat_flow_nominal=datHpWw.capHea_nominal/abs(datHpWw.THeaWatSup_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWat_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHea_nominal=500E3,
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWat_flow_nominal=datHpWw.capCoo_nominal/abs(datHpWw.TChiWatSup_nominal -
        Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCoo_nominal=500E3,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCoo_nominal=Buildings.Templates.Data.Defaults.TSouHpCoo,
    TSouHea_nominal=Buildings.Templates.Data.Defaults.TSouHpHea,
    dpSouWwHea_nominal=Buildings.Templates.Data.Defaults.dpChiWatChi,
    mSouWwCoo_flow_nominal=datHpWw.mSouWwHea_flow_nominal,
    mSouWwHea_flow_nominal=datHpWw.mHeaWat_flow_nominal,
    perFit(hea(
        P=datHpWw.capHea_nominal/Buildings.Templates.Data.Defaults.COPHpWwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpHea), coo(
        P=datHpWw.capCoo_nominal/Buildings.Templates.Data.Defaults.COPHpWwCoo,
        coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
        coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpCoo)))
    "Reversible WWHP parameters parameters"
    annotation (Placement(transformation(extent={{328,162},{348,182}})));

protected
  Components.Interfaces.Bus                     bus2 "HP control bus"
    annotation (Placement(transformation(extent={{-102,-276},{-62,-236}}),
      iconTransformation(extent={{-276,6},{-236,46}})));
equation
  connect(jun2.port_2, jun1.port_1)
    annotation (Line(points={{-100,110},{70,110}},
                                                color={0,127,255}));
  connect(jun3.port_3, jun2.port_1)
    annotation (Line(points={{-150,110},{-120,110}},
                                                 color={0,127,255}));
  connect(jun3.port_2, mov.port_a) annotation (Line(points={{-160,120},{-160,150},
          {-140,150}},        color={0,127,255}));
  connect(val.port_a, jun.port_2)
    annotation (Line(points={{140,90},{140,100}},color={0,127,255}));
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
    annotation (Line(points={{310,10},{310,-10}},color={0,127,255}));
  connect(jun13.port_3, val6.port_b)
    annotation (Line(points={{310,-50},{310,-30}},
                                                color={0,127,255}));
  connect(jun12.port_2, mov3.port_a)
    annotation (Line(points={{320,20},{340,20}}, color={0,127,255}));
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
  connect(val.y_actual, val1.y) annotation (Line(points={{147,75},{147,72},{160,
          72},{160,94},{110,94},{110,76},{92,76}},
                                color={0,0,127}));
  connect(val3.y_actual, val4.y) annotation (Line(points={{-103,75},{-103,60},{-140,
          60},{-140,0},{-146,0}}, color={0,0,127}));
  connect(mov2.port_a, res1.port_a)
    annotation (Line(points={{-60,40},{-38,40}}, color={0,127,255}));
  connect(jun15.port_2, res3.port_a) annotation (Line(points={{-250,40},{-242,
          40},{-242,42},{-234,42}}, color={0,127,255}));
  connect(res3.port_b, jun10.port_1) annotation (Line(points={{-214,42},{-208,
          42},{-208,40},{-200,40}}, color={0,127,255}));
  connect(mov3.port_b, res5.port_a) annotation (Line(points={{360,20},{372,20},{
          372,22},{388,22},{388,-8}}, color={0,127,255}));
  connect(jun.port_3, val8.port_b)
    annotation (Line(points={{130,110},{120,110}}, color={0,127,255}));
  connect(val8.port_a, jun1.port_2)
    annotation (Line(points={{100,110},{90,110}}, color={0,127,255}));
  connect(mov1.port_b, jun5.port_1)
    annotation (Line(points={{136,-60},{64,-60}}, color={0,127,255}));
  connect(res4.port_b, val9.port_1)
    annotation (Line(points={{250,20},{266,20}}, color={0,127,255}));
  connect(val9.port_2, jun12.port_1)
    annotation (Line(points={{286,20},{300,20}}, color={0,127,255}));
  connect(res2.port_b, jun16.port_1)
    annotation (Line(points={{30,20},{44,20}}, color={0,127,255}));
  connect(jun16.port_2, jun17.port_2)
    annotation (Line(points={{64,20},{70,20}}, color={0,127,255}));
  connect(jun17.port_3, val1.port_b)
    annotation (Line(points={{80,30},{80,66}}, color={0,127,255}));
  connect(val1.port_a, jun1.port_3)
    annotation (Line(points={{80,86},{80,100}}, color={0,127,255}));
  connect(jun5.port_3, val2.port_b)
    annotation (Line(points={{54,-50},{54,-26}},color={0,127,255}));
  connect(val2.port_a, jun16.port_3)
    annotation (Line(points={{54,-6},{54,10}}, color={0,127,255}));
  connect(jun4.port_1, jun6.port_1)
    annotation (Line(points={{150,20},{184,20}}, color={0,127,255}));
  connect(jun6.port_2, res4.port_a)
    annotation (Line(points={{204,20},{230,20}}, color={0,127,255}));
  connect(val9.port_3, jun6.port_3) annotation (Line(points={{276,10},{276,-22},
          {194,-22},{194,10}},color={0,127,255}));
  if not hasSecondary then
    connect(jun12.port_2, res5.port_a) annotation (Line(points={{320,20},{320,0},
            {388,0},{388,-8}},color={0,127,255}));
  end if;

  connect(mov1.port_a, senVolFlo.port_b)
    annotation (Line(points={{156,-60},{220,-60}}, color={0,127,255}));
  connect(senVolFlo.port_a, jun13.port_2)
    annotation (Line(points={{240,-60},{300,-60}}, color={0,127,255}));
  connect(val.port_b, senVolFlo1.port_a)
    annotation (Line(points={{140,70},{140,58}}, color={0,127,255}));
  connect(senVolFlo1.port_b, jun4.port_3)
    annotation (Line(points={{140,38},{140,30}}, color={0,127,255}));
  connect(jun17.port_1, senVolFlo2.port_a)
    annotation (Line(points={{90,20},{98,20}}, color={0,127,255}));
  connect(senVolFlo2.port_b, jun4.port_2)
    annotation (Line(points={{118,20},{130,20}}, color={0,127,255}));
  connect(senVolFlo3.port_b, jun13.port_1)
    annotation (Line(points={{340,-60},{320,-60}}, color={0,127,255}));
  connect(res5.port_b, val10.port_a) annotation (Line(points={{388,-28},{388,-60},
          {386,-60}}, color={0,127,255}));
  connect(val10.port_b, senVolFlo3.port_a)
    annotation (Line(points={{366,-60},{360,-60}}, color={0,127,255}));
  connect(senVolFlo.V_flow, conPID.u_m) annotation (Line(points={{230,-71},{230,
          -112},{250,-112},{250,-102}}, color={0,0,127}));
  connect(const12.y, conPID.u_s)
    annotation (Line(points={{221,-90},{238,-90}}, color={0,0,127}));
  connect(conPID.y, val6.y) annotation (Line(points={{262,-90},{330,-90},{330,-20},
          {322,-20}}, color={0,0,127}));
  connect(jun12.port_3, senVolFlo4.port_a)
    annotation (Line(points={{310,10},{290,10},{290,-16}}, color={0,127,255}));
  connect(senVolFlo4.port_b, jun13.port_3) annotation (Line(points={{290,-36},{290,
          -50},{310,-50}}, color={0,127,255}));
  connect(senVolFlo4.V_flow, conPID1.u_m) annotation (Line(points={{301,-26},{
          304,-26},{304,-150},{250,-150},{250,-142}}, color={0,0,127}));
  connect(const1.y, conPID1.u_s)
    annotation (Line(points={{221,-130},{238,-130}}, color={0,0,127}));
  connect(const2.y, conPID2.u_s)
    annotation (Line(points={{-219,170},{-202,170}}, color={0,0,127}));
  connect(conPID2.y, mov.y) annotation (Line(points={{-178,170},{-130,170},{
          -130,162}}, color={0,0,127}));
  connect(senVolFlo2.V_flow, conPID2.u_m) annotation (Line(points={{108,31},{
          108,66},{-190,66},{-190,158}}, color={0,0,127}));
  connect(const3.y, val10.y) annotation (Line(points={{361,-110},{376,-110},{
          376,-72}}, color={0,0,127}));
  connect(conPID1.y, mov1.y) annotation (Line(points={{262,-130},{280,-130},{
          280,-40},{146,-40},{146,-48}}, color={0,0,127}));
  connect(const4.y, mov1.y) annotation (Line(points={{121,-90},{130,-90},{130,
          -40},{146,-40},{146,-48}}, color={0,0,127}));
  connect(const5.y, val3.y) annotation (Line(points={{-61,176},{-50,176},{-50,84},
          {-98,84},{-98,80}}, color={0,0,127}));
  connect(const11.y, mov4.dp_in) annotation (Line(points={{-321,-8},{-310,-8},{-310,
          28},{-300,28}}, color={0,0,127}));
  connect(const.y, val5.y) annotation (Line(points={{-215,74},{-192,74},{-192,72},
          {-176,72},{-176,4},{-186,4}}, color={0,0,127}));
  connect(val5.y_actual, val7.y) annotation (Line(points={{-191,-1},{-191,-66},{
          -248,-66},{-248,0}}, color={0,0,127}));
  connect(const6.y, mov2.dp_in) annotation (Line(points={{-83,-14},{-83,6},{-70,
          6},{-70,28}}, color={0,0,127}));
  connect(const10.y, val2.y) annotation (Line(points={{91,-38},{98,-38},{98,-16},
          {66,-16}}, color={0,0,127}));
  connect(const8.y, val8.y) annotation (Line(points={{119,174},{126,174},{126,122},
          {110,122}}, color={0,0,127}));
  connect(const7.y, val.y) annotation (Line(points={{179,136},{194,136},{194,80},
          {152,80}}, color={0,0,127}));
  connect(const9.y, val9.y)
    annotation (Line(points={{261,84},{276,84},{276,32}}, color={0,0,127}));
  connect(const13.y, mov3.dp_in)
    annotation (Line(points={{335,84},{350,84},{350,32}}, color={0,0,127}));
  connect(bus2,hpWw. bus) annotation (Line(
      points={{-82,-256},{-52,-256},{-52,-286}},
      color={255,204,51},
      thickness=0.5));
  connect(y1.y[1],bus2. y1)
    annotation (Line(points={{-332,-120},{-212,-120},{-212,-256},{-82,-256}},
                                                                      color={255,0,255}));
  connect(y1Hea.y[1],bus2. y1Hea)
    annotation (Line(points={{-332,-156},{-212,-156},{-212,-256},{-82,-256}},
                                                                      color={255,0,255}));
  connect(TChiWatSupSet.y, bus2.TSet) annotation (Line(points={{-230,-96},{-162,
          -96},{-162,-124},{-82,-124},{-82,-256}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(jun5.port_2, hpWw.port_a) annotation (Line(points={{44,-60},{-70,-60},
          {-70,-296},{-62,-296}}, color={0,127,255}));
  connect(hpWw.port_b, res2.port_a) annotation (Line(points={{-42,-296},{-16,-296},
          {-16,-138},{10,-138},{10,20}}, color={0,127,255}));
  connect(res1.port_b, hpWw.port_aSou) annotation (Line(points={{-18,40},{-10,
          40},{-10,-306},{-42,-306}}, color={0,127,255}));
  connect(hpWw.port_bSou, jun9.port_1) annotation (Line(points={{-62,-306},{-82,
          -306},{-82,-220},{-150,-220},{-150,-40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-360,-200},{360,200}})));
end HydronicLoopTest;
