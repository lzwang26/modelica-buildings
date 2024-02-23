within Buildings.Examples;
model PumpTest
  extends Modelica.Icons.Example;
package Medium = Media.Water "Medium model";

  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 371700,
    nPorts=1)
    annotation (Placement(transformation(extent={{66,56},{46,76}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov(
    redeclare package Medium = Media.Water,
  m_flow_nominal=1,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{-34,2},{-14,22}})));
  Modelica.Blocks.Sources.Constant const3(k=71737)
    annotation (Placement(transformation(extent={{-76,40},{-56,60}})));
  Fluid.Sources.MassFlowSource_T boundary(
  redeclare package Medium = Medium,m_flow=1, nPorts=1)
    annotation (Placement(transformation(extent={{-88,-34},{-68,-14}})));
equation
  connect(mov.port_b, bou.ports[1]) annotation (Line(points={{-14,12},{6,12},{6,
          10},{26,10},{26,66},{46,66}}, color={0,127,255}));
  connect(const3.y, mov.dp_in)
    annotation (Line(points={{-55,50},{-24,50},{-24,24}}, color={0,0,127}));
  connect(boundary.ports[1], mov.port_a) annotation (Line(points={{-68,-24},{-52,
          -24},{-52,12},{-34,12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PumpTest;
