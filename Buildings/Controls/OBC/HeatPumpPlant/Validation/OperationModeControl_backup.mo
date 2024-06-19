within Buildings.Controls.OBC.HeatPumpPlant.Validation;
model OperationModeControl_backup
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

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl opeModCon
    annotation (Placement(transformation(extent={{-10,-20},{10,20}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[3](
    each k=false)
    annotation (Placement(transformation(extent={{-130,70},{-110,90}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratV_flow(
    table=[0,0,0; 5,0,0; 6,1,0; 12,0.2,0.2; 15,0,1; 22,0.1,0.1; 24,0,0],
    timeScale=3600)
    "Source signal for volume flow rate ratio – Index 1 for HHW, 2 for CHW"
    annotation (Placement(transformation(extent={{-130,-80},{-110,-60}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin THeaWatRet(
    amplitude=6,
    freqHz=4/80000,
    offset=47 + 273.15)
    "HWRT"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TChiWatRet(
    amplitude=2,
    freqHz=3/80000,
    phase=3.1415926535898,
    offset=11 + 273.15)
    "CHWRT"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin THeaWatSup(
    amplitude=4,
    freqHz=4/80000,
    offset=50 + 273.15)
    "HWST"
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TChiWatSup(
    amplitude=4,
    freqHz=3/80000,
    phase=3.1415926535898,
    offset=10 + 273.15)
    "CHWST"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  CDL.Logical.Sources.Pulse booPul(period=86400, shift=30)
    annotation (Placement(transformation(extent={{-130,40},{-110,60}})));
  CDL.Integers.Change cha
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  CDL.Logical.Timer tim(t=15)
    annotation (Placement(transformation(extent={{82,-30},{102,-10}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  CDL.Logical.Pre pre1
    annotation (Placement(transformation(extent={{122,-8},{142,12}})));
equation
  connect(con[1].y, opeModCon.uSchHea) annotation (Line(points={{-108,80},{-20,80},
          {-20,14},{-12,14}},          color={255,0,255}));
  connect(con[2].y, opeModCon.uSchCoo1) annotation (Line(points={{-108,80},{-20,
          80},{-20,10},{-12,10}},
                            color={255,0,255}));
  connect(THeaWatSup.y, opeModCon.THeaSupSet) annotation (Line(points={{-118,20},
          {-40,20},{-40,2},{-12,2}},color={0,0,127}));
  connect(TChiWatSup.y, opeModCon.TChiSupSet)
    annotation (Line(points={{-88,0},{-50,0},{-50,-10},{-12,-10}},
                                                            color={0,0,127}));
  connect(THeaWatRet.y, opeModCon.THeaRet) annotation (Line(points={{-118,-20},{
          -82,-20},{-82,-2},{-12,-2}},
                                  color={0,0,127}));
  connect(TChiWatRet.y,opeModCon.TChiRet)  annotation (Line(points={{-88,-40},{-74,
          -40},{-74,-14},{-12,-14}},
                                  color={0,0,127}));
  connect(VHeaWat_flow.y, opeModCon.VWatHot_flow) annotation (Line(points={{-48,-50},
          {-22,-50},{-22,-6},{-12,-6}},
                                     color={0,0,127}));
  connect(VChiWat_flow.y, opeModCon.VWatChi_flow) annotation (Line(points={{-48,-80},
          {-16,-80},{-16,-18},{-12,-18}},       color={0,0,127}));
  connect(ratV_flow.y[1], VHeaWat_flow.u) annotation (Line(points={{-108,-70},{-80,
          -70},{-80,-50},{-72,-50}}, color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u) annotation (Line(points={{-108,-70},{-80,
          -70},{-80,-80},{-72,-80}}, color={0,0,127}));
  connect(booPul.y, opeModCon.uPlaEna) annotation (Line(points={{-108,50},{-30,50},
          {-30,6},{-12,6}},
                         color={255,0,255}));
  connect(opeModCon.yOpeMod, cha.u)
    annotation (Line(points={{12,0},{18,0}}, color={255,127,0}));
  connect(cha.y, lat.u)
    annotation (Line(points={{42,0},{48,0}}, color={255,0,255}));
  connect(lat.y, tim.u) annotation (Line(points={{72,0},{78,0},{78,-14},{74,-14},
          {74,-20},{80,-20}}, color={255,0,255}));
  connect(tim.passed, pre.u) annotation (Line(points={{104,-28},{104,-46},{12,-46},
          {12,-30},{18,-30}}, color={255,0,255}));
  connect(pre.y, lat.clr)
    annotation (Line(points={{42,-30},{48,-30},{48,-6}}, color={255,0,255}));
  connect(tim.passed, pre1.u) annotation (Line(points={{104,-28},{114,-28},{114,
          2},{120,2}}, color={255,0,255}));
  connect(pre1.y, opeModCon.uProCom) annotation (Line(points={{144,2},{150,2},{
          150,28},{-16,28},{-16,18},{-12,18}},
                                  color={255,0,255}));
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
        preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
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
end OperationModeControl_backup;
