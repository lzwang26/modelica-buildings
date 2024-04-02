within Buildings.Templates.Plants.HeatPumps_PNNL;
model HeatpumpModelTest
  Components.HeatPumps.WaterToWater hp(is_rev=true,final dat=datHpWw)
    annotation (Placement(transformation(extent={{-4,4},{16,24}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    nPorts=1) annotation (Placement(transformation(extent={{-74,-16},{-54,4}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water, nPorts=
        1) annotation (Placement(transformation(extent={{68,6},{48,26}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    nPorts=1) annotation (Placement(transformation(extent={{64,-30},{44,-10}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1) annotation (Placement(transformation(extent={{-76,-44},{-56,-24}})));
  Components.Interfaces.Bus bus
    annotation (Placement(transformation(extent={{-14,32},{26,72}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-78,66},{-58,86}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-78,26},{-58,46}})));
  parameter Components.Data.HeatPump
                          datHpWw(
    final cpHeaWat_default=hpWw.cpHeaWat_default,
    final cpSou_default=hpWw.cpSou_default,
    final typ=hpWw.typ,
    final is_rev=hpWw.is_rev,
    final typMod=hpWw.typMod,
    mHeaWat_flow_nominal=datHpAw.capHea_nominal/abs(datHpAw.THeaWatSup_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWat_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHea_nominal=500E3,
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWat_flow_nominal=datHpAw.capCoo_nominal/abs(datHpAw.TChiWatSup_nominal -
        Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCoo_nominal=500E3,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCoo_nominal=Buildings.Templates.Data.Defaults.TSouHpCoo,
    TSouHea_nominal=Buildings.Templates.Data.Defaults.TSouHpHea,
    dpSouWwHea_nominal=Buildings.Templates.Data.Defaults.dpChiWatChi,
    mSouWwCoo_flow_nominal=datHpWw.mSouWwHea_flow_nominal,
    mSouWwHea_flow_nominal=datHpWw.mHeaWat_flow_nominal,
    perFit(hea(
        P=datHpAw.capHea_nominal/Buildings.Templates.Data.Defaults.COPHpWwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpHea), coo(
        P=datHpAw.capCoo_nominal/Buildings.Templates.Data.Defaults.COPHpWwCoo,
        coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
        coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpCoo)))
    "Reversible WWHP parameters parameters"
    annotation (Placement(transformation(extent={{48,54},{68,74}})));

equation
  connect(boundary.ports[1], hp.port_a) annotation (Line(points={{-54,-6},{-46,
          -6},{-46,-4},{-36,-4},{-36,14},{-4,14}},
                                 color={0,127,255}));
  connect(bou.ports[1], hp.port_b) annotation (Line(points={{48,16},{32,16},{32,
          14},{16,14}}, color={0,127,255}));
  connect(boundary1.ports[1], hp.port_aSou) annotation (Line(points={{44,-20},{
          32,-20},{32,4},{16,4}}, color={0,127,255}));
  connect(bou1.ports[1], hp.port_bSou) annotation (Line(points={{-56,-34},{-24,
          -34},{-24,4},{-4,4}}, color={0,127,255}));
  connect(hp.bus, bus) annotation (Line(
      points={{6,24},{6,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, bus.y) annotation (Line(points={{-57,76},{-22,76},{-22,52},{
          6,52}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, bus.TSet) annotation (Line(points={{-57,36},{-24,36},{-24,
          52},{6,52}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatpumpModelTest;
