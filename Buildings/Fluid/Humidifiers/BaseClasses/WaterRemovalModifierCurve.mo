within Buildings.Fluid.Humidifiers.BaseClasses;
block WaterRemovalModifierCurve

  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
          extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,20},
            {-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput watRemMod
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput phi
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Fluid.Humidifiers.Data.Generic per
    annotation (Placement(transformation(extent={{22,64},{42,84}})));
equation
  watRemMod =Buildings.Utilities.Math.Functions.smoothMax(
      x1=Buildings.Utilities.Math.Functions.biquadratic(
        a=per.watRem,
        x1=Modelica.Units.Conversions.to_degC(T),
        x2=phi*100),
      x2=0.001,
      deltaX=0.0001);
          //x1=Modelica.Units.Conversions.to_degC(senTIn.T),
          //x2=senRelHum.phi*100

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WaterRemovalModifierCurve;
