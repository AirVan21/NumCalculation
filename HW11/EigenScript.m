% Input data matrix A
A = [2.68, 1.83, 0.94;
     1.83, 2.71, 0.47;
     0.94, 0.47, 2.53];
% Input start vector y
y = [-1.32; -0.645; -1.735];

% Describes acccurancy
epsilon = 10^(-6);

%_____________________________________________________%
format short
disp('Input Data:');
disp('      a1        a2        a3        y');
disp([A, y]);

% Accoding to book, first(max) eigen value equal to
% ration of appropriate y(k+1) / y(k)
yNext = A * y;
iterStep = 1;
while(max(abs(yNext - y)) > epsilon)
    % Normalization
    y = yNext ./ yNext(1);
    % Iteration step
    yNext = A * y;
    % Normalization
    yNext = yNext ./ yNext(1);
    fprintf('\n   Iteration ¹ = %d\n', iterStep);
    disp('    ~Y(n)    ~Y(n+1)');
    disp([y, yNext]);
%     format long;
%     disp(yNext./y);
%     format short;
    iterStep = iterStep + 1;
end

% Result yNext : eigen vector for A matrix
% eigen(1) - eigen value for yNext
disp(' Eigen Value (all component) :');
format long;
eigen = A*yNext ./ yNext;
disp(eigen);
format short;
disp('    A * x   Eigen value * x');
disp([A*yNext, eigen(1)*yNext]);