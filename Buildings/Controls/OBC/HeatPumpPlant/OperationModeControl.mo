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

  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{-140,-90},{-120,-70}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim3(
    t=dtMod7)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-82,100},{-62,120}})));

  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(
    t=T_CHWRetMin)
    annotation (Placement(transformation(extent={{-160,100},{-140,120}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim1(
    t=dtMod3)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim2(
    t=dtMod5)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-68,-130},{-48,-110}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrRetHea1(
    t=T_HHWRetMax)
    annotation (Placement(transformation(extent={{-168,-130},{-148,-110}})));

  RequiredCapacity capReqHea(rho_default=rho_default, cp_default=cp_default,
    dtMea=dtMea)             "Required heating capacity"
    annotation (Placement(transformation(extent={{-260,20},{-240,40}})));
  RequiredCapacity capReqCoo(rho_default=rho_default, cp_default=cp_default,
    dtMea=dtMea)             "Required cooling capacity"
    annotation (Placement(transformation(extent={{-260,-180},{-240,-160}})));
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
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  CDL.Logical.Timer                        tim4(t=dtMod1)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
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
  CDL.Logical.Timer tim(t=dtMod1)
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  CDL.Logical.And                        and2
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  CDL.Logical.Latch latCoo2
    annotation (Placement(transformation(extent={{120,-80},{140,-60}})));
  CDL.Logical.Latch latCoo3
    annotation (Placement(transformation(extent={{120,-120},{140,-100}})));
  CDL.Logical.Latch latCoo4
    annotation (Placement(transformation(extent={{120,-170},{140,-150}})));
  CDL.Logical.And                        and5
    annotation (Placement(transformation(extent={{-118,-130},{-98,-110}})));
  CDL.Logical.Not                        not1
    annotation (Placement(transformation(extent={{60,-190},{80,-170}})));
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
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  CDL.Logical.And                        and4
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{360,-10},{380,10}})));
  CDL.Logical.And                        and6
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  CDL.Logical.And                        and7
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{300,-110},{320,-90}})));
  CDL.Logical.And and8
    annotation (Placement(transformation(extent={{80,100},{100,120}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  CDL.Logical.Timer                        tim6(t=dtMod7)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  CDL.Logical.And                        and9
    annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));
  CDL.Logical.Not                        not5
    annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
  CDL.Logical.Timer                        tim7(t=dtMod5)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-20,-160},{0,-140}})));
  CDL.Logical.And and10
    annotation (Placement(transformation(extent={{60,-140},{80,-120}})));
  CDL.Reals.Greater                        gre2(h=1)
    annotation (Placement(transformation(extent={{-220,-60},{-200,-40}})));
  CDL.Interfaces.RealInput TChiSup(final unit="K", displayUnit="degC")
    "Measured chilled water supply temperature" annotation (Placement(
        transformation(extent={{-340,-80},{-300,-40}}),  iconTransformation(
          extent={{-140,-100},{-100,-60}})));
  CDL.Logical.MultiOr mulOr(nin=3)
    annotation (Placement(transformation(extent={{40,-52},{60,-32}})));
  CDL.Logical.MultiOr mulOr1(nin=3)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  CDL.Reals.Hysteresis hys(uLow=-500, uHigh=500)
    annotation (Placement(transformation(extent={{-190,-90},{-170,-70}})));
  CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-220,-90},{-200,-70}})));
