within Buildings.Templates.Plants.HeatPumps_PNNL.Components;
model ExternalEnergyLoop
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "HW or CHW medium";

  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
  Modelica.Fluid.Interfaces.FluidPort_a portCon_a(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-150},{-90,-130}}),
        iconTransformation(extent={{-80,-110},{-60,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b portCon_b(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,-150},{-70,-130}}),
        iconTransformation(extent={{-20,-110},{-40,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a portEva_a(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{40,-150},{60,-130}}),
        iconTransformation(extent={{20,-110},{40,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b portEva_b(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{100,-150},{80,-130}}),
        iconTransformation(extent={{80,-110},{60,-90}})));
  Buildings.Templates.Components.Actuators.Valve valve(
    redeclare package Medium = Buildings.Media.Water,  typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=1,
      dpValve_nominal=1e-6,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-50})));
  Buildings.Templates.Components.Pumps.Single pum(have_var=false, dat(
        m_flow_nominal=1, dp_nominal(displayUnit="kPa") = 120000))
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  CoolingTowerWHeatExchanger coolingTowerWHeatExchanger(
    redeclare package Medium = Buildings.Media.Water,
    mCooTowAir_flow_nominal=8,
    mChiWat_flow_nominal=1,
    mConWat_flow_nominal=15)                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-10})));
  Buildings.Templates.Components.Actuators.Valve valve1(
    redeclare package Medium = Buildings.Media.Water,   typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=hp.mHeaWat_flow_nominal,
      dpValve_nominal=1e-6,
      dpFixed_nominal=5000))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-50})));
  Buildings.Templates.Components.HeatPumps.AirToWater hp(is_rev=false, dat=
        datHpAwNrv)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-10})));
  Buildings.Templates.Components.Pumps.Single pum1(have_var=false, dat(
        m_flow_nominal=hp.mHeaWat_flow_nominal, dp_nominal=hp.dpHeaWat_nominal +
          15000))
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  BoundaryConditions.WeatherData.Bus           busWea
    "Weather bus"
    annotation (Placement(
        transformation(extent={{-50,80},{-10,120}}), iconTransformation(extent={{-50,90},
            {-30,110}})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={
            {10,80},{50,120}}), iconTransformation(extent={{30,90},{50,110}})));
  parameter Buildings.Templates.Components.Data.HeatPump datHpAwNrv(
    final cpHeaWat_default=hp.cpHeaWat_default,
    final cpSou_default=hp.cpSou_default,
    final typ=hp.typ,
    final is_rev=hp.is_rev,
    final typMod=hp.typMod,
    mHeaWat_flow_nominal=datHpAw.capHea_nominal/abs(datHpAw.THeaWatSup_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWat_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHea_nominal=500E3,
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TSouHea_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    perFit(hea(
        P=datHpAwNrv.capHea_nominal/Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow)))
    "Non-reversible AWHP parameters"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));

  parameter Buildings.Templates.Components.Data.HeatPump datHpAw(
    final is_rev=true,
    final typ = Buildings.Templates.Components.Types.HeatPump.AirToWater,
    final typMod = Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
    mHeaWat_flow_nominal=datHpAw.capHea_nominal/abs(datHpAw.THeaWatSup_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWat_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHea_nominal=500E3,
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWat_flow_nominal=datHpAw.capCoo_nominal/abs(datHpAw.TChiWatSup_nominal -
        Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCoo_nominal=500E3,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCoo_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
    TSouHea_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    perFit(hea(
        P=datHpAw.capHea_nominal/Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow), coo(
        P=datHpAw.capCoo_nominal/Buildings.Templates.Data.Defaults.COPHpAwCoo,
        coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
        coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
    "Reversible AWHP parameters parameters"
    annotation (Placement(transformation(extent={{60,80},{80,100}})));

  Buildings.Templates.Components.Sensors.Temperature temperature(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-76})));
  Buildings.Templates.Components.Sensors.Temperature temperature1(redeclare
      package Medium = Media.Water, m_flow_nominal=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-74})));
  Buildings.Templates.Components.Sensors.Temperature temperature2(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=hp.mHeaWat_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-78})));
  Buildings.Templates.Components.Sensors.Temperature temperature3(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=hp.mHeaWat_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-78})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate(
      redeclare package Medium = Buildings.Media.Water, m_flow_nominal=1,
      final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-110})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate1(
      redeclare package Medium = Media.Water, m_flow_nominal=1,
      final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate2(
      redeclare package Medium = Buildings.Media.Water, m_flow_nominal=hp.mHeaWat_flow_nominal,
      final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-110})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate3(
      redeclare package Medium = Buildings.Media.Water, m_flow_nominal=hp.mHeaWat_flow_nominal,
      final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-110})));
  Buildings.Templates.Components.Actuators.Valve valve2(
    redeclare package Medium = Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=1,
      dpValve_nominal=1e-6,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-50})));
  Buildings.Templates.Components.Actuators.Valve valve3(
    redeclare package Medium = Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=hp.mHeaWat_flow_nominal,
      dpValve_nominal=1e-6,
      dpFixed_nominal=5000))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-50})));
  Buildings.Templates.Components.Actuators.Valve valve4(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=1,
      dpValve_nominal=1e-6,
      dpFixed_nominal=5000))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-70})));
  Buildings.Templates.Components.Actuators.Valve valve5(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=1,
      dpValve_nominal=1e-6,
      dpFixed_nominal=5000))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-70})));
