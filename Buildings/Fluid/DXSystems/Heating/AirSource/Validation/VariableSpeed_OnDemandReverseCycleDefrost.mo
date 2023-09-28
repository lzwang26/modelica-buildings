within Buildings.Fluid.DXSystems.Heating.AirSource.Validation;
model VariableSpeed_OnDemandReverseCycleDefrost
  "Validation model for multi speed heating DX coil with defrost operation"
  extends Modelica.Icons.Example;
  extends
    Buildings.Fluid.DXSystems.Heating.AirSource.Validation.BaseClasses.VariableSpeedHeating(
    datRea(final fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Buildings/Resources/Data/Fluid/DXSystems/Heating/AirSource/Validation/VariableSpeedHeating_OnDemandReverseCycleDefrost/DXCoilSystemAuto.dat")),
    datCoi(
      final defOpe=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostOperation.reverseCycle,
      final defTri=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostTimeMethods.onDemand),
    PLR(table=[1,0; 2,0; 3,0; 4,0; 5,0; 6,0; 7,0; 8,0; 8,0.670327586; 9,
          0.670327586; 9,0.789354728; 10,0.789354728; 10,0.76556681; 11,
          0.76556681; 11,0.747324042; 12,0.747324042; 12,0.71683691; 13,
          0.71683691; 13,0.699724389; 14,0.699724389; 14,0.688503863; 15,
          0.688503863; 15,0.672073356; 16,0.672073356; 16,0.68244737; 17,
          0.68244737; 17,0.70942306; 18,0.70942306; 18,0; 19,0; 20,0; 21,0; 22,
          0; 23,0; 24,0; 25,0; 26,0; 27,0; 28,0; 29,0; 30,0; 31,0; 32,0; 32,1;
          33,1; 34,1; 35,1; 36,1; 37,1; 37,0.917699679; 38,0.917699679; 38,
          0.8214888; 39,0.8214888; 39,0.759932352; 40,0.759932352; 40,
          0.71879453; 41,0.71879453; 41,0.684491547; 42,0.684491547; 42,
          0.662859706; 43,0.662859706; 43,0; 44,0; 45,0; 46,0; 47,0; 48,0]));

annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-180,-160},
            {180,160}})),
             __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Fluid/DXSystems/Heating/AirSource/Validation/VariableSpeed_OnDemandReverseCycleDefrost.mos"
        "Simulate and Plot"),
    experiment(
      StartTime=3801600,
      StopTime=6393600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
            Documentation(info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed\">
Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed</a> with the
defrost time fraction calculation <code>datDef.defTri</code> set to
<code>DefrostTimeMethods.onDemand</code> and the defrost operation type
<code>datDef.defOpe</code> set to <code>DefrostOperation.reverseCycle</code>.
</p>
<p>
The difference in results of
<i>T<sub>Out</sub></i> and
<i>X<sub>Out</sub></i>
at the beginning and end of the simulation is because the mass flow rate is zero.
For zero mass flow rate, EnergyPlus assumes steady state condition,
whereas the Modelica model is a dynamic model and hence the properties at the outlet
are equal to the state variables of the model.
</p>
<p>
The EnergyPlus results were generated using the example file <code>DXCoilSystemAuto.idf</code>
from EnergyPlus 22.2. The results were then used to set-up the boundary conditions
for the model as well as the input signals. To compare the results,
the Modelica outputs are averaged over <i>3600</i> seconds, and the EnergyPlus
outputs are used with a zero order delay to avoid the time shift in results.
</p>
<p>
Note that EnergyPlus mass fractions (<code>X</code>) are in mass of water vapor
per mass of dry air, whereas Modelica uses the total mass as a reference. Also,
the temperatures in Modelica are in Kelvin whereas they are in Celsius in EnergyPlus.
Hence, the EnergyPlus values are corrected by using the appropriate conversion blocks.
</p>
<p>
The plots compare the outlet temperature and humidity ratio between Modelica and
EnergyPlus. They also compare the power consumption by the coil compressor as well
as the heat transfer from the airloop.
</p>
</html>",
revisions="<html>
<ul>
<li>
Aug 1, 2023, by Karthik Devaprasad and Xing Lu:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end VariableSpeed_OnDemandReverseCycleDefrost;
