within Buildings.Templates.Plants.HeatPumps_PNNL.Components;
model ValvesIsolation_UpdateIcon "Heat pump isolation valves"
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium model"
    annotation (__ctrlFlow(enable=false));
  final parameter Buildings.Templates.Components.Types.Valve typ=
    Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition
    "Valve type"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Integer nHp(
    final min=1)
    "Number of heat pumps"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Boolean have_chiWat
    "Set to true if the plant provides CHW"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Boolean have_valHpInlIso
    "Set to true for isolation valves at HP inlet"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Boolean have_valHpOutIso
    "Set to true for isolation valves at HP outlet"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Boolean have_pumChiWatPriDed(
    start=false)
    "Set to true for plants with separate dedicated primary CHW pumps"
    annotation (Evaluate=true,
    Dialog(group="Configuration",
      enable=have_chiWat));
  parameter Modelica.Units.SI.MassFlowRate mHeaWatHp_flow_nominal[nHp](
    each final min=0,
    each start=0)
    "HW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpHeaWatHp_nominal[nHp](
    each final min=0,
    each start=Buildings.Templates.Data.Defaults.dpChiWatChi)
    "Pressure drop at design HW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpBalHeaWatHp_nominal[nHp](
    each final min=0)=fill(0, nHp)
    "Balancing valve pressure drop at design HW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MassFlowRate mChiWatHp_flow_nominal[nHp](
    each start=0,
    each final min=0)
    "CHW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition",
      enable=have_chiWat));
  final parameter Modelica.Units.SI.PressureDifference dpChiWatHp_nominal[nHp]=
    dpHeaWatHp_nominal .*(mChiWatHp_flow_nominal ./ mHeaWatHp_flow_nominal) .^ 2
    "Pressure drop at design CHW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition",
      enable=have_chiWat));
  parameter Modelica.Units.SI.PressureDifference dpBalChiWatHp_nominal[nHp](
    each final min=0,
    each start=0)=fill(0, nHp)
    "Balancing valve pressure drop at design CHW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition",
      enable=have_chiWat));
  parameter Modelica.Units.SI.PressureDifference dpValveHeaWat_nominal[nHp]=fill(Buildings.Templates.Data.Defaults.dpValIso, nHp)
    "HW isolation valve pressure drop: identical for inlet and outlet valves"
    annotation (Dialog(group="Nominal condition"));
  final parameter Modelica.Units.SI.PressureDifference dpFixedHeaWat_nominal[nHp]=
    dpHeaWatHp_nominal + dpBalHeaWatHp_nominal
    "Fixed HW pressure drop: HP + balancing valve"
    annotation (Dialog(group="Nominal condition"));
  final parameter Modelica.Units.SI.PressureDifference dpHeaWat_nominal[nHp]=
    dpFixedHeaWat_nominal +(if have_valHpOutIso then dpValveHeaWat_nominal else fill(0, nHp)) +
    (if have_valHpInlIso then dpValveHeaWat_nominal else fill(0, nHp))
    "Total HW pressure drop: fixed + valves"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpValveChiWat_nominal[nHp](
    each start=0)=fill(Buildings.Templates.Data.Defaults.dpValIso, nHp)
    "Isolation valve CHW pressure drop: identical for inlet and outlet valves"
    annotation (Dialog(group="Nominal condition",
      enable=have_chiWat));
  final parameter Modelica.Units.SI.PressureDifference dpFixedChiWat_nominal[nHp]=
    if have_chiWat then dpChiWatHp_nominal + dpBalChiWatHp_nominal else fill(0, nHp)
    "Total fixed CHW pressure drop"
    annotation (Dialog(group="Nominal condition",
      enable=have_chiWat));
  final parameter Modelica.Units.SI.PressureDifference dpChiWat_nominal[nHp]=
    dpFixedChiWat_nominal +(if have_chiWat and have_valHpOutIso then dpValveChiWat_nominal
    else fill(0, nHp)) +(if have_chiWat and have_valHpInlIso then dpValveChiWat_nominal
    else fill(0, nHp))
    "Total CHW pressure drop: fixed + valves"
    annotation (Dialog(group="Nominal condition",
      enable=have_chiWat));
  final parameter Buildings.Templates.Components.Data.Valve datValHeaWatHpOutIso[nHp](
    each typ=typ,
    m_flow_nominal=mHeaWatHp_flow_nominal,
    dpValve_nominal=dpValveHeaWat_nominal,
    dpFixed_nominal=dpFixedHeaWat_nominal)
    "Heat pump outlet HW isolation valve parameters"
    annotation (Placement(transformation(extent={{-1904,-60},{-1884,-40}})));
  // dpFixed_nominal only applied to inlet valves if there is no outlet valve.
  final parameter Buildings.Templates.Components.Data.Valve datValHeaWatHpInlIso[nHp](
    each typ=typ,
    m_flow_nominal=mHeaWatHp_flow_nominal,
    dpValve_nominal=dpValveHeaWat_nominal,
    dpFixed_nominal=if not have_valHpOutIso then dpFixedHeaWat_nominal else fill(0, nHp))
    "Heat pump inlet HW isolation valve parameters"
    annotation (Placement(transformation(extent={{-1904,-60},{-1884,-40}})));
  final parameter Buildings.Templates.Components.Data.Valve datValChiWatHpOutIso[nHp](
    each typ=typ,
    m_flow_nominal=mChiWatHp_flow_nominal,
    dpValve_nominal=dpValveChiWat_nominal,
    dpFixed_nominal=dpFixedChiWat_nominal)
    "Heat pump outlet CHW isolation valve parameters"
    annotation (Placement(transformation(extent={{-1864,-60},{-1844,-40}})));
  // dpFixed_nominal only applied to inlet valves if there is no outlet valve.
  final parameter Buildings.Templates.Components.Data.Valve datValChiWatHpInlIso[nHp](
    each typ=typ,
    m_flow_nominal=mChiWatHp_flow_nominal,
    dpValve_nominal=dpValveChiWat_nominal,
    dpFixed_nominal=if not have_valHpOutIso then dpFixedChiWat_nominal else fill(0, nHp))
    "Heat pump inlet CHW isolation valve parameters"
    annotation (Placement(transformation(extent={{-1864,-60},{-1844,-40}})));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  parameter Modelica.Units.SI.Time tau=10
    "Time constant at nominal flow"
    annotation (Dialog(tab="Dynamics",group="Nominal condition",
      enable=energyDynamics<>Modelica.Fluid.Types.Dynamics.SteadyState),
    __ctrlFlow(enable=false));
  parameter Boolean allowFlowReversal=true
    "Set to false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions"),
    Evaluate=true);
  parameter Boolean use_inputFilter=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
    annotation (__ctrlFlow(enable=false),
  Dialog(tab="Dynamics",group="Filtered opening",
    enable=have_valHpInlIso or have_valHpOutIso));
  parameter Modelica.Units.SI.Time riseTime=120
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation (__ctrlFlow(enable=false),
  Dialog(tab="Dynamics",group="Filtered opening",
    enable=use_inputFilter and have_valHpInlIso or have_valHpOutIso));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation (__ctrlFlow(enable=false),
  Dialog(tab="Dynamics",group="Filtered opening",
    enable=use_inputFilter and have_valHpInlIso or have_valHpOutIso));
  parameter Real y_start=1
    "Initial position of actuator"
    annotation (__ctrlFlow(enable=false),
  Dialog(tab="Dynamics",group="Filtered opening",
    enable=use_inputFilter and have_valHpInlIso or have_valHpOutIso));
  parameter Boolean from_dp=true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true,
    Dialog(tab="Advanced",
      enable=have_valHpInlIso or have_valHpOutIso));
  parameter Boolean linearized=true
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation (Evaluate=true,
    Dialog(tab="Advanced",
      enable=have_valHpInlIso or have_valHpOutIso));
  Modelica.Fluid.Interfaces.FluidPort_b port_bChiWat(
    redeclare final package Medium=Medium,
    m_flow(
      max=if allowFlowReversal then + Modelica.Constants.inf else 0),
    h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    if have_chiWat
    "CHW supply (to primary loop)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-1974,60}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-1660,4})));
  Modelica.Fluid.Interfaces.FluidPort_a port_aChiWat(
    redeclare final package Medium=Medium,
    m_flow(
      min=if allowFlowReversal then - Modelica.Constants.inf else 0),
    h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    if have_chiWat
    "CHW return (from primary loop)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-1694,60}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-1660,-84})));
  Modelica.Fluid.Interfaces.FluidPort_b port_bHeaWat(
    redeclare final package Medium=Medium,
    m_flow(
      max=if allowFlowReversal then + Modelica.Constants.inf else 0),
    h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    "HW supply (to primary loop)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-2054,60}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2082,-78})));
  Modelica.Fluid.Interfaces.FluidPort_a port_aHeaWat(
    redeclare final package Medium=Medium,
    m_flow(
      min=if allowFlowReversal then - Modelica.Constants.inf else 0),
    h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    "HW return (from primary loop)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-1774,60}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2076,6})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_bChiHeaWatHp[nHp](
    redeclare each final package Medium=Medium,
    each m_flow(
      max=if allowFlowReversal then + Modelica.Constants.inf else 0),
    each h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    "CHW/HW return (HP entering)"
    annotation (Placement(transformation(extent={{-10,-40},{10,40}},rotation=90,
      origin={-1774,-340}),
      iconTransformation(extent={{-10,-40},{10,40}},rotation=90,origin={-1730,
            -336})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_aChiHeaWatHp[nHp](
    redeclare each final package Medium=Medium,
    each m_flow(
      min=if allowFlowReversal then - Modelica.Constants.inf else 0),
    each h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    if not have_pumChiWatPriDed
    "CHW/HW supply (HP leaving)"
    annotation (Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-1974,-340}),iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-1936,-338})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_aHeaWatHp[nHp](
    redeclare each final package Medium=Medium,
    each m_flow(
      min=if allowFlowReversal then - Modelica.Constants.inf else 0),
    each h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    if have_pumChiWatPriDed
    "HW supply (HP leaving)"
    annotation (Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-2054,-340}),iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-2040,-338})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_aChiWatHp[nHp](
    redeclare each final package Medium=Medium,
    each m_flow(
      min=if allowFlowReversal then - Modelica.Constants.inf else 0),
    each h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default))
    if have_pumChiWatPriDed
    "CHW supply (HP leaving)"
    annotation (Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-1894,-340}),
                            iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-1834,-336})));
  Buildings.Templates.Plants.HeatPumps.Interfaces.Bus bus
    "Plant control bus"
    annotation (Placement(transformation(extent={{-1894,40},{-1854,80}}),
      iconTransformation(extent={{-1894,26},{-1854,66}})));
  Buildings.Templates.Components.Actuators.Valve valHeaWatHpOutIso[nHp](
    redeclare each final package Medium=Medium,
    final dat=datValHeaWatHpOutIso,
    each final typ=typ,
    each final use_inputFilter=use_inputFilter,
    each final riseTime=riseTime,
    each final init=init,
    each final y_start=y_start,
    each final from_dp=from_dp,
    each final linearized=linearized)
    if have_valHpOutIso
    "HP outlet HW isolation valve"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,
      origin={-2054,-140})));
  Buildings.Templates.Components.Actuators.Valve valChiWatHpOutIso[nHp](
    redeclare each final package Medium=Medium,
    final dat=datValChiWatHpOutIso,
    each final typ=typ,
    each final use_inputFilter=use_inputFilter,
    each final riseTime=riseTime,
    each final init=init,
    each final y_start=y_start,
    each final from_dp=from_dp,
    each final linearized=linearized)
    if have_valHpOutIso and have_chiWat
    "HP outlet CHW isolation valve"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,
      origin={-1974,-140})));
  Buildings.Templates.Components.Actuators.Valve valHeaWatHpInlIso[nHp](
    redeclare each final package Medium=Medium,
    final dat=datValHeaWatHpInlIso,
    each final typ=typ,
    each final use_inputFilter=use_inputFilter,
    each final riseTime=riseTime,
    each final init=init,
    each final y_start=y_start,
    each final from_dp=from_dp,
    each final linearized=linearized)
    if have_valHpInlIso
    "HP inlet HW isolation valve"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},rotation=90,
      origin={-1774,-140})));
  Buildings.Templates.Components.Actuators.Valve valChiWatHpInlIso[nHp](
    redeclare each final package Medium=Medium,
    final dat=datValChiWatHpInlIso,
    each final typ=typ,
    each final use_inputFilter=use_inputFilter,
    each final riseTime=riseTime,
    each final init=init,
    each final y_start=y_start,
    each final from_dp=from_dp,
    each final linearized=linearized)
    if have_valHpInlIso and have_chiWat
    "HP inlet CHW isolation valve"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},rotation=90,
      origin={-1694,-140})));
  Buildings.Templates.Components.Routing.PassThroughFluid pasHeaWatHpOut[nHp](
    redeclare each final package Medium=Medium)
    if not have_valHpOutIso
    "Direct fluid pass-through"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,
      origin={-2034,-140})));
  Buildings.Templates.Components.Routing.PassThroughFluid pasChiWatHpOut[nHp](
    redeclare each final package Medium=Medium)
    if not have_valHpOutIso and have_chiWat
    "Direct fluid pass-through"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,
      origin={-1954,-140})));
  Fluid.Delays.DelayFirstOrder junHeaWatSup(
    redeclare final package Medium=Medium,
    final tau=tau,
    final m_flow_nominal=sum(mHeaWatHp_flow_nominal),
    final energyDynamics=energyDynamics,
    final allowFlowReversal=allowFlowReversal,
    final prescribedHeatFlowRate=false,
    final nPorts=nHp + 1)
    "Fluid volume at junction"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
      origin={-2034,-90})));
  Fluid.Delays.DelayFirstOrder junChiWatSup(
    redeclare final package Medium=Medium,
    final tau=tau,
    final m_flow_nominal=sum(mChiWatHp_flow_nominal),
    final energyDynamics=energyDynamics,
    final allowFlowReversal=allowFlowReversal,
    final prescribedHeatFlowRate=false,
    final nPorts=nHp + 1)
    if have_chiWat
    "Fluid volume at junction"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
      origin={-1956,-90})));
  Fluid.Delays.DelayFirstOrder junHeaWatRet(
    redeclare final package Medium=Medium,
    final tau=tau,
    final m_flow_nominal=sum(mHeaWatHp_flow_nominal),
    final energyDynamics=energyDynamics,
    final allowFlowReversal=allowFlowReversal,
    final prescribedHeatFlowRate=false,
    final nPorts=nHp + 1)
    "Fluid volume at junction"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
      origin={-1794,-90})));
  /*
  HW pressure drop computed in this component in the absence of isolation valves
  at both inlet and outlet.
  */
    Fluid.FixedResistances.PressureDrop pasHeaWatHpInl[nHp](
    redeclare each final package Medium=Medium,
    final m_flow_nominal=mHeaWatHp_flow_nominal,
    final dp_nominal=if not have_valHpInlIso and not have_valHpOutIso then dpFixedHeaWat_nominal
      else fill(0, nHp))
    if not have_valHpInlIso
    "Direct fluid pass-through with optional fluid resistance"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},rotation=90,
      origin={-1794,-140})));
  /*
  CHW pressure drop computed in this component in the absence of isolation valves
  at both inlet and outlet.
  */
    Fluid.FixedResistances.PressureDrop pasChiWatHpInl[nHp](
    redeclare each final package Medium=Medium,
    final m_flow_nominal=mChiWatHp_flow_nominal,
    final dp_nominal=if not have_valHpInlIso and not have_valHpOutIso then dpFixedChiWat_nominal
      else fill(0, nHp))
    if not have_valHpInlIso and have_chiWat
    "Direct fluid pass-through with optional fluid resistance"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},rotation=90,
      origin={-1714,-140})));
  Fluid.Delays.DelayFirstOrder junChiWatRet(
    redeclare final package Medium=Medium,
    final tau=tau,
    final m_flow_nominal=sum(mChiWatHp_flow_nominal),
    final energyDynamics=energyDynamics,
    final allowFlowReversal=allowFlowReversal,
    final prescribedHeatFlowRate=false,
    final nPorts=nHp + 1)
    if have_chiWat
    "Fluid volume at junction"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
      origin={-1714,-90})));
