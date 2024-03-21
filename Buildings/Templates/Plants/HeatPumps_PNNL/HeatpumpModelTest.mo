within Buildings.Templates.Plants.HeatPumps_PNNL;
model HeatpumpModelTest
  Components.HeatPumps.WaterToWater hp(is_rev=true)
    annotation (Placement(transformation(extent={{-4,4},{16,24}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    nPorts=1) annotation (Placement(transformation(extent={{-60,8},{-40,28}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water, nPorts=
        1) annotation (Placement(transformation(extent={{68,6},{48,26}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    nPorts=1) annotation (Placement(transformation(extent={{64,-30},{44,-10}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts
      =1) annotation (Placement(transformation(extent={{-64,-22},{-44,-2}})));
  Components.Interfaces.Bus bus
    annotation (Placement(transformation(extent={{-14,32},{26,72}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
equation
  connect(boundary.ports[1], hp.port_a) annotation (Line(points={{-40,18},{-22,
          18},{-22,14},{-4,14}}, color={0,127,255}));
  connect(bou.ports[1], hp.port_b) annotation (Line(points={{48,16},{32,16},{32,
          14},{16,14}}, color={0,127,255}));
  connect(boundary1.ports[1], hp.port_aSou) annotation (Line(points={{44,-20},{
          32,-20},{32,4},{16,4}}, color={0,127,255}));
  connect(bou1.ports[1], hp.port_bSou) annotation (Line(points={{-44,-12},{-24,
          -12},{-24,4},{-4,4}}, color={0,127,255}));
  connect(hp.bus, bus) annotation (Line(
      points={{6,24},{6,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatpumpModelTest;
