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

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl opeModCon
    annotation (Placement(transformation(extent={{42,-12},{62,12}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[3](
    each k=false)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(
    k=true)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratV_flow(
    table=[0,0,0; 5,0,0; 6,1,0; 12,0.2,0.2; 15,0,1; 22,0.1,0.1; 24,0,0],
    timeScale=3600)
    "Source signal for volume flow rate ratio – Index 1 for HHW, 2 for CHW"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin THeaWatRet(
    amplitude=6,
    freqHz=4/80000,
    offset=47 + 273.15)
    "HWRT"
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TChiWatRet(
    amplitude=2,
    freqHz=3/80000,
    phase=3.1415926535898,
    offset=11 + 273.15)
    "CHWRT"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin THeaWatSup(
    amplitude=4,
    freqHz=4/80000,
    offset=50 + 273.15)
    "HWST"
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TChiWatSup(
    amplitude=4,
    freqHz=3/80000,
    phase=3.1415926535898,
    offset=10 + 273.15)
    "CHWST"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

equation
  connect(con[1].y, opeModCon.uSchHea) annotation (Line(points={{-58,80},{30,80},
          {30,12},{40,12},{40,11}},    color={255,0,255}));
  connect(con[2].y, opeModCon.uSchCoo1) annotation (Line(points={{-58,80},{30,80},
          {30,8},{40,8}},   color={255,0,255}));
  connect(con[3].y, opeModCon.uSchCoo2) annotation (Line(points={{-58,80},{30,80},
          {30,5},{40,5}},   color={255,0,255}));
  connect(con1.y, opeModCon.uPla_ava) annotation (Line(points={{-58,50},{20,50},
          {20,2},{40,2}},   color={255,0,255}));
  connect(THeaWatSup.y, opeModCon.THeaSup) annotation (Line(points={{-68,20},{10,
          20},{10,-1},{40,-1}}, color={0,0,127}));
  connect(TChiWatSup.y,opeModCon.TChiSup)  annotation (Line(points={{-38,0},{0,0},
          {0,-3},{40,-3}},      color={0,0,127}));
  connect(THeaWatRet.y, opeModCon.THeaRet) annotation (Line(points={{-68,-20},{-32,
          -20},{-32,-5},{40,-5}}, color={0,0,127}));
  connect(TChiWatRet.y,opeModCon.TChiRet)  annotation (Line(points={{-38,-40},{-24,
          -40},{-24,-7},{40,-7}}, color={0,0,127}));
  connect(VHeaWat_flow.y, opeModCon.V_heaflow) annotation (Line(points={{2,-50},
          {28,-50},{28,-9},{40,-9}}, color={0,0,127}));
  connect(VChiWat_flow.y, opeModCon.V_chiflow) annotation (Line(points={{2,-80},
          {34,-80},{34,-12},{40,-12},{40,-11}}, color={0,0,127}));
  connect(ratV_flow.y[1], VHeaWat_flow.u) annotation (Line(points={{-58,-70},{-30,
          -70},{-30,-50},{-22,-50}}, color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u) annotation (Line(points={{-58,-70},{-30,
          -70},{-30,-80},{-22,-80}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/HeatPumpPlant/Validation/OperationModeControl.mos"
        "Simulate and plot"),
    experiment(
      StopTime=86400.0,
      Tolerance=1e-06),
    Icon(
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
        preserveAspectRatio=false)),
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
