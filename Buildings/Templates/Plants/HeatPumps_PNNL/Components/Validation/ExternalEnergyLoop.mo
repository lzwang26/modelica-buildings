within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model ExternalEnergyLoop
  extends Modelica.Icons.Example;
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Controls.ExternalEnergyOpenLoop externalEnergyOpenLoop
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={
            {10,50},{50,90}}), iconTransformation(extent={{30,50},{70,90}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Buildings.Media.Water,
    T=305.35,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,-40})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-10,-40})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Buildings.Media.Water,
    T(displayUnit="degC") = 288.7,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,-40})));
  Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={50,-40})));
equation
  connect(externalEnergyOpenLoop.bus, bus) annotation (Line(
      points={{50,40},{50,46},{30,46},{30,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus, externalEnergyLoop.bus) annotation (Line(
      points={{30,70},{30,16},{4,16},{4,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaDat.weaBus, externalEnergyLoop.busWea) annotation (Line(
      points={{-20,50},{-4,50},{-4,10}},
      color={255,204,51},
      thickness=0.5));
  connect(bou1.ports[1], externalEnergyLoop.portCon_b) annotation (Line(points={{-10,-30},
          {-2,-30},{-2,-10},{-3,-10}},           color={0,127,255}));
  connect(externalEnergyLoop.portCon_a, bou.ports[1]) annotation (Line(points={{-7,-10},
          {-40,-10},{-40,-30}},         color={0,127,255}));
  connect(bou2.ports[1], externalEnergyLoop.portEva_a) annotation (Line(points={{20,-30},
          {20,-16},{3,-16},{3,-10}},          color={0,127,255}));
  connect(bou3.ports[1], externalEnergyLoop.portEva_b) annotation (Line(points={{50,-30},
          {50,-14},{7,-14},{7,-10}},          color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
end ExternalEnergyLoop;
