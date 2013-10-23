syms x;
format long;
% Current example 
f = cos(x);
nodes = [-pi/8, -pi/10, pi/10, pi/9];
interval = [-pi/8, pi/8];
obj = lagrange(f, interval, nodes);
obj.buildPlot;