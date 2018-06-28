// Suppose you have already done "gmsh mixing_elbow.stl -reclassify -o reclassfied.msh -format msh"

Merge "reclassifyed.msh";

CreateTopology;

ll[] = Line "*";
For j In {0: #ll[]-1}
  Compound Line(newl) = ll[j];
EndFor
ss[] = Surface "*";
s = news;
For i In {0 : #ss[]-1}
  Compound Surface(s+i) = ss[i];
EndFor

Surface Loop(1) = {s : s + #ss[] - 1};
Volume(1) = {1};

Physical Surface ("in1") = {s};
Physical Surface ("in2") = {s+1};
Physical Surface ("out") = {s+2};
Physical Surface ("side") = {s+3};
Physical Volume ("fluid") = {1};

//Field[1] = MathEval;
//Field[1].F = "0.002";
//Background Field = 1;
  
//DefineConstant[
//  funny = {0, Choices{0,1},
//    Name "Parameters/Apply funny mesh size field?"},
//  hide = {Geometry.HideCompounds, Choices{0,1},
//    AutoCheck 0, GmshOption "Geometry.HideCompounds",
//    Name "Parameters/Hide compound sub-entities"}
//];
  
//If(funny)
//  Field[1].F = "2*Sin((x+y)/5) + 3";
//EndIf
  
//Mesh.RemeshAlgorithm = 1; // automatic
//Mesh.RemeshParametrization = 7; // conformal finite element
//Mesh.Algorithm = 6; // Frontal

Mesh.CharacteristicLengthMin = 0.;
Mesh.CharacteristicLengthMax = 0.002;
  
//Geometry.HideCompounds = 0;

