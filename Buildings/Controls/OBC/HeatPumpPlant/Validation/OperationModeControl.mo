within Buildings.Controls.OBC.HeatPumpPlant.Validation;
model OperationModeControl
  "Validation model for system operation mode control"

  final parameter Real capHea_nominal(
    final unit="W")=120000
    "Installed heating capacity"
    annotation (Dialog(group="Nominal condition"));

  parameter Real THeaWatSup_nominal(
    unit="K",
    displayUnit="degC")=323.15
    "Design HW supply temperature"
    annotation (Dialog(group="Nominal condition"));

  parameter Real THeaWatRet_nominal(
    unit="K",
    displayUnit="degC")=315.15
    "Design HW return temperature"
    annotation (Dialog(group="Nominal condition"));

  parameter Real VHeaWat_flow_nominal(unit="m3/s")=capHea_nominal/abs(
    THeaWatSup_nominal - THeaWatRet_nominal)/opeModCon.cp_default/opeModCon.rho_default
    "Design HW volume flow rate"
    annotation (Dialog(group="Nominal condition"));

  final parameter Real capCoo_nominal(
    final unit="W")=120000
    "Installed cooling capacity"
    annotation (Dialog(group="Nominal condition"));

  parameter Real TChiWatSup_nominal(
    unit="K",
    displayUnit="degC")=280.15
    "Design CHW supply temperature"
    annotation (Dialog(group="Nominal condition"));

  parameter Real TChiWatRet_nominal(
    unit="K",
    displayUnit="degC")=285.15
    "Design CHW return temperature"
    annotation (Dialog(group="Nominal condition"));

  parameter Real VChiWat_flow_nominal(unit="m3/s")=capCoo_nominal/abs(
    TChiWatSup_nominal - TChiWatRet_nominal)/opeModCon.cp_default/opeModCon.rho_default
    "Design CHW volume flow rate"
    annotation (Dialog(group="Nominal condition"));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl opeModCon(
      T_CHWRetMin(displayUnit="degC") = 287.15, T_CHWSupSetMax(displayUnit=
          "degC") = 282.15)
    annotation (Placement(transformation(extent={{-30,20},{-10,60}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[3](
    each k=false)
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratV_flow(table=[0,0,0;
        1.5,0,0; 6,1,0; 12,0.2,0.2; 15,0,1; 22,0.1,0.1; 24,0,0],
    timeScale=3600)
    "Source signal for volume flow rate ratio – Index 1 for HHW, 2 for CHW"
    annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));

  CDL.Reals.Sources.Constant THeaWatRet2(k=273.15 + 50) "HWRT"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

  CDL.Reals.Sources.Constant TChiWatRet1(k=273.15 + 12) "CHWRT"
    annotation (Placement(transformation(extent={{-200,30},{-180,50}})));

  CDL.Reals.Sources.Constant THeaWatSupSet(k=273.15 + 60)
    "Hot Water Supply Temperature Setpoint"
    annotation (Placement(transformation(extent={{-200,120},{-180,140}})));

  CDL.Reals.Sources.Constant TChiWatSup1(k=273.15 + 14) "CHWST"
    annotation (Placement(transformation(extent={{-200,-80},{-180,-60}})));

  CDL.Logical.Sources.Pulse booPul(period=86400*2, shift=30)
    annotation (Placement(transformation(extent={{-200,150},{-180,170}})));
  CDL.Integers.Sources.Constant conInt[8](k={Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Disabled,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4})
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  CDL.Integers.Equal intEqu[8]
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  CDL.Routing.IntegerScalarReplicator intScaRep(nout=8)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  CDL.Logical.TrueDelay truDel[8](delayTime=fill(30, 8))
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  CDL.Logical.MultiOr mulOr(nin=8)
    annotation (Placement(transformation(extent={{120,30},{140,50}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{150,30},{170,50}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{154,-16},{174,4}})));
  CDL.Reals.Sources.Constant TChiWatSupSet(k=273.15 + 14.5)
    annotation (Placement(transformation(extent={{-252,-148},{-232,-128}})));
  CDL.Reals.Sources.Constant TChiWatRet2(k=273.15 + 16) "CHWRT"
    annotation (Placement(transformation(extent={{-200,-10},{-180,10}})));
  CDL.Reals.Sources.Constant                   THeaWatRet1(k=273.15 + 54)
    "HWRT"
    annotation (Placement(transformation(extent={{-200,90},{-180,110}})));
  CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{-160,70},{-140,90}})));
  CDL.Reals.Switch swi1
    annotation (Placement(transformation(extent={{-160,20},{-140,40}})));
  CDL.Reals.Sources.Constant TChiWatSup2(k=273.15 + 9)  "CHWST"
    annotation (Placement(transformation(extent={{-200,-110},{-180,-90}})));
  CDL.Reals.Switch swi2
    annotation (Placement(transformation(extent={{-150,-120},{-130,-100}})));
  CDL.Logical.Pre pre1[8]
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  CDL.Logical.TrueDelay truDel1(delayTime=14000)
    annotation (Placement(transformation(extent={{90,-30},{70,-10}})));
  CDL.Logical.Timer tim(t=18000)
    annotation (Placement(transformation(extent={{50,-50},{30,-30}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{14,-60},{-6,-40}})));
  CDL.Logical.MultiAnd mulAnd(nin=3)
    annotation (Placement(transformation(extent={{-10,-10},{-30,10}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  CDL.Logical.Pre pre2
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  CDL.Integers.OnCounter onCouInt
    annotation (Placement(transformation(extent={{10,-120},{30,-100}})));
  CDL.Integers.GreaterEqualThreshold intGreEquThr(t=1)
    annotation (Placement(transformation(extent={{40,-120},{60,-100}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  CDL.Logical.Sources.Constant con2(k=false)
    annotation (Placement(transformation(extent={{-50,-140},{-30,-120}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{70,-120},{90,-100}})));
  CDL.Logical.TrueDelay truDel2(delayTime=7000)
    annotation (Placement(transformation(extent={{90,-180},{70,-160}})));
  CDL.Logical.TrueDelay truDel3(delayTime=7000)
    annotation (Placement(transformation(extent={{60,-260},{40,-240}})));
  CDL.Logical.Pre pre3
    annotation (Placement(transformation(extent={{10,-230},{30,-210}})));
  CDL.Reals.Switch swi3
    annotation (Placement(transformation(extent={{-130,-150},{-110,-130}})));
  CDL.Reals.Sources.Constant TChiWatSupSet1(k=273.15 + 9)
    annotation (Placement(transformation(extent={{-200,-190},{-180,-170}})));
  CDL.Logical.Timer tim1(t=7000)
    annotation (Placement(transformation(extent={{60,-300},{40,-280}})));
  CDL.Logical.Pre pre4
    annotation (Placement(transformation(extent={{8,-280},{28,-260}})));
  CDL.Logical.Latch lat1
    annotation (Placement(transformation(extent={{-80,-260},{-100,-240}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-40,-260},{-60,-240}})));
  CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-8,-280},{-28,-260}})));
  CDL.Logical.Latch lat2
    annotation (Placement(transformation(extent={{30,-180},{10,-160}})));
  CDL.Logical.Timer tim2(t=7000)
    annotation (Placement(transformation(extent={{-120,-280},{-140,-260}})));
  CDL.Reals.Sources.Constant TChiWatSupSet2(k=273.15 + 9)
    annotation (Placement(transformation(extent={{-252,-110},{-232,-90}})));
  CDL.Logical.Timer tim3(t=7000)
    annotation (Placement(transformation(extent={{-170,-280},{-190,-260}})));
equation
  connect(con[1].y, opeModCon.uSchHea) annotation (Line(points={{-178,190},{-90,
          190},{-90,54.5455},{-32,54.5455}},
                                       color={255,0,255}));
  connect(con[2].y, opeModCon.uSchCoo1) annotation (Line(points={{-178,190},{
          -90,190},{-90,44},{-88,44},{-88,50.9091},{-32,50.9091}},
                            color={255,0,255}));
  connect(THeaWatSupSet.y, opeModCon.THeaSupSet) annotation (Line(points={{-178,
          130},{-102,130},{-102,43.6364},{-32,43.6364}},
                                                       color={0,0,127}));
  connect(VHeaWat_flow.y, opeModCon.VWatHot_flow) annotation (Line(points={{-118,
          -40},{-92,-40},{-92,36.3636},{-32,36.3636}},
                                     color={0,0,127}));
  connect(VChiWat_flow.y, opeModCon.VWatChi_flow) annotation (Line(points={{-118,
          -70},{-86,-70},{-86,21.8182},{-32,21.8182}},
                                                color={0,0,127}));
  connect(ratV_flow.y[1], VHeaWat_flow.u) annotation (Line(points={{-178,-40},{
          -142,-40}},                color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u) annotation (Line(points={{-178,-40},{
          -150,-40},{-150,-70},{-142,-70}},
                                     color={0,0,127}));
  connect(booPul.y, opeModCon.uPlaEna) annotation (Line(points={{-178,160},{-92,
          160},{-92,47.2727},{-32,47.2727}},
                         color={255,0,255}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{22,110},{30,110},{30,
          32},{38,32}},
                    color={255,127,0}));
  connect(opeModCon.yOpeMod, intScaRep.u)
    annotation (Line(points={{-8,40},{-2,40}}, color={255,127,0}));
  connect(intScaRep.y, intEqu.u1)
    annotation (Line(points={{22,40},{38,40}},
                                             color={255,127,0}));
  connect(intEqu.y, truDel.u)
    annotation (Line(points={{62,40},{78,40}},
                                             color={255,0,255}));
  connect(truDel.y, mulOr.u[1:8]) annotation (Line(points={{102,40},{110,40},{
          110,33.875},{118,33.875}},
                                 color={255,0,255}));
  connect(mulOr.y, edg.u)
    annotation (Line(points={{142,40},{148,40}},
                                               color={255,0,255}));
  connect(edg.y, pre.u) annotation (Line(points={{172,40},{178,40},{178,10},{
          144,10},{144,-6},{152,-6}},color={255,0,255}));
  connect(pre.y, opeModCon.uProCom) annotation (Line(points={{176,-6},{180,-6},
          {180,80},{-36,80},{-36,58.1818},{-32,58.1818}}, color={255,0,255}));
  connect(THeaWatRet1.y, swi.u1) annotation (Line(points={{-178,100},{-168,100},
          {-168,88},{-162,88}},color={0,0,127}));
  connect(THeaWatRet2.y, swi.u3)
    annotation (Line(points={{-178,70},{-178,72},{-162,72}}, color={0,0,127}));
  connect(swi.y, opeModCon.THeaRet) annotation (Line(points={{-138,80},{-120,80},
          {-120,40},{-32,40}},
                            color={0,0,127}));
  connect(TChiWatRet1.y, swi1.u1) annotation (Line(points={{-178,40},{-168,40},
          {-168,38},{-162,38}},
                              color={0,0,127}));
  connect(TChiWatRet2.y, swi1.u3) annotation (Line(points={{-178,0},{-174,0},{
          -174,22},{-162,22}},  color={0,0,127}));
  connect(swi1.y, opeModCon.TChiRet) annotation (Line(points={{-138,30},{-132,
          30},{-132,25.4545},{-32,25.4545}},
                                         color={0,0,127}));
  connect(TChiWatSup1.y, swi2.u1) annotation (Line(points={{-178,-70},{-156,-70},
          {-156,-102},{-152,-102}},       color={0,0,127}));
  connect(TChiWatSup2.y, swi2.u3) annotation (Line(points={{-178,-100},{-160,
          -100},{-160,-118},{-152,-118}}, color={0,0,127}));
  connect(swi2.y, opeModCon.TChiSup) annotation (Line(points={{-128,-110},{-88,
          -110},{-88,32.7273},{-32,32.7273}},   color={0,0,127}));
  connect(intEqu.y, pre1.u) annotation (Line(points={{62,40},{68,40},{68,22},{
          60,22},{60,10},{68,10}}, color={255,0,255}));
  connect(pre1[3].y, truDel1.u) annotation (Line(points={{92,10},{96,10},{96,
          -20},{92,-20}}, color={255,0,255}));
  connect(not1.u, tim.passed)
    annotation (Line(points={{16,-50},{16,-48},{28,-48}},
                                                        color={255,0,255}));
  connect(lat.u, mulAnd.y)
    annotation (Line(points={{-48,0},{-32,0}},     color={255,0,255}));
  connect(lat.y, pre2.u) annotation (Line(points={{-72,0},{-80,0},{-80,-80},{-2,
          -80}},             color={255,0,255}));
  connect(lat.clr, tim.passed) annotation (Line(points={{-48,-6},{-32,-6},{-32,
          -16},{22,-16},{22,-48},{28,-48}},     color={255,0,255}));
  connect(pre2.y, tim.u) annotation (Line(points={{22,-80},{60,-80},{60,-40},{
          52,-40}},  color={255,0,255}));
  connect(lat.y, swi1.u2) annotation (Line(points={{-72,0},{-168,0},{-168,30},{
          -162,30}}, color={255,0,255}));
  connect(onCouInt.y, intGreEquThr.u)
    annotation (Line(points={{32,-110},{38,-110}}, color={255,127,0}));
  connect(falEdg.y, onCouInt.trigger)
    annotation (Line(points={{2,-110},{8,-110}},   color={255,0,255}));
  connect(truDel1.y, mulAnd.u[1]) annotation (Line(points={{68,-20},{24,-20},{
          24,4.66667},{-8,4.66667}},    color={255,0,255}));
  connect(not1.y, mulAnd.u[2]) annotation (Line(points={{-8,-50},{-14,-50},{-14,
          -12},{-2,-12},{-2,0},{-8,0}},            color={255,0,255}));
  connect(con2.y, onCouInt.reset) annotation (Line(points={{-28,-130},{20,-130},
          {20,-122}}, color={255,0,255}));
  connect(pre2.y, falEdg.u) annotation (Line(points={{22,-80},{28,-80},{28,-92},
          {-30,-92},{-30,-110},{-22,-110}},        color={255,0,255}));
  connect(intGreEquThr.y, not2.u)
    annotation (Line(points={{62,-110},{68,-110}}, color={255,0,255}));
  connect(not2.y, mulAnd.u[3]) annotation (Line(points={{92,-110},{100,-110},{
          100,-4.66667},{-8,-4.66667}},  color={255,0,255}));
  connect(pre1[5].y, truDel2.u) annotation (Line(points={{92,10},{110,10},{110,
          -170},{92,-170}}, color={255,0,255}));
  connect(pre3.y, truDel3.u) annotation (Line(points={{32,-220},{70,-220},{70,
          -250},{62,-250}}, color={255,0,255}));
  connect(swi3.y, opeModCon.TChiSupSet) annotation (Line(points={{-108,-140},{
          -84,-140},{-84,29.0909},{-32,29.0909}}, color={0,0,127}));
  connect(TChiWatSupSet1.y, swi3.u3) annotation (Line(points={{-178,-180},{-144,
          -180},{-144,-148},{-132,-148}}, color={0,0,127}));
  connect(truDel3.y, pre4.u) annotation (Line(points={{38,-250},{0,-250},{0,
          -270},{6,-270}}, color={255,0,255}));
  connect(pre4.y, tim1.u) annotation (Line(points={{30,-270},{74,-270},{74,-290},
          {62,-290}}, color={255,0,255}));
  connect(lat1.y, swi.u2) annotation (Line(points={{-102,-250},{-170,-250},{
          -170,80},{-162,80}}, color={255,0,255}));
  connect(tim1.passed, lat1.clr) annotation (Line(points={{38,-298},{-70,-298},
          {-70,-256},{-78,-256}}, color={255,0,255}));
  connect(truDel3.y, and2.u1)
    annotation (Line(points={{38,-250},{-38,-250}}, color={255,0,255}));
  connect(and2.y, lat1.u)
    annotation (Line(points={{-62,-250},{-78,-250}}, color={255,0,255}));
  connect(not3.y, and2.u2) annotation (Line(points={{-30,-270},{-34,-270},{-34,
          -258},{-38,-258}}, color={255,0,255}));
  connect(tim1.passed, not3.u) annotation (Line(points={{38,-298},{-4,-298},{-4,
          -270},{-6,-270}}, color={255,0,255}));
  connect(truDel2.y, lat2.u)
    annotation (Line(points={{68,-170},{32,-170}}, color={255,0,255}));
  connect(lat2.y, swi2.u2) annotation (Line(points={{8,-170},{-156,-170},{-156,
          -110},{-152,-110}}, color={255,0,255}));
  connect(lat2.y, pre3.u) annotation (Line(points={{8,-170},{-50,-170},{-50,
          -220},{8,-220}}, color={255,0,255}));
  connect(tim2.passed, swi3.u2) annotation (Line(points={{-142,-278},{-150,-278},
          {-150,-140},{-132,-140}}, color={255,0,255}));
  connect(tim1.passed, tim2.u) annotation (Line(points={{38,-298},{-70,-298},{
          -70,-270},{-118,-270}}, color={255,0,255}));
  connect(con2.y, lat2.clr) annotation (Line(points={{-28,-130},{40,-130},{40,
          -176},{32,-176}}, color={255,0,255}));
  connect(tim2.passed, tim3.u) annotation (Line(points={{-142,-278},{-156,-278},
          {-156,-270},{-168,-270}}, color={255,0,255}));
  connect(TChiWatSupSet.y, swi3.u1) annotation (Line(points={{-230,-138},{-180,
          -138},{-180,-132},{-132,-132}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/HeatPumpPlant/Validation/OperationModeControl.mos"
        "Simulate and plot"),
    experiment(
      StopTime=86400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-220,-220},{220,220}}),
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false, extent={{-220,-220},{220,220}})),
    Documentation(
      info="<html>
<p>
This model validates
<a href=\"modelica://Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl\">
Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl</a>
in a heating operation, in a cooling operation, and in
a heating operation with the enable schedule provided via an input point,
and two cooling operations with the enable schedules provided via two
input points.
</p>
</html>", revisions="<html>
<ul>
<li>
June 7, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end OperationModeControl;
