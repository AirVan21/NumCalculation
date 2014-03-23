% Input data matrix A
A = [2.68, 1.83, 0.94;
     1.83, 2.71, 0.47;
     0.94, 0.47, 2.53];
 
% Describes acccurancy
epsilon = 10^(-5);

%_____________________________________________________%
format short;
disp('   Input Data:');
disp('      a1        a2        a3     ');
disp(A);

diagPrev = zeros(length(A), 1);
diagCur  = diag(A);
iterStep = 1;

% Jacobi method iteration
% Minimization for non-diagonal elements
while (~isdiag(A) && (max(abs(diagCur - diagPrev))> epsilon))
    disp('_______________________________________________________');
    % Stores diagonal elements
    diagonal = diag(A);
    A = A - diag(diagonal);
    
    % Calculates maximum non-diagonal element
    [maxElementVector, maxRowIndexPerCol] = max(abs(A));
    [maxElement, j] = max(abs(maxElementVector)); 
    i = maxRowIndexPerCol(j);
    A = A + diag(diagonal); 
    
    % Output part
    fprintf('\n   Iteration ¹ = %d\n', iterStep);
    disp('   Input matrix:');
    disp(A);
    fprintf('   Maximum non-diag |a(i,j)| = a(%d,%d) = ', i, j);
    disp(A(i,j));
    
    % Sets maximum abs() element to zero
    diagPrev = diag(A);
    d = ((A(i,i) - A(j,j))^2 + 4*A(i,j)^2) ^ (1/2);
    A(i,i) = (A(i,i) + A(j,j))/2 + sign(A(i,i) - A(j,j))*(d/2);
    A(j,j) = (A(i,i) + A(j,j))/2 - sign(A(i,i) - A(j,j))*(d/2);
    A(i,j) = 0;
    A(j,i) = 0;
    diagCur = diag(A);
    iterStep = iterStep + 1;
    
    % Show Results
    disp('   Transformed to:');
    disp(A);
end

% Show Results
disp('_______________________________________________________');
fprintf('\n\n');
format long;
disp('   Our diagonal of A   Matlab Eigen Values ');
disp([diag(A), eig(A)]);
