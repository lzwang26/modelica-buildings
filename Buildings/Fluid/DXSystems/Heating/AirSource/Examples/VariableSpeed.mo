within Buildings.Fluid.DXSystems.Heating.AirSource.Examples;
model VariableSpeed "Test model for variable speed DX heating coil"
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
          Q_flow_nominal=6143.05,
          COP_nominal=3.90494,
          m_flow_nominal=0.75,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1200/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=8190.73,
          COP_nominal=3.90494,
          m_flow_nominal=1,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=12286.10786,
          COP_nominal=3.90494,
          m_flow_nominal=1.5,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=2400/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=16381.47714,
          COP_nominal=3.90494,
          m_flow_nominal=2,
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
    "Variable speed DX heating coil data record"
    annotation (Placement(transformation(extent={{60,38},{80,58}})));

  Buildings.Fluid.DXSystems.Heating.AirSource.VariableSpeed varSpeDX(
    final datCoi=datCoi,
    redeclare package Medium = Medium,
    final dp_nominal=dp_nominal,
    final minSpeRat=datCoi.minSpeRat,
    final T_start=datCoi.sta[1].nomVal.TConIn_nominal,
    final show_T=true,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final dTHys=1e-6)
    "Variable speed DX coil"
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

  Modelica.Blocks.Sources.TimeTable speRat(final table=[0.0,0.2; 100,0.2; 937.5,
        0.2; 1800,0.8; 2700,0.75; 3600,0.75])
    "Speed ratio "
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

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

equation
  connect(TConIn.y, sou.T_in) annotation (Line(
      points={{-59,-70},{-30,-70},{-30,-44},{-22,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(p.y, sou.p_in) annotation (Line(
      points={{-59,-40},{-22,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(speRat.y, varSpeDX.speRat)   annotation (Line(
      points={{-59,70},{-22,70},{-22,8},{19,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varSpeDX.port_a, sou.ports[1]) annotation (Line(
      points={{20,0},{12,0},{12,-48},{0,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TEvaIn.y, varSpeDX.TOut) annotation (Line(points={{-59,-4},{19,-4}},
                         color={0,0,127}));
  connect(varSpeDX.port_b, sin.ports[1]) annotation (Line(
      points={{40,0},{44,0},{44,-20},{48,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(varSpeDX.phi, phi.y) annotation (Line(points={{19,-8},{-50,-8},{-50,
          40},{-59,40}},
                     color={0,0,127}));
  annotation (
    experiment(
      StopTime=3600,
      Tolerance=1e-06),
            Documentation(info="<html>
<p>
This is an example model for
<a href=\"modelica://Buildings.Fluid.DXSystems.Heating.AirSource.VariableSpeed\">
Buildings.Fluid.DXSystems.Heating.AirSource.VariableSpeed</a>.
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
          "Resources/Scripts/Dymola/Fluid/DXSystems/Heating/AirSource/Examples/VariableSpeed.mos"
        "Simulate and Plot"));
end VariableSpeed;
