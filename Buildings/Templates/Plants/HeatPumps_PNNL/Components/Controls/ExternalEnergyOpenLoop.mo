within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ExternalEnergyOpenLoop
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={{-20,120},
            {20,160}}),          iconTransformation(extent={{-10,90},{10,110}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
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
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi1
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=false)
    annotation (Placement(transformation(extent={{-88,40},{-68,60}})));
  CoolingTowerControl coolingTowerControl
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(period=2*1300, shift=
        1600)
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=273.15 + 24)
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul1(period=2*1300, shift=
       1600)
    annotation (Placement(transformation(extent={{-92,-110},{-72,-90}})));
  Buildings.Controls.OBC.CDL.Integers.OnCounter onCouInt
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=3)
    annotation (Placement(transformation(extent={{-20,-130},{0,-110}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
equation
  connect(logSwi.y, seqEveHea.u1Hea) annotation (Line(points={{12,70},{30,70},{30,
          78},{38,78}}, color={255,0,255}));
  connect(logSwi1.y, seqEveCoo.u1Coo) annotation (Line(points={{12,-10},{30,-10},
          {30,2},{38,2}},     color={255,0,255}));
  connect(con.y, logSwi.u1) annotation (Line(points={{-66,80},{-18,80},{-18,78},
          {-12,78}}, color={255,0,255}));
  connect(con1.y, logSwi.u3) annotation (Line(points={{-66,50},{-12,50},{-12,62}},
                     color={255,0,255}));
  connect(con.y, logSwi1.u1) annotation (Line(points={{-66,80},{-18,80},{-18,-2},
          {-12,-2}},  color={255,0,255}));
  connect(con1.y, logSwi1.u3) annotation (Line(points={{-66,50},{-36,50},{-36,-10},
          {-26,-10},{-26,-18},{-12,-18}},
                      color={255,0,255}));
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
  connect(seqEveCoo.y1ValChiWatOutIso, bus.coolingOutletValveBus.y1)
    annotation (Line(points={{62,-10},{68,-10},{68,12},{0.1,12},{0.1,140.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1ValChiWatInlIso, bus.coolingInletValveBus.y1)
    annotation (Line(points={{62,-8},{66,-8},{66,10},{0.1,10},{0.1,140.1}},
                                                                          color=
         {255,0,255}), Text(
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
  connect(con1.y, onCouInt.reset) annotation (Line(points={{-66,50},{-36,50},{-36,
          -62},{-10,-62}}, color={255,0,255}));
  connect(onCouInt.y, intEqu.u1)
    annotation (Line(points={{2,-50},{18,-50}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{2,-80},{10,-80},{10,-58},
          {18,-58}}, color={255,127,0}));
  connect(intEqu.y, and2.u1)
    annotation (Line(points={{42,-50},{58,-50}}, color={255,0,255}));
  connect(booPul.y, and2.u2) annotation (Line(points={{-68,10},{-34,10},{-34,-34},
          {50,-34},{50,-58},{58,-58}}, color={255,0,255}));
  connect(and2.y, logSwi.u2) annotation (Line(points={{82,-50},{90,-50},{90,-28},
          {-30,-28},{-30,70},{-12,70}}, color={255,0,255}));
  connect(or2.y, onCouInt.trigger)
    annotation (Line(points={{-38,-50},{-22,-50}}, color={255,0,255}));
  connect(or2.u1, edg.y) annotation (Line(points={{-62,-50},{-68,-50},{-68,-30}},
        color={255,0,255}));
  connect(falEdg.y, or2.u2) annotation (Line(points={{-68,-70},{-68,-58},{-62,-58}},
        color={255,0,255}));
  connect(booPul.y, falEdg.u) annotation (Line(points={{-68,10},{-60,10},{-60,-12},
          {-96,-12},{-96,-70},{-92,-70}}, color={255,0,255}));
  connect(booPul.y, edg.u) annotation (Line(points={{-68,10},{-60,10},{-60,-12},
          {-96,-12},{-96,-30},{-92,-30}}, color={255,0,255}));
  connect(onCouInt.y, intEqu1.u1) annotation (Line(points={{2,-50},{14,-50},{14,
          -90},{18,-90}}, color={255,127,0}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{2,-120},{14,-120},{14,
          -98},{18,-98}}, color={255,127,0}));
  connect(and1.u1, intEqu1.y)
    annotation (Line(points={{58,-90},{42,-90}}, color={255,0,255}));
  connect(booPul1.y, and1.u2) annotation (Line(points={{-70,-100},{8,-100},{8,
          -110},{48,-110},{48,-98},{58,-98}}, color={255,0,255}));
  connect(and1.y, logSwi1.u2) annotation (Line(points={{82,-90},{92,-90},{92,-22},
          {-24,-22},{-24,-10},{-12,-10}}, color={255,0,255}));
  connect(con1.y, bus.wseInletValveBus.y1) annotation (Line(points={{-66,50},
          {-58,50},{-58,140.1},{0.1,140.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(con1.y, bus.wseOutletValveBus.y1) annotation (Line(points={{-66,50},
          {-58,50},{-58,140},{-24,140},{-24,116},{0.1,116},{0.1,140.1}}, color={
          255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-140},{100,140}})));
end ExternalEnergyOpenLoop;
