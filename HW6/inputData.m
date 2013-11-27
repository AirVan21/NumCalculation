% Parameters
format long;
alpha = -0.25;
pFunction = @(x)x.^(alpha);
fFunction = @(x)cos(x);
anonFunction = @(x) x.^(alpha) .* cos(x);
obj = quadrature(pFunction, fFunction, alpha);
obj.idealCalc
obj.quadrN2
%obj.quadrN2
