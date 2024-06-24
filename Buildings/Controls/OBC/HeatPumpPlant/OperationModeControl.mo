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

  parameter Real dtMod5(
    final min=0,
    final unit="s")=300
    "Duration used to switch operation mode";

  parameter Real dtMod7(
    final min=0,
    final unit="s")=300
    "Duration used to switch operation mode";

  parameter Real dtRun(
    final min=0,
    final unit="s")=15 * 60
    "Minimum runtime of enable and disable states";

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

  parameter Real min_heating(
    final min=0,
    final unit="W")=10
    "Minimum threshold for heating load";

  parameter Real min_cooling(
    final min=0,
    final unit="W")=10
    "Minimum threshold for cooling load";

  parameter Real tMinRun(
    final unit="s",
    displayUnit="min",
    final quantity="time") = 900
    "Minimum run time for each operation mode";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uSchHea
    "Heating mode enable via schedule"
    annotation (Placement(transformation(extent={{-340,160},{-300,200}}),
      iconTransformation(extent={{-140,140},{-100,180}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uSchCoo1
    "Cooling mode enable via schedule 1"
    annotation (Placement(transformation(extent={{-340,120},{-300,160}}),
      iconTransformation(extent={{-140,100},{-100,140}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaSupSet(final unit="K",
      displayUnit="degC")
    "Heating supply temperature setpoint used to compute required heating load"
    annotation (Placement(transformation(extent={{-340,40},{-300,80}}),
        iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaRet(
    final unit="K",
    displayUnit="degC")
    "Return temperature used to compute required heating or cooling load"
    annotation (Placement(transformation(extent={{-340,0},{-300,40}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VWatHot_flow(final unit=
        "m3/s")
    "Hot water volume flow rate used to compute required heating load"
    annotation (Placement(transformation(extent={{-340,-40},{-300,0}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiSupSet(final unit="K",
      displayUnit="degC")
    "Cooling supply temperature setpoint used to compute required cooling load"
    annotation (Placement(transformation(extent={{-340,-120},{-300,-80}}),
        iconTransformation(extent={{-140,-140},{-100,-100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiRet(
    final unit="K",
    displayUnit="degC")
    "Return temperature used to compute required cooling load"
    annotation (Placement(transformation(extent={{-340,-160},{-300,-120}}),
      iconTransformation(extent={{-140,-180},{-100,-140}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VWatChi_flow(final unit=
        "m3/s")
    "Chilled water volume flow rate used to compute required cooling load"
    annotation (Placement(transformation(extent={{-340,-200},{-300,-160}}),
        iconTransformation(extent={{-140,-220},{-100,-180}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod
    "Operation mode"
    annotation (Placement(transformation(extent={{400,-20},{440,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim3(
    t=dtMod7)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-30,140},{-10,160}})));

  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(
    t=T_CHWRetMin)
    annotation (Placement(transformation(extent={{-200,140},{-180,160}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim1(
    t=dtMod3)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim2(
    t=dtMod5)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrRetHea1(
    t=T_HHWRetMax)
    annotation (Placement(transformation(extent={{-220,-160},{-200,-140}})));

  RequiredCapacity capReqHea(rho_default=rho_default, cp_default=cp_default,
    dtMea=dtMea)             "Required heating capacity"
    annotation (Placement(transformation(extent={{-260,20},{-240,40}})));
  RequiredCapacity capReqCoo(rho_default=rho_default, cp_default=cp_default,
    dtMea=dtMea)             "Required cooling capacity"
    annotation (Placement(transformation(extent={{-260,-140},{-240,-120}})));
  CDL.Logical.Latch latDis
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
  CDL.Conversions.BooleanToInteger booToInt1[8]
    annotation (Placement(transformation(extent={{184,-30},{204,-10}})));
  CDL.Integers.Sources.Constant conInt[8](k={Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Disabled,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4})
    annotation (Placement(transformation(extent={{184,10},{204,30}})));
  CDL.Integers.Multiply mulInt1[8]
    annotation (Placement(transformation(extent={{224,-10},{244,10}})));
  CDL.Integers.MultiSum mulSumInt(nin=8)
    annotation (Placement(transformation(extent={{260,-10},{280,10}})));
  CDL.Interfaces.BooleanInput uProCom "Staging process completion signal"
    annotation (Placement(transformation(extent={{-340,200},{-300,240}}),
        iconTransformation(extent={{-140,180},{-100,220}})));
  CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-140,90},{-120,110}})));
  CDL.Logical.Timer                        tim4(t=dtMod1)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  CDL.Logical.Latch latCoo1
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  CDL.Logical.Latch latHea1
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
  CDL.Logical.Latch latHea2
    annotation (Placement(transformation(extent={{120,120},{140,140}})));
  CDL.Logical.Latch latHea3
    annotation (Placement(transformation(extent={{120,160},{140,180}})));
  CDL.Logical.Not                        not4
    annotation (Placement(transformation(extent={{60,140},{80,160}})));
  CDL.Interfaces.BooleanInput uPlaEna "Staging process completion signal"
    annotation (Placement(transformation(extent={{-340,80},{-300,120}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  CDL.Logical.MultiAnd                   mulAnd(nin=3)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  CDL.Logical.Latch latCoo2
    annotation (Placement(transformation(extent={{120,-110},{140,-90}})));
  CDL.Logical.Latch latCoo3
    annotation (Placement(transformation(extent={{120,-170},{140,-150}})));
  CDL.Logical.Latch latCoo4
    annotation (Placement(transformation(extent={{120,-210},{140,-190}})));
  CDL.Logical.And                        and5
    annotation (Placement(transformation(extent={{-140,-160},{-120,-140}})));
  CDL.Logical.Not                        not1
    annotation (Placement(transformation(extent={{60,-230},{80,-210}})));
  CDL.Logical.Latch latCoo5
    annotation (Placement(transformation(extent={{230,-60},{250,-40}})));
  CDL.Integers.Change cha
    annotation (Placement(transformation(extent={{190,-90},{210,-70}})));
  CDL.Logical.Timer tim5(t=tMinRun)
    annotation (Placement(transformation(extent={{260,-60},{280,-40}})));
  CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{300,-50},{320,-30}})));
  CDL.Discrete.TriggeredSampler triSam
    annotation (Placement(transformation(extent={{330,-50},{350,-30}})));
  CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{360,-50},{380,-30}})));
  CDL.Logical.And                        and3
    annotation (Placement(transformation(extent={{-120,140},{-100,160}})));
  CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{360,-10},{380,10}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{300,-110},{320,-90}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  CDL.Logical.Timer                        tim6(t=dtMod7)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  CDL.Logical.MultiAnd                   and9(nin=3)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  CDL.Logical.Not                        not5
    annotation (Placement(transformation(extent={{-100,-190},{-80,-170}})));
  CDL.Logical.Timer                        tim7(t=dtMod5)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-40,-190},{-20,-170}})));
  CDL.Reals.Greater                        gre2(h=0)
    annotation (Placement(transformation(extent={{-200,-80},{-180,-60}})));
  CDL.Interfaces.RealInput TChiSup(final unit="K", displayUnit="degC")
    "Measured chilled water supply temperature" annotation (Placement(
        transformation(extent={{-340,-80},{-300,-40}}),  iconTransformation(
          extent={{-140,-100},{-100,-60}})));
  CDL.Reals.Hysteresis hys(uLow=-500, uHigh=500)
    annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
  CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-220,-50},{-200,-30}})));
  CDL.Reals.GreaterThreshold                        greThrRetHea2(t=
        T_CHWSupSetMax)
    annotation (Placement(transformation(extent={{-220,-120},{-200,-100}})));
  CDL.Logical.Timer tim8(t=dtMod1)
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
  CDL.Logical.Pre pre1[8]
    annotation (Placement(transformation(extent={{180,60},{200,80}})));
  CDL.Logical.MultiOr mulOr(nin=3)
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  CDL.Logical.And                        and4
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  CDL.Logical.And                        and6
    annotation (Placement(transformation(extent={{-50,100},{-30,120}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{80,90},{100,110}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{10,140},{30,160}})));
  CDL.Logical.And and7
    annotation (Placement(transformation(extent={{10,100},{30,120}})));
  CDL.Logical.And and8
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  CDL.Logical.And and10
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  CDL.Logical.MultiOr mulOr1(nin=3)
    annotation (Placement(transformation(extent={{80,-64},{100,-44}})));
  CDL.Logical.MultiAnd                   and11(nin=3)
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  CDL.Logical.Timer                        tim9(t=dtMod3)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  CDL.Logical.Or or4
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  CDL.Logical.And and1
    annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  CDL.Logical.Or or5
    annotation (Placement(transformation(extent={{80,-120},{100,-100}})));
  CDL.Logical.And and12
    annotation (Placement(transformation(extent={{10,-120},{30,-100}})));
  CDL.Logical.MultiAnd                   and13(nin=3)
    annotation (Placement(transformation(extent={{-140,-120},{-120,-100}})));
  CDL.Logical.And                        and14
    annotation (Placement(transformation(extent={{-100,-160},{-80,-140}})));
  CDL.Logical.And and15
    annotation (Placement(transformation(extent={{10,-160},{30,-140}})));
  CDL.Logical.And                        and16
    annotation (Placement(transformation(extent={{-70,-190},{-50,-170}})));
  CDL.Logical.And and17
    annotation (Placement(transformation(extent={{10,-190},{30,-170}})));
  CDL.Logical.Or or6
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  CDL.Logical.Not not6
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  CDL.Logical.Or or7
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  CDL.Logical.Or or8
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
equation
  connect(TChiRet, lesThr.u)
    annotation (Line(points={{-320,-140},{-274,-140},{-274,150},{-202,150}},
                                                     color={0,0,127}));
  connect(THeaRet,greThrRetHea1. u)
    annotation (Line(points={{-320,20},{-284,20},{-284,-150},{-222,-150}},
                                                     color={0,0,127}));
  connect(THeaSupSet, capReqHea.TSupSet) annotation (Line(points={{-320,60},{
          -292,60},{-292,34},{-262,34}},
                                       color={0,0,127}));
  connect(THeaRet, capReqHea.TRet) annotation (Line(points={{-320,20},{-284,20},
          {-284,30},{-262,30}},    color={0,0,127}));
  connect(VWatHot_flow, capReqHea.V_flow) annotation (Line(points={{-320,-20},{
          -266,-20},{-266,26},{-262,26}}, color={0,0,127}));
  connect(TChiSupSet, capReqCoo.TSupSet) annotation (Line(points={{-320,-100},{-270,
          -100},{-270,-126},{-262,-126}},      color={0,0,127}));
  connect(TChiRet, capReqCoo.TRet) annotation (Line(points={{-320,-140},{-274,-140},
          {-274,-130},{-262,-130}},       color={0,0,127}));
  connect(VWatChi_flow, capReqCoo.V_flow) annotation (Line(points={{-320,-180},{
          -270,-180},{-270,-134},{-262,-134}},  color={0,0,127}));
  connect(conInt.y, mulInt1.u1) annotation (Line(points={{206,20},{214,20},{214,
          6},{222,6}},  color={255,127,0}));
  connect(booToInt1.y, mulInt1.u2) annotation (Line(points={{206,-20},{214,-20},
          {214,-6},{222,-6}},
                        color={255,127,0}));
  connect(latDis.y, booToInt1[4].u) annotation (Line(points={{142,50},{160,50},{
          160,-20},{182,-20}}, color={255,0,255}));
  connect(not4.y, latHea3.clr) annotation (Line(points={{82,150},{112,150},{112,
          164},{118,164}}, color={255,0,255}));
  connect(latHea3.y, booToInt1[1].u) annotation (Line(points={{142,170},{160,170},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(uPlaEna, falEdg.u) annotation (Line(points={{-320,100},{-160,100},{-160,
          20},{-142,20}}, color={255,0,255}));
  connect(mulAnd.y, tim4.u)
    annotation (Line(points={{-78,80},{-62,80}}, color={255,0,255}));
  connect(latHea1.y, booToInt1[3].u) annotation (Line(points={{142,90},{160,90},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latHea2.y, booToInt1[2].u) annotation (Line(points={{142,130},{160,130},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latCoo1.y, booToInt1[5].u) annotation (Line(points={{142,-30},{160,-30},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(uSchHea, not4.u) annotation (Line(points={{-320,180},{40,180},{40,150},
          {58,150}}, color={255,0,255}));
  connect(uSchHea, latHea3.u) annotation (Line(points={{-320,180},{40,180},{40,170},
          {118,170}}, color={255,0,255}));
  connect(uSchCoo1, latCoo4.u) annotation (Line(points={{-320,140},{-234,140},{-234,
          -200},{118,-200}}, color={255,0,255}));
  connect(latCoo2.y, booToInt1[6].u) annotation (Line(points={{142,-100},{160,-100},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latCoo3.y, booToInt1[7].u) annotation (Line(points={{142,-160},{160,-160},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latCoo4.y, booToInt1[8].u) annotation (Line(points={{142,-200},{160,-200},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(not1.y, latCoo4.clr) annotation (Line(points={{82,-220},{112,-220},{112,
          -206},{118,-206}}, color={255,0,255}));
  connect(uSchCoo1, not1.u) annotation (Line(points={{-320,140},{-234,140},{-234,
          -220},{58,-220}},                     color={255,0,255}));
  connect(mulSumInt.y, cha.u) annotation (Line(points={{282,0},{290,0},{290,-32},
          {176,-32},{176,-80},{188,-80}}, color={255,127,0}));
  connect(cha.y, latCoo5.clr) annotation (Line(points={{212,-80},{220,-80},{220,
          -56},{228,-56}}, color={255,0,255}));
  connect(uProCom, latCoo5.u) annotation (Line(points={{-320,220},{168,220},{168,
          -50},{228,-50}}, color={255,0,255}));
  connect(latCoo5.y, tim5.u)
    annotation (Line(points={{252,-50},{258,-50}}, color={255,0,255}));
  connect(mulSumInt.y, intToRea.u) annotation (Line(points={{282,0},{290,0},{290,
          -40},{298,-40}}, color={255,127,0}));
  connect(intToRea.y, triSam.u)
    annotation (Line(points={{322,-40},{328,-40}}, color={0,0,127}));
  connect(triSam.y, reaToInt.u)
    annotation (Line(points={{352,-40},{358,-40}}, color={0,0,127}));
  connect(intSwi.y, yOpeMod)
    annotation (Line(points={{382,0},{420,0}}, color={255,127,0}));
  connect(reaToInt.y, intSwi.u3) annotation (Line(points={{382,-40},{390,-40},{390,
          -20},{350,-20},{350,-8},{358,-8}}, color={255,127,0}));
  connect(mulSumInt.y, intSwi.u1) annotation (Line(points={{282,0},{290,0},{290,
          8},{358,8}}, color={255,127,0}));
  connect(tim5.passed, intSwi.u2) annotation (Line(points={{282,-58},{294,-58},{
          294,0},{358,0}}, color={255,0,255}));
  connect(cha.y, triSam.trigger) annotation (Line(points={{212,-80},{340,-80},{340,
          -52}}, color={255,0,255}));
  connect(mulInt1.y, mulSumInt.u)
    annotation (Line(points={{246,0},{258,0}}, color={255,127,0}));
  connect(tim5.passed, pre.u) annotation (Line(points={{282,-58},{280,-58},{280,
          -100},{298,-100}}, color={255,0,255}));
  connect(and3.y, not2.u) annotation (Line(points={{-98,150},{-92,150},{-92,110},
          {-82,110}},color={255,0,255}));
  connect(and5.y, not5.u) annotation (Line(points={{-118,-150},{-110,-150},{-110,
          -180},{-102,-180}},
                       color={255,0,255}));
  connect(TChiSup, gre2.u1) annotation (Line(points={{-320,-60},{-250,-60},{-250,
          -70},{-202,-70}}, color={0,0,127}));
  connect(TChiSupSet, gre2.u2) annotation (Line(points={{-320,-100},{-250,-100},
          {-250,-78},{-202,-78}}, color={0,0,127}));
  connect(hys.y, not3.u) annotation (Line(points={{-168,-40},{-152,-40},{-152,100},
          {-142,100}},
                     color={255,0,255}));
  connect(hys.u, sub.y)
    annotation (Line(points={{-192,-40},{-198,-40}}, color={0,0,127}));
  connect(capReqHea.yCapReq, sub.u2) annotation (Line(points={{-238,30},{-226,30},
          {-226,-46},{-222,-46}},     color={0,0,127}));
  connect(capReqCoo.yCapReq, sub.u1) annotation (Line(points={{-238,-130},{-232,
          -130},{-232,-34},{-222,-34}}, color={0,0,127}));
  connect(TChiSupSet, greThrRetHea2.u) annotation (Line(points={{-320,-100},{-250,
          -100},{-250,-110},{-222,-110}},    color={0,0,127}));
  connect(uPlaEna, and9.u[1]) annotation (Line(points={{-320,100},{-160,100},{
          -160,-35.3333},{-62,-35.3333}},
                                color={255,0,255}));
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
  connect(mulOr.y, latHea1.clr) annotation (Line(points={{102,70},{110,70},{110,
          84},{118,84}}, color={255,0,255}));
  connect(lesThr.y, and3.u1)
    annotation (Line(points={{-178,150},{-122,150}}, color={255,0,255}));
  connect(uPlaEna, and3.u2) annotation (Line(points={{-320,100},{-160,100},{-160,
          142},{-122,142}}, color={255,0,255}));
  connect(and3.y, and4.u1)
    annotation (Line(points={{-98,150},{-82,150}}, color={255,0,255}));
  connect(and4.y, tim3.u)
    annotation (Line(points={{-58,150},{-32,150}}, color={255,0,255}));
  connect(not2.y, and6.u1)
    annotation (Line(points={{-58,110},{-52,110}}, color={255,0,255}));
  connect(tim6.u, and6.y)
    annotation (Line(points={{-22,110},{-28,110}}, color={255,0,255}));
  connect(pre1[3].y, and4.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-88,200},{-88,142},{-82,142}}, color={255,0,255}));
  connect(pre1[2].y, and6.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-56,200},{-56,102},{-52,102}}, color={255,0,255}));
  connect(or1.y, latHea1.u) annotation (Line(points={{102,100},{110,100},{110,90},
          {118,90}}, color={255,0,255}));
  connect(not3.y, mulAnd.u[1]) annotation (Line(points={{-118,100},{-110,100},{
          -110,84.6667},{-102,84.6667}},
                                    color={255,0,255}));
  connect(uPlaEna, mulAnd.u[2]) annotation (Line(points={{-320,100},{-160,100},{
          -160,80},{-102,80}}, color={255,0,255}));
  connect(or3.y, mulAnd.u[3]) annotation (Line(points={{-118,60},{-110,60},{
          -110,75.3333},{-102,75.3333}},
                                    color={255,0,255}));
  connect(pre1[4].y, or3.u1) annotation (Line(points={{202,70},{212,70},{212,200},
          {-146,200},{-146,60},{-142,60}}, color={255,0,255}));
  connect(pre1[5].y, or3.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-146,200},{-146,52},{-142,52}}, color={255,0,255}));
  connect(and2.y, latHea2.u) annotation (Line(points={{32,150},{36,150},{36,136},
          {118,136},{118,130}}, color={255,0,255}));
  connect(tim3.passed, and2.u2)
    annotation (Line(points={{-8,142},{8,142}}, color={255,0,255}));
  connect(pre.y, and2.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,150},{8,150}}, color={255,0,255}));
  connect(and7.y, or1.u1) annotation (Line(points={{32,110},{70,110},{70,100},{78,
          100}}, color={255,0,255}));
  connect(and7.y, latHea2.clr) annotation (Line(points={{32,110},{70,110},{70,124},
          {118,124}}, color={255,0,255}));
  connect(tim6.passed, and7.u2)
    annotation (Line(points={{2,102},{8,102}}, color={255,0,255}));
  connect(pre.y, and7.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,110},{8,110}}, color={255,0,255}));
  connect(tim4.passed, and8.u2)
    annotation (Line(points={{-38,72},{8,72}}, color={255,0,255}));
  connect(pre.y, and8.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,80},{8,80}}, color={255,0,255}));
  connect(and8.y, or1.u2) annotation (Line(points={{32,80},{70,80},{70,92},{78,92}},
        color={255,0,255}));
  connect(and2.y, mulOr.u[1]) annotation (Line(points={{32,150},{36,150},{36,
          74.6667},{78,74.6667}},
                         color={255,0,255}));
  connect(or2.y, and9.u[2]) annotation (Line(points={{-118,-20},{-110,-20},{-110,
          -40},{-62,-40}}, color={255,0,255}));
  connect(pre1[3].y, or2.u1) annotation (Line(points={{202,70},{212,70},{212,200},
          {-146,200},{-146,-20},{-142,-20}}, color={255,0,255}));
  connect(pre1[4].y, or2.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-146,200},{-146,-28},{-142,-28}}, color={255,0,255}));
  connect(tim1.passed, and10.u2)
    annotation (Line(points={{2,-48},{8,-48}}, color={255,0,255}));
  connect(pre.y, and10.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,-40},{8,-40}}, color={255,0,255}));
  connect(and9.y, tim1.u)
    annotation (Line(points={{-38,-40},{-22,-40}}, color={255,0,255}));
  connect(and10.y, mulOr.u[2]) annotation (Line(points={{32,-40},{40,-40},{40,
          70},{78,70}},  color={255,0,255}));
  connect(mulOr1.y, latCoo1.clr) annotation (Line(points={{102,-54},{112,-54},{
          112,-36},{118,-36}},
                           color={255,0,255}));
  connect(or1.y, mulOr1.u[1]) annotation (Line(points={{102,100},{106,100},{106,
          0},{68,0},{68,-49.3333},{78,-49.3333}},
                                            color={255,0,255}));
  connect(and11.y, tim9.u)
    annotation (Line(points={{-118,-70},{-102,-70}}, color={255,0,255}));
  connect(hys.y, and9.u[3]) annotation (Line(points={{-168,-40},{-116,-40},{
          -116,-44.6667},{-62,-44.6667}},
                                     color={255,0,255}));
  connect(tim9.passed, and1.u2)
    annotation (Line(points={{-78,-78},{8,-78}}, color={255,0,255}));
  connect(gre2.y, and11.u[1]) annotation (Line(points={{-178,-70},{-164,-70},{
          -164,-65.3333},{-142,-65.3333}},
                                      color={255,0,255}));
  connect(pre1[5].y, and11.u[2]) annotation (Line(points={{202,70},{212,70},{212,
          200},{-146,200},{-146,-70},{-142,-70}},           color={255,0,255}));
  connect(uPlaEna, and11.u[3]) annotation (Line(points={{-320,100},{-160,100},{
          -160,-74.6667},{-142,-74.6667}},
                                      color={255,0,255}));
  connect(and1.y, mulOr1.u[2]) annotation (Line(points={{32,-70},{48,-70},{48,
          -54},{78,-54}}, color={255,0,255}));
  connect(pre.y, and1.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,-70},{8,-70}}, color={255,0,255}));
  connect(and1.y, or4.u1) annotation (Line(points={{32,-70},{48,-70},{48,-80},{78,
          -80}}, color={255,0,255}));
  connect(or4.y, latCoo2.u) annotation (Line(points={{102,-80},{110,-80},{110,-100},
          {118,-100}}, color={255,0,255}));
  connect(or5.y, latCoo2.clr) annotation (Line(points={{102,-110},{110,-110},{110,
          -106},{118,-106}}, color={255,0,255}));
  connect(and12.y, or5.u1)
    annotation (Line(points={{32,-110},{78,-110}}, color={255,0,255}));
  connect(tim8.passed, and12.u2)
    annotation (Line(points={{-78,-118},{8,-118}}, color={255,0,255}));
  connect(pre.y, and12.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,-110},{8,-110}}, color={255,0,255}));
  connect(and13.y, tim8.u)
    annotation (Line(points={{-118,-110},{-102,-110}}, color={255,0,255}));
  connect(greThrRetHea2.y, and13.u[1]) annotation (Line(points={{-198,-110},{
          -170,-110},{-170,-105.333},{-142,-105.333}},
                                              color={255,0,255}));
  connect(uPlaEna, and13.u[2]) annotation (Line(points={{-320,100},{-160,100},{-160,
          -110},{-142,-110}},     color={255,0,255}));
  connect(pre1[6].y, and13.u[3]) annotation (Line(points={{202,70},{212,70},{
          212,200},{-146,200},{-146,-114},{-142,-114},{-142,-114.667}},
                                                                  color={255,0,255}));
  connect(greThrRetHea1.y, and5.u1)
    annotation (Line(points={{-198,-150},{-142,-150}}, color={255,0,255}));
  connect(uPlaEna, and5.u2) annotation (Line(points={{-320,100},{-160,100},{-160,
          -158},{-142,-158}}, color={255,0,255}));
  connect(and5.y, and14.u1)
    annotation (Line(points={{-118,-150},{-102,-150}}, color={255,0,255}));
  connect(and14.y, tim2.u)
    annotation (Line(points={{-78,-150},{-62,-150}}, color={255,0,255}));
  connect(and15.y, latCoo3.u) annotation (Line(points={{32,-150},{100,-150},{100,
          -160},{118,-160}}, color={255,0,255}));
  connect(tim2.passed, and15.u2)
    annotation (Line(points={{-38,-158},{8,-158}}, color={255,0,255}));
  connect(pre.y, and15.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,-150},{8,-150}}, color={255,0,255}));
  connect(pre1[6].y, and14.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-146,200},{-146,-130},{-104,-130},{-104,-158},{-102,-158}}, color={255,
          0,255}));
  connect(not5.y, and16.u1)
    annotation (Line(points={{-78,-180},{-72,-180}}, color={255,0,255}));
  connect(and16.y, tim7.u)
    annotation (Line(points={{-48,-180},{-42,-180}}, color={255,0,255}));
  connect(tim7.passed, and17.u2)
    annotation (Line(points={{-18,-188},{8,-188}}, color={255,0,255}));
  connect(and15.y, or5.u2) annotation (Line(points={{32,-150},{70,-150},{70,-118},
          {78,-118}}, color={255,0,255}));
  connect(and17.y, latCoo3.clr) annotation (Line(points={{32,-180},{100,-180},{100,
          -166},{118,-166}}, color={255,0,255}));
  connect(pre.y, and17.u1) annotation (Line(points={{322,-100},{330,-100},{330,-130},
          {6,-130},{6,-180},{8,-180}}, color={255,0,255}));
  connect(pre1[7].y, and16.u2) annotation (Line(points={{202,70},{212,70},{212,200},
          {-146,200},{-146,-130},{-76,-130},{-76,-188},{-72,-188}}, color={255,0,
          255}));
  connect(and17.y, or4.u2) annotation (Line(points={{32,-180},{60,-180},{60,-88},
          {78,-88}}, color={255,0,255}));
  connect(or6.y, mulOr1.u[3]) annotation (Line(points={{-38,30},{60,30},{60,
          -58.6667},{78,-58.6667}}, color={255,0,255}));
  connect(or6.y, mulOr.u[3]) annotation (Line(points={{-38,30},{60,30},{60,
          65.3333},{78,65.3333}}, color={255,0,255}));
  connect(or6.y, latDis.u) annotation (Line(points={{-38,30},{60,30},{60,50},{
          118,50}}, color={255,0,255}));
  connect(falEdg.y, or6.u2) annotation (Line(points={{-118,20},{-70,20},{-70,22},
          {-62,22}}, color={255,0,255}));
  connect(uPlaEna, not6.u) annotation (Line(points={{-320,100},{-160,100},{-160,
          40},{-102,40}}, color={255,0,255}));
  connect(not6.y, or6.u1) annotation (Line(points={{-78,40},{-70,40},{-70,30},{
          -62,30}}, color={255,0,255}));
  connect(or7.y, latDis.clr) annotation (Line(points={{-38,0},{50,0},{50,44},{
          118,44}}, color={255,0,255}));
  connect(or1.y, or7.u1) annotation (Line(points={{102,100},{106,100},{106,16},
          {-70,16},{-70,0},{-62,0}}, color={255,0,255}));
  connect(latCoo1.y, or7.u2) annotation (Line(points={{142,-30},{150,-30},{150,
          -14},{-70,-14},{-70,-8},{-62,-8}}, color={255,0,255}));
  connect(and10.y, or8.u1) annotation (Line(points={{32,-40},{40,-40},{40,-30},
          {78,-30}}, color={255,0,255}));
  connect(or8.y, latCoo1.u)
    annotation (Line(points={{102,-30},{118,-30}}, color={255,0,255}));
  connect(and12.y, or8.u2) annotation (Line(points={{32,-110},{54,-110},{54,-38},
          {78,-38}}, color={255,0,255}));
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
heat pump plants.
</p>
</html>", revisions="<html>
<ul>
<li>
May 31, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end OperationModeControl;
