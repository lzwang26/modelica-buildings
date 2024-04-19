within Buildings.Templates.Plants.HeatPumps_PNNL.Validation;
model ValvesIsolation_OnHydronicLoop
  "Validation model for isolation valve component"

   parameter Boolean hasSecondary = false
    "True: Primary-secondary; False: Primary-only";

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


  extends Modelica.Icons.Example;
  parameter Buildings.Templates.Plants.HeatPumps.Types.Controller typCtl=
    Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CHW/HW medium";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlHeaInl(
    cfg(
      have_pumHeaWatPriVar=true,
      have_pumChiWatPriVar=false,
      have_inpSch=false,
      have_hrc=false,
      have_valHpOutIso=valIsoHeaInl.have_valHpOutIso,
      have_valHpInlIso=valIsoHeaInl.have_valHpInlIso,
      have_chiWat=valIsoHeaInl.have_chiWat,
      have_pumChiWatPriDed=valIsoHeaInl.have_pumChiWatPriDed,
      typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
      typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
      is_rev=false,
      typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
      nPumChiWatSec=0,
      rhoHeaWat_default=Buildings.Media.Water.d_const,
      typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
      typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
      rhoChiWat_default=Buildings.Media.Water.d_const,
      cpChiWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      have_hotWat=false,
      have_valChiWatMinByp=false,
      have_valHeaWatMinByp=false,
      typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
      cpHeaWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      cpSou_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      have_senDpChiWatRemWir=true,
      typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
      nHp=2,
      nPumHeaWatPri=2,
      have_heaWat=true,
      nPumHeaWatSec=0,
      rhoSou_default=Buildings.Media.Air.dStp,
      have_senDpHeaWatRemWir=true,
      typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      nPumChiWatPri=0,
      nSenDpHeaWatRem=0,
      nSenDpChiWatRem=0,
      nAirHan=0,
      nEquZon=0),
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
        dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlHeaInl.cfg.nSenDpChiWatRem),
    dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlHeaInl.cfg.nSenDpHeaWatRem),
    staEqu={fill(1, datCtlHeaInl.cfg.nHp)})
    "Controller parameters"
    annotation (Placement(transformation(extent={{-44,356},{-24,376}})));
  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHp(
    final nHp=2,
    final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
    final is_rev=true,
    final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
    mHeaWatHp_flow_nominal=datHp.capHeaHp_nominal / abs(datHp.THeaWatSupHp_nominal -
      Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=500E3,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mChiWatHp_flow_nominal=datHp.capCooHp_nominal / abs(datHp.TChiWatSupHp_nominal -
      Buildings.Templates.Data.Defaults.TChiWatRet) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCooHp_nominal=500E3,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
    perFitHp(
      hea(
        P=datHp.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
        coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow),
      coo(
        P=datHp.capCooHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwCoo,
        coeQ={- 2.2545246871, 6.9089257665, - 3.6548225094, 0, 0},
        coeP={- 5.8086010402, 1.6894933858, 5.1167787436, 0, 0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
    "HP parameters"
    annotation (Placement(transformation(extent={{-252,356},{-232,376}})));
  Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation valIsoHeaInl(
    redeclare final package Medium = Medium,
    nHp=2,
    have_chiWat=false,
    have_pumChiWatPriDed=false,
    have_valHpInlIso=true,
    have_valHpOutIso=false,
    final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal, valIsoHeaInl.nHp),
    dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
    mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
    final energyDynamics=energyDynamics,
    y_start=0)
    "Isolation valves - Heating-only system with isolation valves at HP inlet"
    annotation (Placement(transformation(extent={{-204,206},{276,346}})));
  Fluid.FixedResistances.PressureDrop hpHea[valIsoHeaInl.nHp](
    redeclare each final package Medium=Medium,
    m_flow_nominal=valIsoHeaInl.mHeaWatHp_flow_nominal,
    dp_nominal=fill(0, valIsoHeaInl.nHp))
    "Heat pump HX with zero fluid resistance: pressure drop computed in valve component"
    annotation (Placement(transformation(extent={{46,196},{26,216}})));
  Buildings.Templates.Plants.HeatPumps.Components.Controls.OpenLoop ctlHeaInl(
    final cfg=datCtlHeaInl.cfg,
    final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{6,356},{-14,376}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={138,44})));
  Fluid.Movers.Preconfigured.SpeedControlled_y mov(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-142,74},{-122,94}})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{68,34},{88,54}})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-122,34},{-102,54}})));
  Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-162,44})));
  Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={138,-46})));
  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={138,14})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={78,10})));
  Fluid.FixedResistances.Junction jun5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={52,-126})));
  Fluid.Movers.Preconfigured.SpeedControlled_y mov1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{154,-136},{134,-116}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={52,-82})));
  Fluid.FixedResistances.PressureDrop
                              res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{78,74},{98,94}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-72,-26})));
  Fluid.FixedResistances.Junction jun8(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-114,-26})));
  Fluid.Actuators.Valves.TwoWayLinear val3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-112,14})));
  Fluid.Actuators.Valves.TwoWayLinear val4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-160,-66})));
  Fluid.FixedResistances.Junction jun9(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-162,-106})));
  Fluid.FixedResistances.Junction jun10(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-202,-36},{-182,-16}})));
  Fluid.FixedResistances.Junction jun11(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-192,-106})));
  Fluid.Actuators.Valves.TwoWayLinear val5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-200,-62})));
  Fluid.Actuators.Valves.TwoWayLinear val6(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve) if                                                            not
    hasSecondary
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={308,-86})));
  Fluid.FixedResistances.Junction jun12(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{298,-56},{318,-36}})));
  Fluid.FixedResistances.Junction jun13(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={308,-126})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal) if
    hasSecondary
    annotation (Placement(transformation(extent={{338,-56},{358,-36}})));
  Fluid.FixedResistances.Junction jun14(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-262,-106})));
  Fluid.FixedResistances.Junction jun15(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-272,-36},{-252,-16}})));
  Fluid.Actuators.Valves.TwoWayLinear val7(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-262,-66})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-302,-26})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Media.Water,
    p=370000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-352,-36},{-332,-16}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Media.Water,
    p=300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-352,-116},{-332,-96}})));
  Fluid.FixedResistances.PressureDrop
                              res1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-40,-36},{-20,-16}})));
  Fluid.FixedResistances.PressureDrop
                              res3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-236,-34},{-216,-14}})));
  Fluid.FixedResistances.PressureDrop
                              res4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{228,-56},{248,-36}})));
  Fluid.FixedResistances.PressureDrop
                              res5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={386,-84})));
  Fluid.Actuators.Valves.TwoWayLinear val8(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
        origin={108,44})));
  Fluid.Actuators.Valves.ThreeWayLinear val9(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{264,-56},{284,-36}})));
  Fluid.FixedResistances.Junction jun16(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{42,-56},{62,-36}})));
  Fluid.FixedResistances.Junction jun17(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={78,-46})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{182,-56},{202,-36}})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={228,-126})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo1(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={138,-18})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo2(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{96,-56},{116,-36}})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo3(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={348,-126})));
  Fluid.Actuators.Valves.TwoWayLinear val10(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal_valve)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,
        origin={374,-126})));
  Fluid.Sensors.VolumeFlowRate
                             senVolFlo4(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal) if hasSecondary
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={288,-92})));
  Modelica.Blocks.Sources.Constant const2(k=70000)
    annotation (Placement(transformation(extent={{-216,112},{-196,132}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{338,-186},{358,-166}})));
  Modelica.Blocks.Sources.Constant const4(k=70000) if
                                                  not hasSecondary
    annotation (Placement(transformation(extent={{102,-110},{122,-90}})));
  Modelica.Blocks.Sources.Constant const5(k=0)
    annotation (Placement(transformation(extent={{192,52},{212,72}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-90,52},{-70,72}})));
  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{-290,42},{-270,62}})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{-110,-84},{-90,-64}})));
  Modelica.Blocks.Sources.Constant const9(k=0)
    annotation (Placement(transformation(extent={{-334,-84},{-314,-64}})));
  Modelica.Blocks.Sources.Constant const10(k=0)
    annotation (Placement(transformation(extent={{74,-120},{94,-100}})));
  Modelica.Blocks.Sources.Constant const11(k=70000)
    annotation (Placement(transformation(extent={{314,-14},{334,6}})));
  Modelica.Blocks.Sources.Constant const13(k=0)
    annotation (Placement(transformation(extent={{234,-14},{254,6}})));
  Modelica.Blocks.Sources.Constant const14(k=0)
    annotation (Placement(transformation(extent={{82,122},{102,142}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{296,46},{316,66}})));
