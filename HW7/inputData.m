% Input Data for differential equation
% Set Patametrs
a = 1.5;
k = 20; 
ydiff =@(x,y)(3*y^(2) +  a*y + 1)/(k*x*y + 4);
lowBound = 0;
highBound = 1;
hStep = 0.1;
obj = diffEquation(ydiff, 0, 1, hStep);
obj.output;