protected
  Buildings.Templates.Components.Interfaces.Bus busValHeaWatHpInlIso[nHp]
    if have_valHpInlIso
    "Heat pump inlet HW isolation valve control bus"
    annotation (Placement(transformation(extent={{-1834,0},{-1794,40}}),
      iconTransformation(extent={{-466,50},{-426,90}})));
  Buildings.Templates.Components.Interfaces.Bus busValHeaWatHpOutIso[nHp]
    if have_valHpOutIso
    "Heat pump outlet HW isolation valve control bus"
    annotation (Placement(transformation(extent={{-1954,0},{-1914,40}}),
      iconTransformation(extent={{-466,50},{-426,90}})));
  Buildings.Templates.Components.Interfaces.Bus busValChiWatHpInlIso[nHp]
    if have_chiWat and have_valHpInlIso
    "Heat pump inlet CHW isolation valve control bus"
    annotation (Placement(transformation(extent={{-1864,20},{-1824,60}}),
      iconTransformation(extent={{-466,50},{-426,90}})));
  Buildings.Templates.Components.Interfaces.Bus busValChiWatHpOutIso[nHp]
    if have_chiWat and have_valHpOutIso
    "Heat pump outlet CHW isolation valve control bus"
    annotation (Placement(transformation(extent={{-1924,20},{-1884,60}}),
      iconTransformation(extent={{-466,50},{-426,90}})));
