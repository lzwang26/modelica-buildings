within Buildings.Fluid.DXSystems.Heating.AirSource.Examples;
model MultiStage "Test model for multi stage DX heating coil"
  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Air
    "Fluid medium for the model";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=datCoi.sta[datCoi.nSta].nomVal.m_flow_nominal
    "Nominal mass flow rate";

  parameter Modelica.Units.SI.PressureDifference dp_nominal=1000
    "Pressure drop at m_flow_nominal";

  parameter
    Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.DXCoil
    datCoi(
    nSta=4,
    sta={Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=900/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=12000,
          COP_nominal=3,
          m_flow_nominal=0.9,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1200/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=18000,
          COP_nominal=3,
          m_flow_nominal=1.2,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=21000,
          COP_nominal=3,
          m_flow_nominal=1.5,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=2400/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=30000,
          COP_nominal=3,
          m_flow_nominal=1.8,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I())},
    minSpeRat=0.2,
    final defOpe=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostOperation.resistive,
    final defTri=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostTimeMethods.timed,
    final tDefRun=1/6,
    final TDefLim=273.65,
    final QDefResCap=10500,
    final QCraCap=200)
    "DX heating coil data record"
    annotation (Placement(transformation(extent={{60,38},{80,58}})));

  Buildings.Fluid.DXSystems.Heating.AirSource.MultiStage    mulStaDX(
    final datCoi=datCoi,
    redeclare package Medium = Medium,
    final dp_nominal=dp_nominal,
    final T_start=datCoi.sta[1].nomVal.TConIn_nominal,
    final show_T=true,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final dTHys=1e-6) "Multi stage DX coil"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    final p(displayUnit="Pa") = 101325,
    final T=303.15,
    final nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{68,-30},{48,-10}})));

  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    final use_T_in=true,
    final use_p_in=true,
    final nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-20,-58},{0,-38}})));

  Modelica.Blocks.Sources.Ramp TConIn(
    final duration=600,
    final startTime=2400,
    final height=-3,
    final offset=273.15 + 21)
    "Temperature"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));

  Modelica.Blocks.Sources.Ramp p(
    final duration=600,
    final startTime=937.5,
    final height=dp_nominal,
    final offset=101325)
    "Pressure"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));

  Modelica.Blocks.Sources.Constant TEvaIn(
    final k=273.15 + 0)
    "Evaporator inlet temperature"
    annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));

  Modelica.Blocks.Sources.Constant phi(final k=0.1)
    "Outside air relative humidity"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  Modelica.Blocks.Sources.IntegerTable speRat(final table=[0.0,0.0; 900,1; 1800,
        4; 2700,3; 3600,2])
    "Speed ratio "
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(TConIn.y, sou.T_in) annotation (Line(
      points={{-59,-70},{-30,-70},{-30,-44},{-22,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(p.y, sou.p_in) annotation (Line(
      points={{-59,-40},{-22,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mulStaDX.port_a, sou.ports[1]) annotation (Line(
      points={{20,0},{12,0},{12,-48},{0,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TEvaIn.y,mulStaDX. TOut) annotation (Line(points={{-59,-4},{19,-4}},
                         color={0,0,127}));
  connect(mulStaDX.port_b, sin.ports[1]) annotation (Line(
      points={{40,0},{44,0},{44,-20},{48,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mulStaDX.phi, phi.y) annotation (Line(points={{19,-8},{-50,-8},{-50,
          40},{-59,40}},
                     color={0,0,127}));
  connect(speRat.y, mulStaDX.stage) annotation (Line(points={{-59,70},{-22,70},
          {-22,8},{19,8}}, color={255,127,0}));
  annotation (
    experiment(
      StopTime=3600,
      Tolerance=1e-06),
            Documentation(info="<html>
<p>
This is an example model for
<a href=\"modelica://Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed\">
Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed</a>.
The model has time-varying control signals and input conditions.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 08, 2023 by Xing Lu and Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/DXSystems/Heating/AirSource/Examples/MultiStage.mos"
        "Simulate and Plot"));
end MultiStage;
