W = 4;
U = W^2;
AndList[l_] := Fold[And, True, l];
OrList[l_] := Fold[Or, False, l];
s = Table[Table[Table[Unique[s], {z, 1, U}], {y, 1, U}], {x, 1, U}];
f1 = AndList[Table[AndList[Table[OrList[Table[s[[x, y, i]], {i, 1, U}]], {x, 1, U}]], {y, 1, U}]];
f2 = AndList[Table[AndList[Table[AndList[Table[AndList[Table[Not[s[[x, y, z]]] || Not[s[[i, y, z]]], {i, x + 1, U}]], {x, 1, U - 1}]], {z, 1, U}]], {y, 1, U}]];
f3 = AndList[Table[AndList[Table[AndList[Table[AndList[Table[Not[s[[x, y, z]]] || Not[s[[x, i, z]]], {i, y + 1, U}]], {y, 1, U - 1}]], {z, 1, U}]], {x, 1, U}]];
f4 = AndList[Table[AndList[Table[AndList[Table[AndList[Table[AndList[Table[AndList[Table[Not[s[[W i + x, W j + y, z]]] || Not[s[[W i + x, W j + k, z]]], {k, y + 1, W}]], {y, 1, W}]], {x, 1, W}]], {j, 0, W - 1}]], {i, 0, W - 1}]], {z, 1, U}]];
f5 = AndList[Table[AndList[Table[AndList[Table[AndList[Table[AndList[Table[AndList[Table[AndList[Table[Not[s[[W i + x, W j + y, z]]] || Not[s[[W i + k, W j + l, z]]], {l, 1, W}]], {k, x + 1, W}]], {y, 1, W}]], {x, 1, W}]], {j, 0, W - 1}]], {i, 0, W - 1}]], {z, 1, U}]];

GetAssociationRules[m_?MatrixQ] := Association @@ Reap[With[{b = Dimensions[m]}, Do[If[m[[i, j]] != 0, Sow[{i, j} -> m[[i, j]]]], {i, b[[1]]}, {j, b[[2]]}]; Apply[Association, s]]][[2]]
mymat = {
{ 0, 2,14, 0, 0, 0,16, 4, 0, 0, 0, 1, 0, 0, 5, 0},
{ 0, 0, 9, 0, 0,10, 0, 1, 0, 0, 0, 0, 0, 4, 0, 0},
{ 0, 0, 0, 0,13, 6, 0, 0, 0,14, 0, 0,15,12, 0,16},
{ 6, 5,10, 0, 8, 2, 0, 0, 0,12, 0, 0, 0, 1, 0, 7},
{ 9, 0, 5, 4, 1, 0, 0, 2, 0, 0, 0, 0,12, 0, 7, 0},
{ 0, 0, 0, 0,11, 0, 0,13, 0, 3, 0, 0, 0, 0, 0, 1},
{ 0, 0, 0, 0,16, 0, 0, 0,13,10,15, 9,14, 0, 4, 0},
{10, 0, 0,11, 0, 4, 8,15, 0, 0, 0, 0, 5, 0,13, 0},
{ 0,11, 0, 1, 0, 0, 0, 0,10, 7, 4, 0, 3, 0, 0, 6},
{ 0, 7, 0, 2,14,16, 6,10, 0, 0, 0,11, 0, 0, 0, 0},
{16, 0, 0, 0, 0, 0, 1, 0,12, 0, 0,14, 0, 0, 0, 0},
{ 0, 4, 0,10, 0, 0, 0, 0,15, 0, 0, 2,16, 5, 0,11},
{11, 0,12, 0, 0, 0,14, 0, 0, 0,13, 7, 0, 9, 6, 2},
{ 8, 0, 7, 9, 0, 0,11, 0, 0, 0,14,10, 0, 0, 0, 0},
{ 0, 0, 4, 0, 0, 0, 0, 0,11, 0, 2, 0, 0, 8, 0, 0},
{ 0, 6, 0, 0,12, 0, 0, 0, 9, 8, 0, 0, 0,14, 1, 0}};

initial = GetAssociationRules[mymat];
fInit = AndList[Map[s[[#[[1]], #[[2]], initial[#]]] &, Keys[initial]]];
soln = SatisfiabilityInstances[f1 && f2 && f3 && f4 && f5 && fInit, Flatten[s]];
Print["constraint set size: "<>ToString[Length[Flatten[f1&&f2&&f3&&f4&&f5]]]];
r=ArrayReshape[soln,{U,U,U}];
Print[ExportString[Table[Table[Flatten[Position[r[[i,j]],True]][[1]],{j,1,U}],{i,1,U}],"Table", "FieldSeparators" -> " ", Alignment -> Right]]