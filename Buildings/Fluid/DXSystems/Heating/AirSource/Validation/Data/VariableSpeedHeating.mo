within Buildings.Fluid.DXSystems.Heating.AirSource.Validation.Data;
record VariableSpeedHeating
  "Data record for variable speed DX heating coil in validation models"
  extends Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.DXCoil(
    nSta=4,
    sta={Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=500/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=5625,
          COP_nominal=2.75,
          m_flow_nominal=0.2933328675,
          TEvaIn_nominal=273.15 + 6,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1000/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=7500,
          COP_nominal=2.75,
          m_flow_nominal=0.39111049,
          TEvaIn_nominal=273.15 + 6,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1500/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=11250,
          COP_nominal=2.75,
          m_flow_nominal=0.586665735,
          TEvaIn_nominal=273.15 + 6,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I()),
      Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=2000/60,
        nomVal=
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=15000,
          COP_nominal=2.75,
          m_flow_nominal=0.782220983308365,
          TEvaIn_nominal=273.15 + 6,
          TConIn_nominal=273.15 + 21),
        perCur=
        Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I())},
    minSpeRat=0.2,
    defEIRFunT={0.297145,0.0430933,-0.000748766,0.00597727,0.000482112,-0.000956448},
    final tDefRun=1/6,
    final TDefLim=273.65,
    final QDefResCap=10500,
    final QCraCap=200,
    final PLFraFunPLR={1});

  annotation (defaultComponentName="datCoi",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This record declares performance curves for the heating capacity and the EIR for use in
heating coil validation models in
<a href=\"modelica://Buildings.Fluid.DXSystems.Heating.AirSource.Validation\">
Buildings.Fluid.DXSystems.Heating.AirSource.Validation</a>.
It has been obtained from the EnergyPlus 9.6 example file
<code>PackagedTerminalHeatPump.idf</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
Aug 1, 2023 by Xing Lu and Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end VariableSpeedHeating;
