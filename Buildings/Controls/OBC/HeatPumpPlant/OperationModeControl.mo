within Buildings.Controls.OBC.HeatPumpPlant;
block OperationModeControl "Sequences for operation mode control"

  parameter Real dtMea(
    final min=0,
    final unit="s")=300
    "Duration used to compute the moving average of required heating or cooling load";

  parameter Real dtMod1(
    final min=0,
    final unit="s")=300
    "Duration used to switch operation mode";

  parameter Real dtMod2(
    final min=0,
    final unit="s")=300
    "Duration used to switch operation mode";

  parameter Real dtMod3(
    final min=0,
    final unit="s")=300
    "Duration used to switch operation mode";

  parameter Real dtMod4(
    final min=0,
    final unit="s")=300
    "Duration used to switch operation mode";

  parameter Real rho_default(
    final min=0,
    final unit="kg/m3")=996
    "Default density used to compute required capacity";

  parameter Real cp_default(
    final min=0,
    final unit="J/(kg.K)")=4184
    "Default specific heat capacity used to compute required capacity";

  parameter Real T_CHWRetMin(
    final unit="K")= 273.15 + 10
    "Minimum threshold for chilled water return temperature";

  parameter Real T_HHWRetMax(
    final unit="K")= 273.15 + 52
    "Minimum threshold for chilled water return temperature";

  parameter Real T_CHWSupSetMax(
    final unit="K")= 273.15 + 9
    "Maximum chilled water supply temperature setpoint allowed by heat-recovery chiller";

  parameter Real uLow(
    final min=0,
    final unit="W")=-500
    "Hysteresis low value for determining heating load";

  parameter Real uHigh(
    final min=0,
    final unit="W")=500
    "Hysteresis high value for determining cooling load";

  parameter Real tMinRun(
    final unit="s",
    displayUnit="min",
    final quantity="time") = 900
    "Minimum run time for each operation mode";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uProCom
    "Staging process completion signal"
    annotation (Placement(transformation(extent={{-340,200},{-300,240}}),
      iconTransformation(extent={{-140,180},{-100,220}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHotTanCha
    "Hot thermal energy storage dedicated charging mode enable signal"
    annotation (Placement(transformation(extent={{-340,160},{-300,200}}),
      iconTransformation(extent={{-140,140},{-100,180}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uCooTanCha
    "Cold thermal energy storage dedicated charging mode enable signal"
    annotation (Placement(transformation(extent={{-340,120},{-300,160}}),
      iconTransformation(extent={{-140,100},{-100,140}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPlaEna
    "Plant enable signal"
    annotation (Placement(transformation(extent={{-340,80},{-300,120}}),
      iconTransformation(extent={{-140,60},{-100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaSupSet(
    final unit="K",
    displayUnit="degC")
    "Heating hot water loop supply temperature setpoint"
    annotation (Placement(transformation(extent={{-340,40},{-300,80}}),
      iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaRet(
    final unit="K",
    displayUnit="degC")
    "Heating hot water loop return temperature"
    annotation (Placement(transformation(extent={{-340,0},{-300,40}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VWatHot_flow(
    final unit="m3/s")
    "Heating hot water loop volume flow rate"
    annotation (Placement(transformation(extent={{-340,-40},{-300,0}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiSup(
    final unit="K",
    displayUnit="degC")
    "Measured chilled water loop supply temperature"
    annotation (Placement(transformation(extent={{-340,-80},{-300,-40}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiSupSet(
    final unit="K",
    displayUnit="degC")
    "Chilled water loop supply temperature setpoint"
    annotation (Placement(transformation(extent={{-340,-120},{-300,-80}}),
      iconTransformation(extent={{-140,-140},{-100,-100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiRet(
    final unit="K",
    displayUnit="degC")
    "Chilled water loop return temperature"
    annotation (Placement(transformation(extent={{-340,-160},{-300,-120}}),
      iconTransformation(extent={{-140,-180},{-100,-140}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VWatChi_flow(
    final unit="m3/s")
    "Chilled water loop volume flow rate"
    annotation (Placement(transformation(extent={{-340,-200},{-300,-160}}),
      iconTransformation(extent={{-140,-220},{-100,-180}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod
    "Operation mode"
    annotation (Placement(transformation(extent={{400,-20},{440,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timEnaHea2(t=dtMod4)
    "Enable heating-2 only when enable conditions are continuously met for threshold time duration"
    annotation (Placement(transformation(extent={{-30,140},{-10,160}})));

  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThrCHWRet(
    final t=T_CHWRetMin)
    "Check if the chilled water loop return temperature is lower than the the minimum allowed return temperature"
    annotation (Placement(transformation(extent={{-200,140},{-180,160}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timCoo1(t=dtMod1)
    "Check if enable conditon is continuously true for threshold time duration"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timEnaCoo3(t=dtMod3)
    "Check if enable conditon is continuously true for threshold time duration"
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrEnaCoo3(
    final t=T_HHWRetMax)
    "Check if hot water loop return temperature is greater than the maximum allowed temperature"
    annotation (Placement(transformation(extent={{-220,-160},{-200,-140}})));

  Buildings.Controls.OBC.HeatPumpPlant.RequiredCapacity capReqHea(
    final rho_default=rho_default,
    final cp_default=cp_default,
    final dtMea=dtMea)
    "Required heating capacity"
    annotation (Placement(transformation(extent={{-260,20},{-240,40}})));

  Buildings.Controls.OBC.HeatPumpPlant.RequiredCapacity capReqCoo(
    final rho_default=rho_default,
    final cp_default=cp_default,
    final dtMea=dtMea)
    "Required cooling capacity"
    annotation (Placement(transformation(extent={{-260,-140},{-240,-120}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latDis
    "Latch to hold plant disable status"
    annotation (Placement(transformation(extent={{120,40},{140,60}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToIntOpeMod[8]
    "Convert operation mode enable signals to Integers"
    annotation (Placement(transformation(extent={{180,-30},{200,-10}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conIntOpeMods[8](
    k={Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Disabled,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4})
    "Constant Integer sources for the various available operation modes"
    annotation (Placement(transformation(extent={{180,10},{200,30}})));

  Buildings.Controls.OBC.CDL.Integers.Multiply mulIntOpeMod[8]
    "Output non-zero integer value only for enabled mode"
    annotation (Placement(transformation(extent={{220,-10},{240,10}})));

  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumIntOpeMod(
    final nin=8)
    "Sum all mode integer outputs to determine currently enabled mode"
    annotation (Placement(transformation(extent={{260,-10},{280,10}})));

  Buildings.Controls.OBC.CDL.Logical.Not notCooLoa
    "Check if dominant load is heating and not cooling"
    annotation (Placement(transformation(extent={{-140,90},{-120,110}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timEnaHea1(
    final t=dtMod1)
    "Check if the conditions for enabling heating-1 are continuously met for threshold time duration"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latCoo1
    "Latch to hold enable status of cooling-1 mode"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latHea1
    "Latch to hold enable status of heating-1 mode"
    annotation (Placement(transformation(extent={{120,80},{140,100}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latHea2
    "Latch to hold enable status of heating-2 mode"
    annotation (Placement(transformation(extent={{120,120},{140,140}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latHea3
    "Latch to hold enable status of heating-3 mode"
    annotation (Placement(transformation(extent={{120,160},{140,180}})));

  Buildings.Controls.OBC.CDL.Logical.Not not4
    "Disable latch when input signal becomes false"
    annotation (Placement(transformation(extent={{60,140},{80,160}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAndEnaHea1(
    final nin=3)
    "Enable heating-1 only when the plant is enabled and other conditions are met"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));

  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdgPlaEna
    "Detect plant enable signal changing from enable to disable"
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latCoo2
    "Latch to hold enable status of cooling-2 mode"
    annotation (Placement(transformation(extent={{120,-110},{140,-90}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latCoo3
    "Latch to hold enable status of cooling-3 mode"
    annotation (Placement(transformation(extent={{120,-170},{140,-150}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latCoo4
    "Latch to hold enable status of cooling-4 mode"
    annotation (Placement(transformation(extent={{120,-210},{140,-190}})));

  Buildings.Controls.OBC.CDL.Logical.And andEnaCoo3
    "Enable cooling-3 only if the plant is enabled and other conditions are met"
    annotation (Placement(transformation(extent={{-140,-160},{-120,-140}})));

  Buildings.Controls.OBC.CDL.Logical.Not notDisCoo4
    "Check if enable condition for cooling-4 is not met"
    annotation (Placement(transformation(extent={{60,-230},{80,-210}})));

  Buildings.Controls.OBC.CDL.Logical.Latch latOpeMod
    "Latch to drive minimum runtime timer"
    annotation (Placement(transformation(extent={{230,-60},{250,-40}})));

  Buildings.Controls.OBC.CDL.Integers.Change chaOpeMod
    "Detect changes in operation mode output"
    annotation (Placement(transformation(extent={{190,-90},{210,-70}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timOpeMod(
    t=tMinRun)
    "Check if operation mode has been enabled for minimum runtime duration"
    annotation (Placement(transformation(extent={{260,-60},{280,-40}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToReaOpeMod
    "Convert operation mode output integer to real signal for sampling"
    annotation (Placement(transformation(extent={{300,-50},{320,-30}})));

  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSamOpeMod
    "Sample output when operation mode changes"
    annotation (Placement(transformation(extent={{330,-50},{350,-30}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToIntOpeMod
    "Convert sampled real value back to integer"
    annotation (Placement(transformation(extent={{360,-50},{380,-30}})));

  Buildings.Controls.OBC.CDL.Logical.And andEnaHea2
    "Enable heating-2 only when plant is enabled and condition is met"
    annotation (Placement(transformation(extent={{-120,140},{-100,160}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwiOpeMod
    "Switch to hold previously enabled operation mode when minimum run time threshold has not been crossed"
    annotation (Placement(transformation(extent={{360,-10},{380,10}})));

  Buildings.Controls.OBC.CDL.Logical.Pre preMinRun
    "Pre block for routing back signal indicating minimum runtime threshold has been crossed"
    annotation (Placement(transformation(extent={{300,-110},{320,-90}})));

  Buildings.Controls.OBC.CDL.Logical.Not notDisHea2
    "Check if enable status is not met for heating-2"
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim6(t=dtMod4)
    "Disable heating-2 only when disable conditions are continuously met for threshold time duration"
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd andEnaCoo1(
    final nin=3)
    "Enable lowest cooling dominant mode operation only when plant is enabled and current mode is disabled or lowest heating"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

  Buildings.Controls.OBC.CDL.Logical.Not notDisCoo3
    "Check if enable condition for cooling-3 is not met"
    annotation (Placement(transformation(extent={{-100,-190},{-80,-170}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timDisCoo3(t=dtMod3)
    "Check if disable conditon is continuously true for threshold time duration"
    annotation (Placement(transformation(extent={{-40,-190},{-20,-170}})));

  Buildings.Controls.OBC.CDL.Reals.Greater greChiSup
    "Check if chilled water loop supply temperature is greater than setpoint"
    annotation (Placement(transformation(extent={{-200,-80},{-180,-60}})));

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysDomLoa(
    final uLow=uLow,
    final uHigh=uHigh)
    "Determine dominant load between hot water and chilled water loop"
    annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));

  Buildings.Controls.OBC.CDL.Reals.Subtract subDomLoa
    "Relative difference between the calculated loads on the hot water loop and the chilled water loop"
    annotation (Placement(transformation(extent={{-220,-50},{-200,-30}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrDisCoo2(
    final t=T_CHWSupSetMax)
    "Check if chilled water loop supply temperature setpoint is greater than maximum allowed setpoint on the heat recovery heat pump"
    annotation (Placement(transformation(extent={{-220,-120},{-200,-100}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timDisCoo2(t=dtMod2)
    "Check if disable conditon is continuously true for threshold time duration"
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre1[8]
    "Pre block for routing back enable status signals of the various operation modes"
    annotation (Placement(transformation(extent={{180,60},{200,80}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOrDisHea1(
    final nin=3)
    "Check conditions for disabling heating-1"
    annotation (Placement(transformation(extent={{80,60},{100,80}})));

  Buildings.Controls.OBC.CDL.Logical.And andEnaPreModHea2
    "Enable heating-2 only when previous mode is heating-1"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));

  Buildings.Controls.OBC.CDL.Logical.And and6
    "Disable heating-2 only when it is enabled"
    annotation (Placement(transformation(extent={{-50,100},{-30,120}})));

  Buildings.Controls.OBC.CDL.Logical.Or orEnaHea1
    "Enable heating-1 either when conditions are satisfied or when heating-2 is disabled"
    annotation (Placement(transformation(extent={{80,90},{100,110}})));

  Buildings.Controls.OBC.CDL.Logical.Or orOpeModEnaHea1
    "Check if current operating mode is disabled or cooling-1"
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunEnaHea2
    "Enable mode only when previous mode has been enabled for minimum runtime"
    annotation (Placement(transformation(extent={{10,140},{30,160}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunDisHea2
    "Disable and enable modes only when previous mode has been enabled for minimum runtime"
    annotation (Placement(transformation(extent={{10,100},{30,120}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunEnaHea1
    "Enable mode only when previous mode has been enabled for minimum runtime"
    annotation (Placement(transformation(extent={{10,70},{30,90}})));

  Buildings.Controls.OBC.CDL.Logical.Or orOpeModEnaCoo1
    "Enable cooling-1 only if previous operation modes are disabled or heating-1"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunEnaCoo1
    "Enable mode only after previous mode has been active for minimum run time"
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOrDisCoo1(
    nin=3)
    "Disable cooling-1 when any of the disable conditions become true"
    annotation (Placement(transformation(extent={{80,-64},{100,-44}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAndEnaCoo2(
    final nin=3)
    "Enable cooling-2 only if plant is enabled and other conditions are met"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timEnaCoo2(t=dtMod2)
    "Check if enable conditon is continuously true for threshold time duration"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));

  Buildings.Controls.OBC.CDL.Logical.Or orEnaCoo2
    "Check all conditions for enabling cooling-2"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunEnaCoo2
    "Enable mode only after previous mode has been active for minimum run time"
    annotation (Placement(transformation(extent={{10,-80},{30,-60}})));

  Buildings.Controls.OBC.CDL.Logical.Or orDisCoo5
    "Check all conditions for disabling cooling-2"
    annotation (Placement(transformation(extent={{80,-120},{100,-100}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunDisCoo2
    "Disable mode only after previous mode has been active for minimum run time"
    annotation (Placement(transformation(extent={{10,-120},{30,-100}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd andDisCoo2(
    final nin=3)
    "Disable cooling-2 when the plant is enabled and other conditions are met"
    annotation (Placement(transformation(extent={{-140,-120},{-120,-100}})));

  Buildings.Controls.OBC.CDL.Logical.And andOpeModEnaCoo3
    "Enable cooling-3 only if the previous mode was cooling-2"
    annotation (Placement(transformation(extent={{-100,-160},{-80,-140}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunEnaCoo3
    "Enable mode only after previous mode has been active for minimum run time"
    annotation (Placement(transformation(extent={{10,-160},{30,-140}})));

  Buildings.Controls.OBC.CDL.Logical.And andDisCoo3
    "Disable cooling-3 only if the current operating mode is cooling-3"
    annotation (Placement(transformation(extent={{-70,-190},{-50,-170}})));

  Buildings.Controls.OBC.CDL.Logical.And andMinRunDisCoo3
    "Disable mode only after previous mode has been active for minimum run time"
    annotation (Placement(transformation(extent={{10,-190},{30,-170}})));

  Buildings.Controls.OBC.CDL.Logical.Or orDisPla
    "Check conditions for setting disable mode latch"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  Buildings.Controls.OBC.CDL.Logical.Not notDisPla
    "Check if plant is disabled"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));

  Buildings.Controls.OBC.CDL.Logical.Or orEnaPla
    "Check for conditions for enabling plant"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Buildings.Controls.OBC.CDL.Logical.Or orEnaCoo1
    "Enable cooling mode-1 when either enable conditios are met"
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));

equation
  connect(TChiRet, lesThrCHWRet.u) annotation (Line(points={{-320,-140},{-274,-140},
          {-274,150},{-202,150}}, color={0,0,127}));
  connect(THeaRet,greThrEnaCoo3. u)
    annotation (Line(points={{-320,20},{-280,20},{-280,-150},{-222,-150}},
                                                     color={0,0,127}));
  connect(THeaSupSet, capReqHea.TSupSet) annotation (Line(points={{-320,60},{
          -292,60},{-292,34},{-262,34}},
                                       color={0,0,127}));
  connect(THeaRet, capReqHea.TRet) annotation (Line(points={{-320,20},{-280,20},
          {-280,30},{-262,30}},    color={0,0,127}));
  connect(VWatHot_flow, capReqHea.V_flow) annotation (Line(points={{-320,-20},{
          -266,-20},{-266,26},{-262,26}}, color={0,0,127}));
  connect(TChiSupSet, capReqCoo.TSupSet) annotation (Line(points={{-320,-100},{-270,
          -100},{-270,-126},{-262,-126}},      color={0,0,127}));
  connect(TChiRet, capReqCoo.TRet) annotation (Line(points={{-320,-140},{-274,-140},
          {-274,-130},{-262,-130}},       color={0,0,127}));
  connect(VWatChi_flow, capReqCoo.V_flow) annotation (Line(points={{-320,-180},{
          -270,-180},{-270,-134},{-262,-134}},  color={0,0,127}));
  connect(conIntOpeMods.y, mulIntOpeMod.u1) annotation (Line(points={{202,20},{
          214,20},{214,6},{218,6}}, color={255,127,0}));
  connect(booToIntOpeMod.y, mulIntOpeMod.u2) annotation (Line(points={{202,-20},
          {214,-20},{214,-6},{218,-6}}, color={255,127,0}));
  connect(latDis.y, booToIntOpeMod[4].u) annotation (Line(points={{142,50},{160,
          50},{160,-20},{178,-20}}, color={255,0,255}));
  connect(not4.y, latHea3.clr) annotation (Line(points={{82,150},{112,150},{112,
          164},{118,164}}, color={255,0,255}));
  connect(latHea3.y, booToIntOpeMod[1].u) annotation (Line(points={{142,170},{
          160,170},{160,-20},{178,-20}}, color={255,0,255}));
  connect(uPlaEna, falEdgPlaEna.u) annotation (Line(points={{-320,100},{-160,
          100},{-160,20},{-142,20}}, color={255,0,255}));
  connect(mulAndEnaHea1.y, timEnaHea1.u)
    annotation (Line(points={{-78,80},{-62,80}}, color={255,0,255}));
  connect(latHea1.y, booToIntOpeMod[3].u) annotation (Line(points={{142,90},{
          160,90},{160,-20},{178,-20}}, color={255,0,255}));
  connect(latHea2.y, booToIntOpeMod[2].u) annotation (Line(points={{142,130},{
          160,130},{160,-20},{178,-20}}, color={255,0,255}));
  connect(latCoo1.y, booToIntOpeMod[5].u) annotation (Line(points={{142,-30},{
          160,-30},{160,-20},{178,-20}}, color={255,0,255}));
  connect(uHotTanCha, not4.u) annotation (Line(points={{-320,180},{40,180},{40,
          150},{58,150}}, color={255,0,255}));
  connect(uHotTanCha, latHea3.u) annotation (Line(points={{-320,180},{40,180},{
          40,170},{118,170}}, color={255,0,255}));
  connect(uCooTanCha, latCoo4.u) annotation (Line(points={{-320,140},{-234,140},
          {-234,-200},{118,-200}}, color={255,0,255}));
  connect(latCoo2.y, booToIntOpeMod[6].u) annotation (Line(points={{142,-100},{
          160,-100},{160,-20},{178,-20}}, color={255,0,255}));
  connect(latCoo3.y, booToIntOpeMod[7].u) annotation (Line(points={{142,-160},{
          160,-160},{160,-20},{178,-20}}, color={255,0,255}));
  connect(latCoo4.y, booToIntOpeMod[8].u) annotation (Line(points={{142,-200},{
          160,-200},{160,-20},{178,-20}}, color={255,0,255}));
  connect(notDisCoo4.y, latCoo4.clr) annotation (Line(points={{82,-220},{112,-220},
          {112,-206},{118,-206}}, color={255,0,255}));
  connect(uCooTanCha, notDisCoo4.u) annotation (Line(points={{-320,140},{-234,
          140},{-234,-220},{58,-220}}, color={255,0,255}));
  connect(mulSumIntOpeMod.y, chaOpeMod.u) annotation (Line(points={{282,0},{290,
          0},{290,-32},{176,-32},{176,-80},{188,-80}}, color={255,127,0}));
  connect(chaOpeMod.y, latOpeMod.clr) annotation (Line(points={{212,-80},{220,-80},
          {220,-56},{228,-56}}, color={255,0,255}));
  connect(uProCom, latOpeMod.u) annotation (Line(points={{-320,220},{168,220},{
          168,-50},{228,-50}}, color={255,0,255}));
  connect(latOpeMod.y, timOpeMod.u)
    annotation (Line(points={{252,-50},{258,-50}}, color={255,0,255}));
  connect(mulSumIntOpeMod.y, intToReaOpeMod.u) annotation (Line(points={{282,0},
          {290,0},{290,-40},{298,-40}}, color={255,127,0}));
  connect(intToReaOpeMod.y, triSamOpeMod.u)
    annotation (Line(points={{322,-40},{328,-40}}, color={0,0,127}));
  connect(triSamOpeMod.y, reaToIntOpeMod.u)
    annotation (Line(points={{352,-40},{358,-40}}, color={0,0,127}));
  connect(intSwiOpeMod.y, yOpeMod)
    annotation (Line(points={{382,0},{420,0}}, color={255,127,0}));
  connect(reaToIntOpeMod.y, intSwiOpeMod.u3) annotation (Line(points={{382,-40},
          {390,-40},{390,-20},{350,-20},{350,-8},{358,-8}}, color={255,127,0}));
  connect(mulSumIntOpeMod.y, intSwiOpeMod.u1) annotation (Line(points={{282,0},
          {290,0},{290,8},{358,8}}, color={255,127,0}));
  connect(timOpeMod.passed, intSwiOpeMod.u2) annotation (Line(points={{282,-58},
          {294,-58},{294,0},{358,0}}, color={255,0,255}));
  connect(chaOpeMod.y, triSamOpeMod.trigger) annotation (Line(points={{212,-80},
          {340,-80},{340,-52}}, color={255,0,255}));
  connect(mulIntOpeMod.y, mulSumIntOpeMod.u)
    annotation (Line(points={{242,0},{258,0}}, color={255,127,0}));
  connect(timOpeMod.passed, preMinRun.u) annotation (Line(points={{282,-58},{
          294,-58},{294,-100},{298,-100}}, color={255,0,255}));
  connect(andEnaHea2.y, notDisHea2.u) annotation (Line(points={{-98,150},{-92,
          150},{-92,110},{-82,110}}, color={255,0,255}));
  connect(andEnaCoo3.y, notDisCoo3.u) annotation (Line(points={{-118,-150},{-110,
          -150},{-110,-180},{-102,-180}}, color={255,0,255}));
  connect(TChiSup, greChiSup.u1) annotation (Line(points={{-320,-60},{-250,-60},
          {-250,-70},{-202,-70}}, color={0,0,127}));
  connect(TChiSupSet, greChiSup.u2) annotation (Line(points={{-320,-100},{-250,
          -100},{-250,-78},{-202,-78}}, color={0,0,127}));
  connect(hysDomLoa.y, notCooLoa.u) annotation (Line(points={{-168,-40},{-152,-40},
          {-152,100},{-142,100}}, color={255,0,255}));
  connect(hysDomLoa.u, subDomLoa.y)
    annotation (Line(points={{-192,-40},{-198,-40}}, color={0,0,127}));
  connect(capReqHea.yCapReq, subDomLoa.u2) annotation (Line(points={{-238,30},{
          -226,30},{-226,-46},{-222,-46}}, color={0,0,127}));
  connect(capReqCoo.yCapReq, subDomLoa.u1) annotation (Line(points={{-238,-130},
          {-232,-130},{-232,-34},{-222,-34}}, color={0,0,127}));
  connect(TChiSupSet,greThrDisCoo2. u) annotation (Line(points={{-320,-100},{-250,
          -100},{-250,-110},{-222,-110}},    color={0,0,127}));
  connect(uPlaEna, andEnaCoo1.u[1]) annotation (Line(points={{-320,100},{-160,
          100},{-160,-42.3333},{-62,-42.3333}}, color={255,0,255}));
  connect(latHea3.y, pre1[1].u) annotation (Line(points={{142,170},{160,170},{160,
          70},{178,70}}, color={255,0,255}));
  connect(latHea2.y, pre1[2].u) annotation (Line(points={{142,130},{160,130},{160,
          70},{178,70}}, color={255,0,255}));
  connect(latHea1.y, pre1[3].u) annotation (Line(points={{142,90},{160,90},{160,
          70},{178,70}}, color={255,0,255}));
  connect(latDis.y, pre1[4].u) annotation (Line(points={{142,50},{160,50},{160,70},
          {178,70}}, color={255,0,255}));
  connect(latCoo1.y, pre1[5].u) annotation (Line(points={{142,-30},{160,-30},{160,
          70},{178,70}}, color={255,0,255}));
  connect(latCoo2.y, pre1[6].u) annotation (Line(points={{142,-100},{160,-100},{
          160,70},{178,70}},
                         color={255,0,255}));
  connect(latCoo3.y, pre1[7].u) annotation (Line(points={{142,-160},{160,-160},{
          160,70},{178,70}}, color={255,0,255}));
  connect(latCoo4.y, pre1[8].u) annotation (Line(points={{142,-200},{160,-200},{
          160,70},{178,70}}, color={255,0,255}));
  connect(mulOrDisHea1.y, latHea1.clr) annotation (Line(points={{102,70},{110,
          70},{110,84},{118,84}}, color={255,0,255}));
  connect(lesThrCHWRet.y, andEnaHea2.u1)
    annotation (Line(points={{-178,150},{-122,150}}, color={255,0,255}));
  connect(uPlaEna, andEnaHea2.u2) annotation (Line(points={{-320,100},{-160,100},
          {-160,142},{-122,142}}, color={255,0,255}));
  connect(andEnaHea2.y, andEnaPreModHea2.u1)
    annotation (Line(points={{-98,150},{-82,150}}, color={255,0,255}));
  connect(andEnaPreModHea2.y, timEnaHea2.u)
    annotation (Line(points={{-58,150},{-32,150}}, color={255,0,255}));
  connect(notDisHea2.y, and6.u1)
    annotation (Line(points={{-58,110},{-52,110}}, color={255,0,255}));
  connect(tim6.u, and6.y)
    annotation (Line(points={{-22,110},{-28,110}}, color={255,0,255}));
  connect(pre1[3].y, andEnaPreModHea2.u2) annotation (Line(points={{202,70},{
          212,70},{212,200},{-88,200},{-88,142},{-82,142}}, color={255,0,255}));
  connect(pre1[2].y, and6.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-56,200},{-56,102},{-52,102}}, color={255,0,255}));
  connect(orEnaHea1.y, latHea1.u) annotation (Line(points={{102,100},{110,100},
          {110,90},{118,90}}, color={255,0,255}));
  connect(notCooLoa.y, mulAndEnaHea1.u[1]) annotation (Line(points={{-118,100},
          {-110,100},{-110,77.6667},{-102,77.6667}}, color={255,0,255}));
  connect(uPlaEna, mulAndEnaHea1.u[2]) annotation (Line(points={{-320,100},{-160,
          100},{-160,80},{-102,80}}, color={255,0,255}));
  connect(orOpeModEnaHea1.y, mulAndEnaHea1.u[3]) annotation (Line(points={{-118,60},
          {-110,60},{-110,82.3333},{-102,82.3333}},     color={255,0,255}));
  connect(pre1[4].y, orOpeModEnaHea1.u1) annotation (Line(points={{202,70},{212,
          70},{212,200},{-146,200},{-146,60},{-142,60}}, color={255,0,255}));
  connect(pre1[5].y, orOpeModEnaHea1.u2) annotation (Line(points={{202,70},{212,
          70},{212,200},{-146,200},{-146,52},{-142,52}}, color={255,0,255}));
  connect(andMinRunEnaHea2.y, latHea2.u) annotation (Line(points={{32,150},{36,
          150},{36,136},{118,136},{118,130}}, color={255,0,255}));
  connect(timEnaHea2.passed, andMinRunEnaHea2.u2)
    annotation (Line(points={{-8,142},{8,142}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunEnaHea2.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,150},{8,150}}, color={255,0,255}));
  connect(andMinRunDisHea2.y, orEnaHea1.u1) annotation (Line(points={{32,110},{
          70,110},{70,100},{78,100}}, color={255,0,255}));
  connect(andMinRunDisHea2.y, latHea2.clr) annotation (Line(points={{32,110},{
          70,110},{70,124},{118,124}}, color={255,0,255}));
  connect(tim6.passed, andMinRunDisHea2.u2)
    annotation (Line(points={{2,102},{8,102}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunDisHea2.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,110},{8,110}}, color={255,0,255}));
  connect(timEnaHea1.passed, andMinRunEnaHea1.u2)
    annotation (Line(points={{-38,72},{8,72}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunEnaHea1.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,80},{8,80}}, color={255,0,255}));
  connect(andMinRunEnaHea1.y, orEnaHea1.u2) annotation (Line(points={{32,80},{
          70,80},{70,92},{78,92}}, color={255,0,255}));
  connect(andMinRunEnaHea2.y, mulOrDisHea1.u[1]) annotation (Line(points={{32,150},
          {36,150},{36,67.6667},{78,67.6667}},      color={255,0,255}));
  connect(orOpeModEnaCoo1.y, andEnaCoo1.u[2]) annotation (Line(points={{-118,-20},
          {-110,-20},{-110,-40},{-62,-40}}, color={255,0,255}));
  connect(pre1[3].y, orOpeModEnaCoo1.u1) annotation (Line(points={{202,70},{212,
          70},{212,200},{-146,200},{-146,-20},{-142,-20}}, color={255,0,255}));
  connect(pre1[4].y, orOpeModEnaCoo1.u2) annotation (Line(points={{202,70},{212,
          70},{212,200},{-146,200},{-146,-28},{-142,-28}}, color={255,0,255}));
  connect(timCoo1.passed, andMinRunEnaCoo1.u2)
    annotation (Line(points={{2,-48},{8,-48}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunEnaCoo1.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,-40},{8,-40}}, color={255,0,255}));
  connect(andEnaCoo1.y, timCoo1.u)
    annotation (Line(points={{-38,-40},{-22,-40}}, color={255,0,255}));
  connect(andMinRunEnaCoo1.y, mulOrDisHea1.u[2]) annotation (Line(points={{32,
          -40},{40,-40},{40,70},{78,70}}, color={255,0,255}));
  connect(mulOrDisCoo1.y, latCoo1.clr) annotation (Line(points={{102,-54},{112,
          -54},{112,-36},{118,-36}}, color={255,0,255}));
  connect(orEnaHea1.y, mulOrDisCoo1.u[1]) annotation (Line(points={{102,100},{
          106,100},{106,0},{68,0},{68,-56.3333},{78,-56.3333}}, color={255,0,
          255}));
  connect(mulAndEnaCoo2.y, timEnaCoo2.u)
    annotation (Line(points={{-118,-70},{-102,-70}}, color={255,0,255}));
  connect(hysDomLoa.y, andEnaCoo1.u[3]) annotation (Line(points={{-168,-40},{
          -116,-40},{-116,-37.6667},{-62,-37.6667}}, color={255,0,255}));
  connect(timEnaCoo2.passed, andMinRunEnaCoo2.u2)
    annotation (Line(points={{-78,-78},{8,-78}}, color={255,0,255}));
  connect(greChiSup.y, mulAndEnaCoo2.u[1]) annotation (Line(points={{-178,-70},
          {-164,-70},{-164,-72.3333},{-142,-72.3333}}, color={255,0,255}));
  connect(pre1[5].y, mulAndEnaCoo2.u[2]) annotation (Line(points={{202,70},{212,
          70},{212,200},{-146,200},{-146,-70},{-142,-70}}, color={255,0,255}));
  connect(uPlaEna, mulAndEnaCoo2.u[3]) annotation (Line(points={{-320,100},{
          -160,100},{-160,-67.6667},{-142,-67.6667}}, color={255,0,255}));
  connect(andMinRunEnaCoo2.y, mulOrDisCoo1.u[2]) annotation (Line(points={{32,
          -70},{48,-70},{48,-54},{78,-54}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunEnaCoo2.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,-70},{8,-70}}, color={255,0,255}));
  connect(andMinRunEnaCoo2.y, orEnaCoo2.u1) annotation (Line(points={{32,-70},{
          48,-70},{48,-80},{78,-80}}, color={255,0,255}));
  connect(orEnaCoo2.y, latCoo2.u) annotation (Line(points={{102,-80},{110,-80},
          {110,-100},{118,-100}}, color={255,0,255}));
  connect(orDisCoo5.y, latCoo2.clr) annotation (Line(points={{102,-110},{110,-110},
          {110,-106},{118,-106}}, color={255,0,255}));
  connect(andMinRunDisCoo2.y, orDisCoo5.u1)
    annotation (Line(points={{32,-110},{78,-110}}, color={255,0,255}));
  connect(timDisCoo2.passed, andMinRunDisCoo2.u2)
    annotation (Line(points={{-78,-118},{8,-118}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunDisCoo2.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,-110},{8,-110}}, color={255,0,255}));
  connect(andDisCoo2.y, timDisCoo2.u)
    annotation (Line(points={{-118,-110},{-102,-110}}, color={255,0,255}));
  connect(greThrDisCoo2.y, andDisCoo2.u[1]) annotation (Line(points={{-198,-110},
          {-170,-110},{-170,-112.333},{-142,-112.333}}, color={255,0,255}));
  connect(uPlaEna, andDisCoo2.u[2]) annotation (Line(points={{-320,100},{-160,
          100},{-160,-110},{-142,-110}}, color={255,0,255}));
  connect(pre1[6].y, andDisCoo2.u[3]) annotation (Line(points={{202,70},{212,70},
          {212,200},{-146,200},{-146,-114},{-142,-114},{-142,-107.667}}, color=
          {255,0,255}));
  connect(greThrEnaCoo3.y, andEnaCoo3.u1)
    annotation (Line(points={{-198,-150},{-142,-150}}, color={255,0,255}));
  connect(uPlaEna, andEnaCoo3.u2) annotation (Line(points={{-320,100},{-160,100},
          {-160,-158},{-142,-158}}, color={255,0,255}));
  connect(andEnaCoo3.y, andOpeModEnaCoo3.u1)
    annotation (Line(points={{-118,-150},{-102,-150}}, color={255,0,255}));
  connect(andOpeModEnaCoo3.y, timEnaCoo3.u)
    annotation (Line(points={{-78,-150},{-62,-150}}, color={255,0,255}));
  connect(andMinRunEnaCoo3.y, latCoo3.u) annotation (Line(points={{32,-150},{
          100,-150},{100,-160},{118,-160}}, color={255,0,255}));
  connect(timEnaCoo3.passed, andMinRunEnaCoo3.u2)
    annotation (Line(points={{-38,-158},{8,-158}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunEnaCoo3.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,-150},{8,-150}}, color={255,0,255}));
  connect(pre1[6].y, andOpeModEnaCoo3.u2) annotation (Line(points={{202,70},{
          212,70},{212,200},{-146,200},{-146,-130},{-104,-130},{-104,-158},{-102,
          -158}}, color={255,0,255}));
  connect(notDisCoo3.y, andDisCoo3.u1)
    annotation (Line(points={{-78,-180},{-72,-180}}, color={255,0,255}));
  connect(andDisCoo3.y, timDisCoo3.u)
    annotation (Line(points={{-48,-180},{-42,-180}}, color={255,0,255}));
  connect(timDisCoo3.passed, andMinRunDisCoo3.u2)
    annotation (Line(points={{-18,-188},{8,-188}}, color={255,0,255}));
  connect(andMinRunEnaCoo3.y, orDisCoo5.u2) annotation (Line(points={{32,-150},
          {70,-150},{70,-118},{78,-118}}, color={255,0,255}));
  connect(andMinRunDisCoo3.y, latCoo3.clr) annotation (Line(points={{32,-180},{
          100,-180},{100,-166},{118,-166}}, color={255,0,255}));
  connect(preMinRun.y, andMinRunDisCoo3.u1) annotation (Line(points={{322,-100},
          {330,-100},{330,-130},{6,-130},{6,-180},{8,-180}}, color={255,0,255}));
  connect(pre1[7].y, andDisCoo3.u2) annotation (Line(points={{202,70},{212,70},
          {212,200},{-146,200},{-146,-130},{-76,-130},{-76,-188},{-72,-188}},
        color={255,0,255}));
  connect(andMinRunDisCoo3.y, orEnaCoo2.u2) annotation (Line(points={{32,-180},
          {60,-180},{60,-88},{78,-88}}, color={255,0,255}));
  connect(orDisPla.y, mulOrDisCoo1.u[3]) annotation (Line(points={{-38,30},{60,
          30},{60,-51.6667},{78,-51.6667}}, color={255,0,255}));
  connect(orDisPla.y, mulOrDisHea1.u[3]) annotation (Line(points={{-38,30},{60,
          30},{60,72.3333},{78,72.3333}}, color={255,0,255}));
  connect(orDisPla.y, latDis.u) annotation (Line(points={{-38,30},{60,30},{60,
          50},{118,50}}, color={255,0,255}));
  connect(falEdgPlaEna.y, orDisPla.u2) annotation (Line(points={{-118,20},{-70,
          20},{-70,22},{-62,22}}, color={255,0,255}));
  connect(uPlaEna, notDisPla.u) annotation (Line(points={{-320,100},{-160,100},
          {-160,40},{-102,40}}, color={255,0,255}));
  connect(notDisPla.y, orDisPla.u1) annotation (Line(points={{-78,40},{-70,40},
          {-70,30},{-62,30}}, color={255,0,255}));
  connect(orEnaPla.y, latDis.clr) annotation (Line(points={{-38,0},{50,0},{50,
          44},{118,44}}, color={255,0,255}));
  connect(orEnaHea1.y, orEnaPla.u1) annotation (Line(points={{102,100},{106,100},
          {106,16},{-70,16},{-70,0},{-62,0}}, color={255,0,255}));
  connect(latCoo1.y, orEnaPla.u2) annotation (Line(points={{142,-30},{150,-30},
          {150,-14},{-70,-14},{-70,-8},{-62,-8}}, color={255,0,255}));
  connect(andMinRunEnaCoo1.y, orEnaCoo1.u1) annotation (Line(points={{32,-40},{
          40,-40},{40,-30},{78,-30}}, color={255,0,255}));
  connect(orEnaCoo1.y, latCoo1.u)
    annotation (Line(points={{102,-30},{118,-30}}, color={255,0,255}));
  connect(andMinRunDisCoo2.y, orEnaCoo1.u2) annotation (Line(points={{32,-110},
          {54,-110},{54,-38},{78,-38}}, color={255,0,255}));
annotation (
    defaultComponentName="opeModCon",
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-220},{100,220}}),
      graphics={
        Rectangle(
          extent={{-100,220},{100,-220}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,260},{150,220}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-300,-240},{400,240}})),
    Documentation(
      info="<html>
<p>
This block implements the control sequences of operation modes for water-to-water 
heat pump plants. The output integer values <code>yOpeMod</code> range from -3 to 5, 
representing the following modes: Heating_3, Heating_2, Heating_1, Disabled, Cooling_1, 
Cooling_2, Cooing_3, Cooling_4, and Cooling_5, respectively. See
<a href=\"modelica://Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode\">
Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode</a>
for a description of each operation mode. 
</p>
<p>
The sequence of each operation mode is determined as follows: 
</p>
<ul>
<li>
The Heating-3 mode is eanbled (i.e., <code>yOpeMod=-3</code>) 
if the hot thermal energy storage (TES) dedicated charging mode 
enable signal <code>uHotTanCha</code> is enabled. 
</li>
<li>
The Heating-2 mode is enabled (i.e., <code>yOpeMod=-2</code>) 
if <code>yOpeMod=-1</code> and the chilled water loop return 
temperature <code>TChiRet</code> is lower than its minimum 
allowed return temperature <code>T_CHWRetMin</code> for a period 
<code>dtMod4</code>. 
</li>
<li>
The Heating-1 mode is eanbled (i.e., <code>yOpeMod=-1</code>) 
if the plant enable signal <code>uPlaEna</code> is enabled, 
<code>yOpeMod=1</code>, and the calculated heating load is greater 
than the calculated cooling load for a period <code>dtMod1</code>, 
or if <code>yOpeMod=-2</code> and <code>TChiRet</code> is higher than 
<code>T_CHWRetMin</code> for a period <code>dtMod1</code>. 
</li>
<li>
The Disabled mode is enabled (i.e., <code>yOpeMod=0</code>)  
if <code>uPlaEna</code> is disabled or changes from enable to disable, 
or if <code>yOpeMod=-1</code> (or <code>yOpeMod=-1</code>) and the calculated 
heating (or cooling) load is less than a specific threshold value. 
</li>
<li>
The Cooling-1 mode is enabled (i.e., <code>yOpeMod=1</code>)  
if <code>uPlaEna</code> is enabled, <code>yOpeMod=-1</code>, 
and the calculated cooling load is greater than the calculated 
heating load for a period <code>dtMod1</code>, or if 
<code>yOpeMod=2</code> and the chilled water loop supply temperature 
<code>TChiSup</code> is lower than its maximum allowed setpoint 
<code>T_CHWSupSetMax</code> for a period <code>dtMod2</code>.
</li>
<li>
The Cooling-2 mode is enabled (i.e., <code>yOpeMod=2</code>)  
if <code>yOpeMod=1</code> and <code>TChiSup</code> is greater 
than its allowed setpoint <code>TChiSupSet</code> for a period 
<code>dtMod2</code>, or if <code>yOpeMod=3</code> and the heating 
hot water loop return temperature <code>THeaRet</code> is lower 
than its maximum allowed setpoint <code>T_HHWRetMax</code> 
for a period <code>dtMod3</code>.
</li>
<li>
The Cooling-3 mode is enabled (i.e., <code>yOpeMod=3</code>)  
if <code>yOpeMod=2</code> and <code>THeaRet</code> is greater 
than <code>T_HHWRetMax</code> for a period <code>dtMod3</code>.
</li>
<li>
The Cooling-4 mode is eanbled (i.e., <code>yOpeMod=4</code>) 
when the cold TES dedicated charging mode enable signal 
<code>uCooTanCha</code> is enabled. 
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
May 31, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end OperationModeControl;
