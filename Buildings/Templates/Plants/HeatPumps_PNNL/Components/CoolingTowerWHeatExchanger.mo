within Buildings.Templates.Plants.HeatPumps_PNNL.Components;
model CoolingTowerWHeatExchanger
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow_nominal=mChiWat_flow_nominal);
  parameter Real mCooTowAir_flow_nominal;
  Buildings.Templates.Components.Coolers.CoolingTower coo(typ=Buildings.Templates.Components.Types.Cooler.CoolingTowerOpen, dat(
      mConWat_flow_nominal=mConWat_flow_nominal,
      dpConWatFri_nominal(displayUnit="Pa") = 14930 + 14930 + 74650,
      dpConWatSta_nominal(displayUnit="Pa") = 5000,
      mAir_flow_nominal=mCooTowAir_flow_nominal,
      TWetBulEnt_nominal=283.15,
      TConWatRet_nominal=296.15,
      TConWatSup_nominal=294.26,
      PFan_nominal=6000))                                 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-70})));
  Buildings.Templates.Components.Pumps.Single pum(have_var=false,
                                                  dat(m_flow_nominal=39.75,
        dp_nominal=200000))
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  BoundaryConditions.WeatherData.Bus           busWea
    "Weather bus"
    annotation (Placement(
        transformation(extent={{-50,80},{-10,120}}), iconTransformation(extent={{-50,90},
            {-30,110}})));
  Fluid.Storage.ExpansionVessel           expVesChi(redeclare package Medium =
        Buildings.Media.Water, V_start=1)
    annotation (Placement(transformation(extent={{-94,-79},{-74,-59}})));
  parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal
    "Air mass flow rate";
  Buildings.Templates.Components.Coils.WaterBasedHeating waterBasedHeating(typVal=
        Buildings.Templates.Components.Types.Valve.ThreeWayModulating, dat(
      mAir_flow_nominal=mChiWat_flow_nominal,
      dpAir_nominal=5000,
      mWat_flow_nominal=39.75,
      dpWat_nominal=0,
      dpValve_nominal=1e-6,
      cap_nominal=10000,
      TWatEnt_nominal=294.26,
      TAirEnt_nominal=303.15,
      wAirEnt_nominal=1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter Modelica.Units.SI.MassFlowRate mConWat_flow_nominal=39.75
    "CW mass flow rate";
  Buildings.Templates.Components.Sensors.Temperature temperature(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=
        mChiWat_flow_nominal,
    have_sen=true)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Interface.CoolingTowerWHEBus bus annotation (Placement(transformation(extent={
            {10,80},{50,120}}), iconTransformation(extent={{30,90},{50,108}})));
equation
  connect(busWea, coo.busWea) annotation (Line(
      points={{-30,100},{-30,-86},{-6,-86},{-6,-80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(expVesChi.port_a, pum.port_a) annotation (Line(points={{-84,-79},{-84,
          -84},{-68,-84},{-68,-70},{-60,-70}}, color={0,127,255}));
  connect(port_a, waterBasedHeating.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(pum.port_a, waterBasedHeating.port_bSou) annotation (Line(points={{-60,
          -70},{-70,-70},{-70,-32},{-5,-32},{-5,-10}}, color={0,127,255}));
  connect(pum.port_b, coo.port_a)
    annotation (Line(points={{-40,-70},{-10,-70}}, color={0,127,255}));
  connect(waterBasedHeating.port_b, temperature.port_a)
    annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
  connect(temperature.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(waterBasedHeating.bus, bus.heatExchBus) annotation (Line(
      points={{0,10},{0,74},{30.1,74},{30.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(coo.bus, bus.coolingTowerBus) annotation (Line(
      points={{-7.21645e-16,-80},{-7.21645e-16,-82},{22,-82},{22,72},{30.1,72},{
          30.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pum.bus, bus.condenserPumpBus) annotation (Line(
      points={{-50,-60},{-50,4},{-16,4},{-16,76},{30.1,76},{30.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(temperature.y, bus.coolingTowerOutputTemp)  annotation (Line(
      points={{70,12},{70,76},{30,76},{30,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(coo.port_b, waterBasedHeating.port_aSou) annotation (Line(points={{10,
          -70},{60,-70},{60,-30},{5,-30},{5,-10}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-40,-60},{40,-100}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={239,239,239},
          fillPattern=FillPattern.Solid),
    Text( extent={{-60,-60},{60,-100}},
          textColor={0,0,0},
          textString="CT"),
    Rectangle(
          extent={{40,60},{-40,-100}},
          lineColor={0,0,0},
          lineThickness=1),
    Bitmap(extent={{-20,60},{20,100}}, fileName=
              "modelica://Buildings/Resources/Images/Templates/Components/Actuators/VFD.svg"),
        Bitmap(
          extent={{-33,-30},{33,30}},
          fileName="modelica://Buildings/Resources/Images/Templates/Components/Fans/Propeller.svg",
          origin={0,41},
          rotation=-90)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoolingTowerWHeatExchanger;
