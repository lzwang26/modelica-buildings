within Buildings.Controls.OBC.HeatPumpPlant;
package Types "Package with type definitions for control sequences"


  package OperationMode
      "Heat pump plant operation modes"
      constant Integer Heating_3=-3 "Dedicated charging of heating hot water (HHW) TES with HRU and 
      external energy loop";
      constant Integer Heating_2=-2 "Heating with HRU, CHW TES opportunistic charging and evaporator-side 
      heating from Air-source heat pump (ASHP) in external energy loop";
      constant Integer Heating_1=-1 "Heating only with heat recovery unit (HRU) and chilled water (CHW) 
      thermal energy storage (TES) opportunistic charging";
      constant Integer Disabled=0 "All systems disabled";
      constant Integer Cooling_1=1 "Cooling with cooling tower in external energy loop (water-side 
      economizer)";
      constant Integer Cooling_2=2 "Cooling only with HRU and hot TES charging";
      constant Integer Cooling_3=3 "Cooling with HRU, hot TES charging, and venting from cooling tower 
      in external energy loop";
      constant Integer Cooling_4=4 "Dedicated charging of CHW TES with primary loop";
      constant Integer Cooling_5=5 "Dedicated charging of ice TES with HRU and primary loop";
  annotation (
  Documentation(info="<html>
<p>
Collection of integer values to define the operation modes of a water-to-water 
heat pump plant. For example, if the plant operates in heating only with 
heat recovery unit (HRU) and chilled water (CHW) thermal energy storage (TES) 
opportunistic charging, i.e., Heating_1=-1, use
<code>Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1</code>.
</p>
</html>",   revisions="<html>
<ul>
<li>
May 31, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
  end OperationMode;

  type OperationMode_backup = enumeration(
      Heating_3 "Dedicated charging of heating hot water (HHW) TES with HRU and 
      external energy loop",
      Heating_2 "Heating with HRU, CHW TES opportunistic charging and evaporator-side 
      heating from Air-source heat pump (ASHP) in external energy loop",
      Heating_1 "Heating only with heat recovery unit (HRU) and chilled water (CHW) 
      thermal energy storage (TES) opportunistic charging",
      Not_Specified "Not specified",
      Cooling_1 "Cooling with cooling tower in external energy loop (water-side 
      economizer)",
      Cooling_2 "Cooling only with HRU and hot TES charging",
      Cooling_3 "Cooling with HRU, hot TES charging, and venting from cooling tower 
      in external energy loop",
      Cooling_4 "Dedicated charging of CHW TES with primary loop",
      Cooling_5 "Dedicated charging of ice TES with HRU and primary loop")
    "Enumeration of heat pump plant operation modes"
  annotation (
   Evaluate=true, Documentation(info="<html>
<p>
Enumeration of heat pump plant operation modes. Possible values are:
</p>
<table border=\"1\" summary=\"Explanation of the enumeration\">
<tr>
<th>Enumeration</th>
<th>Description</th></tr>
<tr><td><code>Not_Specified</code></td>
<td>
Not specified.
</td></tr>
<tr><td><code>Heating_1</code></td>
<td>
Heating only with heat recovery unit (HRU) and chilled water (CHW) thermal energy storage (TES) opportunistic charging.
</td></tr>
<tr><td><code>Heating_2</code></td>
<td>
Heating with HRU, CHW TES opportunistic charging and evaporator-side heating from Air-source heat pump (ASHP) in external energy loop.
</td></tr>
<tr><td><code>Heating_3</code></td>
<td>
Dedicated charging of heating hot water (HHW) TES with HRU and external energy loop.
</td></tr>
<tr><td><code>Cooling_1</code></td>
<td>
Cooling with cooling tower in external energy loop (water-side economizer).
</td></tr>
<tr><td><code>Cooling_2</code></td>
<td>
Cooling only with HRU and hot TES charging.
</td></tr>
<tr><td><code>Cooling_3</code></td>
<td>
Cooling with HRU, hot TES charging, and venting from cooling tower in external energy loop.
</td></tr>
<tr><td><code>Cooling_4</code></td>
<td>
Dedicated charging of CHW TES with primary loop.
</td></tr>
<tr><td><code>Cooling_5</code></td>
<td>
Dedicated charging of ice TES with HRU and primary loop.
</td></tr>
</table>
</html>",   revisions="<html>
<ul>
<li>
May 31, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
  annotation (Documentation(info="<html>
<p>
This package provides type definitions used in heat pump plant control sequences.
</p>
</html>", revisions="<html>
<ul>
<li>
May 31, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"), Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),                  Polygon(
          origin={-12.167,-23},
          fillColor={128,128,128},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{12.167,65},{14.167,93},{36.167,89},{24.167,20},{4.167,-30},
              {14.167,-30},{24.167,-30},{24.167,-40},{-5.833,-50},{-15.833,
              -30},{4.167,20},{12.167,65}},
          smooth=Smooth.Bezier,
          lineColor={0,0,0}), Polygon(
          origin={2.7403,1.6673},
          fillColor={128,128,128},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{49.2597,22.3327},{31.2597,24.3327},{7.2597,18.3327},{-26.7403,
            10.3327},{-46.7403,14.3327},{-48.7403,6.3327},{-32.7403,0.3327},{-6.7403,
            4.3327},{33.2597,14.3327},{49.2597,14.3327},{49.2597,22.3327}},
          smooth=Smooth.Bezier)}));
end Types;
