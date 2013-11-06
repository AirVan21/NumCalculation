syms x;
% Integrating function
inputFunc = 1 / (0.3 + sinh(x));
bounds = [0, 0.4];
obj = integration(inputFunc, bounds);