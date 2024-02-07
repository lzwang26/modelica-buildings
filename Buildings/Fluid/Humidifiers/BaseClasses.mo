within Buildings.Fluid.Humidifiers;
package BaseClasses "Package with base classes for Buildings.Fluid.Humidifiers"
    extends Modelica.Icons.BasesPackage;
annotation (
  Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://Buildings.Fluid.Humidifiers\">
Buildings.Fluid.Humidifiers</a>.
</p>
</html>",
  revisions="<html>
<ul>
<li>
May 31, 2023, by Michael Wetter:<br/>
Changed implementation to use <code>phi</code> rather than water vapor concentration
as input because the latter is not available on the weather data bus.
</li>
<li>
March 19, 2023 by Xing Lu and Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>

</html>"));

end BaseClasses;
