within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model HeatPumpGroupWaterToWater
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
    annotation (Placement(transformation(extent={{-260,40},{-240,60}})));

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
    annotation (Placement(transformation(extent={{-220,40},{-200,60}})));

  Fluid.Sources.Boundary_pT sup(
    redeclare final package Medium=Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=hpAwNrv.nHp)
    "Boundary condition at distribution system supply"
    annotation (Placement(transformation(extent={{170,130},{150,150}})));
  Fluid.Sources.Boundary_pT inlHp1(
    redeclare final package Medium=Medium,
    use_p_in=false,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    use_T_in=false,
    nPorts=hpAwNrv.nHp)
    "Boundary conditions at HP inlet"
    annotation (Placement(transformation(extent={{-120,150},{-100,170}})));
  Fluid.Sensors.TemperatureTwoPort TRet1[hpAwNrv.nHp](
    redeclare each final package Medium=Medium,
    each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    "Return temperature"
    annotation (Placement(transformation(extent={{-80,150},{-60,170}})));
  Fluid.Sensors.TemperatureTwoPort TSup1[hpAwNrv.nHp](
    redeclare each final package Medium=Medium,
    each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    "Supply temperature"
    annotation (Placement(transformation(extent={{104,130},{124,150}})));
  Buildings.Templates.Plants.HeatPumps.Components.Controls.OpenLoop ctlPlaAwNrv(
    final cfg=datCtlPlaAwNrv.cfg,
    final dat=datCtlPlaAwNrv)
    "Plant controller"
    annotation (Placement(transformation(extent={{10,170},{-10,190}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
    redeclare final package MediumHeaWat=Medium,
    nHp=3,
    is_rev=false,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics)
    "Non reversible AWHP"
    annotation (Placement(transformation(extent={{280,40},{-200,120}})));
  Fluid.Sources.Boundary_pT inlHp2(
    redeclare final package Medium = Medium,
    use_p_in=false,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    use_T_in=false,
    nPorts=hpAwNrv.nHp)
    "Boundary conditions at HP inlet"
    annotation (Placement(transformation(extent={{82,-78},{102,-58}})));
  Fluid.Sensors.TemperatureTwoPort TRet2[hpAwNrv.nHp](redeclare each final
      package Medium = Medium, each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    "Return temperature"
    annotation (Placement(transformation(extent={{56,-36},{76,-16}})));
  Fluid.Sources.Boundary_pT sup1(
    redeclare final package Medium = Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=hpAwNrv.nHp)
    "Boundary condition at distribution system supply"
    annotation (Placement(transformation(extent={{18,-34},{-2,-14}})));
  Fluid.Sensors.TemperatureTwoPort TSup2[hpAwNrv.nHp](redeclare each final
      package Medium = Medium, each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    "Supply temperature"
    annotation (Placement(transformation(extent={{-48,-34},{-28,-14}})));
equation
  connect(ctlPlaAwNrv.bus, hpAwNrv.bus)
    annotation (Line(points={{10,180},{40,180},{40,120}},
                                                        color={255,204,51},thickness=0.5));
  connect(inlHp1.ports, TRet1.port_a)
    annotation (Line(points={{-100,160},{-80,160}},color={0,127,255}));
  connect(TRet1.port_b, hpAwNrv.ports_aChiWat) annotation (Line(points={{-60,
          160},{-10,160},{-10,120}}, color={0,127,255}));
  connect(hpAwNrv.ports_bChiWat, TSup1.port_a)
    annotation (Line(points={{90,120},{90,140},{104,140}}, color={0,127,255}));
  connect(TSup1.port_b, sup.ports)
    annotation (Line(points={{124,140},{150,140}},
                                                 color={0,127,255}));
  connect(inlHp2.ports,TRet2. port_a)
    annotation (Line(points={{102,-68},{108,-68},{108,-42},{50,-42},{50,-26},
          {56,-26}},                               color={0,127,255}));
  connect(TRet2.port_b, hpAwNrv.ports_aHotWat)
    annotation (Line(points={{76,-26},{90,-26},{90,40}}, color={0,127,255}));
  connect(TSup2.port_b, sup1.ports)
    annotation (Line(points={{-28,-24},{-2,-24}}, color={0,127,255}));
  connect(TSup2.port_a, hpAwNrv.ports_bHotWat) annotation (Line(points={{-48,-24},
          {-54,-24},{-54,34},{-10,34},{-10,40.2}}, color={0,127,255}));
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
end HeatPumpGroupWaterToWater;
