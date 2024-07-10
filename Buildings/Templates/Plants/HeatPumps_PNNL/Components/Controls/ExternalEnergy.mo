within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ExternalEnergy
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={{-20,120},
            {20,160}}),          iconTransformation(extent={{-10,90},{10,110}})));
  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEveHea(
    have_heaWat=true,
    have_chiWat=false,
    have_valInlIso=true,
    have_valOutIso=true,
    have_pumHeaWatPri=true,
    have_pumHeaWatSec=false)
    annotation (Placement(transformation(extent={{40,52},{60,80}})));
  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEveCoo(
    have_heaWat=false,
    have_chiWat=true,
    have_valInlIso=true,
    have_valOutIso=true,
    have_pumHeaWatPri=true,
    have_pumChiWatPri=true,
    have_pumHeaWatSec=false,
    have_pumChiWatSec=false)
    annotation (Placement(transformation(extent={{40,-20},{60,8}})));
  CoolingTowerControl coolingTowerControl
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=273.15 + 24)
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Modelica.Blocks.Routing.IntegerPassThrough integerPassThrough
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(nin=3)
    annotation (Placement(transformation(extent={{-24,60},{-4,80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr1(nin=3)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-24,-50},{-4,-30}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=3)
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Buildings.Controls.OBC.CDL.Logical.And and3
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Buildings.Controls.OBC.CDL.Logical.And and4
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(bus.heatingPumpBus.y1_actual, seqEveHea.u1PumHeaWatPri_actual)
    annotation (Line(
      points={{0.1,140.1},{0.1,56},{30,56},{30,66},{38,66}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.coolingPumpBus.y1_actual, seqEveCoo.u1PumChiWatPri_actual)
    annotation (Line(
      points={{0.1,140.1},{0.1,4},{32,4},{32,-8},{38,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(coolingTowerControl.bus, bus.coolingTowerSystemBus) annotation (Line(
      points={{59.2,28.4},{0.1,28.4},{0.1,140.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1, bus.heatPumpBus.y1) annotation (Line(points={{62,78},{70,
          78},{70,114},{0.1,114},{0.1,140.1}},
                                         color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1, bus.coolingTowerSystemBus.uEna) annotation (Line(points={{62,6},{
          62,16},{0.1,16},{0.1,140.1}},                         color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1PumHeaWatPri, bus.heatingPumpBus.y1) annotation (Line(
        points={{62,58},{68,58},{68,48},{0.1,48},{0.1,140.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1PumChiWatPri, bus.coolingPumpBus.y1) annotation (Line(
        points={{62,-16},{84,-16},{84,46},{0.1,46},{0.1,140.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1ValHeaWatInlIso, bus.heatingInletValveBus.y1)
    annotation (Line(points={{62,68},{72,68},{72,118},{24,118},{24,116},{0.1,116},
          {0.1,140.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1ValHeaWatOutIso, bus.heatingOutletValveBus.y1)
    annotation (Line(points={{62,66},{66,66},{66,70},{68,70},{68,112},{0.1,112},
          {0.1,140.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(con2.y, bus.heatPumpBus.TSet) annotation (Line(points={{-18,100},{0.1,
          100},{0.1,140.1}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.uOpeMod, integerPassThrough.u) annotation (Line(
      points={{0,140},{0,130},{-90,130},{-90,70},{-82,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integerPassThrough.y, intEqu.u1) annotation (Line(points={{-59,70},{-54,
          70},{-54,46},{-58,46},{-58,40},{-52,40}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{-58,20},{-58,24},{-52,24},
          {-52,32}}, color={255,127,0}));
  connect(mulOr.y, seqEveHea.u1Hea) annotation (Line(points={{-2,70},{30,70},{30,
          78},{38,78}}, color={255,0,255}));
  connect(intEqu.y, mulOr.u[1]) annotation (Line(points={{-28,40},{-22,40},{-22,
          56},{-32,56},{-32,67.6667},{-26,67.6667}}, color={255,0,255}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{-58,-30},{-58,-26},{-52,
          -26},{-52,-18}}, color={255,127,0}));
  connect(integerPassThrough.y, intEqu1.u1) annotation (Line(points={{-59,70},{-54,
          70},{-54,46},{-58,46},{-58,34},{-84,34},{-84,-10},{-52,-10}}, color={255,
          127,0}));
  connect(mulOr1.y, seqEveCoo.u1Coo) annotation (Line(points={{2,-10},{20,-10},{
          20,2},{38,2}}, color={255,0,255}));
  connect(intEqu1.y, mulOr1.u[1]) annotation (Line(points={{-28,-10},{-26,-10},
          {-26,-12.3333},{-22,-12.3333}},color={255,0,255}));
  connect(intEqu.y, not1.u) annotation (Line(points={{-28,40},{-2,40},{-2,6},{-36,
          6},{-36,20},{-30,20}}, color={255,0,255}));
  connect(not1.y, mulOr1.u[2]) annotation (Line(points={{-6,20},{-14,20},{-14,-10},
          {-22,-10}}, color={255,0,255}));
  connect(intEqu1.y, not2.u) annotation (Line(points={{-28,-10},{-28,-40},{-26,-40}},
        color={255,0,255}));
  connect(not2.y, mulOr.u[2]) annotation (Line(points={{-2,-40},{8,-40},{8,58},{
          -2,58},{-2,56},{-32,56},{-32,70},{-26,70}}, color={255,0,255}));
  connect(conInt2.y, intEqu2.u2) annotation (Line(points={{-58,-90},{-58,-86},{-52,
          -86},{-52,-78}}, color={255,127,0}));
  connect(integerPassThrough.y, intEqu2.u1) annotation (Line(points={{-59,70},{-54,
          70},{-54,46},{-58,46},{-58,34},{-84,34},{-84,-70},{-52,-70}}, color={255,
          127,0}));
  connect(intEqu2.y, not3.u) annotation (Line(points={{-28,-70},{-22,-70},{-22,-76},
          {-24,-76},{-24,-84},{-28,-84},{-28,-90},{-22,-90}}, color={255,0,255}));
  connect(not3.y, mulOr.u[3]) annotation (Line(points={{2,-90},{8,-90},{8,58},{
          -2,58},{-2,56},{-32,56},{-32,72.3333},{-26,72.3333}},
                                                             color={255,0,255}));
  connect(intEqu2.y, mulOr1.u[3]) annotation (Line(points={{-28,-70},{-22,-70},{
          -22,-54},{-32,-54},{-32,-28},{-22,-28},{-22,-7.66667}}, color={255,0,255}));
  connect(and2.y, bus.coolingInletValveBus.y1) annotation (Line(points={{122,
          0},{128,0},{128,14},{0.1,14},{0.1,140.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and1.y, bus.coolingOutletValveBus.y1) annotation (Line(points={{122,
          -30},{132,-30},{132,134},{0.1,134},{0.1,140.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(and3.y, bus.wseInletValveBus.y1) annotation (Line(points={{122,-60},
          {128,-60},{128,-46},{26,-46},{26,64},{0.1,64},{0.1,140.1}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and4.y, bus.wseOutletValveBus.y1) annotation (Line(points={{122,-90},
          {128,-90},{128,-76},{22,-76},{22,62},{0.1,62},{0.1,140.1}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1ValChiWatInlIso, and2.u1) annotation (Line(points={{62,-8},
          {90,-8},{90,0},{98,0}}, color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatInlIso, and3.u1) annotation (Line(points={{62,-8},
          {90,-8},{90,-60},{98,-60}}, color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatOutIso, and1.u1) annotation (Line(points={{62,-10},
          {92,-10},{92,-30},{98,-30}}, color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatOutIso, and4.u1) annotation (Line(points={{62,-10},
          {92,-10},{92,-90},{98,-90}}, color={255,0,255}));
  connect(intEqu1.y, and3.u2) annotation (Line(points={{-28,-10},{-28,-26},{24,-26},
          {24,-68},{98,-68}}, color={255,0,255}));
  connect(intEqu1.y, and4.u2) annotation (Line(points={{-28,-10},{-28,-26},{24,-26},
          {24,-68},{88,-68},{88,-98},{98,-98}}, color={255,0,255}));
  connect(intEqu2.y, and2.u2) annotation (Line(points={{-28,-70},{-22,-70},{-22,
          -54},{-32,-54},{-32,-28},{86,-28},{86,-14},{98,-14},{98,-8}}, color={255,
          0,255}));
  connect(intEqu2.y, and1.u2) annotation (Line(points={{-28,-70},{-22,-70},{-22,
          -54},{-32,-54},{-32,-28},{86,-28},{86,-38},{98,-38}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,20},{150,-20}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-140},{140,140}})));
end ExternalEnergy;