equation
  connect(ctlHeaInl.bus, valIsoHeaInl.bus)
    annotation (Line(points={{6,366},{36,366},{36,316}},   color={255,204,51},thickness=0.5));
  connect(valIsoHeaInl.ports_bChiHeaWatHp, hpHea.port_a)
    annotation (Line(points={{86,206},{46,206}},        color={0,127,255}));
  connect(hpHea.port_b, valIsoHeaInl.ports_aChiHeaWatHp)
    annotation (Line(points={{26,206},{-14,206}},         color={0,127,255}));
  connect(jun2.port_2,jun1. port_1)
    annotation (Line(points={{-102,44},{68,44}},color={0,127,255}));
  connect(jun3.port_3,jun2. port_1)
    annotation (Line(points={{-152,44},{-122,44}},
                                                 color={0,127,255}));
  connect(jun3.port_2,mov. port_a) annotation (Line(points={{-162,54},{-162,84},
          {-142,84}},         color={0,127,255}));
  connect(val.port_a,jun. port_2)
    annotation (Line(points={{138,24},{138,34}}, color={0,127,255}));
  connect(mov.port_b,res. port_a)
    annotation (Line(points={{-122,84},{78,84}},   color={0,127,255}));
  connect(res.port_b,jun. port_1)
    annotation (Line(points={{98,84},{138,84},{138,54}},  color={0,127,255}));
  connect(jun8.port_1,mov2. port_b)
    annotation (Line(points={{-104,-26},{-82,-26}},color={0,127,255}));
  connect(jun8.port_3,val3. port_b)
    annotation (Line(points={{-114,-16},{-114,-6},{-112,-6},{-112,4}},
                                                    color={0,127,255}));
  connect(val3.port_a,jun2. port_3)
    annotation (Line(points={{-112,24},{-112,34}},   color={0,127,255}));
  connect(val4.port_a,jun3. port_1)
    annotation (Line(points={{-160,-56},{-160,-10},{-162,-10},{-162,34}},
                                                    color={0,127,255}));
  connect(jun9.port_3,val4. port_b)
    annotation (Line(points={{-162,-96},{-162,-76},{-160,-76}},
                                                  color={0,127,255}));
  connect(jun10.port_2,jun8. port_2)
    annotation (Line(points={{-182,-26},{-124,-26}},
                                                   color={0,127,255}));
  connect(jun11.port_1,jun9. port_2)
    annotation (Line(points={{-182,-106},{-172,-106}},
                                                     color={0,127,255}));
  connect(val5.port_a,jun10. port_3)
    annotation (Line(points={{-200,-52},{-200,-46},{-192,-46},{-192,-36}},
                                                   color={0,127,255}));
  connect(val5.port_b,jun11. port_3)
    annotation (Line(points={{-200,-72},{-200,-86},{-192,-86},{-192,-96}},
                                                  color={0,127,255}));
  connect(jun12.port_3,val6. port_a)
    annotation (Line(points={{308,-56},{308,-76}},
                                                 color={0,127,255}));
  connect(jun13.port_3,val6. port_b)
    annotation (Line(points={{308,-116},{308,-96}},
                                                color={0,127,255}));
  connect(jun12.port_2,mov3. port_a)
    annotation (Line(points={{318,-46},{338,-46}},
                                                 color={0,127,255}));
  connect(jun14.port_1,jun11. port_2)
    annotation (Line(points={{-252,-106},{-202,-106}},
                                                     color={0,127,255}));
  connect(val7.port_a,jun15. port_3)
    annotation (Line(points={{-262,-56},{-262,-36}},
                                                   color={0,127,255}));
  connect(val7.port_b,jun14. port_3)
    annotation (Line(points={{-262,-76},{-262,-96}}, color={0,127,255}));
  connect(mov4.port_a,jun15. port_1)
    annotation (Line(points={{-292,-26},{-272,-26}},
                                                   color={0,127,255}));
  connect(bou2.ports[1],mov4. port_b)
    annotation (Line(points={{-332,-26},{-312,-26}},
                                                   color={0,127,255}));
  connect(bou3.ports[1],jun14. port_2)
    annotation (Line(points={{-332,-106},{-272,-106}},
                                                     color={0,127,255}));
  connect(val.y_actual,val1. y) annotation (Line(points={{145,9},{145,6},{158,6},
          {158,28},{108,28},{108,10},{90,10}},
                                color={0,0,127}));
  connect(val3.y_actual,val4. y) annotation (Line(points={{-105,9},{-105,-6},{-142,
          -6},{-142,-66},{-148,-66}},
                                  color={0,0,127}));
  connect(mov2.port_a,res1. port_a)
    annotation (Line(points={{-62,-26},{-40,-26}},
                                                 color={0,127,255}));
  connect(res1.port_b,jun9. port_1) annotation (Line(points={{-20,-26},{-14,-26},
          {-14,-106},{-152,-106}},color={0,127,255}));
  connect(jun15.port_2,res3. port_a) annotation (Line(points={{-252,-26},{-244,-26},
          {-244,-24},{-236,-24}},   color={0,127,255}));
  connect(res3.port_b,jun10. port_1) annotation (Line(points={{-216,-24},{-210,-24},
          {-210,-26},{-202,-26}},   color={0,127,255}));
  connect(mov3.port_b,res5. port_a) annotation (Line(points={{358,-46},{370,-46},
          {370,-44},{386,-44},{386,-74}},
                                      color={0,127,255}));
  connect(jun.port_3,val8. port_b)
    annotation (Line(points={{128,44},{118,44}},   color={0,127,255}));
  connect(val8.port_a,jun1. port_2)
    annotation (Line(points={{98,44},{88,44}},    color={0,127,255}));
  connect(mov1.port_b,jun5. port_1)
    annotation (Line(points={{134,-126},{62,-126}},
                                                  color={0,127,255}));
  connect(res4.port_b,val9. port_1)
    annotation (Line(points={{248,-46},{264,-46}},
                                                 color={0,127,255}));
  connect(val9.port_2,jun12. port_1)
    annotation (Line(points={{284,-46},{298,-46}},
                                                 color={0,127,255}));
  connect(jun16.port_2,jun17. port_2)
    annotation (Line(points={{62,-46},{68,-46}},
                                               color={0,127,255}));
  connect(jun17.port_3,val1. port_b)
    annotation (Line(points={{78,-36},{78,0}}, color={0,127,255}));
  connect(val1.port_a,jun1. port_3)
    annotation (Line(points={{78,20},{78,34}},  color={0,127,255}));
  connect(jun5.port_3,val2. port_b)
    annotation (Line(points={{52,-116},{52,-92}},
                                                color={0,127,255}));
  connect(val2.port_a,jun16. port_3)
    annotation (Line(points={{52,-72},{52,-56}},
                                               color={0,127,255}));
  connect(jun4.port_1,jun6. port_1)
    annotation (Line(points={{148,-46},{182,-46}},
                                                 color={0,127,255}));
  connect(jun6.port_2,res4. port_a)
    annotation (Line(points={{202,-46},{228,-46}},
                                                 color={0,127,255}));
  connect(val9.port_3,jun6. port_3) annotation (Line(points={{274,-56},{274,-88},
          {192,-88},{192,-56}},
                              color={0,127,255}));
    connect(jun12.port_2,res5. port_a) annotation (Line(points={{318,-46},{318,-66},
          {386,-66},{386,-74}},
                              color={0,127,255}));
  connect(mov1.port_a,senVolFlo. port_b)
    annotation (Line(points={{154,-126},{218,-126}},
                                                   color={0,127,255}));
  connect(senVolFlo.port_a,jun13. port_2)
    annotation (Line(points={{238,-126},{298,-126}},
                                                   color={0,127,255}));
  connect(val.port_b,senVolFlo1. port_a)
    annotation (Line(points={{138,4},{138,-8}},  color={0,127,255}));
  connect(senVolFlo1.port_b,jun4. port_3)
    annotation (Line(points={{138,-28},{138,-36}},
                                                 color={0,127,255}));
  connect(jun17.port_1,senVolFlo2. port_a)
    annotation (Line(points={{88,-46},{96,-46}},
                                               color={0,127,255}));
  connect(senVolFlo2.port_b,jun4. port_2)
    annotation (Line(points={{116,-46},{128,-46}},
                                                 color={0,127,255}));
  connect(senVolFlo3.port_b,jun13. port_1)
    annotation (Line(points={{338,-126},{318,-126}},
                                                   color={0,127,255}));
  connect(res5.port_b,val10. port_a) annotation (Line(points={{386,-94},{386,-126},
          {384,-126}},color={0,127,255}));
  connect(val10.port_b,senVolFlo3. port_a)
    annotation (Line(points={{364,-126},{358,-126}},
                                                   color={0,127,255}));
  connect(jun12.port_3,senVolFlo4. port_a)
    annotation (Line(points={{308,-56},{288,-56},{288,-82}},
                                                           color={0,127,255}));
  connect(senVolFlo4.port_b,jun13. port_3) annotation (Line(points={{288,-102},{
          288,-116},{308,-116}},
                           color={0,127,255}));
  connect(const3.y,val10. y) annotation (Line(points={{359,-176},{374,-176},{374,
          -138}},    color={0,0,127}));
  connect(const4.y,mov1. y) annotation (Line(points={{123,-100},{128,-100},{128,
          -106},{144,-106},{144,-114}},
                                     color={0,0,127}));
  connect(const5.y, val.y) annotation (Line(points={{213,62},{213,38},{214,38},{
          214,14},{150,14}}, color={0,0,127}));
  connect(const6.y, val3.y) annotation (Line(points={{-69,62},{-60,62},{-60,14},
          {-100,14}}, color={0,0,127}));
  connect(const7.y, val7.y) annotation (Line(points={{-269,52},{-260,52},{-260,-66},
          {-250,-66}}, color={0,0,127}));
  connect(const7.y, val5.y) annotation (Line(points={{-269,52},{-228,52},{-228,-62},
          {-188,-62}}, color={0,0,127}));
  connect(const8.y, mov2.dp_in) annotation (Line(points={{-89,-74},{-80,-74},{-80,
          -38},{-72,-38}}, color={0,0,127}));
  connect(const9.y, mov4.dp_in) annotation (Line(points={{-313,-74},{-304,-74},{
          -304,-38},{-302,-38}}, color={0,0,127}));
  connect(const10.y, val2.y) annotation (Line(points={{95,-110},{80,-110},{80,-82},
          {64,-82}}, color={0,0,127}));
  connect(const11.y, mov3.dp_in) annotation (Line(points={{335,-4},{342,-4},{342,
          -34},{348,-34}}, color={0,0,127}));
  connect(const13.y, val9.y) annotation (Line(points={{255,-4},{255,-19},{274,-19},
          {274,-34}}, color={0,0,127}));
  connect(const14.y, val8.y) annotation (Line(points={{103,132},{103,87},{108,
          87},{108,56}},
                     color={0,0,127}));
  connect(jun5.port_2, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{42,
          -126},{-142,-126},{-142,-134},{-474,-134},{-474,316},{-204,316}},
        color={0,127,255}));
  connect(jun16.port_1, valIsoHeaInl.port_bHeaWat) annotation (Line(points={{42,
          -46},{-392,-46},{-392,266},{-298,266},{-298,276},{-204,276}}, color={
          0,127,255}));
  connect(const1.y, val6.y) annotation (Line(points={{317,56},{344,56},{344,42},
          {320,42},{320,-86}}, color={0,0,127}));
  connect(const2.y, mov.y) annotation (Line(points={{-195,122},{-132,122},{-132,
          96}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/ValvesIsolation.mos"
        "Simulate and plot"),
    experiment(
      Tolerance=1e-6,
      StopTime=5000.0),
    Diagram(
      coordinateSystem(
        extent={{-300,-400},{300,400}})),
    Documentation(revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation\">
Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation</a>
for the following configurations.
</p>
<ul>
<li>
Heating and cooling system with common dedicated primary HW and CHW pumps
and isolation valves at both heat pump inlet and outlet: 
component <code>valIsoCom</code>.
</li>
<li>
Heating-only system with isolation valves at heat pump inlet: 
component <code>valIsoHeaInl</code>.
</li>
<li>
Heating and cooling system with separate dedicated primary HW and CHW pumps
and isolation valves at heat pump inlet: 
component <code>valIsoSep</code>.
</li>
</ul>
<p>
In each configuration, two identical heat pumps are represented by fixed 
flow resistances (components <code>hp*</code>). 
</p>
<p>
The model uses open loop controls and the simulation allows verifying that design 
flow is obtained in each loop and each heat pump when the valves are open.
</p>
</html>"));
end ValvesIsolation_OnHydronicLoop;
