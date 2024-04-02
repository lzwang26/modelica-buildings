within Buildings.Templates.Plants.HeatPumps_PNNL;
model HeatPumpEquiationFit_WatertoWater
  "Validation model for heat pump component with equation fit model"
  extends Modelica.Icons.Example;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "HW or CHW medium";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSupSet(k=datHpWw.TChiWatSup_nominal,
      y(final unit="K", displayUnit="degC")) "CHWST setpoint" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,120})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1(
    table=[
      0, 0;
      0.5, 1],
    timeScale=1000,
    period=3000)
    "Heat pump Enable signal"
    annotation (Placement(transformation(extent={{-192,86},{-172,106}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1Hea(
    table=[
      0, 0;
      2, 1],
    timeScale=1000,
    period=3000)
    "Heat pump heating mode signal"
    annotation (Placement(transformation(extent={{-192,50},{-172,70}})));
  Fluid.Sources.Boundary_pT sup(
    redeclare final package Medium=Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=1)
    "Boundary condition at distribution system supply"
    annotation (Placement(transformation(extent={{190,30},{170,50}})));
  Fluid.Sources.Boundary_pT inlHp(
    redeclare final package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1) "Boundary conditions of CHW/HW at HP inlet"
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant pChiWatInl(
    k=sup.p + hpWw.dpChiWat_nominal) "CHW inlet pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
      origin={-74,-10})));
  Buildings.Templates.Components.HeatPumps.WaterToWater hpWw(
    is_rev=true,
    show_T=true,
    redeclare final package MediumHeaWat = Medium,
    final dat=datHpWw,
    final energyDynamics=energyDynamics,
    have_preDroChiHeaWat=false,
    have_preDroSou=false)
    "Reversible WWHP - CHW/HW and source fluid pressure drops computed externally"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  parameter Buildings.Templates.Components.Data.HeatPump datHpWw(
    final cpHeaWat_default=hpWw.cpHeaWat_default,
    final cpSou_default=hpWw.cpSou_default,
    final typ=hpWw.typ,
    final is_rev=hpWw.is_rev,
    final typMod=hpWw.typMod,
    mHeaWat_flow_nominal=datHpWw.capHea_nominal/abs(datHpWw.THeaWatSup_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWat_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHea_nominal=500E3,
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWat_flow_nominal=datHpWw.capCoo_nominal/abs(datHpWw.TChiWatSup_nominal -
        Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCoo_nominal=500E3,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCoo_nominal=Buildings.Templates.Data.Defaults.TSouHpCoo,
    TSouHea_nominal=Buildings.Templates.Data.Defaults.TSouHpHea,
    dpSouWwHea_nominal=Buildings.Templates.Data.Defaults.dpChiWatChi,
    mSouWwCoo_flow_nominal=datHpWw.mSouWwHea_flow_nominal,
    mSouWwHea_flow_nominal=datHpWw.mHeaWat_flow_nominal,
    perFit(hea(
        P=datHpWw.capHea_nominal/Buildings.Templates.Data.Defaults.COPHpWwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpHea), coo(
        P=datHpWw.capCoo_nominal/Buildings.Templates.Data.Defaults.COPHpWwCoo,
        coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
        coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpCoo)))
    "Reversible WWHP parameters parameters"
    annotation (Placement(transformation(extent={{118,14},{138,34}})));

  Fluid.Sensors.TemperatureTwoPort TRet2(redeclare final package Medium =
        Medium, final m_flow_nominal=datHpWw.mChiWat_flow_nominal)
    "Return temperature"
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Fluid.Sensors.TemperatureTwoPort TSup2(redeclare final package Medium =
        Medium, final m_flow_nominal=datHpWw.mChiWat_flow_nominal)
    "Supply temperature"
    annotation (Placement(transformation(extent={{130,-90},{150,-70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant pSouInlCoo(k=retSou.p +
        hpWw.dpSouCoo_nominal) "Source fluid inlet pressure" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,-148})));
  Fluid.Sources.Boundary_pT inlHpSou(
    redeclare final package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    nPorts=1) "Boundary conditions or source side fluid at HP inlet"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Fluid.Sources.Boundary_pT retSou(
    redeclare final package Medium=Medium,
    p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
    nPorts=1)
    "Boundary condition at source system return"
    annotation (Placement(transformation(extent={{190,-130},{170,-110}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare final package Medium = Medium,
    final m_flow_nominal=datHpWw.mHeaWat_flow_nominal,
    final dp_nominal=datHpWw.dpHeaWat_nominal)
    "CHW/HW pressure drop computed externally"
    annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  Fluid.FixedResistances.PressureDrop resSou(
    redeclare final package Medium = Medium,
    final m_flow_nominal=datHpWw.mSouWwHea_flow_nominal,
    final dp_nominal=datHpWw.dpSouWwHea_nominal)
    "Source fluid pressure drop computed externally"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSouInlCoo(k=datHpWw.TSouCoo_nominal)
    "Source fluid inlet pressure" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,-100})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatInl(k=datHpWw.TChiWatRet_nominal)
    "CHW inlet pressure" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,38})));
protected
  Buildings.Templates.Components.Interfaces.Bus bus2 "HP control bus"
    annotation (Placement(transformation(extent={{60,-60},{100,-20}}),
      iconTransformation(extent={{-276,6},{-236,46}})));
equation
  connect(hpWw.port_b, TSup2.port_a)
    annotation (Line(points={{120,-80},{130,-80}}, color={0,127,255}));
  connect(TSup2.port_b, sup.ports[1])
    annotation (Line(points={{150,-80},{170,-80},{170,40}},     color={0,127,255}));
  connect(inlHp.ports[1], TRet2.port_a) annotation (Line(points={{30,0},{30,0},
          {40,0},{40,-80},{50,-80}},       color={0,127,255}));
  connect(bus2, hpWw.bus) annotation (Line(
      points={{80,-40},{110,-40},{110,-70}},
      color={255,204,51},
      thickness=0.5));
  connect(retSou.ports[1], hpWw.port_bSou) annotation (Line(points={{170,-120},{
          94,-120},{94,-90},{100,-90}},  color={0,127,255}));
  connect(y1.y[1], bus2.y1)
    annotation (Line(points={{-170,96},{-50,96},{-50,-40},{80,-40}},  color={255,0,255}));
  connect(y1Hea.y[1], bus2.y1Hea)
    annotation (Line(points={{-170,60},{-50,60},{-50,-40},{80,-40}},  color={255,0,255}));
  connect(TRet2.port_b, res.port_a)
    annotation (Line(points={{70,-80},{70,-80}}, color={0,127,255}));
  connect(res.port_b, hpWw.port_a)
    annotation (Line(points={{90,-80},{100,-80}}, color={0,127,255}));
  connect(hpWw.port_aSou, resSou.port_b) annotation (Line(points={{120,-90},{126,
          -90},{126,-100},{90,-100}}, color={0,127,255}));
  connect(inlHpSou.ports[1], resSou.port_a) annotation (Line(points={{30,-100},
          {50,-100},{50,-100},{70,-100}}, color={0,127,255}));
  connect(pSouInlCoo.y, inlHpSou.p_in) annotation (Line(points={{-80,-148},{-52,
          -148},{-52,-92},{8,-92}}, color={0,0,127}));
  connect(pChiWatInl.y, inlHp.p_in) annotation (Line(points={{-62,-10},{-38,-10},
          {-38,8},{8,8}}, color={0,0,127}));
  connect(TChiWatSupSet.y, bus2.TSet) annotation (Line(points={{-68,120},{0,120},
          {0,92},{80,92},{80,-40}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TSouInlCoo.y, inlHpSou.T_in) annotation (Line(points={{-80,-100},{-38,
          -100},{-38,-96},{8,-96}}, color={0,0,127}));
  connect(TChiWatInl.y, inlHp.T_in) annotation (Line(points={{-66,38},{-30,38},
          {-30,4},{8,4}}, color={0,0,127}));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-200,-180},{200,180}})),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Components/HeatPumps/Validation/HeatPumpEquationFit.mos"
        "Simulate and plot"),
    experiment(
      Tolerance=1e-6,
      StartTime=10497600.0,
      StopTime=10505600.0),
    Documentation(
      info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Components.HeatPumps.AirToWater>
Buildings.Templates.Components.HeatPumps.AirToWater</a>
in a configuration in which the heat pump components are exposed
to a constant differential pressure and a varying
return temperature.
</p>
<p>
The model is configured to represent either a non-reversible heat pump
(suffix <code>Nrv</code>) or a reversible heat pump
that switches between cooling and heating mode.
</p>
<p>
It can be seen that the HW supply temperature setpoint is not met
at minimum HW return temperature because the outdoor air temperature
is below the heat pump selection conditions.
</p>
</html>"));
end HeatPumpEquiationFit_WatertoWater;
