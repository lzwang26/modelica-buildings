within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model ControlBoxTest
  "Control Box Test"

  extends Modelica.Icons.Example;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CHW/HW medium";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlPlaAwNrv(
    cfg(
      have_hrc = false,
      have_inpSch = false,
      have_chiWat=false,
      typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
      typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
      typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      have_pumHeaWatPriVar=true,
      have_pumChiWatPriVar=false,
      typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
      have_pumChiWatPriDed=false,
      nPumChiWatSec=0,
      rhoHeaWat_default=Buildings.Media.Water.d_const,
      typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
      is_rev=hpAwNrv.is_rev,
      typ=hpAwNrv.typ,
      rhoChiWat_default=Buildings.Media.Water.d_const,
      cpChiWat_default=hpAwNrv.cpChiWat_default,
      have_hotWat=false,
      have_valChiWatMinByp=false,
      have_valHeaWatMinByp=false,
      have_valHpInlIso=false,
      have_valHpOutIso=false,
      typMod=hpAwNrv.typMod,
      cpHeaWat_default=hpAwNrv.cpHeaWat_default,
      cpSou_default=hpAwNrv.cpSou_default,
      have_senDpChiWatRemWir=true,
      typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
      nHp=hpAwNrv.nHp,
      nPumHeaWatPri=hpAwNrv.nHp,
      have_heaWat=true,
      nPumHeaWatSec=0,
      rhoSou_default=Buildings.Media.Air.dStp,
      have_senDpHeaWatRemWir=true,
      typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      nPumChiWatPri=hpAwNrv.nHp,
      nSenDpHeaWatRem=1,
      nSenDpChiWatRem=1,
      nAirHan=0,
      nEquZon=0),
    THeaWatSup_nominal=datHpAwNrv.THeaWatSupHp_nominal,
    dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpChiWatRem),
    dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpHeaWatRem),
    staEqu={fill(1, hpAwNrv.nHp)})
    "Controller parameters"
    annotation (Placement(transformation(extent={{-192,-192},{-172,-172}})));

  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHpAwNrv(
    final cpHeaWat_default=hpAwNrv.cpHeaWat_default,
    final cpSou_default=hpAwNrv.cpSou_default,
    final nHp=hpAwNrv.nHp,
    final typ=hpAwNrv.typ,
    final is_rev=hpAwNrv.is_rev,
    final typMod=hpAwNrv.typMod,
    mHeaWatHp_flow_nominal=datHpAwNrv.capHeaHp_nominal / abs(datHpAwNrv.THeaWatSupHp_nominal -
      Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=500E3,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWatHp_flow_nominal=datHpAwNrv.capCooHp_nominal/abs(datHpAwNrv.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCooHp_nominal=500E3,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mSouWwHeaHp_flow_nominal=datHpAwNrv.capHeaHp_nominal/abs(datHpAwNrv.THeaWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpSouWwHeaHp_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpHeaWatHp,
    TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
    mSouWwCooHp_flow_nominal=datHpAwNrv.capCooHp_nominal/abs(datHpAwNrv.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    perFitHp(
      hea(
        P=datHpAwNrv.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
        coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow)))
    "Non-reversible AWHP parameters"
    annotation (Placement(transformation(extent={{-150,-192},{-130,-172}})));

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
    redeclare final package MediumHeaWat=Medium,
    nHp=1,
    is_rev=true,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics)
    "Non reversible AWHP"
    annotation (Placement(transformation(extent={{272,-114},{-208,-34}})));
  parameter HeatPumps.Components.Data.Controller                            datCtlHeaInl(
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
      is_rev=true,
      typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
      nPumChiWatSec=0,
      rhoHeaWat_default=Buildings.Media.Water.d_const,
      typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
      typ=Buildings.Templates.Components.Types.HeatPump.WaterToWater,
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
      nHp=1,
      nPumHeaWatPri=1,
      have_heaWat=true,
      nPumHeaWatSec=0,
      rhoSou_default=Buildings.Media.Air.dStp,
      have_senDpHeaWatRemWir=true,
      typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      nPumChiWatPri=1,
      nSenDpHeaWatRem=0,
      nSenDpChiWatRem=0,
      nAirHan=0,
      nEquZon=0),
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max,
        datCtlHeaInl.cfg.nSenDpChiWatRem),
    dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max,
        datCtlHeaInl.cfg.nSenDpHeaWatRem),
    staEqu={fill(1, datCtlHeaInl.cfg.nHp)})
    "Controller parameters"
    annotation (Placement(transformation(extent={{-284,-192},{-264,-172}})));

  parameter HeatPumps.Components.Data.HeatPumpGroup                            datHp(
    final nHp=2,
    final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
    final is_rev=true,
    final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
    mHeaWatHp_flow_nominal=datHp.capHeaHp_nominal/abs(datHp.THeaWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=500E3,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mChiWatHp_flow_nominal=datHp.capCooHp_nominal/abs(datHp.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCooHp_nominal=500E3,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
    perFitHp(hea(
        P=datHp.capHeaHp_nominal/Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow), coo(
        P=datHp.capCooHp_nominal/Buildings.Templates.Data.Defaults.COPHpAwCoo,
        coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
        coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
    "HP parameters"
    annotation (Placement(transformation(extent={{-228,-192},{-208,-172}})));

  ValvesIsolation_UpdatePorts
    valIsoHeaInl(
    redeclare final package Medium = Medium,
    nHp=1,
    have_chiWat=true,
    have_pumChiWatPriDed=false,
    have_valHpInlIso=true,
    have_valHpOutIso=false,
    final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal,
        valIsoHeaInl.nHp),
    dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
    mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
    final energyDynamics=energyDynamics,
    y_start=0)
    "Isolation valves - Heating-only system with isolation valves at HP inlet"
    annotation (Placement(transformation(extent={{-22,18},{20,60}})));

  Fluid.Sources.Boundary_pT retHeaWat1(
    redeclare final package Medium = Medium,
    T=293.15,
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{-394,84},{-374,104}})));
  Fluid.Sources.Boundary_pT supHeaWat1(
    redeclare final package Medium = Medium,
    T=298.15,
    nPorts=1) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{-396,14},{-376,34}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoopWithHeatRecoveryUnitController
  ctlHeaInl(final cfg=
       datCtlHeaInl.cfg, final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{-50,110},{-70,130}})));
  Fluid.Sources.Boundary_pT retChiWat(
    redeclare final package Medium = Medium,
    T=287.15,
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{296,-6},{276,14}})));
  Fluid.Sources.Boundary_pT supChiWat(
    redeclare final package Medium = Medium,
    T=279.85,
    nPorts=1) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{352,74},{332,94}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
  final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
  dat=datPumMul,
  redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{68,64},{48,84}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple
                              datPumMul(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(1, pum.nPum),
    dp_nominal=fill(1E5, pum.nPum))
    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-110,-194},{-90,-174}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{14,72},{34,92}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y(k=0.1)
                                                           "Pump speed command"
    annotation (Placement(transformation(extent={{-214,176},{-194,196}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1(
    table=[0,1; 1,1; 2,1; 3,1],
    timeScale=100,
    period=300) "Pump enable signal"
    annotation (Placement(transformation(extent={{-216,132},{-196,152}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou1(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-66,28},{-86,48}})));
  Buildings.Templates.Components.Pumps.Multiple pum1(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMul,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-130,26},{-110,46}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou2(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-172,24},{-152,44}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-206,24})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-206,84})));
  Buildings.Templates.Components.Actuators.Valve valve(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=1,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-206,54})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y2(k=0.1)
    "Pump speed command"
    annotation (Placement(transformation(extent={{-292,174},{-272,194}})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPHea(redeclare
      package Medium = Media.Water)           annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-270,62})));
  Buildings.Templates.Components.Sensors.Temperature TSupHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-328,14},{-308,34}})));
  HeatPumps.Interfaces.Bus bus_sensor
    annotation (Placement(transformation(extent={{-340,110},{-300,150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSupHeaSet(k=20 + 273.15)
    "Pump speed command"
    annotation (Placement(transformation(extent={{-424,154},{-404,174}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou3(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{110,72},{90,92}})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={136,82})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={134,24})));
  Buildings.Templates.Components.Actuators.Valve valve1(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=1,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={134,52})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y3(k=0.1)
    "Pump speed command"
    annotation (Placement(transformation(extent={{126,184},{146,204}})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPCoo(redeclare
      package Medium = Buildings.Media.Water) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={232,50})));
  Buildings.Templates.Components.Sensors.Temperature TSupCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{260,80},{280,100}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSupCooSet(k=0 + 273.15)
    "Pump speed command"
    annotation (Placement(transformation(extent={{-386,154},{-366,174}})));

  Buildings.Templates.Components.Interfaces.Bus bus_HeaVal "Pump control bus"
    annotation (Placement(transformation(extent={{-262,166},{-222,206}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));

  Buildings.Templates.Components.Interfaces.Bus bus_CooVal "Pump control bus"
    annotation (Placement(transformation(extent={{150,122},{190,162}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));
equation
  connect(ctlHeaInl.bus, valIsoHeaInl.bus) annotation (Line(
      points={{-50,126.4},{-1.4,126.4},{-1.4,58.53}},
      color={255,204,51},
      thickness=0.5));
  connect(valIsoHeaInl.port_bChiWat, rou.port_a) annotation (Line(points={{20,54.12},
          {26,54.12},{26,66},{8,66},{8,82},{14,82}},             color={0,127,255}));
  connect(valIsoHeaInl.port_bHeaWat, rou1.port_a) annotation (Line(points={{-22,
          45.51},{-54,45.51},{-54,38},{-66,38}},      color={0,127,255}));
  connect(hpAwNrv.ports_bHotWat, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(
        points={{-18,-113.8},{-18,-122},{-218,-122},{-218,6},{-16.6,6},{-16.6,18.21}},
                   color={0,127,255}));
  connect(valIsoHeaInl.ports_bHeaWatHp, hpAwNrv.ports_aHotWat) annotation (Line(
        points={{-6,18.21},{-6,10},{-222,10},{-222,-126},{82,-126},{82,-114}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_aChiWatHp, hpAwNrv.ports_bChiWat) annotation (Line(
        points={{4.6,18.42},{4.6,10},{34,10},{34,-26},{82,-26},{82,-34}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_bChiWatHp, hpAwNrv.ports_aChiWat) annotation (Line(
        points={{14.8,18.21},{14.8,-26},{-18,-26},{-18,-34}},color={0,127,255}));
  connect(rou2.port_a, jun.port_1) annotation (Line(points={{-172,34},{-190,34},
          {-190,24},{-196,24}}, color={0,127,255}));
  connect(retHeaWat1.ports[1], jun6.port_1) annotation (Line(points={{-374,94},{
          -228,94},{-228,84},{-216,84}}, color={0,127,255}));
  connect(jun6.port_2, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{-196,
          84},{-188,84},{-188,74},{-28,74},{-28,54.54},{-22,54.54}}, color={0,127,
          255}));
  connect(jun.port_3, valve.port_a)
    annotation (Line(points={{-206,34},{-206,44}}, color={0,127,255}));
  connect(valve.port_b, jun6.port_3)
    annotation (Line(points={{-206,64},{-206,74}}, color={0,127,255}));
  connect(bus_HeaVal, valve.bus) annotation (Line(
      points={{-242,186},{-242,54},{-216,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(y2.y, bus_HeaVal.y) annotation (Line(points={{-270,184},{-270,186},{-242,
          186}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(jun.port_2, dPHea.port_a) annotation (Line(points={{-216,24},{-266,24},
          {-266,46},{-270,46},{-270,52}}, color={0,127,255}));
  connect(jun6.port_1, dPHea.port_b) annotation (Line(points={{-216,84},{-228,84},
          {-228,96},{-270,96},{-270,72}}, color={0,127,255}));
  connect(jun.port_2, TSupHea.port_b)
    annotation (Line(points={{-216,24},{-308,24}}, color={0,127,255}));
  connect(TSupHea.port_a, supHeaWat1.ports[1])
    annotation (Line(points={{-328,24},{-376,24}}, color={0,127,255}));

  connect(rou3.port_a, jun1.port_1)
    annotation (Line(points={{110,82},{126,82}}, color={0,127,255}));
  connect(pum1.ports_b, rou1.ports_b) annotation (Line(points={{-110,36},{-92,
          36},{-92,38},{-86,38}}, color={0,127,255}));
  connect(pum1.ports_a, rou2.ports_b) annotation (Line(points={{-130,36},{-146,
          36},{-146,34},{-152,34}}, color={0,127,255}));
  connect(rou3.ports_b, pum.ports_a)
    annotation (Line(points={{90,82},{80,82},{80,74},{68,74}},
                                               color={0,127,255}));
  connect(pum.ports_b, rou.ports_b)
    annotation (Line(points={{48,74},{42,74},{42,82},{34,82}},
                                               color={0,127,255}));
  connect(retChiWat.ports[1], jun2.port_1)
    annotation (Line(points={{276,4},{150,4},{150,24},{144,24}},
                                                 color={0,127,255}));
  connect(jun2.port_2, valIsoHeaInl.port_aChiWat) annotation (Line(points={{124,
          24},{26,24},{26,44.88},{20,44.88}}, color={0,127,255}));
  connect(jun2.port_3, valve1.port_a)
    annotation (Line(points={{134,34},{134,42}}, color={0,127,255}));
  connect(valve1.port_b, jun1.port_3) annotation (Line(points={{134,62},{134,68},
          {136,68},{136,72}}, color={0,127,255}));
  connect(bus_CooVal, valve1.bus) annotation (Line(
      points={{170,142},{216,142},{216,52},{144,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(y3.y, bus_CooVal.y) annotation (Line(points={{148,194},{170,194},{170,
          142}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(jun1.port_2, dPCoo.port_a)
    annotation (Line(points={{146,82},{232,82},{232,60}}, color={0,127,255}));
  connect(jun2.port_1, dPCoo.port_b) annotation (Line(points={{144,24},{150,24},
          {150,4},{244,4},{244,34},{232,34},{232,40}}, color={0,127,255}));
  connect(jun1.port_2, TSupCoo.port_a) annotation (Line(points={{146,82},{248,82},
          {248,90},{260,90}}, color={0,127,255}));
  connect(TSupCoo.port_b, supChiWat.ports[1]) annotation (Line(points={{280,90},
          {320,90},{320,84},{332,84}}, color={0,127,255}));

connect(TSupHeaSet.y, bus_sensor.TSupHeaSet);
connect(TSupHea.y, bus_sensor.TSupHea);
connect(TSupCooSet.y, bus_sensor.TSupCooSet);
connect(TSupCoo.y, bus_sensor.TSupCoo);
connect(dPHea.y, bus_sensor.uDpHea);
connect(dPCoo.y, bus_sensor.uDpCoo);
  connect(ctlHeaInl.bus, hpAwNrv.bus) annotation (Line(
      points={{-50,126.4},{0,126.4},{0,62},{32,62},{32,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_sensor, ctlHeaInl.bus) annotation (Line(
      points={{-320,130},{-222,130},{-222,126},{-76,126},{-76,136},{-44,136},{
          -44,126.4},{-50,126.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pum1.bus, ctlHeaInl.bus_HeaPum) annotation (Line(
      points={{-120,46},{-120,102},{-40,102},{-40,114},{-49.8,114}},
      color={255,204,51},
      thickness=0.5));
  connect(pum.bus, ctlHeaInl.bus_CooPum) annotation (Line(
      points={{58,84},{58,100},{-38,100},{-38,120.2},{-50,120.2}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-300,-220},{300,220}})),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
        "Simulate and plot"),
    experiment(
      Tolerance=1e-6,
      StartTime=10497600.0,
      StopTime=10505600.0),
    Documentation(
      info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater\">
Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater</a>
in a configuration in which the heat pump components are exposed
to a constant differential pressure and a varying
return temperature.
</p>
<p>
The model is configured to represent either a non-reversible heat pump
(component <code>hpAwNrv</code>) or a reversible heat pump
(component <code>hpAw</code>) that switches between cooling and heating
mode.
</p>
</html>", revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
end ControlBoxTest;
