within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model HeatPumpPlantPrimarySecondary "Validation model for heat pump group"

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
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mSouWwHeaHp_flow_nominal=datHpAwNrv.capHeaHp_nominal/abs(datHpAwNrv.THeaWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpSouWwHeaHp_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpHeaWatHp,
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
    is_rev=false,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics)
    "Non reversible AWHP"
    annotation (Placement(transformation(extent={{274,-152},{-206,-72}})));
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
    annotation (Placement(transformation(extent={{-20,-20},{22,22}})));

  Fluid.Sources.Boundary_pT retHeaWat1(
    redeclare final package Medium = Medium,
    p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
    T=Buildings.Templates.Data.Defaults.THeaWatRetMed,
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{-382,14},{-362,34}})));
  Fluid.Sources.Boundary_pT supHeaWat1(
    redeclare final package Medium = Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=1) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{-382,-10},{-362,10}})));
  Fluid.Sources.Boundary_pT retChiWat(
    redeclare final package Medium = Medium,
    p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
    T=287.15,
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{268,-22},{248,-2}})));
  Fluid.Sources.Boundary_pT supChiWat(
    redeclare final package Medium = Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    T=279.85,
    nPorts=1) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{280,30},{260,50}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
  final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
  dat=datPumMul,
  redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{94,-20},{74,0}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple
                              datPumMul(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(1, pum.nPum),
    dp_nominal=fill(1E5, pum.nPum))
    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{220,120},{240,140}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou1(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-46,16},{-66,36}})));
  Buildings.Templates.Components.Pumps.Multiple pum1(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMul,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,14},{-90,34}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou2(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-164,14},{-144,34}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou3(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{126,-20},{106,0}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-210,-2})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,24})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou4(
    redeclare package Medium = Medium,
    nPorts=pum2.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-350,-14},{-330,6}})));
  Buildings.Templates.Components.Pumps.Multiple pum2(
    have_var=false,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMul,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-276,-14},{-296,6}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou5(
    redeclare package Medium = Medium,
    nPorts=pum2.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-232,-12},{-252,8}})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={150,40})));
  Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={150,-12})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou6(
    redeclare package Medium = Medium,
    nPorts=pum3.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{252,30},{232,50}})));
  Buildings.Templates.Components.Pumps.Multiple pum3(
    have_var=false,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMul,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{200,30},{220,50}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou7(
    redeclare package Medium = Medium,
    nPorts=pum3.nPum,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{166,30},{186,50}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop extEneLoo
    "External energy loop"
    annotation (Placement(transformation(extent={{-92,64},{-68,88}})));
  Controls.ExternalEnergy extEneCon "External energy loop control" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,150})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-120,140},{-100,160}})));
  Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,40})));
  Fluid.FixedResistances.Junction jun5(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,40})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-182,24})));
  Fluid.FixedResistances.Junction jun7(
    redeclare package Medium = Media.Water,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-130,-16})));
  Buildings.Templates.Components.Interfaces.Bus bus annotation (Placement(
        transformation(extent={{-300,-60},{-280,-40}}), iconTransformation(
          extent={{-420,-50},{-380,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-380,-60},{-360,-40}})));
  Buildings.Templates.Components.Interfaces.Bus bus1 annotation (Placement(
        transformation(extent={{200,-40},{220,-20}}), iconTransformation(extent=
           {{-420,-50},{-380,-10}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep
    annotation (Placement(transformation(extent={{-340,-60},{-320,-40}})));
  Controls.HeatRecoveryUnitControl hruCon "Heat recovery unit control"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Interface.HeatRecoveryUnit bus2 annotation (Placement(transformation(extent={
            {-20,100},{0,120}}), iconTransformation(extent={{-56,54},{-16,94}})));
equation
  connect(valIsoHeaInl.ports_bChiWatHp, hpAwNrv.ports_aChiWat) annotation (Line(
        points={{16.8,-19.79},{16.8,-66},{-16,-66},{-16,-72}}, color={0,127,255}));
  connect(hpAwNrv.ports_bChiWat, valIsoHeaInl.ports_aChiWatHp) annotation (Line(
        points={{84,-72},{84,-58},{6.6,-58},{6.6,-19.58}}, color={0,127,255}));
  connect(hpAwNrv.ports_bHotWat, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(
        points={{-16,-151.8},{-16,-158},{-212,-158},{-212,-26},{-14.6,-26},{-14.6,
          -19.79}}, color={0,127,255}));
  connect(hpAwNrv.ports_aHotWat, valIsoHeaInl.ports_bHeaWatHp) annotation (Line(
        points={{84,-152},{30,-152},{30,-150},{-4,-150},{-4,-19.79}}, color={0,127,
          255}));
  connect(retHeaWat1.ports[1], jun1.port_1)
    annotation (Line(points={{-362,24},{-220,24}}, color={0,127,255}));
  connect(jun.port_3, jun1.port_3)
    annotation (Line(points={{-210,8},{-210,14}}, color={0,127,255}));
  connect(pum2.ports_b, rou4.ports_b)
    annotation (Line(points={{-296,-4},{-330,-4}}, color={0,127,255}));
  connect(rou5.ports_b,pum2. ports_a) annotation (Line(points={{-252,-2},{-252,-4},
          {-276,-4}},       color={0,127,255}));
  connect(jun.port_2, rou5.port_a) annotation (Line(points={{-220,-2},{-226,-2},
          {-226,-2},{-232,-2}}, color={0,127,255}));
  connect(rou4.port_a, supHeaWat1.ports[1])
    annotation (Line(points={{-350,-4},{-350,0},{-362,0}}, color={0,127,255}));
  connect(retChiWat.ports[1], jun3.port_1)
    annotation (Line(points={{248,-12},{160,-12}}, color={0,127,255}));
  connect(jun3.port_3, jun2.port_3)
    annotation (Line(points={{150,-2},{150,30}}, color={0,127,255}));
  connect(pum3.ports_b, rou6.ports_b)
    annotation (Line(points={{220,40},{232,40}}, color={0,127,255}));
  connect(jun2.port_2, rou7.port_a)
    annotation (Line(points={{160,40},{166,40}}, color={0,127,255}));
  connect(rou7.ports_b, pum3.ports_a)
    annotation (Line(points={{186,40},{200,40}}, color={0,127,255}));
  connect(rou6.port_a, supChiWat.ports[1])
    annotation (Line(points={{252,40},{260,40}}, color={0,127,255}));
  connect(rou1.port_a, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{-46,
          26},{-32,26},{-32,16.54},{-20,16.54}}, color={0,127,255}));
  connect(rou2.ports_b, pum1.ports_a)
    annotation (Line(points={{-144,24},{-110,24}}, color={0,127,255}));
  connect(pum1.ports_b, rou1.ports_b) annotation (Line(points={{-90,24},{-78,24},
          {-78,26},{-66,26}}, color={0,127,255}));
  connect(rou3.ports_b, pum.ports_a)
    annotation (Line(points={{106,-10},{94,-10}}, color={0,127,255}));
  connect(pum.ports_b, rou.ports_b)
    annotation (Line(points={{74,-10},{60,-10}}, color={0,127,255}));
  connect(rou.port_a, valIsoHeaInl.port_aChiWat) annotation (Line(points={{40,-10},
          {32,-10},{32,6.88},{22,6.88}}, color={0,127,255}));
  connect(rou3.port_a, jun3.port_2) annotation (Line(points={{126,-10},{128,-10},
          {128,-12},{140,-12}}, color={0,127,255}));
  connect(extEneLoo.bus, extEneCon.bus) annotation (Line(
      points={{-75.2,88},{-75.2,128},{-70,128},{-70,140}},
      color={255,204,51},
      thickness=0.5));
  connect(extEneLoo.busWea, weaDat.weaBus) annotation (Line(
      points={{-84.8,88},{-84.8,132},{-88,132},{-88,150},{-100,150}},
      color={255,204,51},
      thickness=0.5));
  connect(jun4.port_1, jun2.port_1)
    annotation (Line(points={{120,40},{140,40}}, color={0,127,255}));
  connect(extEneLoo.portEva_b, jun4.port_3) annotation (Line(points={{-71.6,64},
          {110,64},{110,50}}, color={0,127,255}));
  connect(valIsoHeaInl.port_bChiWat, jun5.port_2) annotation (Line(points={{22,16.12},
          {50,16.12},{50,40},{60,40}}, color={0,127,255}));
  connect(jun5.port_1, jun4.port_2)
    annotation (Line(points={{80,40},{100,40}}, color={0,127,255}));
  connect(extEneLoo.portEva_a, jun5.port_3) annotation (Line(points={{-76.4,64},
          {-76.4,50},{70,50}}, color={0,127,255}));
  connect(jun1.port_2, jun6.port_2)
    annotation (Line(points={{-200,24},{-192,24}}, color={0,127,255}));
  connect(jun6.port_1, rou2.port_a)
    annotation (Line(points={{-172,24},{-164,24}}, color={0,127,255}));
  connect(extEneLoo.portCon_b, jun6.port_3) annotation (Line(points={{-83.6,64},
          {-84,64},{-84,52},{-182,52},{-182,34}}, color={0,127,255}));
  connect(valIsoHeaInl.port_bHeaWat, jun7.port_1) annotation (Line(points={{-20,
          7.51},{-20,4},{-36,4},{-36,-16},{-120,-16}}, color={0,127,255}));
  connect(jun7.port_2, jun.port_1) annotation (Line(points={{-140,-16},{-188,-16},
          {-188,-2},{-200,-2}}, color={0,127,255}));
  connect(jun7.port_3, extEneLoo.portCon_a) annotation (Line(points={{-130,-6},
          {-130,56},{-88.4,56},{-88.4,64}}, color={0,127,255}));
  connect(bus, pum2.bus) annotation (Line(
      points={{-290,-50},{-290,-20},{-304,-20},{-304,6},{-286,6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus1, pum3.bus) annotation (Line(
      points={{210,-30},{292,-30},{292,50},{210,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.y, booScaRep.u) annotation (Line(points={{-358,-50},{-342,-50}},
                                                                        color={255,
          0,255}));
  connect(booScaRep.y, bus.y1) annotation (Line(points={{-318,-50},{-290,-50}},
                                  color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booScaRep.y, bus1.y1) annotation (Line(points={{-318,-50},{-308,-50},
          {-308,-164},{210,-164},{210,-30}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hruCon.bus, bus2) annotation (Line(
      points={{-10,100},{-10,110}},
      color={255,204,51},
      thickness=0.5));
  connect(bus2.plantControlBus, valIsoHeaInl.bus) annotation (Line(
      points={{-9.95,110.05},{-9.95,110},{34,110},{34,20},{0.6,20},{0.6,20.53}},
      color={255,204,51},
      thickness=0.5));
  connect(bus2.plantControlBus, hpAwNrv.bus) annotation (Line(
      points={{-9.95,110.05},{-9.95,110},{34,110},{34,-72}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-400,-220},{300,220}})),
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
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HeatPumpPlantPrimarySecondary;
