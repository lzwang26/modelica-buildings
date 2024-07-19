within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model FixingHeatPumpGroupError
  "Validation model for isolation valve component"

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
    annotation (Placement(transformation(extent={{-56,360},{-36,380}})));
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
    annotation (Placement(transformation(extent={{-264,360},{-244,380}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ValvesIsolation_UpdatePorts
    valIsoHeaInl(
    redeclare final package Medium = Medium,
    nHp=2,
    have_chiWat=true,
    have_pumChiWatPriDed=false,
    have_valHpInlIso=true,
    have_valHpOutIso=true,
    final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal,
        valIsoHeaInl.nHp),
    dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
    mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
    final energyDynamics=energyDynamics,
    y_start=0)
    "Isolation valves - Heating-only system with isolation valves at HP inlet"
    annotation (Placement(transformation(extent={{-18,262},{24,304}})));

  Fluid.FixedResistances.PressureDrop hpHea[valIsoHeaInl.nHp](
    redeclare each final package Medium=Medium,
    m_flow_nominal=valIsoHeaInl.mHeaWatHp_flow_nominal,
    dp_nominal=fill(0, valIsoHeaInl.nHp))
    "Heat pump HX with zero fluid resistance: pressure drop computed in valve component"
    annotation (Placement(transformation(extent={{2,206},{-18,226}})));
  Fluid.Sources.Boundary_pT retHeaWat1(
    redeclare final package Medium=Medium,
    p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{-254,314},{-234,334}})));
  Fluid.Sources.Boundary_pT supHeaWat1(
    redeclare final package Medium=Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=1) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{-254,282},{-234,302}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoop ctlHeaInl(
    final cfg=datCtlHeaInl.cfg,
    final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{-6,360},{-26,380}})));
  Fluid.FixedResistances.PressureDrop hpCoo[valIsoHeaInl.nHp](
    redeclare each final package Medium = Medium,
    m_flow_nominal=valIsoHeaInl.mHeaWatHp_flow_nominal,
    dp_nominal=fill(0, valIsoHeaInl.nHp))
    "Heat pump HX with zero fluid resistance: pressure drop computed in valve component"
    annotation (Placement(transformation(extent={{42,206},{22,226}})));
  Fluid.Sources.Boundary_pT retChiWat(
    redeclare final package Medium = Medium,
    p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
    nPorts=1) "Boundary condition at HW return"
    annotation (Placement(transformation(extent={{116,276},{96,296}})));
  Fluid.Sources.Boundary_pT supChiWat(
    redeclare final package Medium = Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=1) "Boundary condition at HW supply"
    annotation (Placement(transformation(extent={{116,304},{96,324}})));
equation
  connect(valIsoHeaInl.port_bHeaWat, supHeaWat1.ports[1])
    annotation (Line(points={{-18,289.51},{-226,289.51},{-226,292},{-234,292}},
                                                                       color={0,127,255}));
  connect(ctlHeaInl.bus, valIsoHeaInl.bus)
    annotation (Line(points={{-6,370},{2.6,370},{2.6,302.53}},
                                                           color={255,204,51},thickness=0.5));
  connect(hpHea.port_b, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(points=
         {{-18,216},{-16,216},{-16,262.21},{-12.6,262.21}}, color={0,127,255}));
  connect(hpHea.port_a, valIsoHeaInl.ports_bHeaWatHp) annotation (Line(points=
         {{2,216},{0,216},{0,262.21},{-2,262.21}}, color={0,127,255}));
  connect(hpCoo.port_b, valIsoHeaInl.ports_aChiWatHp) annotation (Line(points=
         {{22,216},{8,216},{8,262.42},{8.6,262.42}}, color={0,127,255}));
  connect(hpCoo.port_a, valIsoHeaInl.ports_bChiWatHp) annotation (Line(points=
         {{42,216},{58,216},{58,262.21},{18.8,262.21}}, color={0,127,255}));
  connect(retChiWat.ports[1], valIsoHeaInl.port_aChiWat) annotation (Line(
        points={{96,286},{60,286},{60,288.88},{24,288.88}}, color={0,127,255}));
  connect(supChiWat.ports[1], valIsoHeaInl.port_bChiWat) annotation (Line(
        points={{96,314},{60,314},{60,298.12},{24,298.12}}, color={0,127,255}));
  connect(valIsoHeaInl.port_aHeaWat, retHeaWat1.ports[1]) annotation (Line(
        points={{-18,298.54},{-224,298.54},{-224,324},{-234,324}}, color={0,
          127,255}));
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
end FixingHeatPumpGroupError;
