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

  parameter Real T_CHWSupSet(
    final unit="K")= 273.15 + 12.8
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

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uSchHea
    "Heating mode enable via schedule"
    annotation (Placement(transformation(extent={{-340,120},{-300,160}}),
      iconTransformation(extent={{-140,90},{-100,130}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uSchCoo1
    "Cooling mode enable via schedule 1"
    annotation (Placement(transformation(extent={{-340,90},{-300,130}}),
      iconTransformation(extent={{-140,60},{-100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaSup(
    final unit="K",
    displayUnit="degC")
    "Supply temperature used to compute required heating load"
    annotation (Placement(transformation(extent={{-340,-10},{-300,30}}),
      iconTransformation(extent={{-140,-30},{-100,10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaRet(
    final unit="K",
    displayUnit="degC")
    "Return temperature used to compute required heating or cooling load"
    annotation (Placement(transformation(extent={{-340,-70},{-300,-30}}),
      iconTransformation(extent={{-140,-70},{-100,-30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput V_heaflow(
    final unit="m3/s")
    "Volume flow rate used to compute required heating load"
    annotation (Placement(transformation(extent={{-340,-130},{-300,-90}}),
      iconTransformation(extent={{-140,-110},{-100,-70}})));

  Buildings.Controls.OBC.CDL.Reals.Subtract delT[2]
    "Compute ∆T"
    annotation (Placement(transformation(extent={{-270,-120},{-250,-100}})));

  Buildings.Controls.OBC.CDL.Reals.Abs absDelT[2]
    "Compute absolute value of ∆T"
    annotation (Placement(transformation(extent={{-240,-120},{-220,-100}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter LoaFlo[2](
    each final k=rho_default*cp_default)
    "Compute the product of specific heat and flow rate"
    annotation (Placement(transformation(extent={{-240,-150},{-220,-130}})));

  Buildings.Controls.OBC.CDL.Reals.Multiply LoaReq[2]
    "Compute required heating/cooling load"
    annotation (Placement(transformation(extent={{-200,-126},{-180,-106}})));

  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAve[2](
    each delta=dtMea)
    "Compute moving average"
    annotation (Placement(transformation(extent={{-170,-126},{-150,-106}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1)
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2)
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3)
    annotation (Placement(transformation(extent={{0,110},{20,130}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt4(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt5(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiSup(
    final unit="K",
    displayUnit="degC")
    "Supply temperature used to compute required cooling load"
    annotation (Placement(transformation(extent={{-340,-40},{-300,0}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiRet(
    final unit="K",
    displayUnit="degC")
    "Return temperature used to compute required cooling load"
    annotation (Placement(transformation(extent={{-340,-100},{-300,-60}}),
      iconTransformation(extent={{-140,-90},{-100,-50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput V_chiflow(
    final unit="m3/s")
    "Volume flow rate used to compute required cooling load"
    annotation (Placement(transformation(extent={{-340,-160},{-300,-120}}),
      iconTransformation(extent={{-140,-130},{-100,-90}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod
    "Operation mode"
    annotation (Placement(transformation(extent={{300,-80},{340,-40}}),
      iconTransformation(extent={{100,-60},{140,-20}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt6(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt7(k=Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_5)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrHea(t=min_heating)
    annotation (Placement(transformation(extent={{-130,-90},{-110,-70}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrCoo(t=min_cooling)
    annotation (Placement(transformation(extent={{-130,-150},{-110,-130}})));

  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{-90,-120},{-70,-100}})));

  Buildings.Controls.OBC.CDL.Reals.Greater gre
    annotation (Placement(transformation(extent={{-130,-60},{-110,-40}})));

  Buildings.Controls.OBC.CDL.Reals.Greater gre1
    annotation (Placement(transformation(extent={{-130,-120},{-110,-100}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{-40,-82},{-20,-62}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{0,-74},{20,-54}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi2
    annotation (Placement(transformation(extent={{80,-66},{100,-46}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi3
    annotation (Placement(transformation(extent={{-40,-128},{-20,-108}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPla_ava
    "Plant availability status"
    annotation (Placement(transformation(extent={{-340,30},{-300,70}}),
      iconTransformation(extent={{-140,0},{-100,40}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim3(
    t=dtMod7)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-240,-90},{-220,-70}})));

  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(
    t=T_CHWRetMin)
    annotation (Placement(transformation(extent={{-270,-90},{-250,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uSchCoo2
    "Cooling mode enable via schedule 2"
    annotation (Placement(transformation(extent={{-340,60},{-300,100}}),
      iconTransformation(extent={{-140,30},{-100,70}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi4
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim1(
    t=dtMod3)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-240,-30},{-220,-10}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrRetCoo1(
    t=T_CHWSupSet)
    annotation (Placement(transformation(extent={{-270,-30},{-250,-10}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi5
    annotation (Placement(transformation(extent={{50,-142},{70,-122}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim2(
    t=dtMod5)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-240,-60},{-220,-40}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThrRetCoo2(
    t=T_HHWRetMax)
    annotation (Placement(transformation(extent={{-270,-60},{-250,-40}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi6
    annotation (Placement(transformation(extent={{90,-130},{110,-110}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi7
    annotation (Placement(transformation(extent={{140,-118},{160,-98}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-280,110},{-260,130}})));

  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-280,70},{-260,90}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(nin=3)
    annotation (Placement(transformation(extent={{-240,130},{-220,150}})));

  Buildings.Controls.OBC.CDL.Logical.And and3
    annotation (Placement(transformation(extent={{-240,90},{-220,110}})));

  Buildings.Controls.OBC.CDL.Logical.And and4
    annotation (Placement(transformation(extent={{-208,56},{-188,76}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPla
    "Plant enable signal"
    annotation (Placement(transformation(extent={{300,40},{340,80}}),
      iconTransformation(extent={{100,20},{140,60}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-260,10},{-240,30}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim(
    t=dtMod1)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{-230,10},{-210,30}})));

  Buildings.Controls.OBC.CDL.Integers.Switch intSwi8
    annotation (Placement(transformation(extent={{220,-82},{240,-62}})));

  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{140,-90},{160,-70}})));

  Buildings.Controls.OBC.CDL.Logical.And and6
    annotation (Placement(transformation(extent={{180,-82},{200,-62}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{270,-40},{250,-20}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt
    annotation (Placement(transformation(extent={{230,-40},{210,-20}})));

  Buildings.Controls.OBC.CDL.Integers.Multiply mulInt
    annotation (Placement(transformation(extent={{260,-70},{280,-50}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{260,50},{280,70}})));

  Buildings.Controls.OBC.CDL.Logical.Not not4
    annotation (Placement(transformation(extent={{130,100},{150,120}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim4(
    t=dtRun)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{160,30},{180,50}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim5(
    t=dtRun)
    "Return true if system has been enabled for specified duration"
    annotation (Placement(transformation(extent={{160,100},{180,120}})));

  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd1(
    nin=3)
    annotation (Placement(transformation(extent={{220,130},{240,150}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    nin=2)
    annotation (Placement(transformation(extent={{160,60},{180,80}})));

  Buildings.Controls.OBC.CDL.Logical.And and5
    annotation (Placement(transformation(extent={{220,44},{240,64}})));

  Buildings.Controls.OBC.CDL.Logical.Not not5
    annotation (Placement(transformation(extent={{90,60},{110,80}})));

  Buildings.Controls.OBC.CDL.Logical.Not not6[2]
    annotation (Placement(transformation(extent={{-180,10},{-160,30}})));

  Buildings.Controls.OBC.CDL.Logical.And and7
    annotation (Placement(transformation(extent={{-148,10},{-128,30}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim6(
    t=dtMod2)
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{210,-150},{230,-130}})));

  Buildings.Controls.OBC.CDL.Logical.And and8
    annotation (Placement(transformation(extent={{-210,-38},{-190,-18}})));

  Buildings.Controls.OBC.CDL.Logical.And and9
    annotation (Placement(transformation(extent={{-210,-68},{-190,-48}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{170,-146},{190,-126}})));

equation
  connect(THeaSup, delT[1].u1) annotation (Line(points={{-320,10},{-280,10},{-280,
          -104},{-272,-104}}, color={0,0,127}));
  connect(THeaRet, delT[1].u2) annotation (Line(points={{-320,-50},{-290,-50},{-290,
          -116},{-272,-116}}, color={0,0,127}));
  connect(TChiSup, delT[2].u1) annotation (Line(points={{-320,-20},{-280,-20},{-280,
          -104},{-272,-104}}, color={0,0,127}));
  connect(TChiRet, delT[2].u2) annotation (Line(points={{-320,-80},{-290,-80},{-290,
          -116},{-272,-116}}, color={0,0,127}));
  connect(delT.y, absDelT.u)
    annotation (Line(points={{-248,-110},{-242,-110}}, color={0,0,127}));
  connect(absDelT.y, LoaReq.u1) annotation (Line(points={{-218,-110},{-202,-110}},
                                 color={0,0,127}));
  connect(LoaFlo.y, LoaReq.u2) annotation (Line(points={{-218,-140},{-208,-140},
          {-208,-122},{-202,-122}},
                             color={0,0,127}));
  connect(LoaReq.y, movAve.u)
    annotation (Line(points={{-178,-116},{-172,-116}},
                                                     color={0,0,127}));
  connect(V_heaflow, LoaFlo[1].u) annotation (Line(points={{-320,-110},{-280,-110},
          {-280,-140},{-242,-140}}, color={0,0,127}));
  connect(V_chiflow, LoaFlo[2].u)
    annotation (Line(points={{-320,-140},{-242,-140}}, color={0,0,127}));
  connect(movAve[1].y, greThrHea.u) annotation (Line(points={{-148,-116},{-140,-116},
          {-140,-80},{-132,-80}},
                            color={0,0,127}));
  connect(movAve[2].y, greThrCoo.u) annotation (Line(points={{-148,-116},{-140,-116},
          {-140,-140},{-132,-140}},
                              color={0,0,127}));
  connect(movAve[1].y, gre.u1) annotation (Line(points={{-148,-116},{-140,-116},
          {-140,-50},{-132,-50}},
                    color={0,0,127}));
  connect(movAve[2].y, gre.u2) annotation (Line(points={{-148,-116},{-140,-116},
          {-140,-58},{-132,-58}},
                    color={0,0,127}));
  connect(gre.y, and2.u1) annotation (Line(points={{-108,-50},{-92,-50}},
                 color={255,0,255}));
  connect(movAve[1].y, gre1.u2) annotation (Line(points={{-148,-116},{-140,-116},
          {-140,-118},{-132,-118}},
                     color={0,0,127}));
  connect(movAve[2].y, gre1.u1)
    annotation (Line(points={{-148,-116},{-140,-116},{-140,-110},{-132,-110}},
                                                  color={0,0,127}));
  connect(gre1.y, and1.u1) annotation (Line(points={{-108,-110},{-92,-110}},
                      color={255,0,255}));
  connect(and2.y, intSwi.u2)
    annotation (Line(points={{-68,-50},{-60,-50},{-60,-72},{-42,-72}},
                                                 color={255,0,255}));
  connect(conInt.y, intSwi.u1) annotation (Line(points={{-58,120},{-48,120},{-48,
          -64},{-42,-64}},
                     color={255,127,0}));
  connect(conInt3.y, intSwi.u3) annotation (Line(points={{-58,70},{-54,70},{-54,
          -80},{-42,-80}},
                     color={255,127,0}));
  connect(intSwi.y, intSwi1.u3) annotation (Line(points={{-18,-72},{-2,-72}},
                     color={255,127,0}));
  connect(conInt1.y, intSwi1.u1) annotation (Line(points={{-18,120},{-6,120},{-6,
          -56},{-2,-56}}, color={255,127,0}));
  connect(intSwi1.y, intSwi2.u3) annotation (Line(points={{22,-64},{78,-64}},
                           color={255,127,0}));
  connect(conInt2.y, intSwi2.u1) annotation (Line(points={{22,120},{74,120},{74,
          -48},{78,-48}},
                      color={255,127,0}));
  connect(and1.y, intSwi3.u2)
    annotation (Line(points={{-68,-110},{-60,-110},{-60,-118},{-42,-118}},
                                                   color={255,0,255}));
  connect(TChiRet, lesThr.u)
    annotation (Line(points={{-320,-80},{-272,-80}}, color={0,0,127}));
  connect(lesThr.y, tim3.u)
    annotation (Line(points={{-248,-80},{-242,-80}}, color={255,0,255}));
  connect(conInt3.y, intSwi3.u1) annotation (Line(points={{-58,70},{-54,70},{-54,
          -110},{-42,-110}}, color={255,127,0}));
  connect(conInt.y, intSwi3.u3) annotation (Line(points={{-58,120},{-48,120},{-48,
          -126},{-42,-126}}, color={255,127,0}));
  connect(greThrRetCoo1.y, tim1.u)
    annotation (Line(points={{-248,-20},{-242,-20}}, color={255,0,255}));
  connect(TChiSup, greThrRetCoo1.u)
    annotation (Line(points={{-320,-20},{-272,-20}}, color={0,0,127}));
  connect(greThrRetCoo2.y, tim2.u)
    annotation (Line(points={{-248,-50},{-242,-50}}, color={255,0,255}));
  connect(THeaRet, greThrRetCoo2.u)
    annotation (Line(points={{-320,-50},{-272,-50}}, color={0,0,127}));
  connect(intSwi4.y, intSwi5.u3)
    annotation (Line(points={{22,-120},{34,-120},{34,-140},{48,-140}},
                                                   color={255,127,0}));
  connect(conInt5.y, intSwi5.u1) annotation (Line(points={{22,40},{26,40},{26,-124},
          {48,-124}}, color={255,127,0}));
  connect(intSwi5.y, intSwi6.u3) annotation (Line(points={{72,-132},{80,-132},{80,
          -128},{88,-128}},      color={255,127,0}));
  connect(conInt6.y, intSwi6.u1) annotation (Line(points={{62,20},{66,20},{66,-112},
          {88,-112}},  color={255,127,0}));
  connect(intSwi6.y, intSwi7.u3) annotation (Line(points={{112,-120},{120,-120},
          {120,-116},{138,-116}}, color={255,127,0}));
  connect(conInt7.y, intSwi7.u1) annotation (Line(points={{102,0},{106,0},{106,-100},
          {138,-100}},color={255,127,0}));
  connect(uSchCoo1, not1.u) annotation (Line(points={{-320,110},{-290,110},{-290,
          120},{-282,120}}, color={255,0,255}));
  connect(uSchCoo2, not2.u)
    annotation (Line(points={{-320,80},{-282,80}}, color={255,0,255}));
  connect(uSchHea, mulAnd.u[1]) annotation (Line(points={{-320,140},{-260,140},
          {-260,137.667},{-242,137.667}},color={255,0,255}));
  connect(not1.y, mulAnd.u[2]) annotation (Line(points={{-258,120},{-248,120},{-248,
          140},{-242,140}}, color={255,0,255}));
  connect(not2.y, mulAnd.u[3]) annotation (Line(points={{-258,80},{-248,80},{
          -248,142.333},{-242,142.333}},
                                    color={255,0,255}));
  connect(mulAnd.y, intSwi2.u2) annotation (Line(points={{-218,140},{34,140},{34,
          -56},{78,-56}}, color={255,0,255}));
  connect(uSchCoo1, and3.u1) annotation (Line(points={{-320,110},{-290,110},{-290,
          100},{-242,100}}, color={255,0,255}));
  connect(not2.y, and3.u2) annotation (Line(points={{-258,80},{-248,80},{-248,92},
          {-242,92}}, color={255,0,255}));
  connect(and3.y, intSwi6.u2) annotation (Line(points={{-218,100},{70,100},{70,-120},
          {88,-120}},        color={255,0,255}));
  connect(uSchCoo2, and4.u2) annotation (Line(points={{-320,80},{-290,80},{-290,
          58},{-210,58}}, color={255,0,255}));
  connect(and4.y, intSwi7.u2) annotation (Line(points={{-186,66},{-88,66},{-88,-32},
          {114,-32},{114,-108},{138,-108}},  color={255,0,255}));
  connect(intSwi7.y, intSwi8.u3) annotation (Line(points={{162,-108},{210,-108},
          {210,-80},{218,-80}},
                           color={255,127,0}));
  connect(intSwi2.y, intSwi8.u1)
    annotation (Line(points={{102,-56},{210,-56},{210,-64},{218,-64}},
                                                   color={255,127,0}));
  connect(and1.y, not3.u) annotation (Line(points={{-68,-110},{-60,-110},{-60,-94},
          {130,-94},{130,-80},{138,-80}},  color={255,0,255}));
  connect(not3.y, and6.u2)
    annotation (Line(points={{162,-80},{178,-80}}, color={255,0,255}));
  connect(and2.y, and6.u1) annotation (Line(points={{-68,-50},{-60,-50},{-60,-88},
          {120,-88},{120,-60},{170,-60},{170,-72},{178,-72}},
                                                          color={255,0,255}));
  connect(and6.y, intSwi8.u2) annotation (Line(points={{202,-72},{218,-72}},
                           color={255,0,255}));
  connect(yPla, pre.u) annotation (Line(points={{320,60},{290,60},{290,-30},{272,
          -30}},color={255,0,255}));
  connect(pre.y, booToInt.u)
    annotation (Line(points={{248,-30},{232,-30}},
                                                 color={255,0,255}));
  connect(intSwi8.y, mulInt.u2) annotation (Line(points={{242,-72},{250,-72},{250,
          -66},{258,-66}},
                         color={255,127,0}));
  connect(booToInt.y, mulInt.u1) annotation (Line(points={{208,-30},{200,-30},{200,
          -54},{258,-54}},
                       color={255,127,0}));
  connect(or2.y, tim.u)
    annotation (Line(points={{-238,20},{-232,20}}, color={255,0,255}));
  connect(tim3.passed, intSwi1.u2) annotation (Line(points={{-218,-88},{-148,-88},
          {-148,-26},{-10,-26},{-10,-64},{-2,-64}}, color={255,0,255}));
  connect(lat.y, yPla)
    annotation (Line(points={{282,60},{320,60}}, color={255,0,255}));
  connect(mulInt.y, yOpeMod) annotation (Line(points={{282,-60},{320,-60}},
                      color={255,127,0}));
  connect(mulAnd1.y, lat.u) annotation (Line(points={{242,140},{250,140},{250,60},
          {258,60}}, color={255,0,255}));
  connect(and5.y, lat.clr)
    annotation (Line(points={{242,54},{258,54}}, color={255,0,255}));
  connect(pre.y, tim4.u) annotation (Line(points={{248,-30},{240,-30},{240,-48},
          {150,-48},{150,40},{158,40}}, color={255,0,255}));
  connect(tim4.passed, and5.u2) annotation (Line(points={{182,32},{210,32},{210,
          46},{218,46}}, color={255,0,255}));
  connect(mulOr.y, and5.u1) annotation (Line(points={{182,70},{210,70},{210,54},
          {218,54}}, color={255,0,255}));
  connect(pre.y, not4.u) annotation (Line(points={{248,-30},{240,-30},{240,-48},
          {120,-48},{120,110},{128,110}}, color={255,0,255}));
  connect(not4.y, tim5.u)
    annotation (Line(points={{152,110},{158,110}}, color={255,0,255}));
  connect(tim5.passed, mulAnd1.u[1]) annotation (Line(points={{182,102},{210,
          102},{210,137.667},{218,137.667}},
                                        color={255,0,255}));
  connect(uPla_ava, mulAnd1.u[2]) annotation (Line(points={{-320,50},{-214,50},{
          -214,150},{210,150},{210,140},{218,140}}, color={255,0,255}));
  connect(not5.u, uPla_ava) annotation (Line(points={{88,70},{80,70},{80,150},{-214,
          150},{-214,50},{-320,50}}, color={255,0,255}));
  connect(tim.passed, mulAnd1.u[3]) annotation (Line(points={{-208,12},{-200,12},
          {-200,40},{-180,40},{-180,146},{210,146},{210,142},{214,142},{214,
          142.333},{218,142.333}},
                          color={255,0,255}));
  connect(or2.u1, greThrCoo.y) annotation (Line(points={{-262,20},{-270,20},{-270,
          0},{-186,0},{-186,-94},{-104,-94},{-104,-140},{-108,-140}}, color={255,
          0,255}));
  connect(greThrHea.y, or2.u2) annotation (Line(points={{-108,-80},{-104,-80},{-104,
          4},{-266,4},{-266,12},{-262,12}}, color={255,0,255}));
  connect(greThrHea.y, not6[1].u) annotation (Line(points={{-108,-80},{-104,-80},
          {-104,0},{-186,0},{-186,20},{-182,20}}, color={255,0,255}));
  connect(greThrCoo.y, not6[2].u) annotation (Line(points={{-108,-140},{-104,-140},
          {-104,-94},{-186,-94},{-186,20},{-182,20}}, color={255,0,255}));
  connect(not6[1].y, and7.u1)
    annotation (Line(points={{-158,20},{-150,20}}, color={255,0,255}));
  connect(not6[2].y, and7.u2) annotation (Line(points={{-158,20},{-154,20},{-154,
          12},{-150,12}}, color={255,0,255}));
  connect(and7.y, tim6.u)
    annotation (Line(points={{-126,20},{-122,20}}, color={255,0,255}));
  connect(tim6.passed, mulOr.u[1]) annotation (Line(points={{-98,12},{30,12},{30,
          40},{140,40},{140,68.25},{158,68.25}}, color={255,0,255}));
  connect(not5.y, mulOr.u[2]) annotation (Line(points={{112,70},{140,70},{140,71.75},
          {158,71.75}}, color={255,0,255}));
  connect(tim.passed, and2.u2) annotation (Line(points={{-208,12},{-200,12},{-200,
          -4},{-100,-4},{-100,-58},{-92,-58}}, color={255,0,255}));
  connect(tim.passed, and1.u2) annotation (Line(points={{-208,12},{-200,12},{-200,
          -4},{-100,-4},{-100,-118},{-92,-118}}, color={255,0,255}));
  connect(not1.y, and4.u1) annotation (Line(points={{-258,120},{-248,120},{-248,
          66},{-210,66}}, color={255,0,255}));
  connect(intSwi3.y, intSwi4.u3) annotation (Line(points={{-18,-118},{-14,-118},
          {-14,-128},{-2,-128}}, color={255,127,0}));
  connect(conInt4.y, intSwi4.u1) annotation (Line(points={{-18,50},{-8,50},{-8,-112},
          {-2,-112}},       color={255,127,0}));
  connect(and8.y, intSwi4.u2) annotation (Line(points={{-188,-28},{-180,-28},{-180,
          -12},{-12,-12},{-12,-120},{-2,-120}}, color={255,0,255}));
  connect(tim1.passed, and8.u1)
    annotation (Line(points={{-218,-28},{-212,-28}}, color={255,0,255}));
  connect(tim2.passed, and9.u1)
    annotation (Line(points={{-218,-58},{-212,-58}}, color={255,0,255}));
  connect(and9.y, intSwi5.u2) annotation (Line(points={{-188,-58},{-174,-58},{-174,
          -20},{40,-20},{40,-132},{48,-132}}, color={255,0,255}));
  connect(conInt4.y, intEqu1.u2) annotation (Line(points={{-18,50},{-8,50},{-8,-144},
          {168,-144}}, color={255,127,0}));
  connect(mulInt.y, intEqu1.u1) annotation (Line(points={{282,-60},{290,-60},{290,
          -120},{160,-120},{160,-136},{168,-136}}, color={255,127,0}));
  connect(mulInt.y, intEqu.u1) annotation (Line(points={{282,-60},{290,-60},{290,
          -120},{200,-120},{200,-140},{208,-140}}, color={255,127,0}));
  connect(conInt3.y, intEqu.u2) annotation (Line(points={{-58,70},{-54,70},{-54,
          -148},{208,-148}},                       color={255,127,0}));
  connect(intEqu1.y, and9.u2) annotation (Line(points={{192,-136},{196,-136},{196,
          -152},{-214,-152},{-214,-66},{-212,-66}}, color={255,0,255}));
  connect(intEqu.y, and8.u2) annotation (Line(points={{232,-140},{236,-140},{236,
          -156},{-214,-156},{-214,-36},{-212,-36}}, color={255,0,255}));
annotation (
    defaultComponentName="opeModCon",
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-120},{100,120}}),
      graphics={
        Rectangle(
          extent={{-100,120},{100,-120}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,170},{150,130}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-300,-160},{300,160}})),
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
