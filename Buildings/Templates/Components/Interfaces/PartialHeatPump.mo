within Buildings.Templates.Components.Interfaces;
model PartialHeatPump
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare final package Medium=MediumHeaWat,
    final m_flow_nominal=max(mHeaWat_flow_nominal, mChiWat_flow_nominal));

  replaceable package MediumHeaWat=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "HW medium"
    annotation(__Linkage(enable=false));
  /*
  MediumChiWat is for internal use only.
  It is the same as MediumHeaWat for reversible HP.
  Non-reversible HP that can be controlled to produce either HW or CHW
  shall be modeled with chiller components (as a chiller/heater).
  */
  final package MediumChiWat=MediumHeaWat
    "CHW medium";
  /*
  Derived classes representing AWHP shall use: 
  redeclare final package MediumSou = MediumAir
  */
  replaceable package MediumSou=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Source-side medium"
    annotation(Dialog(enable=
    typ==Buildings.Templates.Components.Types.HeatPump.WaterToWater),
    __Linkage(enable=false));
  replaceable package MediumAir=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Air medium"
    annotation(Dialog(enable=
    typ==Buildings.Templates.Components.Types.HeatPump.AirToWater),
    __Linkage(enable=false));

  parameter Buildings.Templates.Components.Types.HeatPump typ
    "Equipment type"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Boolean is_rev
    "Set to true for reversible heat pumps, false for heating only"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Buildings.Templates.Components.Types.HeatPumpModel typMod=
    Buildings.Templates.Components.Types.HeatPumpModel.ModularTableData2D
    "Type of heat pump model"
    annotation (Evaluate=true, Dialog(group="Configuration"),
    __ctrlFlow(enable=false));

  parameter Buildings.Templates.Components.Data.HeatPump dat(
    typ=typ,
    is_rev=is_rev,
    typMod=typMod,
    cpHeaWat_default=cpHeaWat_default,
    cpSou_default=cpSou_default)
    "Design and operating parameters"
    annotation (
    Placement(transformation(extent={{70,80},{90,100}})),
    __ctrlFlow(enable=false));

  final parameter Modelica.Units.SI.MassFlowRate mHeaWat_flow_nominal=
    dat.mHeaWat_flow_nominal
    "Design HW mass flow rate";
  final parameter Modelica.Units.SI.HeatFlowRate capHea_nominal=
    dat.capHea_nominal
    "Design heating capacity";
  final parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal=
    abs(capHea_nominal)
    "Design heating heat flow rate";
  final parameter Modelica.Units.SI.PressureDifference dpHeaWat_nominal=
    dat.dpHeaWat_nominal
    "Design HW pressure drop";
  final parameter Modelica.Units.SI.Temperature THeaWatSup_nominal=
    dat.THeaWatSup_nominal
    "Design HW supply temperature";
  final parameter Modelica.Units.SI.Temperature THeaWatRet_nominal=
    dat.THeaWatRet_nominal
    "Design HW return temperature";
  final parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal=
    dat.mChiWat_flow_nominal
    "Design CHW mass flow rate"
    annotation(Dialog(group="Nominal condition"));
  final parameter Modelica.Units.SI.PressureDifference dpChiWat_nominal=
    dat.dpChiWat_nominal
    "Design CHW pressure drop";
  final parameter Modelica.Units.SI.HeatFlowRate capCoo_nominal=
    dat.capCoo_nominal
    "Design cooling capacity";
  final parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal=
    -abs(capCoo_nominal)
    "Design cooling heat flow rate";
  final parameter Modelica.Units.SI.Temperature TChiWatSup_nominal=
    dat.TChiWatSup_nominal
    "Design CHW supply temperature";
  final parameter Modelica.Units.SI.Temperature TChiWatRet_nominal=
    dat.TChiWatRet_nominal
    "Design CHW return temperature";
  final parameter Modelica.Units.SI.MassFlowRate mSouHea_flow_nominal=
    dat.datTabHea.mEva_flow_nominal
    "Design source fluid mass flow rate in heating mode";
  final parameter Modelica.Units.SI.PressureDifference dpSouHea_nominal=
    dat.datTabHea.dpEva_nominal
    "Design source fluid pressure drop in heating mode"
    annotation (Dialog(group="Nominal condition",
    enable=typ==Buildings.Templates.Components.Types.HeatPump.WaterToWater));
  final parameter Modelica.Units.SI.MassFlowRate mSouCoo_flow_nominal=
    dat.datTabCoo.mCon_flow_nominal
    "Design source fluid mass flow rate in cooling mode";
  final parameter Modelica.Units.SI.PressureDifference dpSouCoo_nominal=
    dat.datTabCoo.dpCon_nominal
    "Designs source fluid pressure drop in cooling mode";
  final parameter Modelica.Units.SI.Temperature TSouCoo_nominal=
    dat.TSouCoo_nominal
    "Design OAT or source fluid supply temperature (condenser entering) in cooling mode";
  final parameter Modelica.Units.SI.Temperature TSouHea_nominal=
    dat.TSouHea_nominal
    "Design OAT or source fluid supply temperature (evaporator entering) in heating mode";

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Conservation equations"));
  parameter Boolean allowFlowReversalSou = true
    "Source side flow reversal: false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  final parameter MediumHeaWat.SpecificHeatCapacity cpHeaWat_default=
    MediumHeaWat.specificHeatCapacityCp(staHeaWat_default)
    "HW default specific heat capacity";
  final parameter MediumHeaWat.ThermodynamicState staHeaWat_default=
    MediumHeaWat.setState_pTX(
      T=THeaWatSup_nominal,
      p=MediumHeaWat.p_default,
      X=MediumHeaWat.X_default)
    "HW default state";
  final parameter MediumChiWat.SpecificHeatCapacity cpChiWat_default=
    MediumChiWat.specificHeatCapacityCp(staChiWat_default)
    "CHW default specific heat capacity";
  final parameter MediumChiWat.ThermodynamicState staChiWat_default=
    MediumChiWat.setState_pTX(
      T=TChiWatSup_nominal,
      p=MediumChiWat.p_default,
      X=MediumChiWat.X_default)
    "CHW default state";
  final parameter MediumSou.SpecificHeatCapacity cpSou_default=
    MediumSou.specificHeatCapacityCp(staSou_default)
    "Source fluid default specific heat capacity";
  final parameter MediumSou.ThermodynamicState staSou_default=
    MediumSou.setState_pTX(
      T=TSouHea_nominal,
      p=MediumSou.p_default,
      X=MediumSou.X_default)
    "Source fluid default state";

  Modelica.Fluid.Interfaces.FluidPort_a port_aSou(
    redeclare final package Medium = MediumSou)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(
      iconVisible=typ==Buildings.Templates.Components.Types.HeatPump.WaterToWater,
      transformation(extent={{30,-110},{50,-90}}),
      iconTransformation(extent={{40,-110},{60,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_bSou(
    redeclare final package Medium = MediumSou)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(
      iconVisible=typ==Buildings.Templates.Components.Types.HeatPump.WaterToWater,
      transformation(extent={{-30,-110},{-50,-90}}),
      iconTransformation(extent={{-40,-110},{-60,-90}})));
  Buildings.Templates.Components.Interfaces.Bus bus
    "Control bus"
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
     iconTransformation(extent={{-20,80},{20, 120}})));
  Buildings.BoundaryConditions.WeatherData.Bus busWea
    if typ==Buildings.Templates.Components.Types.HeatPump.AirToWater
    "Weather bus"
    annotation (Placement(transformation(extent={{-80,80},{-40,120}}),
        iconTransformation(extent={{-80,80},{-40,120}})));
  Buildings.Fluid.Sources.Boundary_pT sinAir(
    redeclare final package Medium =MediumAir,
    nPorts=2)
    if typ == Buildings.Templates.Components.Types.HeatPump.AirToWater
    "Air sink"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-90})));
equation
  connect(sinAir.ports[1], port_bSou) annotation (Line(points={{-1,-80},{-40,-80},
          {-40,-100}}, color={0,127,255}));
  connect(sinAir.ports[2], port_aSou)
    annotation (Line(points={{1,-80},{40,-80},{40,-100}}, color={0,127,255}));
annotation (
Icon(graphics={
    Rectangle(
          extent={{100,60},{-100,-100}},
          lineColor={0,0,0},
          lineThickness=1),
    Bitmap(extent={{-20,60},{20,100}}, fileName=
    "modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg"),
    Text( extent={{-60,-20},{60,-60}},
          textColor={0,0,0},
          textString="HP")}), Documentation(info="<html>
RFE: Add check for design capacity below the one computed
from reference values (per record).
</html>"));
end PartialHeatPump;