equation
  connect(TChiRet, lesThr.u)
    annotation (Line(points={{-320,-140},{-274,-140},{-274,110},{-162,110}},
                                                     color={0,0,127}));
  connect(THeaRet,greThrRetHea1. u)
    annotation (Line(points={{-320,20},{-290,20},{-290,-120},{-170,-120}},
                                                     color={0,0,127}));
  connect(THeaSupSet, capReqHea.TSupSet) annotation (Line(points={{-320,60},{
          -292,60},{-292,34},{-262,34}},
                                       color={0,0,127}));
  connect(THeaRet, capReqHea.TRet) annotation (Line(points={{-320,20},{-284,20},
          {-284,30},{-262,30}},    color={0,0,127}));
  connect(VWatHot_flow, capReqHea.V_flow) annotation (Line(points={{-320,-20},{
          -266,-20},{-266,26},{-262,26}}, color={0,0,127}));
  connect(TChiSupSet, capReqCoo.TSupSet) annotation (Line(points={{-320,-100},{
          -270,-100},{-270,-166},{-262,-166}}, color={0,0,127}));
  connect(TChiRet, capReqCoo.TRet) annotation (Line(points={{-320,-140},{-292,
          -140},{-292,-170},{-262,-170}}, color={0,0,127}));
  connect(VWatChi_flow, capReqCoo.V_flow) annotation (Line(points={{-320,-180},
          {-270,-180},{-270,-174},{-262,-174}}, color={0,0,127}));
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
  connect(uPlaEna, and1.u2) annotation (Line(points={{-320,100},{-160,100},{
          -160,-88},{-142,-88}},
                       color={255,0,255}));
  connect(and1.y, tim.u)
    annotation (Line(points={{-118,-80},{-102,-80}},color={255,0,255}));
  connect(not3.y, and2.u1)
    annotation (Line(points={{-118,0},{-112,0},{-112,-10},{-102,-10}},
                                                     color={255,0,255}));
  connect(uPlaEna, and2.u2) annotation (Line(points={{-320,100},{-160,100},{
          -160,-18},{-102,-18}},             color={255,0,255}));
  connect(uPlaEna, falEdg.u) annotation (Line(points={{-320,100},{-160,100},{
          -160,50},{-142,50}},
                          color={255,0,255}));
  connect(falEdg.y, latDis.u)
    annotation (Line(points={{-118,50},{118,50}}, color={255,0,255}));
  connect(uPlaEna, edg.u) annotation (Line(points={{-320,100},{-160,100},{-160,
          30},{-102,30}},
                      color={255,0,255}));
  connect(edg.y, latDis.clr) annotation (Line(points={{-78,30},{-20,30},{-20,44},
          {118,44}}, color={255,0,255}));
  connect(and2.y, tim4.u)
    annotation (Line(points={{-78,-10},{-62,-10}}, color={255,0,255}));
  connect(latHea1.y, booToInt1[3].u) annotation (Line(points={{142,90},{160,90},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latHea2.y, booToInt1[2].u) annotation (Line(points={{142,130},{160,130},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latCoo1.y, booToInt1[5].u) annotation (Line(points={{142,-30},{160,-30},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(greThrRetHea1.y, and5.u1)
    annotation (Line(points={{-146,-120},{-120,-120}}, color={255,0,255}));
  connect(and5.y, tim2.u)
    annotation (Line(points={{-96,-120},{-70,-120}}, color={255,0,255}));
  connect(uPlaEna, and5.u2) annotation (Line(points={{-320,100},{-160,100},{
          -160,-100},{-130,-100},{-130,-128},{-120,-128}},             color={255,
          0,255}));
  connect(uSchHea, not4.u) annotation (Line(points={{-320,180},{40,180},{40,150},
          {58,150}}, color={255,0,255}));
  connect(uSchHea, latHea3.u) annotation (Line(points={{-320,180},{40,180},{40,170},
          {118,170}}, color={255,0,255}));
  connect(uSchCoo1, latCoo4.u) annotation (Line(points={{-320,140},{-234,140},{-234,
          -180},{40,-180},{40,-160},{118,-160}},
                             color={255,0,255}));
  connect(latCoo2.y, booToInt1[6].u) annotation (Line(points={{142,-70},{160,-70},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latCoo3.y, booToInt1[7].u) annotation (Line(points={{142,-110},{160,-110},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(latCoo4.y, booToInt1[8].u) annotation (Line(points={{142,-160},{160,-160},
          {160,-20},{182,-20}}, color={255,0,255}));
  connect(not1.y, latCoo4.clr) annotation (Line(points={{82,-180},{112,-180},{112,
          -166},{118,-166}}, color={255,0,255}));
  connect(uSchCoo1, not1.u) annotation (Line(points={{-320,140},{-234,140},{-234,
          -180},{58,-180}},                     color={255,0,255}));
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
  connect(lesThr.y, and3.u1)
    annotation (Line(points={{-138,110},{-122,110}}, color={255,0,255}));
  connect(uPlaEna, and3.u2) annotation (Line(points={{-320,100},{-160,100},{
          -160,102},{-122,102}},            color={255,0,255}));
  connect(and3.y, tim3.u)
    annotation (Line(points={{-98,110},{-84,110}}, color={255,0,255}));
  connect(tim3.passed, and4.u1) annotation (Line(points={{-60,102},{-40,102},{-40,
          110},{-22,110}}, color={255,0,255}));
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
  connect(and4.y, latHea2.u) annotation (Line(points={{2,110},{20,110},{20,130},
          {118,130}}, color={255,0,255}));
  connect(tim.passed, and6.u1) annotation (Line(points={{-78,-88},{-38,-88},{-38,
          -70},{-22,-70}}, color={255,0,255}));
  connect(tim2.passed, and7.u1) annotation (Line(points={{-46,-128},{-40,-128},{
          -40,-120},{-2,-120}}, color={255,0,255}));
  connect(and7.y, latCoo3.u) annotation (Line(points={{22,-120},{40,-120},{40,-110},
          {118,-110}}, color={255,0,255}));
  connect(and7.y, or3.u2) annotation (Line(points={{22,-120},{28,-120},{28,-98},
          {38,-98}}, color={255,0,255}));
  connect(mulInt1.y, mulSumInt.u)
    annotation (Line(points={{246,0},{258,0}}, color={255,127,0}));
  connect(or3.y, latCoo2.clr) annotation (Line(points={{62,-90},{108,-90},{108,
          -76},{118,-76}}, color={255,0,255}));
  connect(tim5.passed, pre.u) annotation (Line(points={{282,-58},{280,-58},{280,
          -100},{298,-100}}, color={255,0,255}));
  connect(pre.y, and4.u2) annotation (Line(points={{322,-100},{340,-100},{340,-194},
          {-30,-194},{-30,102},{-22,102}},       color={255,0,255}));
  connect(pre.y, and6.u2) annotation (Line(points={{322,-100},{340,-100},{340,-194},
          {-30,-194},{-30,-78},{-22,-78}},       color={255,0,255}));
  connect(pre.y, and7.u2) annotation (Line(points={{322,-100},{340,-100},{340,-194},
          {-30,-194},{-30,-128},{-2,-128}},       color={255,0,255}));
  connect(and8.y, latHea2.clr) annotation (Line(points={{102,110},{118,110},{118,
          124}}, color={255,0,255}));
  connect(tim4.passed, and8.u2) annotation (Line(points={{-38,-18},{70,-18},{70,
          102},{78,102}}, color={255,0,255}));
  connect(not2.y, tim6.u) annotation (Line(points={{2,80},{20,80},{20,100},{28,100}},
        color={255,0,255}));
  connect(tim6.passed, and8.u1) annotation (Line(points={{52,92},{68,92},{68,110},
          {78,110}}, color={255,0,255}));
  connect(and3.y, not2.u) annotation (Line(points={{-98,110},{-92,110},{-92,80},
          {-22,80}}, color={255,0,255}));
  connect(and8.y, latHea1.u) annotation (Line(points={{102,110},{108,110},{108,90},
          {118,90}}, color={255,0,255}));
  connect(and6.y, latCoo1.u) annotation (Line(points={{2,-70},{12,-70},{12,-30},
          {118,-30}}, color={255,0,255}));
  connect(uPlaEna, and9.u2) annotation (Line(points={{-320,100},{-160,100},{
          -160,-58},{-122,-58}},             color={255,0,255}));
  connect(and9.y, tim1.u)
    annotation (Line(points={{-98,-50},{-82,-50}}, color={255,0,255}));
  connect(and6.y, or3.u1) annotation (Line(points={{2,-70},{12,-70},{12,-90},{38,
          -90}}, color={255,0,255}));
  connect(and5.y, not5.u) annotation (Line(points={{-96,-120},{-90,-120},{-90,-150},
          {-82,-150}}, color={255,0,255}));
  connect(not5.y, tim7.u)
    annotation (Line(points={{-58,-150},{-22,-150}}, color={255,0,255}));
  connect(tim7.passed, and10.u2) annotation (Line(points={{2,-158},{40,-158},{40,
          -138},{58,-138}}, color={255,0,255}));
  connect(tim1.passed, and10.u1) annotation (Line(points={{-58,-58},{30,-58},{
          30,-130},{58,-130}},                color={255,0,255}));
  connect(and10.y, latCoo3.clr) annotation (Line(points={{82,-130},{100,-130},{100,
          -116},{118,-116}}, color={255,0,255}));
  connect(and10.y, latCoo2.u) annotation (Line(points={{82,-130},{100,-130},{100,
          -70},{118,-70}}, color={255,0,255}));
  connect(gre2.y, and9.u1)
    annotation (Line(points={{-198,-50},{-122,-50}}, color={255,0,255}));
  connect(TChiSup, gre2.u1) annotation (Line(points={{-320,-60},{-260,-60},{
          -260,-50},{-222,-50}},
                            color={0,0,127}));
  connect(TChiSupSet, gre2.u2) annotation (Line(points={{-320,-100},{-250,-100},
          {-250,-58},{-222,-58}}, color={0,0,127}));
  connect(mulOr.y, latCoo1.clr)
    annotation (Line(points={{62,-42},{62,-36},{118,-36}}, color={255,0,255}));
  connect(falEdg.y, mulOr.u[1]) annotation (Line(points={{-118,50},{20,50},{20,
          -44.3333},{38,-44.3333}}, color={255,0,255}));
  connect(tim1.passed, mulOr.u[2]) annotation (Line(points={{-58,-58},{24,-58},
          {24,-42},{38,-42}}, color={255,0,255}));
  connect(and8.y, mulOr.u[3]) annotation (Line(points={{102,110},{108,110},{108,
          30},{30,30},{30,-39.6667},{38,-39.6667}}, color={255,0,255}));
  connect(mulOr1.y, latHea1.clr) annotation (Line(points={{62,70},{104,70},{104,
          84},{118,84}}, color={255,0,255}));
  connect(and4.y, mulOr1.u[1]) annotation (Line(points={{2,110},{8,110},{8,
          67.6667},{38,67.6667}}, color={255,0,255}));
  connect(falEdg.y, mulOr1.u[2]) annotation (Line(points={{-118,50},{14,50},{14,
          70},{38,70}}, color={255,0,255}));
  connect(and6.y, mulOr1.u[3]) annotation (Line(points={{2,-70},{12,-70},{12,
          -30},{36,-30},{36,52},{28,52},{28,72.3333},{38,72.3333}}, color={255,
          0,255}));
  connect(hys.y, not3.u) annotation (Line(points={{-168,-80},{-152,-80},{-152,0},
          {-142,0}}, color={255,0,255}));
  connect(hys.y, and1.u1)
    annotation (Line(points={{-168,-80},{-142,-80}}, color={255,0,255}));
  connect(hys.u, sub.y)
    annotation (Line(points={{-192,-80},{-198,-80}}, color={0,0,127}));
  connect(capReqHea.yCapReq, sub.u2) annotation (Line(points={{-238,30},{-226,
          30},{-226,-86},{-222,-86}}, color={0,0,127}));
  connect(capReqCoo.yCapReq, sub.u1) annotation (Line(points={{-238,-170},{-232,
          -170},{-232,-74},{-222,-74}}, color={0,0,127}));
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
        extent={{-300,-200},{400,240}})),
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
