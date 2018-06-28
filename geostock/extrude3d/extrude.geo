// Extrude 2D to 3D

Merge "nasu.unv";

CreateTopology;

Extrude {0, 0, 5} {
 Surface{1};
}


Physical Surface ("bottom") = {s};
Physical Surface ("side1") = {s+1};
Physical Surface ("side2") = {s+2};
Physical Surface ("side3") = {s+3};
Physical Surface ("side4") = {s+4};
Physical Surface ("top") = {s+5};
Physical Volume ("fluid") = {1};


Field[1] = MathEval;
Field[1].F = "0.1";

Field[2] = MathEval;
Field[2].F = "1.0";

Field[3] = Restrict;
Field[3].IField = 1;
Field[3].FacesList = {s};

Field[4] = Restrict;
Field[4].IField = 2;
Field[4].FacesList = {s+5};

// element size imposed by a size field
Field[5] = MathEval;
Field[5].F = "0.5";
Background Field = 5;

DefineConstant[
  funny = {0, Choices{0,1},
    Name "Parameters/Apply funny mesh size field?"},
  hide = {Geometry.HideCompounds, Choices{0,1},
    AutoCheck 0, GmshOption "Geometry.HideCompounds",
    Name "Parameters/Hide compound sub-entities"}
];

If(funny)
  Field[5].F = "2*Sin((x+y)/5) + 3";
EndIf

Mesh.RemeshAlgorithm = 1; // automatic
Mesh.RemeshParametrization = 7; // conformal finite element
Mesh.Algorithm = 7; // BAMG
