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
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoop ctlHeaInl(
    final cfg=datCtlHeaInl.cfg,
    final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{6,356},{-14,376}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={168,76})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-112,106},{-92,126}})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{118,66},{138,86}})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-92,66},{-72,86}})));
  Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-132,76})));
  Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={168,6})));
  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={168,46})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={128,-34})));
  Fluid.FixedResistances.Junction jun5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={128,-74})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{88,-4},{108,16}})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{198,-4},{218,16}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={208,-34})));
  Fluid.FixedResistances.Junction jun7(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={208,-74})));
  Fluid.FixedResistances.PressureDrop
                              res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{108,106},{128,126}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-42,6})));
  Fluid.FixedResistances.Junction jun8(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-84,6})));
  Fluid.Actuators.Valves.TwoWayLinear val3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-82,46})));
  Fluid.Actuators.Valves.TwoWayLinear val4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-132,-34})));
  Fluid.FixedResistances.Junction jun9(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-132,-74})));
  Fluid.FixedResistances.Junction jun10(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-172,-4},{-152,16}})));
  Fluid.FixedResistances.Junction jun11(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-162,-74})));
  Fluid.Actuators.Valves.TwoWayLinear val5(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-170,-30})));
  Fluid.Actuators.Valves.TwoWayLinear val6(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={278,-34})));
  Fluid.FixedResistances.Junction jun12(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{268,-4},{288,16}})));
  Fluid.FixedResistances.Junction jun13(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={278,-74})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{308,-4},{328,16}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Media.Water,
    p=300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={358,-74})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Media.Water,
    p=370000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={358,6})));
  Fluid.FixedResistances.Junction jun14(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-232,-74})));
  Fluid.FixedResistances.Junction jun15(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal=p_priEnergyFlow_nominal_junctions)
    annotation (Placement(transformation(extent={{-242,-4},{-222,16}})));
  Fluid.Actuators.Valves.TwoWayLinear val7(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dpValve_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-232,-34})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-272,6})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Media.Water,
    p=370000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-322,-4},{-302,16}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Media.Water,
    p=300000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-322,-84},{-302,-64}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{228,-134},{248,-114}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{268,-134},{288,-114}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=-1)
    annotation (Placement(transformation(extent={{-142,-134},{-122,-114}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{-102,-134},{-82,-114}})));
  Fluid.FixedResistances.PressureDrop
                              res1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
  Fluid.FixedResistances.PressureDrop
                              res3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-206,-2},{-186,18}})));
  Fluid.FixedResistances.PressureDrop
                              res4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal,
    dp_nominal=p_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{234,-4},{254,16}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-190,36},{-170,56}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{186,102},{206,122}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-70,136},{-50,156}})));
  Modelica.Blocks.Sources.Constant const3(k=70000)
    annotation (Placement(transformation(extent={{-140,138},{-120,158}})));
  Modelica.Blocks.Sources.Constant const4(k=1)
    annotation (Placement(transformation(extent={{-304,-44},{-284,-24}})));
  Modelica.Blocks.Sources.Constant const5(k=1)
    annotation (Placement(transformation(extent={{-78,-42},{-58,-22}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{258,52},{278,72}})));
  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{58,36},{78,56}})));
