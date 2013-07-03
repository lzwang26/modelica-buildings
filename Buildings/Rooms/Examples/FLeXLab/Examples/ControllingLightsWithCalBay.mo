within Buildings.Rooms.Examples.FLeXLab.Examples;
model ControllingLightsWithCalBay
  "This model uses the BVCTB and Python scripts to control the lights in a room through the CalBay adapter"
  extends Modelica.Icons.Example;
  Utilities.IO.Python27.Real_Real pyt
    annotation (Placement(transformation(extent={{6,4},{26,24}})));
end ControllingLightsWithCalBay;