equation
  connect(valve.port_b, pum.port_a)
    annotation (Line(points={{-100,-40},{-100,20},{-90,20}},
                                                           color={0,127,255}));
  connect(pum.port_b, coolingTowerWHeatExchanger.port_a)
    annotation (Line(points={{-70,20},{-60,20},{-60,0}}, color={0,127,255}));
  connect(hp.port_b, valve1.port_a)
    annotation (Line(points={{90,-20},{90,-40}}, color={0,127,255}));
  connect(hp.port_a, pum1.port_b)
    annotation (Line(points={{90,0},{90,20},{80,20}}, color={0,127,255}));
  connect(coolingTowerWHeatExchanger.busWea, busWea) annotation (Line(
      points={{-50,-6},{-30,-6},{-30,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hp.busWea, busWea) annotation (Line(
      points={{100,-4},{100,6},{-30,6},{-30,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.coolingPumpBus, pum.bus) annotation (Line(
      points={{30.1,100.1},{30.1,30},{-80,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.heatingPumpBus, pum1.bus) annotation (Line(
      points={{30.1,100.1},{30.1,38},{70,38},{70,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.heatPumpBus, hp.bus) annotation (Line(
      points={{30.1,100.1},{30.1,38},{110,38},{110,-10},{100,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.coolingTowerSystemBus, coolingTowerWHeatExchanger.bus)
    annotation (Line(
      points={{30.1,100.1},{30.1,22},{30,22},{30,-14},{-50.1,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valve.port_a, temperature.port_b)
    annotation (Line(points={{-100,-60},{-100,-66}},
                                                   color={0,127,255}));
  connect(temperature2.port_a, valve1.port_b)
    annotation (Line(points={{90,-68},{90,-60}}, color={0,127,255}));
  connect(portCon_a, volumeFlowRate.port_a)
    annotation (Line(points={{-100,-140},{-100,-120}},
                                                     color={0,127,255}));
  connect(volumeFlowRate.port_b, temperature.port_a)
    annotation (Line(points={{-100,-100},{-100,-86}},
                                                    color={0,127,255}));
  connect(temperature1.port_b, volumeFlowRate1.port_a)
    annotation (Line(points={{-60,-84},{-60,-100}}, color={0,127,255}));
  connect(volumeFlowRate1.port_b, portCon_b)
    annotation (Line(points={{-60,-120},{-60,-140}}, color={0,127,255}));
  connect(volumeFlowRate2.port_b, temperature3.port_a)
    annotation (Line(points={{50,-100},{50,-88}}, color={0,127,255}));
  connect(volumeFlowRate2.port_a, portEva_a)
    annotation (Line(points={{50,-120},{50,-140}}, color={0,127,255}));
  connect(portEva_b, volumeFlowRate3.port_b)
    annotation (Line(points={{90,-140},{90,-120}}, color={0,127,255}));
  connect(volumeFlowRate3.port_a, temperature2.port_b)
    annotation (Line(points={{90,-100},{90,-88}}, color={0,127,255}));
  connect(coolingTowerWHeatExchanger.port_b, valve2.port_a)
    annotation (Line(points={{-60,-20},{-60,-40}}, color={0,127,255}));
  connect(valve2.port_b, temperature1.port_a)
    annotation (Line(points={{-60,-60},{-60,-64}}, color={0,127,255}));
  connect(temperature3.port_b, valve3.port_a)
    annotation (Line(points={{50,-68},{50,-60}}, color={0,127,255}));
  connect(valve3.port_b, pum1.port_a)
    annotation (Line(points={{50,-40},{50,20},{60,20}}, color={0,127,255}));
  connect(bus.coolingInletValveBus, valve.bus) annotation (Line(
      points={{30.1,100.1},{30.1,25},{-110,25},{-110,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.coolingOutletValveBus, valve2.bus) annotation (Line(
      points={{30.1,100.1},{30.1,-50},{-50,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.heatingInletValveBus, valve3.bus) annotation (Line(
      points={{30.1,100.1},{30,100.1},{30,-50},{40,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.heatingOutletValveBus, valve1.bus) annotation (Line(
      points={{30.1,100.1},{30.1,-26},{100,-26},{100,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(valve4.port_b, pum.port_a) annotation (Line(points={{-30,-60},{-30,
          -32},{-90,-32},{-90,20}}, color={0,127,255}));
  connect(coolingTowerWHeatExchanger.port_b, valve5.port_a) annotation (Line(
        points={{-60,-20},{-60,-34},{10,-34},{10,-60}}, color={0,127,255}));
  connect(valve4.port_a, temperature3.port_b) annotation (Line(points={{-30,-80},
          {-30,-100},{32,-100},{32,-68},{50,-68}}, color={0,127,255}));
  connect(valve5.port_b, temperature2.port_a) annotation (Line(points={{10,-80},
          {28,-80},{28,-64},{90,-64},{90,-68}}, color={0,127,255}));
  connect(bus.wseInletValveBus, valve4.bus) annotation (Line(
      points={{30.1,100.1},{30.1,-50},{-40,-50},{-40,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.wseOutletValveBus, valve5.bus) annotation (Line(
      points={{30.1,100.1},{30.1,-50},{20,-50},{20,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-140},{120,
            100}})));
end ExternalEnergyLoop;
