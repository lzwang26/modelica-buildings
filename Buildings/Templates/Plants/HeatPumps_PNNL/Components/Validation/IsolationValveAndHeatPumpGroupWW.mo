within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model IsolationValveAndHeatPumpGroupWW
  "Validation model for heat pump group"

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

  Buildings.Templates.Plants.HeatPumps.Components.Controls.OpenLoop ctlPlaAwNrv(
    final cfg=datCtlPlaAwNrv.cfg,
    final dat=datCtlPlaAwNrv)
    "Plant controller"
    annotation (Placement(transformation(extent={{110,112},{90,132}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
    redeclare final package MediumHeaWat=Medium,
    nHp=2,
    is_rev=true,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics)
    "Non reversible AWHP"
    annotation (Placement(transformation(extent={{234,-36},{-246,44}})));
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
    nHp=2,
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
    annotation (Placement(transformation(extent={{-60,96},{-18,138}})));

  Fluid.Sources.Boundary_pT retHeaWat1(
    redeclare final package Medium = Medium,
    T=293.15,
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{-296,150},{-276,170}})));
  Fluid.Sources.Boundary_pT supHeaWat1(
    redeclare final package Medium = Medium,
    T=298.15,
    nPorts=2) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{-296,116},{-276,136}})));
  Controls.OpenLoop                                                      ctlHeaInl(final cfg
      =datCtlHeaInl.cfg, final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{-48,194},{-68,214}})));
  Fluid.Sources.Boundary_pT retChiWat(
    redeclare final package Medium = Medium,
    T=287.15,
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{74,110},{54,130}})));
  Fluid.Sources.Boundary_pT supChiWat(
    redeclare final package Medium = Medium,
    T=279.85,
    nPorts=2) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{74,138},{54,158}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
  final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
  nPum=2,
  dat=datPumMul,
  redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{10,150},{30,170}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple
                              datPumMul(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(1, pum.nPum),
    dp_nominal=fill(1E5, pum.nPum))
    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{150,170},{170,190}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-24,150},{-4,170}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y(k=0.1)
                                                           "Pump speed command"
    annotation (Placement(transformation(extent={{-252,254},{-232,274}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1(
    table=[0,1,1; 1,1,1; 2,1,1; 3,1,1],
    timeScale=100,
    period=300) "Pump enable signal"
    annotation (Placement(transformation(extent={{-254,210},{-234,230}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou1(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-104,106},{-124,126}})));
  Buildings.Templates.Components.Pumps.Multiple pum1(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=2,
    dat=datPumMul,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-148,104},{-168,124}})));
protected
  Buildings.Templates.Components.Interfaces.Bus
                 bus2 "Pump control bus" annotation (Placement(transformation(
          extent={{74,182},{114,222}}),iconTransformation(extent={{-318,-118},{-278,
            -78}})));
protected
  Buildings.Templates.Components.Interfaces.Bus
                 bus1 "Pump control bus" annotation (Placement(transformation(
          extent={{-220,158},{-180,198}}),
                                       iconTransformation(extent={{-318,-118},{-278,
            -78}})));
equation
  connect(ctlPlaAwNrv.bus, hpAwNrv.bus)
    annotation (Line(points={{110,122},{120,122},{120,54},{-6,54},{-6,44}},
                                                        color={255,204,51},thickness=0.5));
  connect(retHeaWat1.ports[1],valIsoHeaInl. port_aHeaWat)
    annotation (Line(points={{-276,160},{-268,160},{-268,132.54},{-60,132.54}},
                                                                       color={0,127,255}));
  connect(retChiWat.ports[1],valIsoHeaInl. port_aChiWat) annotation (Line(
        points={{54,120},{18,120},{18,122.88},{-18,122.88}},color={0,127,255}));
  connect(ctlHeaInl.bus, valIsoHeaInl.bus) annotation (Line(
      points={{-48,204},{-39.4,204},{-39.4,136.53}},
      color={255,204,51},
      thickness=0.5));
  connect(valIsoHeaInl.port_bChiWat, rou.port_a) annotation (Line(points={{-18,132.12},
          {-12,132.12},{-12,144},{-30,144},{-30,160},{-24,160}}, color={0,127,255}));
  connect(rou.ports_b, pum.ports_a)
    annotation (Line(points={{-4,160},{10,160}}, color={0,127,255}));
  connect(pum.ports_b, supChiWat.ports[1:2]) annotation (Line(points={{30,160},{
          48,160},{48,149},{54,149}}, color={0,127,255}));
  connect(bus2, pum.bus) annotation (Line(
      points={{94,202},{94,176},{20,176},{20,170}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(y.y, bus2.y) annotation (Line(points={{-230,264},{-224,264},{-224,236},
          {94,236},{94,202}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(y1.y[1:2], bus2.y1) annotation (Line(points={{-232,220},{-76,220},{-76,
          224},{64,224},{64,202},{94,202}},
                     color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(valIsoHeaInl.port_bHeaWat, rou1.port_a) annotation (Line(points={{-60,
          123.51},{-92,123.51},{-92,116},{-104,116}}, color={0,127,255}));
  connect(rou1.ports_b, pum1.ports_a) annotation (Line(points={{-124,116},{-124,
          114},{-148,114}}, color={0,127,255}));
  connect(pum1.ports_b, supHeaWat1.ports[1:2]) annotation (Line(points={{-168,114},
          {-264,114},{-264,127},{-276,127}}, color={0,127,255}));
  connect(bus1, pum1.bus) annotation (Line(
      points={{-200,178},{-200,136},{-158,136},{-158,124}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(y.y, bus1.y) annotation (Line(points={{-230,264},{-224,264},{-224,240},
          {-264,240},{-264,178},{-200,178}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(y1.y[1:2], bus1.y1) annotation (Line(points={{-232,220},{-200,220},{-200,
          178}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hpAwNrv.ports_bHotWat, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(
        points={{-56,-35.8},{-56,-44},{-256,-44},{-256,84},{-54.6,84},{-54.6,
          96.21}}, color={0,127,255}));
  connect(valIsoHeaInl.ports_bHeaWatHp, hpAwNrv.ports_aHotWat) annotation (Line(
        points={{-44,96.21},{-44,88},{-260,88},{-260,-48},{44,-48},{44,-36}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_aChiWatHp, hpAwNrv.ports_bChiWat) annotation (Line(
        points={{-33.4,96.42},{-33.4,88},{-4,88},{-4,52},{44,52},{44,44}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_bChiWatHp, hpAwNrv.ports_aChiWat) annotation (Line(
        points={{-23.2,96.21},{-23.2,52},{-56,52},{-56,44}}, color={0,127,255}));
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
end IsolationValveAndHeatPumpGroupWW;
