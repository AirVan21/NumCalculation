syms x;
% Integrating function
inputFunc = 1 / (0.3 + sinh(x));
anonymousFunc = @(x) 1 ./ (0.3 + sinh(x));
bounds = [0, 0.4];
obj = integration(inputFunc, anonymousFunc, bounds);