within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model CoolingTowerWHeatExchanger
  extends Modelica.Icons.Example;
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.CoolingTowerWHeatExchanger
    coolingTowerWHeatExchanger(
    redeclare package Medium = Buildings.Media.Water,
    mCooTowAir_flow_nominal=8,
    mChiWat_flow_nominal=1,
    mConWat_flow_nominal=15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Buildings.Media.Water,
    m_flow=1,
    T=311.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Controls.CoolingTowerControl coolingTowerControl
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Interface.CoolingTowerWHEBus bus annotation (Placement(transformation(extent=
            {{-10,60},{30,100}}), iconTransformation(extent={{-278,-28},{-238,
            12}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(period=2*86400, shift=
       300) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(boundary.ports[1], coolingTowerWHeatExchanger.port_a)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  connect(coolingTowerWHeatExchanger.port_b, bou.ports[1])
    annotation (Line(points={{10,0},{30,0}}, color={0,127,255}));
  connect(weaDat.weaBus, coolingTowerWHeatExchanger.busWea) annotation (Line(
      points={{-20,50},{-4,50},{-4,10}},
      color={255,204,51},
      thickness=0.5));
  connect(coolingTowerControl.bus, bus) annotation (Line(
      points={{39.2,48.4},{10,48.4},{10,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus, coolingTowerWHeatExchanger.bus) annotation (Line(
      points={{10,80},{10,14},{4,14},{4,9.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booPul.y, bus.uEna) annotation (Line(points={{22,-30},{28,-30},{28,
          -14},{10,-14},{10,80}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end CoolingTowerWHeatExchanger;
