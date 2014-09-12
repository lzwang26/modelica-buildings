within Buildings.Electrical.AC.ThreePhasesUnbalanced.Examples.IEEETests.Test4NodesFeeder.BaseClasses;
partial model IEEE4 "Base model of the IEEE 4 nodes test feeder"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Voltage VLL_side1 = 12.47e3
    "Voltage line to line side 1";
  parameter Modelica.SIunits.Voltage VLL_side2 = 4.16e3
    "Voltage line to line side 2";

  parameter Modelica.SIunits.ApparentPower VARbase = 6000e3
    "Base VA power of the transformer";

  parameter Boolean line1_use_Z_y = true
    "Choose between Zy or Zd impedance matrix for line 1";
  parameter Boolean line2_use_Z_y = true
    "Choose between Zy or Zd impedance matrix for line 2";

  parameter Modelica.SIunits.Voltage V2_ref[3] = {7107, 7140, 7121}
    "Reference RMS voltage node 2 - IEEE results";
  parameter Modelica.SIunits.Voltage V3_ref[3] = {2247, 2269, 2256}
    "Reference RMS voltage node 3 - IEEE results";
  parameter Modelica.SIunits.Voltage V4_ref[3] = {1918, 2061, 1981}
    "Reference RMS voltage node 4 - IEEE results";
  parameter Real Theta2_ref[3](unit="deg") = {-0.3, -120.3, 119.6}
    "Reference voltage phase angle node 2 - IEEE results";
  parameter Real Theta3_ref[3](unit="deg") = {-3.7, -123.5, 116.4}
    "Reference voltage phase angle node 3 - IEEE results";
  parameter Real Theta4_ref[3](unit="deg") = {-9.1, -128.3, 110.9}
    "Reference voltage phase angle node 4 - IEEE results";
  Modelica.SIunits.Voltage err_V2[3] = node2.V - V2_ref
    "Error on voltage at node 2";
  Modelica.SIunits.Voltage err_V3[3] = node3.V - V3_ref
    "Error on voltage at node 3";
  Modelica.SIunits.Voltage err_V4[3] = node4.V - V4_ref
    "Error on voltage at node 4";
  Real err_Theta2[3](unit="deg") = node2.theta - Theta2_ref
    "Error on voltage at node 2";
  Real err_Theta3[3](unit="deg") = node3.theta - Theta3_ref
    "Error on voltage at node 3";
  Real err_Theta4[3](unit="deg") = node4.theta - Theta4_ref
    "Error on voltage at node 4";
  Real err_V2_percent[3] = 100*{err_V2[i]/V2_ref[i] for i in 1:3}
    "Error in RMS voltage at node 2 -- percent";
  Real err_V3_percent[3] = 100*{err_V3[i]/V3_ref[i] for i in 1:3}
    "Error in RMS voltage at node 3 -- percent";
  Real err_V4_percent[3] = 100*{err_V4[i]/V4_ref[i] for i in 1:3}
    "Error in RMS voltage at node 4 -- percent";
  Real err_Theta2_percent[3] = 100*{err_Theta2[i]/Theta2_ref[i] for i in 1:3}
    "Error in voltage phase angle at node 2 -- percent";
  Real err_Theta3_percent[3] = 100*{err_Theta3[i]/Theta3_ref[i] for i in 1:3}
    "Error in voltage phase angle at node 3 -- percent";
  Real err_Theta4_percent[3] = 100*{err_Theta4[i]/Theta4_ref[i] for i in 1:3}
    "Error in voltage phase angle at node 4 -- percent";
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(
    f=60,
    V=VLL_side1,
    Phi=0) annotation (Placement(transformation(extent={{-98,0},{-78,20}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL line1(
    Z11=L1*(if line1_use_Z_y then Z11_y else Z11_d),
    Z12=L1*(if line1_use_Z_y then Z12_y else Z12_d),
    Z13=L1*(if line1_use_Z_y then Z13_y else Z13_d),
    Z22=L1*(if line1_use_Z_y then Z22_y else Z22_d),
    Z23=L1*(if line1_use_Z_y then Z23_y else Z23_d),
    Z33=L1*(if line1_use_Z_y then Z33_y else Z33_d),
    V_nominal=VLL_side1)
    annotation (Placement(transformation(extent={{-68,0},{-48,20}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL line2(
    Z11=L2*(if line2_use_Z_y then Z11_y else Z11_d),
    Z12=L2*(if line2_use_Z_y then Z12_y else Z12_d),
    Z13=L2*(if line2_use_Z_y then Z13_y else Z13_d),
    Z22=L2*(if line2_use_Z_y then Z22_y else Z22_d),
    Z23=L2*(if line2_use_Z_y then Z23_y else Z23_d),
    Z33=L2*(if line2_use_Z_y then Z33_y else Z33_d),
    V_nominal=VLL_side2)
    annotation (Placement(transformation(extent={{12,0},{32,20}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Inductive loadRL(
    pf=0.9,
    P_nominal=-1800e3,
    V_nominal=VLL_side2,
    mode=Buildings.Electrical.Types.Assumption.VariableZ_P_input,
    use_pf_in=true)
    annotation (Placement(transformation(extent={{54,0},{74,20}})));
  replaceable
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.BaseClasses.GeneralizedProbe
    node1(perUnit=false, V_nominal=VLL_side1)
    annotation (Placement(transformation(extent={{-84,28},{-64,48}})));
  replaceable
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.BaseClasses.GeneralizedProbe
    node2(perUnit=false, V_nominal=VLL_side1)
    annotation (Placement(transformation(extent={{-52,28},{-32,48}})));
  replaceable
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.BaseClasses.GeneralizedProbe
    node3(perUnit=false, V_nominal=VLL_side2)
              annotation (Placement(transformation(extent={{-4,28},{16,48}})));
  replaceable
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.BaseClasses.GeneralizedProbe
    node4(perUnit=false, V_nominal=VLL_side2)
              annotation (Placement(transformation(extent={{28,28},{48,48}})));

protected
  parameter Real L1 = 2000*(1.0/5280.0) "Length line 1 in miles";
  parameter Real L2 = 2500*(1.0/5280.0) "Length line 2 in miles";

  parameter Modelica.SIunits.Impedance Z11_d[2] = {0.4013,1.4133}
    "Element [1,1] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z12_d[2] = {0.0953,0.8515}
    "Element [1,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z13_d[2] = {0.0953,0.7266}
    "Element [1,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z22_d[2] = {0.4013,1.4133}
    "Element [2,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z23_d[2] = {0.0953,0.7802}
    "Element [2,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z33_d[2] = {0.4013,1.4133}
    "Element [3,3] of impedance matrix";

  parameter Modelica.SIunits.Impedance Z11_y[2] = {0.4576,1.078}
    "Element [1,1] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z12_y[2] = {0.1559,0.5017}
    "Element [1,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z13_y[2] = {0.1535,0.3849}
    "Element [1,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z22_y[2] = {0.4666,1.0482}
    "Element [2,2] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z23_y[2] = {0.158,0.4236}
    "Element [2,3] of impedance matrix";
  parameter Modelica.SIunits.Impedance Z33_y[2] = {0.4615,1.0651}
    "Element [3,3] of impedance matrix";
equation
  connect(source.terminal, line1.terminal_n) annotation (Line(
      points={{-78,10},{-68,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(line2.terminal_p, loadRL.terminal_p) annotation (Line(
      points={{32,10},{54,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(line1.terminal_p, node2.term) annotation (Line(
      points={{-48,10},{-42,10},{-42,29}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(source.terminal, node1.term) annotation (Line(
      points={{-78,10},{-74,10},{-74,29}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(line2.terminal_n, node3.term) annotation (Line(
      points={{12,10},{6,10},{6,29}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(line2.terminal_p, node4.term) annotation (Line(
      points={{32,10},{38,10},{38,29}},
      color={0,120,120},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics), Documentation(revisions="<html>
<ul>
<li>
June 6, 2014, by Marco Bonvini:<br/>
First implementation.
</li>
</ul>
</html>"));
end IEEE4;