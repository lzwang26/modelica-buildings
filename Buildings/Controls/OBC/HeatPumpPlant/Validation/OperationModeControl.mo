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
      T_CHWRetMin(displayUnit="degC") = 287.15, T_CHWSupSetMax(displayUnit="degC")=
         282.15) "Operation mode setpoint controller"
    annotation (Placement(transformation(extent={{-10,58},{10,102}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(each k=false)
    "Constant Boolean false source"
    annotation (Placement(transformation(extent={{-180,220},{-160,240}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratV_flow(table=[0,0,0;
        1.5,0,0; 6,1,0; 12,0.2,0.2; 15,0,1; 22,0.1,0.1; 24,0,0],
    timeScale=3600)
    "Source signal for volume flow rate ratio – Index 1 for hot water, 2 for chilled water"
    annotation (Placement(transformation(extent={{-180,-10},{-160,10}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));

  CDL.Reals.Sources.Constant THeaWatRet2(k=273.15 + 50)
    "Measured hot water return temperature (Low)"
    annotation (Placement(transformation(extent={{-180,100},{-160,120}})));

  CDL.Reals.Sources.Constant TChiWatRet1(k=273.15 + 12)
    "Measured chilled water return temperature (High)"
    annotation (Placement(transformation(extent={{-180,70},{-160,90}})));

  CDL.Reals.Sources.Constant THotWatSupSet(k=273.15 + 60)
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-180,160},{-160,180}})));

  CDL.Reals.Sources.Constant TChiWatSup1(k=273.15 + 14)
    "Measured chilled water supply temperature (High)"
    annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));

  CDL.Logical.Sources.Pulse booPul(period=86400*2, shift=30)
    "Boolean pulse signal used to enable plant at non-zero simulation time"
    annotation (Placement(transformation(extent={{-180,190},{-160,210}})));
  CDL.Integers.Sources.Constant conIntOpeMod[8](k={Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Disabled,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4})
    "Constant integer source for enumerating operation modes"
    annotation (Placement(transformation(extent={{20,140},{40,160}})));
  CDL.Integers.Equal intEquOpeMod[8]
    "Identify current operation mode in array of possible operation modes"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  CDL.Routing.IntegerScalarReplicator intScaRep(nout=8) "Integer replicator"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  CDL.Logical.TrueDelay truDelProCha[8](delayTime=fill(30, 8))
    "Delay for representing operation mode change process duration"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  CDL.Logical.MultiOr mulOrProCha(nin=8)
    "Identify any operation mode change completions"
    annotation (Placement(transformation(extent={{140,70},{160,90}})));
  CDL.Logical.Edge edgProCha
    "Edge block to change process change completion signal into pulse"
    annotation (Placement(transformation(extent={{170,70},{190,90}})));
  CDL.Logical.Pre preProCha
    "Pre block for routing back process change completion signal"
    annotation (Placement(transformation(extent={{174,24},{194,44}})));
  CDL.Reals.Sources.Constant TChiWatSupSet1(k=273.15 + 14.5)
    "Chilled water supply temperature setpoint (High)"
    annotation (Placement(transformation(extent={{-180,-110},{-160,-90}})));
  CDL.Reals.Sources.Constant TChiWatRet2(k=273.15 + 16)
    "Measured chilled water return temperature (Low)"
    annotation (Placement(transformation(extent={{-180,30},{-160,50}})));
  CDL.Reals.Sources.Constant                   THeaWatRet1(k=273.15 + 54)
    "Measured hot water return temperature (High)"
    annotation (Placement(transformation(extent={{-180,130},{-160,150}})));
  CDL.Reals.Switch swiTHotWatRet
    "Switch between two different hot water return temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-140,110},{-120,130}})));
  CDL.Reals.Switch swiTChiWatRet
    "Switch between two different chilled water return temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  CDL.Reals.Sources.Constant TChiWatSup2(k=273.15 + 9)
    "Measured chilled water supply temperature (Low)"
    annotation (Placement(transformation(extent={{-180,-70},{-160,-50}})));
  CDL.Reals.Switch swiTChiWatSup
    "Switch between two different chilled water supply temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-130,-80},{-110,-60}})));
  CDL.Logical.Pre preOpeMod[8]
    "Pre block for routing back operation mode status signals"
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  CDL.Logical.TrueDelay truDelTChiWatRet(delayTime=14000)
    "Delay chilled water return temperature signal"
    annotation (Placement(transformation(extent={{110,10},{90,30}})));
  CDL.Logical.Timer timTChiWatRet(t=18000)
    "Timer for disabling chilled water return temperature latch"
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  CDL.Logical.Not notTChiWatRet
    "Not operator for disabling latch required instant"
    annotation (Placement(transformation(extent={{34,-20},{14,0}})));
  CDL.Logical.MultiAnd mulAndTChiWatRet(nin=3)
    "Enable latch for chilled water return temperature"
    annotation (Placement(transformation(extent={{10,30},{-10,50}})));
  CDL.Logical.Latch latTChiWatRet
    "Latch for holding signal to chilled water return temperature switch"
    annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
  CDL.Logical.Pre pre2
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  CDL.Integers.OnCounter onCouInt
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  CDL.Integers.GreaterEqualThreshold intGreEquThr(t=1)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{90,-80},{110,-60}})));
  CDL.Logical.TrueDelay truDelTChiWatSup(delayTime=7000)
    "Delay signal to chilled water supply temperature"
    annotation (Placement(transformation(extent={{110,-140},{90,-120}})));
  CDL.Logical.TrueDelay truDelTHotWatRet(delayTime=7000)
    "Delay enable of hot water return temperature latch"
    annotation (Placement(transformation(extent={{80,-200},{60,-180}})));
  CDL.Logical.Pre preTChiWatSup
    "Pre block for routing back chilled water supply temperature switch signal"
    annotation (Placement(transformation(extent={{30,-170},{50,-150}})));
  CDL.Reals.Switch swiTChiWatSupSet
    "Switch between two different chilled water supply temperature setpoints to induce mode transition"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  CDL.Reals.Sources.Constant TChiWatSupSet2(k=273.15 + 9)
    "Chilled water supply temperature setpoint (Low)"
    annotation (Placement(transformation(extent={{-180,-150},{-160,-130}})));
  CDL.Logical.Timer timTHotWatRet(t=7000)
    "Timer to disable hot water return temperature latch"
    annotation (Placement(transformation(extent={{80,-240},{60,-220}})));
  CDL.Logical.Pre preTHotWatRet
    "Pre block for routing signal to change hot water return temperature latch"
    annotation (Placement(transformation(extent={{28,-220},{48,-200}})));
  CDL.Logical.Latch latTHotWatRet
    "Latch to hold switch for hot water return temperature"
    annotation (Placement(transformation(extent={{-60,-200},{-80,-180}})));
  CDL.Logical.And andTHotWatRet
    "Enable latch only for fixed duration and then disable it"
    annotation (Placement(transformation(extent={{-20,-200},{-40,-180}})));
  CDL.Logical.Not notTHotWatRet "Not operation for disabling latch"
    annotation (Placement(transformation(extent={{12,-220},{-8,-200}})));
  CDL.Logical.Latch latTChiWatSup
    "Latch for holding signal to chilled water supply temperature signal"
    annotation (Placement(transformation(extent={{50,-140},{30,-120}})));
  CDL.Logical.Timer timTChiWatSupSet(t=7000)
    "Timer to switch chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-100,-220},{-120,-200}})));
