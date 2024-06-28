within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HeatRecoveryUnitController
  Buildings.Controls.OBC.CDL.Reals.Greater gre
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=300)
    annotation (Placement(transformation(extent={{6,40},{26,60}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Buildings.Controls.OBC.CDL.Reals.Less les
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=300)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{8,10},{28,30}})));
  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEve(
    have_heaWat=true,
    have_chiWat=false,
    have_valInlIso=true,
    have_valOutIso=false,
    have_pumHeaWatPri=true,
    have_pumHeaWatSec=false)
    annotation (Placement(transformation(extent={{74,20},{94,48}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSet(k=273.15 + 7.22)
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupCoo annotation (Placement(
        transformation(extent={{-140,80},{-100,120}}), iconTransformation(
          extent={{-140,80},{-100,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupCooSet annotation (
      Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupHea annotation (Placement(
        transformation(extent={{-140,0},{-100,40}}), iconTransformation(extent=
            {{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupHeaSet annotation (
      Placement(transformation(extent={{-140,-40},{-100,0}}),
        iconTransformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHeaPum annotation (
      Placement(transformation(extent={{100,40},{140,80}}), iconTransformation(
          extent={{100,40},{140,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHeaPumPro annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uCooPumPro annotation (
      Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-140,-120},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yVal annotation (
      Placement(transformation(extent={{100,0},{140,40}}), iconTransformation(
          extent={{100,0},{140,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPum annotation (
      Placement(transformation(extent={{100,-40},{140,0}}), iconTransformation(
          extent={{100,-40},{140,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSetHeaPum annotation (
      Placement(transformation(extent={{100,-80},{140,-40}}),
        iconTransformation(extent={{100,-80},{140,-40}})));
equation
  connect(truDel.y, lat.u)
    annotation (Line(points={{28,50},{38,50}}, color={255,0,255}));
  connect(gre.y, or2.u1) annotation (Line(points={{-38,50},{-32,50},{-32,44},{-34,
          44},{-34,36},{-38,36},{-38,30},{-32,30}}, color={255,0,255}));
  connect(les.y, or2.u2) annotation (Line(points={{-38,-10},{-32,-10},{-32,22}},
                color={255,0,255}));
  connect(or2.y, truDel.u) annotation (Line(points={{-8,30},{-2,30},{-2,50},{4,50}},
        color={255,0,255}));
  connect(truDel1.u, not1.y)
    annotation (Line(points={{38,20},{30,20}}, color={255,0,255}));
  connect(or2.y, not1.u) annotation (Line(points={{-8,30},{-2,30},{-2,20},{6,20}},
        color={255,0,255}));
  connect(truDel1.y, lat.clr) annotation (Line(points={{62,20},{64,20},{64,36},
          {34,36},{34,44},{38,44}},
                   color={255,0,255}));
  connect(lat.y, seqEve.u1Hea) annotation (Line(points={{62,50},{66,50},{66,46},
          {72,46}}, color={255,0,255}));
  connect(or1.y, seqEve.u1PumHeaWatPri_actual)
    annotation (Line(points={{62,-10},{72,-10},{72,34}}, color={255,0,255}));
  connect(TSupCoo, gre.u1) annotation (Line(points={{-120,100},{-68,100},{-68,
          50},{-62,50}}, color={0,0,127}));
  connect(TSupCooSet, gre.u2) annotation (Line(points={{-120,60},{-68,60},{-68,
          42},{-62,42}}, color={0,0,127}));
  connect(TSupHea, les.u1) annotation (Line(points={{-120,20},{-70,20},{-70,-10},
          {-62,-10}}, color={0,0,127}));
  connect(TSupHeaSet, les.u2) annotation (Line(points={{-120,-20},{-70,-20},{
          -70,-18},{-62,-18}}, color={0,0,127}));
  connect(uHeaPumPro, or1.u1) annotation (Line(points={{-120,-60},{20,-60},{20,
          -10},{38,-10}}, color={255,0,255}));
  connect(uCooPumPro, or1.u2) annotation (Line(points={{-120,-100},{30,-100},{
          30,-18},{38,-18}}, color={255,0,255}));
  connect(seqEve.y1, yHeaPum) annotation (Line(points={{96,46},{98,46},{98,60},
          {120,60}}, color={255,0,255}));
  connect(seqEve.y1ValHeaWatInlIso, yVal) annotation (Line(points={{96,36},{98,
          36},{98,20},{120,20}}, color={255,0,255}));
  connect(seqEve.y1PumHeaWatPri, yPum)
    annotation (Line(points={{96,26},{96,-20},{120,-20}}, color={255,0,255}));
  connect(TSet.y, TSetHeaPum) annotation (Line(points={{82,-60},{96,-60},{96,
          -60},{120,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end HeatRecoveryUnitController;
