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
      T_CHWRetMin(displayUnit="degC") = 287.15)
    annotation (Placement(transformation(extent={{-40,-20},{-20,20}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[3](
    each k=false)
    annotation (Placement(transformation(extent={{-160,70},{-140,90}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratV_flow(table=[0,0,0;
        1.5,0,0; 6,1,0; 12,0.2,0.2; 15,0,1; 22,0.1,0.1; 24,0,0],
    timeScale=3600)
    "Source signal for volume flow rate ratio – Index 1 for HHW, 2 for CHW"
    annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin THeaWatRet(
    amplitude=6,
    freqHz=4/80000,
    offset=47 + 273.15,
    startTime=50000 + 5000)
    "HWRT"
    annotation (Placement(transformation(extent={{-170,-30},{-150,-10}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TChiWatRet(
    amplitude=2,
    freqHz=3/80000,
    phase=3.1415926535898,
    offset=15 + 273.15,
    startTime=6000)
    "CHWRT"
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin THeaWatSup(
    amplitude=4,
    freqHz=4/80000,
    offset=50 + 273.15)
    "HWST"
    annotation (Placement(transformation(extent={{-170,10},{-150,30}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TChiWatSup(
    amplitude=4,
    freqHz=3/80000,
    phase=3.1415926535898,
    offset=13 + 273.15,
    startTime=50000)
    "CHWST"
    annotation (Placement(transformation(extent={{-160,-120},{-140,-100}})));

  CDL.Logical.Sources.Pulse booPul(period=86400*2,
                                                 shift=30)
    annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
  CDL.Integers.Sources.Constant conInt[8](k={Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Disabled,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4})
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  CDL.Integers.Equal intEqu[8]
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  CDL.Routing.IntegerScalarReplicator intScaRep(nout=8)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  CDL.Logical.TrueDelay truDel[8](delayTime=fill(30, 8))
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  CDL.Logical.MultiOr mulOr(nin=8)
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{144,-56},{164,-36}})));
  CDL.Reals.Sources.Constant TChiWatSupSet(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-160,-160},{-140,-140}})));
equation
  connect(con[1].y, opeModCon.uSchHea) annotation (Line(points={{-138,80},{-50,
          80},{-50,14.5455},{-42,14.5455}},
                                       color={255,0,255}));
  connect(con[2].y, opeModCon.uSchCoo1) annotation (Line(points={{-138,80},{-50,
          80},{-50,10.9091},{-42,10.9091}},
                            color={255,0,255}));
  connect(THeaWatSup.y, opeModCon.THeaSupSet) annotation (Line(points={{-148,20},
          {-70,20},{-70,3.63636},{-42,3.63636}},
                                    color={0,0,127}));
  connect(THeaWatRet.y, opeModCon.THeaRet) annotation (Line(points={{-148,-20},
          {-112,-20},{-112,0},{-42,0}},
                                  color={0,0,127}));
  connect(TChiWatRet.y,opeModCon.TChiRet)  annotation (Line(points={{-118,-40},
          {-104,-40},{-104,-14.5455},{-42,-14.5455}},
                                  color={0,0,127}));
  connect(VHeaWat_flow.y, opeModCon.VWatHot_flow) annotation (Line(points={{-78,-50},
          {-52,-50},{-52,-3.63636},{-42,-3.63636}},
                                     color={0,0,127}));
  connect(VChiWat_flow.y, opeModCon.VWatChi_flow) annotation (Line(points={{-78,-80},
          {-46,-80},{-46,-18.1818},{-42,-18.1818}},
                                                color={0,0,127}));
  connect(ratV_flow.y[1], VHeaWat_flow.u) annotation (Line(points={{-138,-70},{
          -110,-70},{-110,-50},{-102,-50}},
                                     color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u) annotation (Line(points={{-138,-70},{
          -110,-70},{-110,-80},{-102,-80}},
                                     color={0,0,127}));
  connect(booPul.y, opeModCon.uPlaEna) annotation (Line(points={{-138,50},{-60,
          50},{-60,7.27273},{-42,7.27273}},
                         color={255,0,255}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{12,70},{20,70},{20,-8},
          {28,-8}}, color={255,127,0}));
  connect(opeModCon.yOpeMod, intScaRep.u)
    annotation (Line(points={{-18,0},{-12,0}}, color={255,127,0}));
  connect(intScaRep.y, intEqu.u1)
    annotation (Line(points={{12,0},{28,0}}, color={255,127,0}));
  connect(intEqu.y, truDel.u)
    annotation (Line(points={{52,0},{68,0}}, color={255,0,255}));
  connect(truDel.y, mulOr.u[1:8]) annotation (Line(points={{92,0},{100,0},{100,
          3.0625},{108,3.0625}}, color={255,0,255}));
  connect(mulOr.y, edg.u)
    annotation (Line(points={{132,0},{138,0}}, color={255,0,255}));
  connect(edg.y, pre.u) annotation (Line(points={{162,0},{168,0},{168,-30},{134,
          -30},{134,-46},{142,-46}}, color={255,0,255}));
  connect(pre.y, opeModCon.uProCom) annotation (Line(points={{166,-46},{170,-46},
          {170,40},{-46,40},{-46,18.1818},{-42,18.1818}}, color={255,0,255}));
  connect(TChiWatSup.y, opeModCon.TChiSup) annotation (Line(points={{-138,-110},
          {-48,-110},{-48,-7.27273},{-42,-7.27273}}, color={0,0,127}));
  connect(TChiWatSupSet.y, opeModCon.TChiSupSet) annotation (Line(points={{-138,
          -150},{-44,-150},{-44,-10.9091},{-42,-10.9091}}, color={0,0,127}));
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
    Icon(coordinateSystem(extent={{-180,-180},{180,180}}),
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
        preserveAspectRatio=false, extent={{-180,-180},{180,180}})),
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
