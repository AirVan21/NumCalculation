syms x;
format long;
% Current example 
f = sin(8*x);
nodes = [-0.91, -0.57, -0.32, 0.23, 0.62, 0.88];
interval = [-1, 1];
obj = lagrange(f, interval, nodes);
obj.buildPlot;