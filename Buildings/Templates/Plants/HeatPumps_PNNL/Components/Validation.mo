within Buildings.Templates.Plants.HeatPumps_PNNL.Components;
package Validation

  extends Modelica.Icons.ExamplesPackage;

  model HeatPumpPlant_Hydronics
    extends Modelica.Icons.Example;
    parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal = 0.1
      "Nominal flowrate in primary energy loop";
    parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal_junctions[3] = {0.1, 0.1, -0.2}
      "Nominal flowrate in primary energy loop for junctions";
    parameter Modelica.Units.SI.Pressure p_priEnergyFlow_nominal = 1
      "Nominal pressure in primary energy loop";
    parameter Modelica.Units.SI.Pressure p_priEnergyFlow_nominal_junctions[3] = {0, 0, 0}
      "Nominal pressure in primary energy loop for junctions";

    Fluid.FixedResistances.Junction jun(redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
          origin={140,110})));
    Fluid.Movers.Preconfigured.FlowControlled_dp mov(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-140,140},{-120,160}})));
    Fluid.FixedResistances.Junction jun1(redeclare package Medium = Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{90,100},{110,120}})));
    Fluid.FixedResistances.Junction jun2(redeclare package Medium = Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
    Fluid.FixedResistances.Junction jun3(redeclare package Medium = Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={-160,110})));
    Fluid.FixedResistances.Junction jun4(redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={140,40})));
    Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={140,80})));
    Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium =
          Media.Water,
          m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={100,0})));
    Fluid.FixedResistances.Junction jun5(redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={100,-40})));
    Fluid.Movers.Preconfigured.FlowControlled_dp mov1(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{60,30},{80,50}})));
    Fluid.FixedResistances.Junction jun6(redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{170,30},{190,50}})));
    Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={180,0})));
    Fluid.FixedResistances.Junction jun7(redeclare package Medium = Media.Water,
    m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={180,-40})));
    Fluid.FixedResistances.PressureDrop
                                res(redeclare package Medium = Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{80,140},{100,160}})));
    Fluid.Movers.Preconfigured.FlowControlled_dp mov2(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-70,40})));
    Fluid.FixedResistances.Junction jun8(redeclare package Medium = Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-112,40})));
    Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={-110,80})));
    Fluid.Actuators.Valves.TwoWayLinear val4(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={-160,0})));
    Fluid.FixedResistances.Junction jun9(redeclare package Medium = Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-160,-40})));
    Fluid.FixedResistances.Junction jun10(redeclare package Medium =
          Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-200,30},{-180,50}})));
    Fluid.FixedResistances.Junction jun11(redeclare package Medium =
          Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-190,-40})));
    Fluid.Actuators.Valves.TwoWayLinear val5(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={-198,4})));
    Fluid.Actuators.Valves.TwoWayLinear val6(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={250,0})));
    Fluid.FixedResistances.Junction jun12(redeclare package Medium =
          Media.Water,                                                            m_flow_nominal=m_priEnergyFlow_nominal_junctions,
      dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{240,30},{260,50}})));
    Fluid.FixedResistances.Junction jun13(redeclare package Medium =
          Media.Water,                                                            m_flow_nominal=m_priEnergyFlow_nominal_junctions,
    dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={250,-40})));
    Fluid.Movers.Preconfigured.FlowControlled_dp mov3(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{280,30},{300,50}})));
    Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water,
      p=300000,                   nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={330,-40})));
    Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water,
      p=370000,                    nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={330,40})));
    Fluid.FixedResistances.Junction jun14(redeclare package Medium =
          Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-260,-40})));
    Fluid.FixedResistances.Junction jun15(redeclare package Medium =
          Media.Water,
        m_flow_nominal=m_priEnergyFlow_nominal_junctions, dp_nominal = p_priEnergyFlow_nominal_junctions)
      annotation (Placement(transformation(extent={{-270,30},{-250,50}})));
    Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dpValve_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
          origin={-260,0})));
    Fluid.Movers.Preconfigured.FlowControlled_dp mov4(redeclare package Medium =
          Media.Water, m_flow_nominal=m_priEnergyFlow_nominal, dp_nominal = p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-300,40})));
    Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Media.Water,
      p=370000,                    nPorts=1)
      annotation (Placement(transformation(extent={{-350,30},{-330,50}})));
    Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water,
      p=300000,                                                            nPorts=
         1)
      annotation (Placement(transformation(extent={{-350,-50},{-330,-30}})));
    Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
      annotation (Placement(transformation(extent={{200,-100},{220,-80}})));
    Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
      annotation (Placement(transformation(extent={{240,-100},{260,-80}})));
    Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=-1)
      annotation (Placement(transformation(extent={{-170,-100},{-150,-80}})));
    Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
      annotation (Placement(transformation(extent={{-130,-100},{-110,-80}})));
    Fluid.FixedResistances.PressureDrop
                                res1(
      redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal,
      dp_nominal=p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-38,30},{-18,50}})));
    Fluid.FixedResistances.PressureDrop
                                res2(
      redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal,
      dp_nominal=p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{16,34},{36,54}})));
    Fluid.FixedResistances.PressureDrop
                                res3(
      redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal,
      dp_nominal=p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{-234,32},{-214,52}})));
    Fluid.FixedResistances.PressureDrop
                                res4(
      redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal,
      dp_nominal=p_priEnergyFlow_nominal)
      annotation (Placement(transformation(extent={{206,30},{226,50}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{-218,70},{-198,90}})));
    Modelica.Blocks.Sources.Constant const1(k=1)
      annotation (Placement(transformation(extent={{158,136},{178,156}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{-98,170},{-78,190}})));
    Modelica.Blocks.Sources.Constant const3(k=70000)
      annotation (Placement(transformation(extent={{-168,172},{-148,192}})));
    Modelica.Blocks.Sources.Constant const4(k=1)
      annotation (Placement(transformation(extent={{-332,-10},{-312,10}})));
    Modelica.Blocks.Sources.Constant const5(k=1)
      annotation (Placement(transformation(extent={{-106,-8},{-86,12}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{230,86},{250,106}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{30,70},{50,90}})));
  equation
    connect(jun1.port_2, jun.port_3)
      annotation (Line(points={{110,110},{130,110}},
                                                 color={0,127,255}));
    connect(jun2.port_2, jun1.port_1)
      annotation (Line(points={{-100,110},{90,110}},
                                                  color={0,127,255}));
    connect(jun3.port_3, jun2.port_1)
      annotation (Line(points={{-150,110},{-120,110}},
                                                   color={0,127,255}));
    connect(jun3.port_2, mov.port_a) annotation (Line(points={{-160,120},{-160,150},
            {-140,150}},        color={0,127,255}));
    connect(jun4.port_3, val.port_b)
      annotation (Line(points={{140,50},{140,70}},color={0,127,255}));
    connect(val.port_a, jun.port_2)
      annotation (Line(points={{140,90},{140,100}},color={0,127,255}));
    connect(val1.port_a, jun1.port_3)
      annotation (Line(points={{100,10},{100,100}},
                                                  color={0,127,255}));
    connect(jun5.port_3, val1.port_b)
      annotation (Line(points={{100,-30},{100,-10}},
                                                color={0,127,255}));
    connect(mov1.port_b, jun4.port_2)
      annotation (Line(points={{80,40},{130,40}},color={0,127,255}));
    connect(jun4.port_1, jun6.port_1)
      annotation (Line(points={{150,40},{170,40}},color={0,127,255}));
    connect(val2.port_a, jun6.port_3)
      annotation (Line(points={{180,10},{180,30}},          color={0,127,255}));
    connect(jun5.port_1, jun7.port_2)
      annotation (Line(points={{110,-40},{170,-40}},color={0,127,255}));
    connect(jun7.port_3, val2.port_b)
      annotation (Line(points={{180,-30},{180,-10}},
                                                  color={0,127,255}));
    connect(mov.port_b,res. port_a)
      annotation (Line(points={{-120,150},{80,150}}, color={0,127,255}));
    connect(res.port_b, jun.port_1)
      annotation (Line(points={{100,150},{140,150},{140,120}},
                                                            color={0,127,255}));
    connect(jun8.port_1, mov2.port_b)
      annotation (Line(points={{-102,40},{-80,40}},  color={0,127,255}));
    connect(jun8.port_3, val3.port_b)
      annotation (Line(points={{-112,50},{-112,60},{-110,60},{-110,70}},
                                                      color={0,127,255}));
    connect(val3.port_a, jun2.port_3)
      annotation (Line(points={{-110,90},{-110,100}},  color={0,127,255}));
    connect(val4.port_a, jun3.port_1)
      annotation (Line(points={{-160,10},{-160,100}}, color={0,127,255}));
    connect(jun9.port_3, val4.port_b)
      annotation (Line(points={{-160,-30},{-160,-10}},
                                                    color={0,127,255}));
    connect(jun10.port_2, jun8.port_2)
      annotation (Line(points={{-180,40},{-122,40}}, color={0,127,255}));
    connect(jun11.port_1, jun9.port_2)
      annotation (Line(points={{-180,-40},{-170,-40}}, color={0,127,255}));
    connect(val5.port_a, jun10.port_3)
      annotation (Line(points={{-198,14},{-198,20},{-190,20},{-190,30}},
                                                     color={0,127,255}));
    connect(val5.port_b, jun11.port_3)
      annotation (Line(points={{-198,-6},{-198,-20},{-190,-20},{-190,-30}},
                                                    color={0,127,255}));
    connect(jun12.port_3, val6.port_a)
      annotation (Line(points={{250,30},{250,10}}, color={0,127,255}));
    connect(jun7.port_1, jun13.port_2)
      annotation (Line(points={{190,-40},{240,-40}}, color={0,127,255}));
    connect(jun13.port_3, val6.port_b)
      annotation (Line(points={{250,-30},{250,-10}},
                                                  color={0,127,255}));
    connect(jun12.port_2, mov3.port_a)
      annotation (Line(points={{260,40},{280,40}}, color={0,127,255}));
    connect(jun13.port_1, bou.ports[1])
      annotation (Line(points={{260,-40},{320,-40}}, color={0,127,255}));
    connect(mov3.port_b, bou1.ports[1])
      annotation (Line(points={{300,40},{320,40}}, color={0,127,255}));
    connect(jun14.port_1, jun11.port_2)
      annotation (Line(points={{-250,-40},{-200,-40}}, color={0,127,255}));
    connect(val7.port_a, jun15.port_3)
      annotation (Line(points={{-260,10},{-260,30}}, color={0,127,255}));
    connect(val7.port_b, jun14.port_3)
      annotation (Line(points={{-260,-10},{-260,-30}}, color={0,127,255}));
    connect(mov4.port_a, jun15.port_1)
      annotation (Line(points={{-290,40},{-270,40}}, color={0,127,255}));
    connect(bou2.ports[1], mov4.port_b)
      annotation (Line(points={{-330,40},{-310,40}}, color={0,127,255}));
    connect(bou3.ports[1], jun14.port_2)
      annotation (Line(points={{-330,-40},{-270,-40}}, color={0,127,255}));
    connect(gai.u, val2.y_actual) annotation (Line(points={{198,-90},{194,-90},{194,
            -5},{187,-5}}, color={0,0,127}));
    connect(gai.y, addPar.u)
      annotation (Line(points={{222,-90},{238,-90}}, color={0,0,127}));
    connect(addPar.y, val6.y) annotation (Line(points={{262,-90},{280,-90},{280,0},
            {262,0}}, color={0,0,127}));
    connect(val.y_actual, val1.y) annotation (Line(points={{147,75},{147,60},{120,
            60},{120,0},{112,0}}, color={0,0,127}));
    connect(val3.y_actual, val4.y) annotation (Line(points={{-103,75},{-103,60},{-140,
            60},{-140,0},{-148,0}}, color={0,0,127}));
    connect(gai1.y, addPar1.u)
      annotation (Line(points={{-148,-90},{-132,-90}}, color={0,0,127}));
    connect(addPar1.y, val7.y) annotation (Line(points={{-108,-90},{-100,-90},{-100,
            -120},{-240,-120},{-240,0},{-248,0}}, color={0,0,127}));
    connect(val5.y_actual, gai1.u) annotation (Line(points={{-191,-1},{-191,-12},
            {-176,-12},{-176,-90},{-172,-90}},color={0,0,127}));
    connect(mov2.port_a, res1.port_a)
      annotation (Line(points={{-60,40},{-38,40}}, color={0,127,255}));
    connect(res1.port_b, jun9.port_1) annotation (Line(points={{-18,40},{-18,-38},
            {-150,-38},{-150,-40}}, color={0,127,255}));
    connect(res2.port_b, mov1.port_a) annotation (Line(points={{36,44},{46,44},{
            46,40},{60,40}}, color={0,127,255}));
    connect(res2.port_a, jun5.port_2) annotation (Line(points={{16,44},{16,24},{2,
            24},{2,-40},{90,-40}}, color={0,127,255}));
    connect(jun15.port_2, res3.port_a) annotation (Line(points={{-250,40},{-242,
            40},{-242,42},{-234,42}}, color={0,127,255}));
    connect(res3.port_b, jun10.port_1) annotation (Line(points={{-214,42},{-208,
            42},{-208,40},{-200,40}}, color={0,127,255}));
    connect(jun6.port_2, res4.port_a) annotation (Line(points={{190,40},{206,40}},
                                color={0,127,255}));
    connect(res4.port_b, jun12.port_1) annotation (Line(points={{226,40},{240,40}},
                                color={0,127,255}));
    connect(const.y, val5.y) annotation (Line(points={{-197,80},{-182,80},{-182,
            76},{-180,76},{-180,4},{-186,4}}, color={0,0,127}));
    connect(const1.y, val2.y) annotation (Line(points={{179,146},{202,146},{202,0},
            {192,0}}, color={0,0,127}));
    connect(const1.y, val.y) annotation (Line(points={{179,146},{188,146},{188,80},
            {152,80}}, color={0,0,127}));
    connect(const2.y, val3.y) annotation (Line(points={{-77,180},{-64,180},{-64,
            80},{-98,80}}, color={0,0,127}));
    connect(const3.y, mov.dp_in) annotation (Line(points={{-147,182},{-138,182},{
            -138,172},{-130,172},{-130,162}}, color={0,0,127}));
    connect(const4.y, mov4.dp_in)
      annotation (Line(points={{-311,0},{-300,0},{-300,28}}, color={0,0,127}));
    connect(const5.y, mov2.dp_in) annotation (Line(points={{-85,2},{-76,2},{-76,
            28},{-70,28}}, color={0,0,127}));
    connect(const6.y, mov3.dp_in)
      annotation (Line(points={{251,96},{290,96},{290,52}}, color={0,0,127}));
    connect(const7.y, mov1.dp_in)
      annotation (Line(points={{51,80},{70,80},{70,52}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-360,-200},{360,200}})));
  end HeatPumpPlant_Hydronics;

  model ValvesIsolation_Test
    "Validation model for isolation valve component"

    extends Modelica.Icons.Example;
    parameter Buildings.Templates.Plants.HeatPumps.Types.Controller typCtl=
      Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop;
    replaceable package Medium=Buildings.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium
      "CHW/HW medium";
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Evaluate=true,
      Dialog(tab="Dynamics",group="Conservation equations"));
    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlHeaInl(
      cfg(
        have_pumHeaWatPriVar=true,
        have_pumChiWatPriVar=false,
        have_inpSch=false,
        have_hrc=false,
        have_valHpOutIso=valIsoHeaInl.have_valHpOutIso,
        have_valHpInlIso=valIsoHeaInl.have_valHpInlIso,
        have_chiWat=valIsoHeaInl.have_chiWat,
        have_pumChiWatPriDed=valIsoHeaInl.have_pumChiWatPriDed,
        typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
        typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
        is_rev=false,
        typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
        nPumChiWatSec=0,
        rhoHeaWat_default=Buildings.Media.Water.d_const,
        typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
        typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
        rhoChiWat_default=Buildings.Media.Water.d_const,
        cpChiWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        have_hotWat=false,
        have_valChiWatMinByp=false,
        have_valHeaWatMinByp=false,
        typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
        cpHeaWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        cpSou_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        have_senDpChiWatRemWir=true,
        typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
        nHp=2,
        nPumHeaWatPri=2,
        have_heaWat=true,
        nPumHeaWatSec=0,
        rhoSou_default=Buildings.Media.Air.dStp,
        have_senDpHeaWatRemWir=true,
        typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        nPumChiWatPri=0,
        nSenDpHeaWatRem=0,
        nSenDpChiWatRem=0,
        nAirHan=0,
        nEquZon=0),
      THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
          dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlHeaInl.cfg.nSenDpChiWatRem),
      dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlHeaInl.cfg.nSenDpHeaWatRem),
      staEqu={fill(1, datCtlHeaInl.cfg.nHp)})
      "Controller parameters"
      annotation (Placement(transformation(extent={{-56,360},{-36,380}})));
    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHp(
      final nHp=2,
      final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
      final is_rev=true,
      final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
      mHeaWatHp_flow_nominal=datHp.capHeaHp_nominal / abs(datHp.THeaWatSupHp_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
      capHeaHp_nominal=500E3,
      THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
      mChiWatHp_flow_nominal=datHp.capCooHp_nominal / abs(datHp.TChiWatSupHp_nominal -
        Buildings.Templates.Data.Defaults.TChiWatRet) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      capCooHp_nominal=500E3,
      TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
      TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
      perFitHp(
        hea(
          P=datHp.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
          coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
          coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
          TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow),
        coo(
          P=datHp.capCooHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwCoo,
          coeQ={- 2.2545246871, 6.9089257665, - 3.6548225094, 0, 0},
          coeP={- 5.8086010402, 1.6894933858, 5.1167787436, 0, 0},
          TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
      "HP parameters"
      annotation (Placement(transformation(extent={{-264,360},{-244,380}})));
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.ValvesIsolation_UpdatePorts
      valIsoHeaInl(
      redeclare final package Medium = Medium,
      nHp=2,
      have_chiWat=true,
      have_pumChiWatPriDed=false,
      have_valHpInlIso=true,
      have_valHpOutIso=false,
      final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal,
          valIsoHeaInl.nHp),
      dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
      mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
      final energyDynamics=energyDynamics,
      y_start=0)
      "Isolation valves - Heating-only system with isolation valves at HP inlet"
      annotation (Placement(transformation(extent={{-18,262},{24,304}})));

    Fluid.FixedResistances.PressureDrop hpHea[valIsoHeaInl.nHp](
      redeclare each final package Medium=Medium,
      m_flow_nominal=valIsoHeaInl.mHeaWatHp_flow_nominal,
      dp_nominal=fill(0, valIsoHeaInl.nHp))
      "Heat pump HX with zero fluid resistance: pressure drop computed in valve component"
      annotation (Placement(transformation(extent={{2,206},{-18,226}})));
    Fluid.Sources.Boundary_pT retHeaWat1(
      redeclare final package Medium=Medium,
      p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
      T=Buildings.Templates.Data.Defaults.THeaWatRetMed,
      nPorts=1) "Boundary condition at HW return"
      annotation (Placement(transformation(extent={{-254,314},{-234,334}})));
    Fluid.Sources.Boundary_pT supHeaWat1(
      redeclare final package Medium=Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      nPorts=1) "Boundary condition at HW supply"
      annotation (Placement(transformation(extent={{-254,282},{-234,302}})));
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoop ctlHeaInl(
      final cfg=datCtlHeaInl.cfg,
      final dat=datCtlHeaInl)
      "Plant controller"
      annotation (Placement(transformation(extent={{-6,360},{-26,380}})));
    Fluid.FixedResistances.PressureDrop hpCoo[valIsoHeaInl.nHp](
      redeclare each final package Medium = Medium,
      m_flow_nominal=valIsoHeaInl.mHeaWatHp_flow_nominal,
      dp_nominal=fill(0, valIsoHeaInl.nHp))
      "Heat pump HX with zero fluid resistance: pressure drop computed in valve component"
      annotation (Placement(transformation(extent={{42,206},{22,226}})));
    Fluid.Sources.Boundary_pT retChiWat(
      redeclare final package Medium = Medium,
      p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
      T=287.15,
      nPorts=1) "Boundary condition at HW return"
      annotation (Placement(transformation(extent={{116,276},{96,296}})));
    Fluid.Sources.Boundary_pT supChiWat(
      redeclare final package Medium = Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      T=279.85,
      nPorts=1) "Boundary condition at HW supply"
      annotation (Placement(transformation(extent={{116,304},{96,324}})));
  equation
    connect(retHeaWat1.ports[1], valIsoHeaInl.port_aHeaWat)
      annotation (Line(points={{-234,324},{-226,324},{-226,298.54},{-18,298.54}},
                                                                         color={0,127,255}));
    connect(valIsoHeaInl.port_bHeaWat, supHeaWat1.ports[1])
      annotation (Line(points={{-18,289.51},{-226,289.51},{-226,292},{-234,292}},
                                                                         color={0,127,255}));
    connect(ctlHeaInl.bus, valIsoHeaInl.bus)
      annotation (Line(points={{-6,370},{2.6,370},{2.6,302.53}},
                                                             color={255,204,51},thickness=0.5));
    connect(hpHea.port_b, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(points=
           {{-18,216},{-16,216},{-16,262.21},{-12.6,262.21}}, color={0,127,255}));
    connect(hpHea.port_a, valIsoHeaInl.ports_bHeaWatHp) annotation (Line(points=
           {{2,216},{0,216},{0,262.21},{-2,262.21}}, color={0,127,255}));
    connect(hpCoo.port_b, valIsoHeaInl.ports_aChiWatHp) annotation (Line(points=
           {{22,216},{8,216},{8,262.42},{8.6,262.42}}, color={0,127,255}));
    connect(hpCoo.port_a, valIsoHeaInl.ports_bChiWatHp) annotation (Line(points=
           {{42,216},{58,216},{58,262.21},{18.8,262.21}}, color={0,127,255}));
    connect(retChiWat.ports[1], valIsoHeaInl.port_aChiWat) annotation (Line(
          points={{96,286},{60,286},{60,288.88},{24,288.88}}, color={0,127,255}));
    connect(supChiWat.ports[1], valIsoHeaInl.port_bChiWat) annotation (Line(
          points={{96,314},{60,314},{60,298.12},{24,298.12}}, color={0,127,255}));
    annotation (
      __Dymola_Commands(
        file=
          "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/ValvesIsolation.mos"
          "Simulate and plot"),
      experiment(
        Tolerance=1e-6,
        StopTime=5000.0),
      Diagram(
        coordinateSystem(
          extent={{-300,-400},{300,400}})),
      Documentation(revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>",   info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation\">
Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation</a>
for the following configurations.
</p>
<ul>
<li>
Heating and cooling system with common dedicated primary HW and CHW pumps
and isolation valves at both heat pump inlet and outlet: 
component <code>valIsoCom</code>.
</li>
<li>
Heating-only system with isolation valves at heat pump inlet: 
component <code>valIsoHeaInl</code>.
</li>
<li>
Heating and cooling system with separate dedicated primary HW and CHW pumps
and isolation valves at heat pump inlet: 
component <code>valIsoSep</code>.
</li>
</ul>
<p>
In each configuration, two identical heat pumps are represented by fixed 
flow resistances (components <code>hp*</code>). 
</p>
<p>
The model uses open loop controls and the simulation allows verifying that design 
flow is obtained in each loop and each heat pump when the valves are open.
</p>
</html>"));
  end ValvesIsolation_Test;

  model ValvesIsolation_HeatPump



    extends Modelica.Icons.Example;
    parameter Buildings.Templates.Plants.HeatPumps.Types.Controller typCtl=
      Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop;
    replaceable package Medium=Buildings.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium
      "CHW/HW medium";
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Evaluate=true,
      Dialog(tab="Dynamics",group="Conservation equations"));
    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlHeaInl(
      cfg(
        have_pumHeaWatPriVar=true,
        have_pumChiWatPriVar=false,
        have_inpSch=false,
        have_hrc=false,
        have_valHpOutIso=valIsoHeaInl.have_valHpOutIso,
        have_valHpInlIso=valIsoHeaInl.have_valHpInlIso,
        have_chiWat=valIsoHeaInl.have_chiWat,
        have_pumChiWatPriDed=valIsoHeaInl.have_pumChiWatPriDed,
        typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
        typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
        is_rev=false,
        typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
        nPumChiWatSec=0,
        rhoHeaWat_default=Buildings.Media.Water.d_const,
        typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
        typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
        rhoChiWat_default=Buildings.Media.Water.d_const,
        cpChiWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        have_hotWat=false,
        have_valChiWatMinByp=false,
        have_valHeaWatMinByp=false,
        typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
        cpHeaWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        cpSou_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        have_senDpChiWatRemWir=true,
        typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
        nHp=2,
        nPumHeaWatPri=2,
        have_heaWat=true,
        nPumHeaWatSec=0,
        rhoSou_default=Buildings.Media.Air.dStp,
        have_senDpHeaWatRemWir=true,
        typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        nPumChiWatPri=0,
        nSenDpHeaWatRem=0,
        nSenDpChiWatRem=0,
        nAirHan=0,
        nEquZon=0),
      THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
          dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlHeaInl.cfg.nSenDpChiWatRem),
      dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlHeaInl.cfg.nSenDpHeaWatRem),
      staEqu={fill(1, datCtlHeaInl.cfg.nHp)})
      "Controller parameters"
      annotation (Placement(transformation(extent={{-56,360},{-36,380}})));
    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHp(
      final nHp=2,
      final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
      final is_rev=true,
      final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
      mHeaWatHp_flow_nominal=datHp.capHeaHp_nominal / abs(datHp.THeaWatSupHp_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
      capHeaHp_nominal=500E3,
      THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
      mChiWatHp_flow_nominal=datHp.capCooHp_nominal / abs(datHp.TChiWatSupHp_nominal -
        Buildings.Templates.Data.Defaults.TChiWatRet) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      capCooHp_nominal=500E3,
      TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
      TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
      perFitHp(
        hea(
          P=datHp.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
          coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
          coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
          TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow),
        coo(
          P=datHp.capCooHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwCoo,
          coeQ={- 2.2545246871, 6.9089257665, - 3.6548225094, 0, 0},
          coeP={- 5.8086010402, 1.6894933858, 5.1167787436, 0, 0},
          TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
      "HP parameters"
      annotation (Placement(transformation(extent={{-264,360},{-244,380}})));
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.ValvesIsolation_UpdatePorts
      valIsoHeaInl(
      redeclare final package Medium = Medium,
      nHp=2,
      have_chiWat=true,
      have_pumChiWatPriDed=false,
      have_valHpInlIso=true,
      have_valHpOutIso=false,
      final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal,
          valIsoHeaInl.nHp),
      dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
      mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
      final energyDynamics=energyDynamics,
      y_start=0)
      "Isolation valves - Heating-only system with isolation valves at HP inlet"
      annotation (Placement(transformation(extent={{-18,262},{24,304}})));

    Fluid.Sources.Boundary_pT retHeaWat1(
      redeclare final package Medium=Medium,
      p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
      T=Buildings.Templates.Data.Defaults.THeaWatRetMed,
      nPorts=1) "Boundary condition at HW return"
      annotation (Placement(transformation(extent={{-254,314},{-234,334}})));
    Fluid.Sources.Boundary_pT supHeaWat1(
      redeclare final package Medium=Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      nPorts=1) "Boundary condition at HW supply"
      annotation (Placement(transformation(extent={{-254,280},{-234,300}})));
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoop ctlHeaInl(
      final cfg=datCtlHeaInl.cfg,
      final dat=datCtlHeaInl)
      "Plant controller"
      annotation (Placement(transformation(extent={{-6,360},{-26,380}})));
    Fluid.Sources.Boundary_pT retChiWat(
      redeclare final package Medium = Medium,
      p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
      T=Buildings.Templates.Data.Defaults.THeaWatRetMed,
      nPorts=1) "Boundary condition at HW return"
      annotation (Placement(transformation(extent={{116,276},{96,296}})));
    Fluid.Sources.Boundary_pT supChiWat(
      redeclare final package Medium = Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      nPorts=1) "Boundary condition at HW supply"
      annotation (Placement(transformation(extent={{116,304},{96,324}})));
    Fluid.HeatPumps.EquationFitReversible heaPum[valIsoHeaInl.nHp](
    redeclare each final package Medium1 = Medium,
    redeclare each final package Medium2 = Medium,
    per = per)
      annotation (Placement(transformation(extent={{-50,190},{-30,210}})));
    parameter Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240
                                                            per[valIsoHeaInl.nHp]
     "Reverse heat pump performance data"
     annotation (Placement(transformation(extent={{152,356},{172,376}})));
  equation
    connect(retHeaWat1.ports[1], valIsoHeaInl.port_aHeaWat)
      annotation (Line(points={{-234,324},{-226,324},{-226,298.54},{-18,298.54}},
                                                                         color={0,127,255}));
    connect(valIsoHeaInl.port_bHeaWat, supHeaWat1.ports[1])
      annotation (Line(points={{-18,289.51},{-226,289.51},{-226,290},{-234,290}},
                                                                         color={0,127,255}));
    connect(ctlHeaInl.bus, valIsoHeaInl.bus)
      annotation (Line(points={{-6,370},{2.6,370},{2.6,302.53}},
                                                             color={255,204,51},thickness=0.5));
    connect(retChiWat.ports[1], valIsoHeaInl.port_aChiWat) annotation (Line(
          points={{96,286},{60,286},{60,288.88},{24,288.88}}, color={0,127,255}));
    connect(supChiWat.ports[1], valIsoHeaInl.port_bChiWat) annotation (Line(
          points={{96,314},{60,314},{60,298.12},{24,298.12}}, color={0,127,255}));
    connect(heaPum.port_b1, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(points=
           {{-30,206},{-12,206},{-12,262.21},{-12.6,262.21}}, color={0,127,255}));
    connect(heaPum.port_a1, valIsoHeaInl.ports_bHeaWatHp) annotation (Line(points=
           {{-50,206},{-60,206},{-60,246},{0,246},{0,262.21},{-2,262.21}}, color={
            0,127,255}));
    connect(heaPum.port_b2, valIsoHeaInl.ports_aChiWatHp) annotation (Line(points=
           {{-50,194},{-60,194},{-60,172},{8.6,172},{8.6,262.42}}, color={0,127,255}));
    connect(heaPum.port_a2, valIsoHeaInl.ports_bChiWatHp) annotation (Line(points=
           {{-30,194},{18.8,194},{18.8,262.21}}, color={0,127,255}));
    annotation (
      __Dymola_Commands(
        file=
          "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/ValvesIsolation.mos"
          "Simulate and plot"),
      experiment(
        Tolerance=1e-6,
        StopTime=5000.0),
      Diagram(
        coordinateSystem(
          extent={{-300,-400},{300,400}})),
      Documentation(revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>",   info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation\">
Buildings.Templates.Plants.HeatPumps.Components.ValvesIsolation</a>
for the following configurations.
</p>
<ul>
<li>
Heating and cooling system with common dedicated primary HW and CHW pumps
and isolation valves at both heat pump inlet and outlet: 
component <code>valIsoCom</code>.
</li>
<li>
Heating-only system with isolation valves at heat pump inlet: 
component <code>valIsoHeaInl</code>.
</li>
<li>
Heating and cooling system with separate dedicated primary HW and CHW pumps
and isolation valves at heat pump inlet: 
component <code>valIsoSep</code>.
</li>
</ul>
<p>
In each configuration, two identical heat pumps are represented by fixed 
flow resistances (components <code>hp*</code>). 
</p>
<p>
The model uses open loop controls and the simulation allows verifying that design 
flow is obtained in each loop and each heat pump when the valves are open.
</p>
</html>"));
  end ValvesIsolation_HeatPump;

  model HeatPumpGroupWaterToWater
    "Validation model for heat pump group"
    extends Modelica.Icons.Example;
    replaceable package Medium=Buildings.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium
      "CHW/HW medium";
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Evaluate=true,
      Dialog(tab="Dynamics",group="Conservation equations"));
    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlPlaAwNrv(
      cfg(
        have_hrc = false,
        have_inpSch = false,
        have_chiWat=false,
        typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
        typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
        typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        have_pumHeaWatPriVar=true,
        have_pumChiWatPriVar=false,
        typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
        have_pumChiWatPriDed=false,
        nPumChiWatSec=0,
        rhoHeaWat_default=Buildings.Media.Water.d_const,
        typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
        is_rev=hpAwNrv.is_rev,
        typ=hpAwNrv.typ,
        rhoChiWat_default=Buildings.Media.Water.d_const,
        cpChiWat_default=hpAwNrv.cpChiWat_default,
        have_hotWat=false,
        have_valChiWatMinByp=false,
        have_valHeaWatMinByp=false,
        have_valHpInlIso=false,
        have_valHpOutIso=false,
        typMod=hpAwNrv.typMod,
        cpHeaWat_default=hpAwNrv.cpHeaWat_default,
        cpSou_default=hpAwNrv.cpSou_default,
        have_senDpChiWatRemWir=true,
        typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
        nHp=hpAwNrv.nHp,
        nPumHeaWatPri=hpAwNrv.nHp,
        have_heaWat=true,
        nPumHeaWatSec=0,
        rhoSou_default=Buildings.Media.Air.dStp,
        have_senDpHeaWatRemWir=true,
        typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        nPumChiWatPri=hpAwNrv.nHp,
        nSenDpHeaWatRem=1,
        nSenDpChiWatRem=1,
        nAirHan=0,
        nEquZon=0),
      THeaWatSup_nominal=datHpAwNrv.THeaWatSupHp_nominal,
      dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpChiWatRem),
      dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpHeaWatRem),
      staEqu={fill(1, hpAwNrv.nHp)})
      "Controller parameters"
      annotation (Placement(transformation(extent={{-260,40},{-240,60}})));

    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHpAwNrv(
      final cpHeaWat_default=hpAwNrv.cpHeaWat_default,
      final cpSou_default=hpAwNrv.cpSou_default,
      final nHp=hpAwNrv.nHp,
      final typ=hpAwNrv.typ,
      final is_rev=hpAwNrv.is_rev,
      final typMod=hpAwNrv.typMod,
      mHeaWatHp_flow_nominal=datHpAwNrv.capHeaHp_nominal / abs(datHpAwNrv.THeaWatSupHp_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
      capHeaHp_nominal=500E3,
      THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
      mSouWwHeaHp_flow_nominal=datHpAwNrv.capHeaHp_nominal/abs(datHpAwNrv.THeaWatSupHp_nominal
           - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpSouWwHeaHp_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpHeaWatHp,
      perFitHp(
        hea(
          P=datHpAwNrv.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
          coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
          coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
          TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow)))
      "Non-reversible AWHP parameters"
      annotation (Placement(transformation(extent={{-220,40},{-200,60}})));

    Fluid.Sources.Boundary_pT sup(
      redeclare final package Medium=Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      nPorts=hpAwNrv.nHp)
      "Boundary condition at distribution system supply"
      annotation (Placement(transformation(extent={{170,130},{150,150}})));
    Fluid.Sources.Boundary_pT inlHp1(
      redeclare final package Medium=Medium,
      use_p_in=false,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      use_T_in=false,
      nPorts=hpAwNrv.nHp)
      "Boundary conditions at HP inlet"
      annotation (Placement(transformation(extent={{-120,150},{-100,170}})));
    Fluid.Sensors.TemperatureTwoPort TRet1[hpAwNrv.nHp](
      redeclare each final package Medium=Medium,
      each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
      "Return temperature"
      annotation (Placement(transformation(extent={{-80,150},{-60,170}})));
    Fluid.Sensors.TemperatureTwoPort TSup1[hpAwNrv.nHp](
      redeclare each final package Medium=Medium,
      each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
      "Supply temperature"
      annotation (Placement(transformation(extent={{104,130},{124,150}})));
    Buildings.Templates.Plants.HeatPumps.Components.Controls.OpenLoop ctlPlaAwNrv(
      final cfg=datCtlPlaAwNrv.cfg,
      final dat=datCtlPlaAwNrv)
      "Plant controller"
      annotation (Placement(transformation(extent={{10,170},{-10,190}})));
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
      redeclare final package MediumHeaWat=Medium,
      nHp=3,
      is_rev=false,
      final dat=datHpAwNrv,
      final energyDynamics=energyDynamics)
      "Non reversible AWHP"
      annotation (Placement(transformation(extent={{280,40},{-200,120}})));
    Fluid.Sources.Boundary_pT inlHp2(
      redeclare final package Medium = Medium,
      use_p_in=false,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      use_T_in=false,
      nPorts=hpAwNrv.nHp)
      "Boundary conditions at HP inlet"
      annotation (Placement(transformation(extent={{82,-78},{102,-58}})));
    Fluid.Sensors.TemperatureTwoPort TRet2[hpAwNrv.nHp](redeclare each final
        package Medium = Medium, each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
      "Return temperature"
      annotation (Placement(transformation(extent={{56,-36},{76,-16}})));
    Fluid.Sources.Boundary_pT sup1(
      redeclare final package Medium = Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      nPorts=hpAwNrv.nHp)
      "Boundary condition at distribution system supply"
      annotation (Placement(transformation(extent={{18,-34},{-2,-14}})));
    Fluid.Sensors.TemperatureTwoPort TSup2[hpAwNrv.nHp](redeclare each final
        package Medium = Medium, each final m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
      "Supply temperature"
      annotation (Placement(transformation(extent={{-48,-34},{-28,-14}})));
  equation
    connect(ctlPlaAwNrv.bus, hpAwNrv.bus)
      annotation (Line(points={{10,180},{40,180},{40,120}},
                                                          color={255,204,51},thickness=0.5));
    connect(inlHp1.ports, TRet1.port_a)
      annotation (Line(points={{-100,160},{-80,160}},color={0,127,255}));
    connect(TRet1.port_b, hpAwNrv.ports_aChiHeaWat)
      annotation (Line(points={{-60,160},{-10,160},{-10,120}},color={0,127,255}));
    connect(hpAwNrv.ports_bChiHeaWat, TSup1.port_a)
      annotation (Line(points={{90,120},{90,140},{104,140}},
                                                           color={0,127,255}));
    connect(TSup1.port_b, sup.ports)
      annotation (Line(points={{124,140},{150,140}},
                                                   color={0,127,255}));
    connect(inlHp2.ports,TRet2. port_a)
      annotation (Line(points={{102,-68},{108,-68},{108,-42},{50,-42},{50,-26},
            {56,-26}},                               color={0,127,255}));
    connect(TRet2.port_b, hpAwNrv.ports_aSou)
      annotation (Line(points={{76,-26},{90,-26},{90,40}}, color={0,127,255}));
    connect(TSup2.port_b, sup1.ports)
      annotation (Line(points={{-28,-24},{-2,-24}}, color={0,127,255}));
    connect(TSup2.port_a, hpAwNrv.ports_bSou) annotation (Line(points={{-48,-24},
            {-54,-24},{-54,34},{-10,34},{-10,40.2}}, color={0,127,255}));
    annotation (
      Diagram(
        coordinateSystem(
          extent={{-300,-220},{300,220}})),
      __Dymola_Commands(
        file=
          "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
          "Simulate and plot"),
      experiment(
        Tolerance=1e-6,
        StartTime=10497600.0,
        StopTime=10505600.0),
      Documentation(
        info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater\">
Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater</a>
in a configuration in which the heat pump components are exposed
to a constant differential pressure and a varying
return temperature.
</p>
<p>
The model is configured to represent either a non-reversible heat pump
(component <code>hpAwNrv</code>) or a reversible heat pump
(component <code>hpAw</code>) that switches between cooling and heating
mode.
</p>
</html>",   revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
  end HeatPumpGroupWaterToWater;

  model IsolationValveAndHeatPumpGroupWW
    "Validation model for heat pump group"

    extends Modelica.Icons.Example;
    replaceable package Medium=Buildings.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium
      "CHW/HW medium";
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state"
      annotation (Evaluate=true,
      Dialog(tab="Dynamics",group="Conservation equations"));
    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlPlaAwNrv(
      cfg(
        have_hrc = false,
        have_inpSch = false,
        have_chiWat=false,
        typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
        typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
        typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        have_pumHeaWatPriVar=true,
        have_pumChiWatPriVar=false,
        typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
        have_pumChiWatPriDed=false,
        nPumChiWatSec=0,
        rhoHeaWat_default=Buildings.Media.Water.d_const,
        typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
        is_rev=hpAwNrv.is_rev,
        typ=hpAwNrv.typ,
        rhoChiWat_default=Buildings.Media.Water.d_const,
        cpChiWat_default=hpAwNrv.cpChiWat_default,
        have_hotWat=false,
        have_valChiWatMinByp=false,
        have_valHeaWatMinByp=false,
        have_valHpInlIso=false,
        have_valHpOutIso=false,
        typMod=hpAwNrv.typMod,
        cpHeaWat_default=hpAwNrv.cpHeaWat_default,
        cpSou_default=hpAwNrv.cpSou_default,
        have_senDpChiWatRemWir=true,
        typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
        nHp=hpAwNrv.nHp,
        nPumHeaWatPri=hpAwNrv.nHp,
        have_heaWat=true,
        nPumHeaWatSec=0,
        rhoSou_default=Buildings.Media.Air.dStp,
        have_senDpHeaWatRemWir=true,
        typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        nPumChiWatPri=hpAwNrv.nHp,
        nSenDpHeaWatRem=1,
        nSenDpChiWatRem=1,
        nAirHan=0,
        nEquZon=0),
      THeaWatSup_nominal=datHpAwNrv.THeaWatSupHp_nominal,
      dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpChiWatRem),
      dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpHeaWatRem),
      staEqu={fill(1, hpAwNrv.nHp)})
      "Controller parameters"
      annotation (Placement(transformation(extent={{-192,-192},{-172,-172}})));

    parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHpAwNrv(
      final cpHeaWat_default=hpAwNrv.cpHeaWat_default,
      final cpSou_default=hpAwNrv.cpSou_default,
      final nHp=hpAwNrv.nHp,
      final typ=hpAwNrv.typ,
      final is_rev=hpAwNrv.is_rev,
      final typMod=hpAwNrv.typMod,
      mHeaWatHp_flow_nominal=datHpAwNrv.capHeaHp_nominal / abs(datHpAwNrv.THeaWatSupHp_nominal -
        Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
      capHeaHp_nominal=500E3,
      THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
      mSouWwHeaHp_flow_nominal=datHpAwNrv.capHeaHp_nominal/abs(datHpAwNrv.THeaWatSupHp_nominal
           - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpSouWwHeaHp_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpHeaWatHp,
      perFitHp(
        hea(
          P=datHpAwNrv.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
          coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
          coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
          TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow)))
      "Non-reversible AWHP parameters"
      annotation (Placement(transformation(extent={{-150,-192},{-130,-172}})));

    Buildings.Templates.Plants.HeatPumps.Components.Controls.OpenLoop ctlPlaAwNrv(
      final cfg=datCtlPlaAwNrv.cfg,
      final dat=datCtlPlaAwNrv)
      "Plant controller"
      annotation (Placement(transformation(extent={{152,-4},{132,16}})));
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
      redeclare final package MediumHeaWat=Medium,
      nHp=2,
      is_rev=false,
      final dat=datHpAwNrv,
      final energyDynamics=energyDynamics)
      "Non reversible AWHP"
      annotation (Placement(transformation(extent={{274,-152},{-206,-72}})));
    parameter HeatPumps.Components.Data.Controller                            datCtlHeaInl(
      cfg(
        have_pumHeaWatPriVar=true,
        have_pumChiWatPriVar=false,
        have_inpSch=false,
        have_hrc=false,
        have_valHpOutIso=valIsoHeaInl.have_valHpOutIso,
        have_valHpInlIso=valIsoHeaInl.have_valHpInlIso,
        have_chiWat=valIsoHeaInl.have_chiWat,
        have_pumChiWatPriDed=valIsoHeaInl.have_pumChiWatPriDed,
        typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
        typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
        is_rev=false,
        typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
        nPumChiWatSec=0,
        rhoHeaWat_default=Buildings.Media.Water.d_const,
        typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
        typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
        rhoChiWat_default=Buildings.Media.Water.d_const,
        cpChiWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        have_hotWat=false,
        have_valChiWatMinByp=false,
        have_valHeaWatMinByp=false,
        typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
        cpHeaWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        cpSou_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        have_senDpChiWatRemWir=true,
        typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
        nHp=2,
        nPumHeaWatPri=2,
        have_heaWat=true,
        nPumHeaWatSec=0,
        rhoSou_default=Buildings.Media.Air.dStp,
        have_senDpHeaWatRemWir=true,
        typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
        nPumChiWatPri=0,
        nSenDpHeaWatRem=0,
        nSenDpChiWatRem=0,
        nAirHan=0,
        nEquZon=0),
      THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
      dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max,
          datCtlHeaInl.cfg.nSenDpChiWatRem),
      dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max,
          datCtlHeaInl.cfg.nSenDpHeaWatRem),
      staEqu={fill(1, datCtlHeaInl.cfg.nHp)})
      "Controller parameters"
      annotation (Placement(transformation(extent={{-284,-192},{-264,-172}})));

    parameter HeatPumps.Components.Data.HeatPumpGroup                            datHp(
      final nHp=2,
      final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
      final is_rev=true,
      final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
      mHeaWatHp_flow_nominal=datHp.capHeaHp_nominal/abs(datHp.THeaWatSupHp_nominal
           - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
      capHeaHp_nominal=500E3,
      THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
      TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
      mChiWatHp_flow_nominal=datHp.capCooHp_nominal/abs(datHp.TChiWatSupHp_nominal
           - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      capCooHp_nominal=500E3,
      TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
      TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
      perFitHp(hea(
          P=datHp.capHeaHp_nominal/Buildings.Templates.Data.Defaults.COPHpAwHea,
          coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
          coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
          TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow), coo(
          P=datHp.capCooHp_nominal/Buildings.Templates.Data.Defaults.COPHpAwCoo,
          coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
          coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
          TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
          TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
      "HP parameters"
      annotation (Placement(transformation(extent={{-228,-192},{-208,-172}})));

    ValvesIsolation_UpdatePorts
      valIsoHeaInl(
      redeclare final package Medium = Medium,
      nHp=2,
      have_chiWat=true,
      have_pumChiWatPriDed=false,
      have_valHpInlIso=true,
      have_valHpOutIso=false,
      final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal,
          valIsoHeaInl.nHp),
      dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
      mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
      final energyDynamics=energyDynamics,
      y_start=0)
      "Isolation valves - Heating-only system with isolation valves at HP inlet"
      annotation (Placement(transformation(extent={{-20,-20},{22,22}})));

    Fluid.Sources.Boundary_pT retHeaWat1(
      redeclare final package Medium = Medium,
      p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
      T=Buildings.Templates.Data.Defaults.THeaWatRetMed,
      nPorts=1) "Boundary condition at HW return"
      annotation (Placement(transformation(extent={{-256,32},{-236,52}})));
    Fluid.Sources.Boundary_pT supHeaWat1(
      redeclare final package Medium = Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      nPorts=2) "Boundary condition at HW supply"
      annotation (Placement(transformation(extent={{-256,0},{-236,20}})));
    Controls.OpenLoop                                                      ctlHeaInl(final cfg=
         datCtlHeaInl.cfg, final dat=datCtlHeaInl)
      "Plant controller"
      annotation (Placement(transformation(extent={{-8,78},{-28,98}})));
    Fluid.Sources.Boundary_pT retChiWat(
      redeclare final package Medium = Medium,
      p=supHeaWat1.p + max(valIsoHeaInl.dpHeaWat_nominal),
      T=287.15,
      nPorts=1) "Boundary condition at HW return"
      annotation (Placement(transformation(extent={{114,-6},{94,14}})));
    Fluid.Sources.Boundary_pT supChiWat(
      redeclare final package Medium = Medium,
      p=Buildings.Templates.Data.Defaults.pHeaWat_rel_nominal + 101325,
      T=279.85,
      nPorts=2) "Boundary condition at HW supply"
      annotation (Placement(transformation(extent={{114,22},{94,42}})));



    Buildings.Templates.Components.Pumps.Multiple pum(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=2,
    dat=datPumMul,
    redeclare final package Medium = Medium)
      annotation (Placement(transformation(extent={{50,34},{70,54}})));
    parameter Buildings.Templates.Components.Data.PumpMultiple
                                datPumMul(
      final typ=Buildings.Templates.Components.Types.Pump.Multiple,
      final nPum=pum.nPum,
      m_flow_nominal=fill(1, pum.nPum),
      dp_nominal=fill(1E5, pum.nPum))
      "Multiple pump parameters"
      annotation (Placement(transformation(extent={{190,54},{210,74}})));
    Buildings.Templates.Components.Routing.SingleToMultiple rou(
      redeclare package Medium = Medium,
      nPorts=2,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{16,34},{36,54}})));
    Buildings.Controls.OBC.CDL.Reals.Sources.Constant y(k=1) "Pump speed command"
      annotation (Placement(transformation(extent={{-212,138},{-192,158}})));
    Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1(
      table=[0,0,0; 1,1,0; 2,1,1; 3,0,0],
      timeScale=100,
      period=300) "Pump enable signal"
      annotation (Placement(transformation(extent={{-214,94},{-194,114}})));
    Buildings.Templates.Components.Routing.SingleToMultiple rou1(
      redeclare package Medium = Medium,
      nPorts=2,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-64,-10},{-84,10}})));
    Buildings.Templates.Components.Pumps.Multiple pum1(
      final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      nPum=2,
      dat=datPumMul,
      redeclare final package Medium = Medium)
      annotation (Placement(transformation(extent={{-108,-12},{-128,8}})));
  protected
    Buildings.Templates.Components.Interfaces.Bus
                   bus2 "Pump control bus" annotation (Placement(transformation(
            extent={{114,66},{154,106}}),iconTransformation(extent={{-318,-118},{-278,
              -78}})));
  protected
    Buildings.Templates.Components.Interfaces.Bus
                   bus1 "Pump control bus" annotation (Placement(transformation(
            extent={{-180,42},{-140,82}}),
                                         iconTransformation(extent={{-318,-118},{-278,
              -78}})));
  equation
    connect(ctlPlaAwNrv.bus, hpAwNrv.bus)
      annotation (Line(points={{152,6},{160,6},{160,-62},{34,-62},{34,-72}},
                                                          color={255,204,51},thickness=0.5));
    connect(retHeaWat1.ports[1],valIsoHeaInl. port_aHeaWat)
      annotation (Line(points={{-236,42},{-228,42},{-228,16.54},{-20,16.54}},
                                                                         color={0,127,255}));
    connect(retChiWat.ports[1],valIsoHeaInl. port_aChiWat) annotation (Line(
          points={{94,4},{58,4},{58,6.88},{22,6.88}},         color={0,127,255}));
    connect(valIsoHeaInl.ports_bChiWatHp, hpAwNrv.ports_aChiHeaWat) annotation (
       Line(points={{16.8,-19.79},{16.8,-66},{-16,-66},{-16,-72}},
                                                                 color={0,127,
            255}));
    connect(hpAwNrv.ports_bChiHeaWat, valIsoHeaInl.ports_aChiWatHp) annotation (
       Line(points={{84,-72},{84,-58},{6.6,-58},{6.6,-19.58}}, color={0,127,255}));
    connect(hpAwNrv.ports_bSou, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(
          points={{-16,-151.8},{-16,-158},{-212,-158},{-212,-26},{-14.6,-26},{
            -14.6,-19.79}},
                     color={0,127,255}));
    connect(hpAwNrv.ports_aSou, valIsoHeaInl.ports_bHeaWatHp) annotation (Line(
          points={{84,-152},{30,-152},{30,-150},{-4,-150},{-4,-19.79}},color={0,
            127,255}));
    connect(ctlHeaInl.bus, valIsoHeaInl.bus) annotation (Line(
        points={{-8,88},{0.6,88},{0.6,20.53}},
        color={255,204,51},
        thickness=0.5));
    connect(valIsoHeaInl.port_bChiWat, rou.port_a) annotation (Line(points={{22,
            16.12},{28,16.12},{28,28},{10,28},{10,44},{16,44}},    color={0,127,255}));
    connect(rou.ports_b, pum.ports_a)
      annotation (Line(points={{36,44},{50,44}},   color={0,127,255}));
    connect(pum.ports_b, supChiWat.ports[1:2]) annotation (Line(points={{70,44},
            {88,44},{88,30},{94,30}},   color={0,127,255}));
    connect(bus2, pum.bus) annotation (Line(
        points={{134,86},{134,60},{60,60},{60,54}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(y.y, bus2.y) annotation (Line(points={{-190,148},{-184,148},{-184,
            120},{134,120},{134,86}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(y1.y[1:2], bus2.y1) annotation (Line(points={{-192,104},{-36,104},{
            -36,108},{104,108},{104,86},{134,86}},
                       color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(valIsoHeaInl.port_bHeaWat, rou1.port_a) annotation (Line(points={{-20,
            7.51},{-52,7.51},{-52,0},{-64,0}},          color={0,127,255}));
    connect(rou1.ports_b, pum1.ports_a) annotation (Line(points={{-84,0},{-84,
            -2},{-108,-2}},   color={0,127,255}));
    connect(pum1.ports_b, supHeaWat1.ports[1:2]) annotation (Line(points={{-128,-2},
            {-224,-2},{-224,8},{-236,8}},      color={0,127,255}));
    connect(bus1, pum1.bus) annotation (Line(
        points={{-160,62},{-160,20},{-118,20},{-118,8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(y.y, bus1.y) annotation (Line(points={{-190,148},{-184,148},{-184,
            124},{-224,124},{-224,62},{-160,62}},
                                               color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(y1.y[1:2], bus1.y1) annotation (Line(points={{-192,104},{-160,104},
            {-160,62}},
                   color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (
      Diagram(
        coordinateSystem(
          extent={{-300,-220},{300,220}})),
      __Dymola_Commands(
        file=
          "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
          "Simulate and plot"),
      experiment(
        Tolerance=1e-6,
        StartTime=10497600.0,
        StopTime=10505600.0),
      Documentation(
        info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater\">
Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater</a>
in a configuration in which the heat pump components are exposed
to a constant differential pressure and a varying
return temperature.
</p>
<p>
The model is configured to represent either a non-reversible heat pump
(component <code>hpAwNrv</code>) or a reversible heat pump
(component <code>hpAw</code>) that switches between cooling and heating
mode.
</p>
</html>",   revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
  end IsolationValveAndHeatPumpGroupWW;
end Validation;
