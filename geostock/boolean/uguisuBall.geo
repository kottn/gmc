SetFactory("OpenCASCADE");  // Req. Ver.>=3.0

//-- inp.
x1 =  .0      ; y1 =  .0      ; z1 =  .3 ;
x2 =  .244949 ; y2 = -.141421 ; z2 = -.1 ;
x3 =  .0      ; y3 =  .282843 ; z3 = -.1 ;
x4 = -.244949 ; y4 = -.282843 ; z4 = -.1 ;
r = .7 ;
cl = .1;

//-- sol.
Sphere(1) = {x1, y1, z1, r};
Sphere(2) = {x2, y2, z2, r};
Sphere(3) = {x3, y3, z3, r};
Sphere(4) = {x4, y4, z4, r};

v() = BooleanUnion{ Volume{1}; Delete; }{ Volume{2:4}; Delete; };
s() = Unique(Abs(Boundary{ Volume{v()}; }));
l() = Unique(Abs(Boundary{ Surface{s()}; }));
p() = Unique(Abs(Boundary{ Line{l()}; }));

Characteristic Length{p()} = cl;

Physical Surface(3001) = {s()};
Physical Volume(5001) = {v()};

