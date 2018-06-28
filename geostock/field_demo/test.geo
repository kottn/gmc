Point (1) = {0, 0, 0};
Point (2) = {1, 0, 0};
Point (3) = {2, 0, 0};
Point (5) = {1, 1, 0};
Point (9) = {1, -1, 0};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 5};
Line(5) = {5, 1};
Line(7) = {5, 2};


Line Loop(8) = {1, -7, 5};
Plane Surface (9) = {8};
Line Loop(10) = {7, 2, 3};
Plane Surface (11) = {10};

Line(12) = {1, 9};
Line(13) = {9, 2};
Line(14) = {9, 3};

Line Loop(15) = {1, -13, -12};
Plane Surface(16) = {15};
Line Loop(17) = {2, -14, 13};
Plane Surface(18) = {17};

Field[1] = MathEval;
Field[1].F = "0.01";  // Sets the element size in the left region (9)

Field[2] = MathEval;
Field[2].F = "0.02";  // Sets the element size in the left region (9)
 
Field[3] = MathEval;
Field[3].F = "0.04";  // Sets the element size in the left region (9)
 
Field[4] = Restrict;
Field[4].IField = 1;
Field[4].FacesList = {9};

Field[5] = Restrict;
Field[5].IField = 2;
Field[5].FacesList = {11};

Field[6] = Restrict;
Field[6].IField = 3;
Field[6].FacesList = {16};

 
// Field[7] = Min;  // all elements are tiny.
// Field[7] = Max;  // all elements are large.
// Field[7].FieldsList = {1,2,3,4,5};

// Field[7] = MathEval;
// Field[7].F = "F4 + F5 + F6";  // All elements are the same size.

// Field[7] = MinAniso;
// Field[7].FieldsList = {4,5,6}; // All elements are large.

Background Field = 7;

