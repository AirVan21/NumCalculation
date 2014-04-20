% Set parameters 
f = @(x) x + x^3;
p = @(x) exp(-x);
q = @(x) 1/(1+x) - x;

% Coefficients
alpha2 = 1;
alpha1 = -0.25;

beta2 = 1;
beta1 = 1.4;

A = 0;
B = 0;

% Bounds
a = 0;
b = 1;

n1 = 10;
n2 = 100;

x = zeros(n1,1);
calcMatrixRel(a, b, n1, q, p, f, alpha2, beta2, alpha1, beta1, A, B);
disp('____________________________________________________________________________________');
% Takes model = sin(x);
fmodel = @(x)-sin(x) + p(x)*cos(x) + q(x)*sin(x);

% Sets new edge statements
A = alpha2 * cos(a) + alpha1*sin(a);
B = beta2 * cos(b) + beta1*sin(b);
fprintf('New A = %d\n', A);
fprintf('New B = %d\n', B)
format short
% Sets model values
[answer100,x100] = calcMatrixRel(a, b, n2, q, p, fmodel, alpha2, beta2, alpha1, beta1, A, B);
[answer10,x10] = calcMatrixRel(a, b, n1, q, p, fmodel, alpha2, beta2, alpha1, beta1, A, B);
accurate = zeros(length(answer10),1);
j = 0;
for i = 1 : 10 : 101
    j = j + 1;
    accurate(j) = answer100(i);
end

disp('Result(10)  Result(100) Precise value');
format short
disp([answer10, accurate, sin(x10)]);

disp('       Result(10)          Result(100)      Precise value');
format long
disp([answer10, accurate, sin(x10)]);
