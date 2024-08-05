within Buildings.Templates.Plants.HeatPumps_PNNL.Components;
package HeatPumpGroups
  extends Modelica.Icons.VariantsPackage;

  model WaterToWater
    "Water-to-water heat pump group"

    extends
      Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface.PartialHeatPumpGroup_WaterToWater(
      redeclare final package MediumSou=MediumHeaWat,
      final typ=Buildings.Templates.Components.Types.HeatPump.WaterToWater,
      final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit);
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater_hp hp[nHp](
      redeclare each final package MediumHeaWat=MediumHeaWat,
      each final is_rev=is_rev,
      final dat=datHp,
      each final allowFlowReversal=allowFlowReversal,
      each final energyDynamics=energyDynamics,
      each final have_preDroChiHeaWat=have_preDroChiHeaWat,
      each final have_preDroSou=have_preDroSou)
      "Heat pump unit"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  equation

    connect(ports_aChiWat, hp.port_a)
      annotation (Line(points={{120,200},{120,0},{10,0}}, color={0,127,255}));
    connect(hp.port_b, ports_bChiWat) annotation (Line(points={{-10,0},{-120,0},
            {-120,200}}, color={0,127,255}));
    connect(busHp, hp.bus)
      annotation (Line(points={{60,140},{60,76},{0,76},{0,10}},
                                               color={255,204,51},thickness=0.5));
    connect(ports_aHotWat, hp.port_aSou) annotation (Line(points={{-120,-200},{
            -120,-10},{-10,-10}}, color={0,127,255}));
    connect(ports_bHotWat, hp.port_bSou) annotation (Line(points={{120,-200},{
            120,-10},{10,-10}}, color={0,127,255}));
    annotation (
      defaultComponentName="hp", Documentation(info="<html>
<p>
This model represents a group of heat pumps.
</p>
</html>"));
  end WaterToWater;

  model WaterToWater_hp
    "Water-to-water heat pump - Equation fit model"

    extends Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.PartialHeatPumpEquationFit(
      final typ=Buildings.Templates.Components.Types.HeatPump.WaterToWater);
  equation
    connect(port_aSou,THotEnt.port_a)
      annotation (Line(points={{80,-140},{80,-20},{40,-20}},color={0,127,255}));
    annotation (
      defaultComponentName="hp",
      Documentation(
        info="<html>
<p>
This is a model for a water-to-water heat pump where the capacity
and input power are computed based on the equation fit method.
The model can be configured with the parameter <code>is_rev</code>
to represent either a non-reversible heat pump (heating only) or a
reversible heat pump.
This model uses
<a href=\"modelica://Buildings.Fluid.HeatPumps.EquationFitReversible\">
Buildings.Fluid.HeatPumps.EquationFitReversible</a>,
which the user may refer to for the modeling assumptions.
</p>
<h4>Control points</h4>
<p>
Refer to the documentation of the interface class
<a href=\"modelica://Buildings.Templates.Components.Interfaces.PartialHeatPumpEquationFit\">
Buildings.Templates.Components.Interfaces.PartialHeatPumpEquationFit</a>
for a description of the available control input and output
variables.
</p>
</html>",   revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
  end WaterToWater_hp;

  model PartialHeatPumpEquationFit
    "Interface for heat pump using equation fit model"

    extends Buildings.Templates.Components.Interfaces.PartialHeatPump(
      final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit);

    final parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic datPerFit(
      dpHeaSou_nominal = if have_preDroSou then dat.perFit.dpHeaSou_nominal else 0,
      dpHeaLoa_nominal = if have_preDroChiHeaWat then dat.perFit.dpHeaLoa_nominal else 0,
      hea(
        TRefLoa = dat.perFit.hea.TRefLoa,
        TRefSou = dat.perFit.hea.TRefSou,
        Q_flow = dat.perFit.hea.Q_flow,
        P = dat.perFit.hea.P,
        mSou_flow = dat.perFit.hea.mSou_flow,
        mLoa_flow = dat.perFit.hea.mLoa_flow,
        coeQ = dat.perFit.hea.coeQ,
        coeP = dat.perFit.hea.coeP),
      coo(
        TRefSou = dat.perFit.coo.TRefSou,
        TRefLoa =  dat.perFit.coo.TRefLoa,
        Q_flow = dat.perFit.coo.Q_flow,
        P = dat.perFit.coo.P,
        coeQ = dat.perFit.coo.coeQ,
        coeP = dat.perFit.coo.coeP))
    "Performance data - Equation fit model";

    Modelica.Blocks.Routing.BooleanPassThrough y1Hea if is_rev
      "Operating mode command: true=heating, false=cooling"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-80,130})));
    Buildings.Controls.OBC.CDL.Logical.Sources.Constant y1HeaNonRev(
      final k=true) if not is_rev
      "Placeholder signal for non-reversible heat pumps"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-40,130})));
    Buildings.Templates.Components.Controls.StatusEmulator y1_actual
      "Compute heat pump status"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,130})));
    Fluid.Sensors.MassFlowRate mChiWat_flow(redeclare final package Medium =
          MediumHeaWat) "CHW mass flow rate"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    Fluid.Sensors.TemperatureTwoPort TChiWatEnt(redeclare final package Medium
        = MediumHeaWat, final m_flow_nominal=max(mChiWat_flow_nominal,
          mHeaWat_flow_nominal)) "CHW entering temperature"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Fluid.Sensors.TemperatureTwoPort TChiWatLvg(redeclare final package Medium
        = MediumHeaWat, final m_flow_nominal=max(mChiWat_flow_nominal,
          mHeaWat_flow_nominal)) "CHW leaving temperature"
      annotation (Placement(transformation(extent={{70,-10},{90,10}})));
    Fluid.Sensors.TemperatureTwoPort THotEnt(
      redeclare final package Medium = MediumSou, final m_flow_nominal=
          mSouHea_flow_nominal) "Hot fluid entering temperature"
      annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
    Fluid.Sensors.TemperatureTwoPort THotLvg(
      redeclare final package Medium = MediumSou,
      final m_flow_nominal=
          mSouHea_flow_nominal) "Hot fluid leaving temperature"
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-20})));
    Buildings.Fluid.HeatPumps.EquationFitReversible hp(
      uMod(start=0),
      redeclare final package Medium1 = MediumHeaWat,
      redeclare final package Medium2 = MediumSou,
      final per=datPerFit,
      final energyDynamics=energyDynamics) "Heat pump"
      annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger y1Int
      "Convert on/off command into integer"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-20,90})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger y1HeaInt(
      y(start=0),
      final integerTrue=1,
      final integerFalse=-1)
      "Convert heating mode command into integer"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-80,90})));
    Buildings.Controls.OBC.CDL.Integers.Multiply mulInt
      "Combine on/off and operating mode command signals"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-20,50})));
  equation
    /* Control point connection - start */
    /* Control point connection - stop */
    connect(bus.y1Hea, y1Hea.u) annotation (Line(
        points={{0,160},{0,156},{-80,156},{-80,142}},
        color={255,204,51},
        thickness=0.5));
    connect(port_a, mChiWat_flow.port_a)
      annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
    connect(mChiWat_flow.port_b, TChiWatEnt.port_a)
      annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
    connect(TChiWatLvg.port_b, port_b)
      annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
    connect(THotLvg.port_b, port_bSou) annotation (Line(points={{-40,-20},{-80,-20},
            {-80,-140}},      color={0,127,255}));
    connect(y1Hea.y, y1HeaInt.u) annotation (Line(points={{-80,119},{-80,110.5},{-80,
            110.5},{-80,102}}, color={255,0,255}));
    connect(y1HeaNonRev.y, y1HeaInt.u) annotation (Line(points={{-40,118},{-40,110},
            {-80,110},{-80,102}}, color={255,0,255}));
    connect(y1HeaInt.y, mulInt.u2) annotation (Line(points={{-80,78},{-80,70},{-26,
            70},{-26,62}}, color={255,127,0}));
    connect(y1Int.y, mulInt.u1) annotation (Line(points={{-20,78},{-20,70},{-14,70},
            {-14,62}}, color={255,127,0}));
    connect(TChiWatEnt.port_b, hp.port_a1)
      annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
    connect(hp.port_b1, TChiWatLvg.port_a)
      annotation (Line(points={{10,0},{70,0}}, color={0,127,255}));
    connect(THotLvg.port_a, hp.port_b2) annotation (Line(points={{-20,-20},{-20,-12},
            {-10,-12}}, color={0,127,255}));
    connect(THotEnt.port_b, hp.port_a2)
      annotation (Line(points={{20,-20},{20,-12},{10,-12}}, color={0,127,255}));
    connect(bus.y1, y1Int.u) annotation (Line(
        points={{0,160},{0,110},{-20,110},{-20,102}},
        color={255,204,51},
        thickness=0.5));
    connect(bus.TSet, hp.TSet) annotation (Line(
        points={{0,160},{0,86},{0,86},{0,10},{-16,10},{-16,3},{-11.4,3}},
        color={255,204,51},
        thickness=0.5));
    connect(mulInt.y, hp.uMod)
      annotation (Line(points={{-20,38},{-20,-6},{-11,-6}}, color={255,127,0}));
    connect(y1_actual.y1_actual, bus.y1_actual)
      annotation (Line(points={{40,142},{40,156},{0,156},{0,160}},
                                                           color={255,0,255}));
    connect(bus.y1, y1_actual.y1) annotation (Line(
        points={{0,160},{0,110},{40,110},{40,118}},
        color={255,204,51},
        thickness=0.5));
    annotation (
    defaultComponentName="heaPum",
    Documentation(info="<html>
<p>
This is a model for an air-to-water heat pump where the capacity
and drawn power are computed based on the equation fit method.
The model can be configured with the parameter <code>is_rev</code>
to represent either a non-reversible heat pump (heating only) or a 
reversible heat pump.
This model uses 
<a href=\"modelica://Buildings.Fluid.HeatPumps.EquationFitReversible\">
Buildings.Fluid.HeatPumps.EquationFitReversible</a>,
which the user may refer to for the modeling assumptions.
</p>
<h4>Control points</h4>
<p>
The following input and output points are available.
</p>
<ul>
<li>
Heat pump on/off command signal <code>y1</code>:
DO signal, with a dimensionality of zero
</li>
<li>For reversible heat pumps only (<code>is_rev=true</code>),
Heat pump operating mode command signal <code>y1Hea</code>:
DO signal, with a dimensionality of zero<br/>
(<code>y1Hea=true</code> for heating mode, 
<code>y1Hea=false</code> for cooling mode)
</li>
<li>
Heat pump supply temperature setpoint <code>TSet</code>:
AO signal, with a dimensionality of zero<br/>
(for reversible heat pumps, the setpoint value must be
switched externally between HW and CHW supply temperature)
</li>
<li>
Heat pump status <code>y1_actual</code>:
DI signal, with a dimensionality of zero
</li>
</ul>
</html>",   revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
  end PartialHeatPumpEquationFit;
end HeatPumpGroups;
