syms x;
% Integrating function
% inputFunc = 1 / (0.3 + sinh(x));
inputFunc = x^3;
anonymousFunc = @(x) 1 ./ (0.3 + sinh(x));
bounds = [0, 1];
obj = integration(inputFunc, anonymousFunc, bounds);