within Buildings.Fluid.DXSystems.Heating.AirSource.Validation.BaseClasses;
model VariableSpeedHeating
  "Baseclass for validation models for variable speed DX heating coil"

  package Medium = Buildings.Media.Air "Medium model";

  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    final p(displayUnit="Pa") = 101325,
    final nPorts=1,
    final T=294.15)
    "Sink"
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));

  Buildings.Fluid.DXSystems.Heating.AirSource.VariableSpeed varSpeDX(
    redeclare package Medium = Medium,
    final dp_nominal=1141,
    final datCoi=datCoi,
    final T_start=datCoi.sta[1].nomVal.TEvaIn_nominal,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final dTHys=1e-6,
    minSpeRat=datCoi.minSpeRat)
                      "Variable speed DX heating coil"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  Buildings.Utilities.IO.BCVTB.From_degC TEvaIn_K
    "Converts degC to K"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  Buildings.Utilities.IO.BCVTB.From_degC TConIn_K
    "Converts degC to K"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));

  Modelica.Blocks.Math.Mean TOutMea(
    final f=1/3600)
    "Mean of measured outlet air temperature"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  Buildings.Utilities.IO.BCVTB.To_degC TOutDegC
    "Convert measured outlet air temperature to deg C"
    annotation (Placement(transformation(extent={{120,80},{140,100}})));

  Modelica.Blocks.Sources.RealExpression TOut(
    final y=varSpeDX.vol.T) "Measured temperature of outlet air"
    annotation (Placement(transformation(extent={{40,80},{60,100}})));

  Modelica.Blocks.Math.Mean XConOutMea(
    final f=1/3600)
    "Mean of measured outlet air humidity ratio per kg total air"
    annotation (Placement(transformation(extent={{80,120},{100,140}})));

  Modelica.Blocks.Sources.RealExpression XConOut(
    final y=sum(varSpeDX.vol.Xi))
    "Measured humidity ratio of outlet air"
    annotation (Placement(transformation(extent={{40,120},{60,140}})));

  Modelica.Blocks.Math.Mean Q_flowMea(
    final f=1/3600)
    "Mean of cooling rate"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));

  Modelica.Blocks.Math.Mean PMea(
    final f=1/3600)
    "Mean of power"
    annotation (Placement(transformation(extent={{80,10},{100,30}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay PEPlu(
    final samplePeriod=3600)
    "Total power consumption from EnergyPlus"
    annotation (Placement(transformation(extent={{-68,-140},{-48,-120}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay Q_flowEPlu(
    final samplePeriod=3600)
    "Heat transfer to airloop from EnergyPlus"
    annotation (Placement(transformation(extent={{100,-140},{120,-120}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay TOutEPlu(
    final samplePeriod=3600)
    "Outlet temperature from EnergyPlus"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay XConOutEPlu(
    final samplePeriod=3600)
    "Outlet air humidity ratio from EnergyPlus"
    annotation (Placement(transformation(extent={{30,-140},{50,-120}})));

  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAirOut
    "Convert humidity ratio per kg dry air to humidity ratio per kg total air for outdoor air"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));

  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAirEPlu
    "Convert humidity ratio per kg dry air from EnergyPlus to humidity ratio per kg total air"
    annotation (Placement(transformation(extent={{0,-140},{20,-120}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay PDefEPlu(
    final samplePeriod=3600)
    "Defrost power from EnergyPlus"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay PCraEPlu(
    final samplePeriod=3600)
    "Cranckcase heater power from EnergyPlus"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final tableOnFile=true,
    final columns=2:22,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{-150,110},{-130,130}})));

  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    final use_Xi_in=true,
    final use_m_flow_in=true,
    final use_T_in=true,
    final nPorts=1)
    "Mass flow source for coil inlet air"
    annotation (Placement(transformation(extent={{-48,-20},{-28,0}})));

  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAirIn
    "Convert humidity ratio per kg dry air to humidity ratio per kg total air for coil inlet air"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));

 parameter Buildings.Fluid.DXSystems.Heating.AirSource.Validation.Data.VariableSpeedHeating datCoi
    "Variable speed DX heating coil data record"
    annotation (Placement(transformation(extent={{80,46},{100,66}})));

  Buildings.Utilities.Psychrometrics.Phi_pTX phi
    "Conversion to relative humidity"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant pAtm(final k=101325) "Atmospheric pressure"
    annotation (Placement(transformation(extent={{-150,60},{-130,80}})));
  Modelica.Blocks.Sources.CombiTimeTable PLR(
    timeScale(displayUnit="h") = 3600,
    startTime(displayUnit="s"),
    shiftTime(displayUnit="h") = 4665600)
    annotation (Placement(transformation(extent={{-150,0},{-130,20}})));
  Modelica.Blocks.Sources.RealExpression speRat(final y=if datRea.y[1] < 0.5
         then datRea.y[18] else datRea.y[2]/15000/datRea.y[19]/datRea.y[20])
    "Calculated speed ratio from EnergyPlus"
    annotation (Placement(transformation(extent={{-152,134},{-132,154}})));
equation
  connect(varSpeDX.port_b, sin.ports[1])
    annotation (Line(
      points={{10,10},{16,10},{16,-10},{20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TEvaIn_K.Kelvin,varSpeDX. TOut) annotation (Line(
      points={{-79,49.8},{-70,49.8},{-70,6},{-11,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TOut.y, TOutMea.u)
                           annotation (Line(
      points={{61,90},{78,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TOutMea.y, TOutDegC.Kelvin)
                                    annotation (Line(
      points={{101,90},{118,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(XConOut.y,XConOutMea. u)
                           annotation (Line(
      points={{61,130},{78,130}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varSpeDX.QSen_flow, Q_flowMea.u) annotation (Line(points={{11,17},{50,
          17},{50,-10},{78,-10}},                 color={0,0,127}));
  connect(toTotAirEPlu.XiTotalAir, XConOutEPlu.u)
    annotation (Line(points={{21,-130},{28,-130}}, color={0,0,127}));
  connect(varSpeDX.P, PMea.u) annotation (Line(points={{11,19},{50,19},{50,20},
          {78,20}}, color={0,0,127}));
  connect(datRea.y[1], TEvaIn_K.Celsius) annotation (Line(points={{-129,120},{
          -108,120},{-108,49.6},{-102,49.6}},
                                         color={0,0,127}));
  connect(datRea.y[9], toTotAirOut.XiDry) annotation (Line(points={{-129,120},{
          -108,120},{-108,80},{-101,80}},
                                     color={0,0,127}));
  connect(datRea.y[17], boundary.m_flow_in) annotation (Line(points={{-129,120},
          {-108,120},{-108,16},{-74,16},{-74,-2},{-50,-2}},
                                                   color={0,0,127}));
  connect(TConIn_K.Kelvin, boundary.T_in) annotation (Line(points={{-79,-10.2},{
          -60,-10.2},{-60,-6},{-50,-6}}, color={0,0,127}));
  connect(toTotAirIn.XiTotalAir, boundary.Xi_in[1]) annotation (Line(points={{-79,
          -50},{-60,-50},{-60,-14},{-50,-14}}, color={0,0,127}));
  connect(datRea.y[5], TConIn_K.Celsius) annotation (Line(points={{-129,120},{
          -108,120},{-108,-10.4},{-102,-10.4}},
                                           color={0,0,127}));
  connect(datRea.y[6], toTotAirIn.XiDry) annotation (Line(points={{-129,120},{
          -108,120},{-108,-50},{-101,-50}},
                                       color={0,0,127}));
  connect(boundary.ports[1],varSpeDX. port_a) annotation (Line(points={{-28,-10},
          {-18,-10},{-18,10},{-10,10}}, color={0,127,255}));
  connect(datRea.y[7], TOutEPlu.u) annotation (Line(points={{-129,120},{-108,
          120},{-108,-30},{-10,-30},{-10,-60},{-2,-60}},
                                                    color={0,0,127}));
  connect(datRea.y[8], toTotAirEPlu.XiDry) annotation (Line(points={{-129,120},
          {-108,120},{-108,-30},{-10,-30},{-10,-130},{-1,-130}},color={0,0,127}));
  connect(datRea.y[3], PEPlu.u) annotation (Line(points={{-129,120},{-108,120},
          {-108,-30},{-10,-30},{-10,-108},{-74,-108},{-74,-130},{-70,-130}},
        color={0,0,127}));
  connect(datRea.y[2], Q_flowEPlu.u) annotation (Line(points={{-129,120},{-108,
          120},{-108,-30},{-10,-30},{-10,-108},{90,-108},{90,-130},{98,-130}},
                                                                          color=
         {0,0,127}));
  connect(datRea.y[15], PDefEPlu.u) annotation (Line(points={{-129,120},{-108,
          120},{-108,-30},{-10,-30},{-10,-40},{98,-40}},
                                                    color={0,0,127}));
  connect(datRea.y[16], PCraEPlu.u) annotation (Line(points={{-129,120},{-108,
          120},{-108,-80},{98,-80}},
                                color={0,0,127}));
  connect(phi.X_w, toTotAirOut.XiTotalAir)
    annotation (Line(points={{-61,80},{-79,80}}, color={0,0,127}));
  connect(TEvaIn_K.Kelvin, phi.T) annotation (Line(points={{-79,49.8},{-70,49.8},
          {-70,88},{-61,88}}, color={0,0,127}));
  connect(pAtm.y, phi.p) annotation (Line(points={{-129,70},{-120,70},{-120,66},
          {-66,66},{-66,72},{-61,72}}, color={0,0,127}));
  connect(varSpeDX.phi, phi.phi) annotation (Line(points={{-11,2},{-32,2},{-32,
          80},{-39,80}}, color={0,0,127}));
  connect(speRat.y, varSpeDX.speRat) annotation (Line(points={{-131,144},{-20,
          144},{-20,18},{-11,18}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-180,-160},
            {180,160}})),
  Documentation(info="<html>
<p>This is a baseclass component for the following validation models: </p>
<ul>
<li><a href=\"modelica://Buildings.Fluid.DXSystems.Heating.AirSource.Validation.VariableSpeed_OnDemandReverseCycleDefrost\">Buildings.Fluid.DXSystems.Heating.AirSource.Validation.VariableSpeed_OnDemandReverseCycleDefrost</a></li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
May 31, 2023, by Michael Wetter:<br/>
Changed implementation to use <code>phi</code> rather than water vapor concentration
as input because the latter is not available on the weather data bus.
</li>
<li>
Aug 1, 2023, by Karthik Devaprasad and Xing Lu:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(
      StartTime=4665600,
      StopTime=5875200,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end VariableSpeedHeating;