equation
  connect(bus.valHeaWatHpInlIso, busValHeaWatHpInlIso)
    annotation (Line(points={{-1874,60},{-1874,20},{-1814,20}},
                                                       color={255,204,51},thickness=0.5));
  connect(bus.valHeaWatHpOutIso, busValHeaWatHpOutIso)
    annotation (Line(points={{-1874,60},{-1874,20},{-1934,20}},
                                                        color={255,204,51},thickness=0.5));
  connect(bus.valChiWatHpInlIso, busValChiWatHpInlIso)
    annotation (Line(points={{-1874,60},{-1874,40},{-1844,40}},
                                                       color={255,204,51},thickness=0.5));
  connect(bus.valChiWatHpOutIso, busValChiWatHpOutIso)
    annotation (Line(points={{-1874,60},{-1874,40},{-1904,40}},
                                                        color={255,204,51},thickness=0.5));
  connect(ports_aHeaWatHp, valHeaWatHpOutIso.port_a)
    annotation (Line(points={{-2054,-340},{-2054,-150}},
                                                     color={0,127,255}));
  connect(ports_aChiHeaWatHp, valHeaWatHpOutIso.port_a)
    annotation (Line(points={{-1974,-340},{-1994,-340},{-1994,-160},{-2054,-160},
          {-2054,-150}},
      color={0,127,255}));
  connect(ports_aChiHeaWatHp, valChiWatHpOutIso.port_a)
    annotation (Line(points={{-1974,-340},{-1974,-150}},         color={0,127,255}));
  connect(ports_aChiWatHp, valChiWatHpOutIso.port_a)
    annotation (Line(points={{-1894,-340},{-1894,-160},{-1974,-160},{-1974,-150}},
                                                                           color={0,127,255}));
  connect(ports_aHeaWatHp, pasHeaWatHpOut.port_a)
    annotation (Line(points={{-2054,-340},{-2034,-340},{-2034,-150}},      color={0,127,255}));
  connect(ports_aChiHeaWatHp, pasHeaWatHpOut.port_a)
    annotation (Line(points={{-1974,-340},{-1994,-340},{-1994,-160},{-2034,-160},
          {-2034,-150}},
      color={0,127,255}));
  connect(ports_aChiHeaWatHp, pasChiWatHpOut.port_a)
    annotation (Line(points={{-1974,-340},{-1954,-340},{-1954,-150}},    color={0,127,255}));
  connect(ports_aChiWatHp, pasChiWatHpOut.port_a)
    annotation (Line(points={{-1894,-340},{-1894,-160},{-1954,-160},{-1954,-150}},
      color={0,127,255}));
  connect(valHeaWatHpOutIso.port_b, junHeaWatSup.ports[1:nHp])
    annotation (Line(points={{-2054,-130},{-2054,-120},{-2034,-120},{-2034,-100}},
                                                                      color={0,127,255}));
  connect(pasHeaWatHpOut.port_b, junHeaWatSup.ports[1:nHp])
    annotation (Line(points={{-2034,-130},{-2034,-100}},
                                                  color={0,127,255}));
  connect(junHeaWatSup.ports[nHp + 1], port_bHeaWat)
    annotation (Line(points={{-2034,-100},{-2054,-100},{-2054,60}},
                                                             color={0,127,255}));
  connect(valChiWatHpOutIso.port_b, junChiWatSup.ports[1:nHp])
    annotation (Line(points={{-1974,-130},{-1974,-120},{-1956,-120},{-1956,-100}},
                                                                    color={0,127,255}));
  connect(pasChiWatHpOut.port_b, junChiWatSup.ports[1:nHp])
    annotation (Line(points={{-1954,-130},{-1954,-100},{-1956,-100}},
                                                         color={0,127,255}));
  connect(port_bChiWat, junChiWatSup.ports[nHp + 1])
    annotation (Line(points={{-1974,60},{-1974,-100},{-1956,-100}},
                                                            color={0,127,255}));
  connect(port_aHeaWat, junHeaWatRet.ports[nHp + 1])
    annotation (Line(points={{-1774,60},{-1774,-100},{-1794,-100}},
                                                         color={0,127,255}));
  connect(junHeaWatRet.ports[1:nHp], valHeaWatHpInlIso.port_a)
    annotation (Line(points={{-1794,-100},{-1794,-120},{-1774,-120},{-1774,-130}},
                                                                color={0,127,255}));
  connect(pasHeaWatHpInl.port_a, junHeaWatRet.ports[1:nHp])
    annotation (Line(points={{-1794,-130},{-1794,-100}},      color={0,127,255}));
  connect(port_aChiWat, junChiWatRet.ports[nHp + 1])
    annotation (Line(points={{-1694,60},{-1694,-100},{-1714,-100}},
                                                          color={0,127,255}));
  connect(valChiWatHpInlIso.port_a, junChiWatRet.ports[1:nHp])
    annotation (Line(points={{-1694,-130},{-1694,-120},{-1714,-120},{-1714,-100}},
                                                                  color={0,127,255}));
  connect(pasChiWatHpInl.port_a, junChiWatRet.ports[1:nHp])
    annotation (Line(points={{-1714,-130},{-1714,-100}},          color={0,127,255}));
  connect(pasHeaWatHpInl.port_b, ports_bChiHeaWatHp)
    annotation (Line(points={{-1794,-150},{-1794,-340},{-1774,-340}},color={0,127,255}));
  connect(valHeaWatHpInlIso.port_b, ports_bChiHeaWatHp)
    annotation (Line(points={{-1774,-150},{-1774,-340}},
                                                   color={0,127,255}));
  connect(pasChiWatHpInl.port_b, ports_bChiHeaWatHp)
    annotation (Line(points={{-1714,-150},{-1714,-320},{-1774,-320},{-1774,-340}},
                                                                         color={0,127,255}));
  connect(valChiWatHpInlIso.port_b, ports_bChiHeaWatHp)
    annotation (Line(points={{-1694,-150},{-1694,-320},{-1774,-320},{-1774,-340}},
      color={0,127,255}));
  connect(busValHeaWatHpInlIso, valHeaWatHpInlIso.bus)
    annotation (Line(points={{-1814,20},{-1764,20},{-1764,-140}},
                                                         color={255,204,51},thickness=0.5));
  connect(busValChiWatHpInlIso, valChiWatHpInlIso.bus)
    annotation (Line(points={{-1844,40},{-1684,40},{-1684,-140}},
                                                         color={255,204,51},thickness=0.5));
  connect(busValChiWatHpOutIso, valChiWatHpOutIso.bus)
    annotation (Line(points={{-1904,40},{-1984,40},{-1984,-140}},
                                                            color={255,204,51},thickness=0.5));
  connect(busValHeaWatHpOutIso, valHeaWatHpOutIso.bus)
    annotation (Line(points={{-1934,20},{-2064,20},{-2064,-140}},
                                                            color={255,204,51},thickness=0.5));

  annotation (
    defaultComponentName="valIso",
    Diagram(
      coordinateSystem(
        extent={{-2080,-340},{-1660,60}})),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-2080,-340},{-1660,60}}), graphics={
        Line(points={{1820,-508}}, color={0,0,0}), Rectangle(
          extent={{-2078,58},{-1660,-338}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(
      info="<html>
<p>
This model represents the heat pump isolation valves.
The isolation valves are modeled as two-way two-position 
valves, which can be located at the heat pump inlet and/or
outlet depending on the settings of the parameters <code>have_valHpInlIso</code>
and <code>have_valHpOutIso</code>.
It is assumed that the heat pumps always provide heating hot water.
Optionally, chilled water return and supply and the associated isolation valves
can be modeled by setting the parameter <code>have_chiWat</code> to true.
</p>
<h4>Implementation details</h4>
<p>
By default, the isolation valves are modeled considering a linear
variation of the pressure drop with the flow rate (<code>linearized=true</code>), 
as opposed to the quadratic relationship usually considered for 
a turbulent flow regime.
By limiting the size of the system of nonlinear equations, this setting 
reduces the risk of solver failure and the time to solution.
</html>", revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
end ValvesIsolation_UpdateIcon;