equation
  connect(ctlHeaInl.bus, valIsoHeaInl.bus)
    annotation (Line(points={{6,366},{36,366},{36,316}},   color={255,204,51},thickness=0.5));
  connect(valIsoHeaInl.ports_bChiHeaWatHp, hpHea.port_a)
    annotation (Line(points={{86,206},{46,206}},        color={0,127,255}));
  connect(hpHea.port_b, valIsoHeaInl.ports_aChiHeaWatHp)
    annotation (Line(points={{26,206},{-14,206}},         color={0,127,255}));
  connect(jun1.port_2,jun. port_3)
    annotation (Line(points={{138,76},{158,76}},
                                               color={0,127,255}));
  connect(jun2.port_2,jun1. port_1)
    annotation (Line(points={{-72,76},{118,76}},color={0,127,255}));
  connect(jun3.port_3,jun2. port_1)
    annotation (Line(points={{-122,76},{-92,76}},color={0,127,255}));
  connect(jun3.port_2,mov. port_a) annotation (Line(points={{-132,86},{-132,116},
          {-112,116}},        color={0,127,255}));
  connect(jun4.port_3,val. port_b)
    annotation (Line(points={{168,16},{168,36}},color={0,127,255}));
  connect(val.port_a,jun. port_2)
    annotation (Line(points={{168,56},{168,66}}, color={0,127,255}));
  connect(val1.port_a,jun1. port_3)
    annotation (Line(points={{128,-24},{128,66}},
                                                color={0,127,255}));
  connect(jun5.port_3,val1. port_b)
    annotation (Line(points={{128,-64},{128,-44}},
                                              color={0,127,255}));
  connect(mov1.port_b,jun4. port_2)
    annotation (Line(points={{108,6},{158,6}}, color={0,127,255}));
  connect(jun4.port_1,jun6. port_1)
    annotation (Line(points={{178,6},{198,6}},  color={0,127,255}));
  connect(val2.port_a,jun6. port_3)
    annotation (Line(points={{208,-24},{208,-4}},         color={0,127,255}));
  connect(jun5.port_1,jun7. port_2)
    annotation (Line(points={{138,-74},{198,-74}},color={0,127,255}));
  connect(jun7.port_3,val2. port_b)
    annotation (Line(points={{208,-64},{208,-44}},
                                                color={0,127,255}));
  connect(mov.port_b,res. port_a)
    annotation (Line(points={{-92,116},{108,116}}, color={0,127,255}));
  connect(res.port_b,jun. port_1)
    annotation (Line(points={{128,116},{168,116},{168,86}},
                                                          color={0,127,255}));
  connect(jun8.port_1,mov2. port_b)
    annotation (Line(points={{-74,6},{-52,6}},     color={0,127,255}));
  connect(jun8.port_3,val3. port_b)
    annotation (Line(points={{-84,16},{-84,26},{-82,26},{-82,36}},
                                                    color={0,127,255}));
  connect(val3.port_a,jun2. port_3)
    annotation (Line(points={{-82,56},{-82,66}},     color={0,127,255}));
  connect(val4.port_a,jun3. port_1)
    annotation (Line(points={{-132,-24},{-132,66}}, color={0,127,255}));
  connect(jun9.port_3,val4. port_b)
    annotation (Line(points={{-132,-64},{-132,-44}},
                                                  color={0,127,255}));
  connect(jun10.port_2,jun8. port_2)
    annotation (Line(points={{-152,6},{-94,6}},    color={0,127,255}));
  connect(jun11.port_1,jun9. port_2)
    annotation (Line(points={{-152,-74},{-142,-74}}, color={0,127,255}));
  connect(val5.port_a,jun10. port_3)
    annotation (Line(points={{-170,-20},{-170,-14},{-162,-14},{-162,-4}},
                                                   color={0,127,255}));
  connect(val5.port_b,jun11. port_3)
    annotation (Line(points={{-170,-40},{-170,-54},{-162,-54},{-162,-64}},
                                                  color={0,127,255}));
  connect(jun12.port_3,val6. port_a)
    annotation (Line(points={{278,-4},{278,-24}},color={0,127,255}));
  connect(jun7.port_1,jun13. port_2)
    annotation (Line(points={{218,-74},{268,-74}}, color={0,127,255}));
  connect(jun13.port_3,val6. port_b)
    annotation (Line(points={{278,-64},{278,-44}},
                                                color={0,127,255}));
  connect(jun12.port_2,mov3. port_a)
    annotation (Line(points={{288,6},{308,6}},   color={0,127,255}));
  connect(jun13.port_1,bou. ports[1])
    annotation (Line(points={{288,-74},{348,-74}}, color={0,127,255}));
  connect(mov3.port_b,bou1. ports[1])
    annotation (Line(points={{328,6},{348,6}},   color={0,127,255}));
  connect(jun14.port_1,jun11. port_2)
    annotation (Line(points={{-222,-74},{-172,-74}}, color={0,127,255}));
  connect(val7.port_a,jun15. port_3)
    annotation (Line(points={{-232,-24},{-232,-4}},color={0,127,255}));
  connect(val7.port_b,jun14. port_3)
    annotation (Line(points={{-232,-44},{-232,-64}}, color={0,127,255}));
  connect(mov4.port_a,jun15. port_1)
    annotation (Line(points={{-262,6},{-242,6}},   color={0,127,255}));
  connect(bou2.ports[1],mov4. port_b)
    annotation (Line(points={{-302,6},{-282,6}},   color={0,127,255}));
  connect(bou3.ports[1],jun14. port_2)
    annotation (Line(points={{-302,-74},{-242,-74}}, color={0,127,255}));
  connect(gai.u,val2. y_actual) annotation (Line(points={{226,-124},{222,-124},
          {222,-39},{215,-39}},
                         color={0,0,127}));
  connect(gai.y,addPar. u)
    annotation (Line(points={{250,-124},{266,-124}},
                                                   color={0,0,127}));
  connect(addPar.y,val6. y) annotation (Line(points={{290,-124},{308,-124},{308,
          -34},{290,-34}},
                    color={0,0,127}));
  connect(val.y_actual,val1. y) annotation (Line(points={{175,41},{175,26},{148,
          26},{148,-34},{140,-34}},
                                color={0,0,127}));
  connect(val3.y_actual,val4. y) annotation (Line(points={{-75,41},{-75,26},{
          -112,26},{-112,-34},{-120,-34}},
                                  color={0,0,127}));
  connect(gai1.y,addPar1. u)
    annotation (Line(points={{-120,-124},{-104,-124}},
                                                     color={0,0,127}));
  connect(addPar1.y,val7. y) annotation (Line(points={{-80,-124},{-72,-124},{
          -72,-154},{-212,-154},{-212,-34},{-220,-34}},
                                                color={0,0,127}));
  connect(val5.y_actual,gai1. u) annotation (Line(points={{-163,-35},{-163,-46},
          {-148,-46},{-148,-124},{-144,-124}},
                                            color={0,0,127}));
  connect(mov2.port_a,res1. port_a)
    annotation (Line(points={{-32,6},{-10,6}},   color={0,127,255}));
  connect(res1.port_b,jun9. port_1) annotation (Line(points={{10,6},{10,-72},{
          -122,-72},{-122,-74}},  color={0,127,255}));
  connect(jun15.port_2,res3. port_a) annotation (Line(points={{-222,6},{-214,6},
          {-214,8},{-206,8}},       color={0,127,255}));
  connect(res3.port_b,jun10. port_1) annotation (Line(points={{-186,8},{-180,8},
          {-180,6},{-172,6}},       color={0,127,255}));
  connect(jun6.port_2,res4. port_a) annotation (Line(points={{218,6},{234,6}},
                              color={0,127,255}));
  connect(res4.port_b,jun12. port_1) annotation (Line(points={{254,6},{268,6}},
                              color={0,127,255}));
  connect(const.y,val5. y) annotation (Line(points={{-169,46},{-154,46},{-154,
          42},{-152,42},{-152,-30},{-158,-30}},
                                            color={0,0,127}));
  connect(const1.y,val2. y) annotation (Line(points={{207,112},{230,112},{230,
          -34},{220,-34}},
                    color={0,0,127}));
  connect(const1.y,val. y) annotation (Line(points={{207,112},{216,112},{216,46},
          {180,46}}, color={0,0,127}));
  connect(const2.y,val3. y) annotation (Line(points={{-49,146},{-36,146},{-36,
          46},{-70,46}}, color={0,0,127}));
  connect(const3.y,mov. dp_in) annotation (Line(points={{-119,148},{-110,148},{
          -110,138},{-102,138},{-102,128}}, color={0,0,127}));
  connect(const4.y,mov4. dp_in)
    annotation (Line(points={{-283,-34},{-272,-34},{-272,-6}},
                                                           color={0,0,127}));
  connect(const5.y,mov2. dp_in) annotation (Line(points={{-57,-32},{-48,-32},{
          -48,-6},{-42,-6}},
                         color={0,0,127}));
  connect(const6.y,mov3. dp_in)
    annotation (Line(points={{279,62},{318,62},{318,18}}, color={0,0,127}));
  connect(const7.y,mov1. dp_in)
    annotation (Line(points={{79,46},{98,46},{98,18}}, color={0,0,127}));
  connect(jun5.port_2, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{118,
          -74},{-96,-74},{-96,-106},{-316,-106},{-316,316},{-204,316}}, color={
          0,127,255}));
  connect(mov1.port_a, valIsoHeaInl.port_bHeaWat) annotation (Line(points={{88,
          6},{-76,6},{-76,58},{-250,58},{-250,276},{-204,276}}, color={0,127,
          255}));
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
