within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HeatRecoveryUnitControl
  Interface.HeatRecoveryUnit bus annotation (Placement(transformation(extent={{-20,
            80},{20,120}}), iconTransformation(extent={{-20,80},{20,120}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=300)
    annotation (Placement(transformation(extent={{6,40},{26,60}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Buildings.Controls.OBC.CDL.Reals.Less les
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
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
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
equation
  connect(truDel.y, lat.u)
    annotation (Line(points={{28,50},{38,50}}, color={255,0,255}));
  connect(bus.TSupHea, les.u1) annotation (Line(
      points={{0,100},{0,70},{-72,70},{-72,10},{-62,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.TSupHeaSet, les.u2) annotation (Line(
      points={{0,100},{0,72},{-74,72},{-74,2},{-62,2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.TSupCoo, gre.u1) annotation (Line(
      points={{0,100},{0,64},{-68,64},{-68,50},{-62,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.TSupCooSet, gre.u2) annotation (Line(
      points={{0,100},{0,66},{-70,66},{-70,42},{-62,42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gre.y, or2.u1) annotation (Line(points={{-38,50},{-32,50},{-32,44},{-34,
          44},{-34,36},{-38,36},{-38,30},{-32,30}}, color={255,0,255}));
  connect(les.y, or2.u2) annotation (Line(points={{-38,10},{-38,14},{-32,14},{-32,
          22}}, color={255,0,255}));
  connect(or2.y, truDel.u) annotation (Line(points={{-8,30},{-2,30},{-2,50},{4,50}},
        color={255,0,255}));
  connect(truDel1.u, not1.y)
    annotation (Line(points={{38,20},{30,20}}, color={255,0,255}));
  connect(or2.y, not1.u) annotation (Line(points={{-8,30},{-2,30},{-2,20},{6,20}},
        color={255,0,255}));
  connect(truDel1.y, lat.clr) annotation (Line(points={{62,20},{66,20},{66,44},{
          38,44}}, color={255,0,255}));
  connect(lat.y, seqEve.u1Hea) annotation (Line(points={{62,50},{66,50},{66,46},
          {72,46}}, color={255,0,255}));
  connect(or1.y, seqEve.u1PumHeaWatPri_actual)
    annotation (Line(points={{62,-10},{72,-10},{72,34}}, color={255,0,255}));
  connect(bus.coolingPumpBus.y1_actual, or1.u1) annotation (Line(
      points={{0.1,100.1},{0.1,64},{32,64},{32,26},{34,26},{34,-4},{32,-4},{32,-10},
          {38,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.heatingPumpBus.y1_actual, or1.u2) annotation (Line(
      points={{0.1,100.1},{0.1,66},{34,66},{34,14},{32,14},{32,-2},{30,-2},{30,-18},
          {38,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEve.y1PumHeaWatPri, bus.coolingPumpBus.y1) annotation (Line(
        points={{96,26},{106,26},{106,78},{24,78},{24,76},{0.1,76},{0.1,100.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEve.y1PumHeaWatPri, bus.heatingPumpBus.y1) annotation (Line(
        points={{96,26},{106,26},{106,78},{24,78},{24,76},{0.1,76},{0.1,100.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEve.y1, bus.plantControlBus.hp.y1) annotation (Line(points={{96,
          46},{96,72},{0.1,72},{0.1,100.1}}, color={255,0,255}));
  connect(TSet.y, bus.plantControlBus.hp.TSet) annotation (Line(points={{82,-40},
          {88,-40},{88,-24},{0,-24},{0,52},{-2,52},{-2,62},{0.1,62},{0.1,100.1}},
        color={0,0,127}));
  connect(seqEve.y1ValHeaWatInlIso, bus.plantControlBus.valChiWatHpInlIso.y1[1])
    annotation (Line(points={{96,36},{102,36},{102,76},{26,76},{26,74},{0.1,74},
          {0.1,100.1}}, color={255,0,255}));
  connect(seqEve.y1ValHeaWatInlIso, bus.plantControlBus.valHeaWatHpInlIso.y1[1])
    annotation (Line(points={{96,36},{102,36},{102,76},{26,76},{26,74},{0.1,74},
          {0.1,100.1}},
                 color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,20},{150,-20}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end HeatRecoveryUnitControl;
