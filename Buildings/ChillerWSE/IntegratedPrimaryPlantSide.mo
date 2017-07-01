within Buildings.ChillerWSE;
model IntegratedPrimaryPlantSide
  "Integrated waterside economizer on the plant side in a primary-only chilled water System"
  extends Buildings.ChillerWSE.BaseClasses.PartialIntegratedPrimary(
    final nVal=6,
    final m_flow_nominal={mChiller1_flow_nominal,mChiller2_flow_nominal,mWSE1_flow_nominal,
      mWSE2_flow_nominal,nChi*mChiller2_flow_nominal,mWSE2_flow_nominal},
    rhoStd = {Medium1.density_pTX(101325, 273.15+4, Medium1.X_default),
            Medium2.density_pTX(101325, 273.15+4, Medium2.X_default),
            Medium1.density_pTX(101325, 273.15+4, Medium1.X_default),
            Medium2.density_pTX(101325, 273.15+4, Medium2.X_default),
            Medium2.density_pTX(101325, 273.15+4, Medium2.X_default),
            Medium2.density_pTX(101325, 273.15+4, Medium2.X_default)});
  extends Buildings.ChillerWSE.BaseClasses.PartialOperationSequenceInterface;

  Modelica.Blocks.Sources.BooleanExpression wseMod(y=if Modelica.Math.BooleanVectors.anyTrue(on[1:nChi]) then false else true)
   "If any chiller is on then the plant is not in free cooling mode"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
equation
  connect(booToRea.y,val6.y)  annotation (Line(points={{-47.4,74},{-28,74},{-28,
          0},{-50,0},{-50,-8}}, color={0,0,127}));
  connect(inv.y,val5.y)  annotation (Line(points={{-2.6,94},{8,94},{8,0},{50,0},
          {50,-8}}, color={0,0,127}));
  connect(val5.port_b,val6.port_a)
    annotation (Line(points={{40,-20},{0,-20},{-40,-20}}, color={0,127,255}));
  connect(wseMod.y, booToRea.u) annotation (Line(points={{-79,80},{-70,80},{-70,
          74},{-61.2,74}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
This model implements an integrated water-side economizer (WSE) 
on the plant side of the primary-only chilled water system, as shown in the following figure. 
In the configuration, users can model multiple chillers with only one integrated WSE.
</p>
<p align=\"center\">
 <img src=\"modelica://Buildings/Resources/Images/ChillerWSE/IntegratedPrimaryPlantSide.png\"/>
</p>
<h4>Implementation</h4>
<p>
 The WSE located on the load side can see the warmest return chilled water, 
 and hence can maximize the use time of the heat exchanger. 
 This system have three operation modes: 
 free cooling (FC) mode, partial mechanical cooling (PMC) mode and fully mechanical cooling (FMC) mode. 
</p>
<p>
 There are 6 valves for on/off use only, 
 which can be controlled in order to switch among FC, PMC and FMC mode. 
</p>
<ul>
 <li>V1 and V2 are associated with the chiller. 
 When the chiller is commanded to run, V1 and V2 will be open, and vice versa. 
 Note that when the number of chillers are larger than 1, 
 V1 and V2 are vectored models with the same dimension as the chillers. 
 </li>
 <li>V2 and V3 are associated with the WSE.
  When the WSE is commanded to run, V3 and V4 will be open, and vice versa. 
 </li>
 <li>V5 is for FMC only. When FMC is on, V5 is commanded to on. 
 Otherwise, V5 is off. 
 </li>
 <li>V6 is for FC only. When FC is on, V6 is commanded to on. 
 Otherwise, V6 is off. 
 </li>
</ul>
<p>
The details about how to switch among different cooling modes are shown as: 
</p>
<p style=\"margin-left: 30px;\">For Free Cooling (FC) Mode: </p>
<ul>
<li style=\"margin-left: 45px;\">V1 and V2 are closed, and V3 and V4 are open; </li>
<li style=\"margin-left: 45px;\">V5 is closed; </li>
<li style=\"margin-left: 45px;\">V6 is open; </li>
</ul>
<p style=\"margin-left: 30px;\">For Partially Mechanical Cooling (PMC) Mode: </p>
<ul>
<li style=\"margin-left: 45px;\">V1 and V2 are open, and V3 and V4 are open; </li>
<li style=\"margin-left: 45px;\">V5 is closed; </li>
<li style=\"margin-left: 45px;\">V6 is closed; </li>
</ul>
<p style=\"margin-left: 30px;\">For fully Mechanical Cooling (FMC) Mode: </p>
<ul>
<li style=\"margin-left: 45px;\">V1 and V2 are open, and V3 and V4 are closed; </li>
<li style=\"margin-left: 45px;\">V5 is open; </li>
<li style=\"margin-left: 45px;\">V6 is closed; </li>
</ul>
</html>", revisions="<html>
<ul>
<li>
July 1, 2017, by Yangyang Fu:<br>
First implementation.
</li>
</ul>
</html>"));
end IntegratedPrimaryPlantSide;