equation
  connect(THotWatSupSet.y, opeModCon.THeaSupSet) annotation (Line(points={{-158,
          170},{-82,170},{-82,84},{-12,84}},           color={0,0,127}));
  connect(VHeaWat_flow.y, opeModCon.VWatHot_flow) annotation (Line(points={{-98,0},
          {-72,0},{-72,76},{-12,76}},color={0,0,127}));
  connect(VChiWat_flow.y, opeModCon.VWatChi_flow) annotation (Line(points={{-98,-30},
          {-66,-30},{-66,60},{-12,60}},         color={0,0,127}));
  connect(ratV_flow.y[1], VHeaWat_flow.u) annotation (Line(points={{-158,0},{
          -122,0}},                  color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u) annotation (Line(points={{-158,0},{
          -130,0},{-130,-30},{-122,-30}},
                                     color={0,0,127}));
  connect(booPul.y, opeModCon.uPlaEna) annotation (Line(points={{-158,200},{-74,
          200},{-74,88},{-12,88}},
                         color={255,0,255}));
  connect(conIntOpeMod.y, intEquOpeMod.u2) annotation (Line(points={{42,150},{
          50,150},{50,72},{58,72}}, color={255,127,0}));
  connect(opeModCon.yOpeMod, intScaRep.u)
    annotation (Line(points={{12,80},{18,80}}, color={255,127,0}));
  connect(intScaRep.y, intEquOpeMod.u1)
    annotation (Line(points={{42,80},{58,80}}, color={255,127,0}));
  connect(intEquOpeMod.y, truDelProCha.u)
    annotation (Line(points={{82,80},{98,80}}, color={255,0,255}));
  connect(truDelProCha.y, mulOrProCha.u[1:8]) annotation (Line(points={{122,80},
          {130,80},{130,73.875},{138,73.875}}, color={255,0,255}));
  connect(mulOrProCha.y, edgProCha.u)
    annotation (Line(points={{162,80},{168,80}}, color={255,0,255}));
  connect(edgProCha.y, preProCha.u) annotation (Line(points={{192,80},{198,80},
          {198,50},{164,50},{164,34},{172,34}}, color={255,0,255}));
  connect(preProCha.y, opeModCon.uProCom) annotation (Line(points={{196,34},{
          200,34},{200,120},{-16,120},{-16,100},{-12,100}}, color={255,0,255}));
  connect(THeaWatRet1.y, swiTHotWatRet.u1) annotation (Line(points={{-158,140},
          {-148,140},{-148,128},{-142,128}}, color={0,0,127}));
  connect(THeaWatRet2.y, swiTHotWatRet.u3) annotation (Line(points={{-158,110},
          {-158,112},{-142,112}}, color={0,0,127}));
  connect(swiTHotWatRet.y, opeModCon.THeaRet) annotation (Line(points={{-118,
          120},{-100,120},{-100,80},{-12,80}}, color={0,0,127}));
  connect(TChiWatRet1.y, swiTChiWatRet.u1) annotation (Line(points={{-158,80},{
          -148,80},{-148,78},{-142,78}}, color={0,0,127}));
  connect(TChiWatRet2.y, swiTChiWatRet.u3) annotation (Line(points={{-158,40},{
          -154,40},{-154,62},{-142,62}}, color={0,0,127}));
  connect(swiTChiWatRet.y, opeModCon.TChiRet) annotation (Line(points={{-118,70},
          {-112,70},{-112,64},{-12,64}}, color={0,0,127}));
  connect(TChiWatSup1.y, swiTChiWatSup.u1) annotation (Line(points={{-158,-30},
          {-136,-30},{-136,-62},{-132,-62}}, color={0,0,127}));
  connect(TChiWatSup2.y, swiTChiWatSup.u3) annotation (Line(points={{-158,-60},
          {-140,-60},{-140,-78},{-132,-78}}, color={0,0,127}));
  connect(swiTChiWatSup.y, opeModCon.TChiSup) annotation (Line(points={{-108,
          -70},{-68,-70},{-68,72},{-12,72}}, color={0,0,127}));
  connect(intEquOpeMod.y, preOpeMod.u) annotation (Line(points={{82,80},{88,80},
          {88,62},{80,62},{80,50},{88,50}}, color={255,0,255}));
  connect(preOpeMod[3].y, truDelTChiWatRet.u) annotation (Line(points={{112,50},
          {116,50},{116,20},{112,20}}, color={255,0,255}));
  connect(notTChiWatRet.u, timTChiWatRet.passed)
    annotation (Line(points={{36,-10},{36,-8},{48,-8}}, color={255,0,255}));
  connect(latTChiWatRet.u, mulAndTChiWatRet.y)
    annotation (Line(points={{-28,40},{-12,40}}, color={255,0,255}));
  connect(latTChiWatRet.y, pre2.u) annotation (Line(points={{-52,40},{-56,40},{
          -56,-40},{18,-40}}, color={255,0,255}));
  connect(latTChiWatRet.clr, timTChiWatRet.passed) annotation (Line(points={{
          -28,34},{-12,34},{-12,24},{42,24},{42,-8},{48,-8}}, color={255,0,255}));
  connect(pre2.y, timTChiWatRet.u) annotation (Line(points={{42,-40},{80,-40},{
          80,0},{72,0}}, color={255,0,255}));
  connect(latTChiWatRet.y, swiTChiWatRet.u2) annotation (Line(points={{-52,40},
          {-148,40},{-148,70},{-142,70}}, color={255,0,255}));
  connect(onCouInt.y, intGreEquThr.u)
    annotation (Line(points={{52,-70},{58,-70}},   color={255,127,0}));
  connect(falEdg.y, onCouInt.trigger)
    annotation (Line(points={{22,-70},{28,-70}},   color={255,0,255}));
  connect(truDelTChiWatRet.y, mulAndTChiWatRet.u[1]) annotation (Line(points={{
          88,20},{44,20},{44,44.6667},{12,44.6667}}, color={255,0,255}));
  connect(notTChiWatRet.y, mulAndTChiWatRet.u[2]) annotation (Line(points={{12,
          -10},{6,-10},{6,28},{18,28},{18,40},{12,40}}, color={255,0,255}));
  connect(pre2.y, falEdg.u) annotation (Line(points={{42,-40},{48,-40},{48,-52},
          {-10,-52},{-10,-70},{-2,-70}},           color={255,0,255}));
  connect(intGreEquThr.y, not2.u)
    annotation (Line(points={{82,-70},{88,-70}},   color={255,0,255}));
  connect(not2.y, mulAndTChiWatRet.u[3]) annotation (Line(points={{112,-70},{
          120,-70},{120,35.3333},{12,35.3333}}, color={255,0,255}));
  connect(preOpeMod[5].y, truDelTChiWatSup.u) annotation (Line(points={{112,50},
          {130,50},{130,-130},{112,-130}}, color={255,0,255}));
  connect(preTChiWatSup.y, truDelTHotWatRet.u) annotation (Line(points={{52,
          -160},{90,-160},{90,-190},{82,-190}}, color={255,0,255}));
  connect(swiTChiWatSupSet.y, opeModCon.TChiSupSet) annotation (Line(points={{
          -88,-100},{-64,-100},{-64,68},{-12,68}}, color={0,0,127}));
  connect(TChiWatSupSet2.y, swiTChiWatSupSet.u3) annotation (Line(points={{-158,
          -140},{-124,-140},{-124,-108},{-112,-108}}, color={0,0,127}));
  connect(truDelTHotWatRet.y, preTHotWatRet.u) annotation (Line(points={{58,
          -190},{20,-190},{20,-210},{26,-210}}, color={255,0,255}));
  connect(preTHotWatRet.y, timTHotWatRet.u) annotation (Line(points={{50,-210},
          {94,-210},{94,-230},{82,-230}}, color={255,0,255}));
  connect(latTHotWatRet.y, swiTHotWatRet.u2) annotation (Line(points={{-82,-190},
          {-150,-190},{-150,120},{-142,120}}, color={255,0,255}));
  connect(timTHotWatRet.passed, latTHotWatRet.clr) annotation (Line(points={{58,
          -238},{-50,-238},{-50,-196},{-58,-196}}, color={255,0,255}));
  connect(truDelTHotWatRet.y, andTHotWatRet.u1)
    annotation (Line(points={{58,-190},{-18,-190}}, color={255,0,255}));
  connect(andTHotWatRet.y, latTHotWatRet.u)
    annotation (Line(points={{-42,-190},{-58,-190}}, color={255,0,255}));
  connect(notTHotWatRet.y, andTHotWatRet.u2) annotation (Line(points={{-10,-210},
          {-14,-210},{-14,-198},{-18,-198}}, color={255,0,255}));
  connect(timTHotWatRet.passed, notTHotWatRet.u) annotation (Line(points={{58,
          -238},{16,-238},{16,-210},{14,-210}}, color={255,0,255}));
  connect(truDelTChiWatSup.y, latTChiWatSup.u)
    annotation (Line(points={{88,-130},{52,-130}}, color={255,0,255}));
  connect(latTChiWatSup.y, swiTChiWatSup.u2) annotation (Line(points={{28,-130},
          {-136,-130},{-136,-70},{-132,-70}}, color={255,0,255}));
  connect(latTChiWatSup.y, preTChiWatSup.u) annotation (Line(points={{28,-130},
          {-30,-130},{-30,-160},{28,-160}}, color={255,0,255}));
  connect(timTChiWatSupSet.passed, swiTChiWatSupSet.u2) annotation (Line(points=
         {{-122,-218},{-130,-218},{-130,-100},{-112,-100}}, color={255,0,255}));
  connect(timTHotWatRet.passed, timTChiWatSupSet.u) annotation (Line(points={{
          58,-238},{-50,-238},{-50,-210},{-98,-210}}, color={255,0,255}));
  connect(TChiWatSupSet1.y, swiTChiWatSupSet.u1) annotation (Line(points={{-158,
          -100},{-140,-100},{-140,-92},{-112,-92}}, color={0,0,127}));
  connect(con.y, opeModCon.uHotTanCha) annotation (Line(points={{-158,230},{-60,
          230},{-60,96},{-12,96}},   color={255,0,255}));
  connect(con.y, opeModCon.uCooTanCha) annotation (Line(points={{-158,230},{-60,
          230},{-60,92},{-12,92}},   color={255,0,255}));
  connect(con.y, onCouInt.reset) annotation (Line(points={{-158,230},{-60,230},
          {-60,-90},{40,-90},{40,-82}}, color={255,0,255}));
  connect(con.y, latTChiWatSup.clr) annotation (Line(points={{-158,230},{-60,
          230},{-60,-90},{60,-90},{60,-136},{52,-136}}, color={255,0,255}));
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
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
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
        preserveAspectRatio=false, extent={{-220,-260},{220,260}})),
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
