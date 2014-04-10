% Input data matrix A
A = [2.68, 1.83, 0.94;
     1.83, 2.71, 0.47;
     0.94, 0.47, 2.53];

 copyA = A;

% Describes acccurancy
epsilon = 10^(-5);

%_____________________________________________________%
format long;
disp('   Input Data:');
disp('      a1        a2        a3     ');
disp(A);

diagPrev = zeros(length(A), 1);
diagCur  = diag(A);
iterStep = 1;

% Jacobi method iteration
% Minimization for non-diagonal elements
while ((max(abs(diagCur - diagPrev))> epsilon))
    disp('_______________________________________________________');
    % Stores diagonal elements
    diagPrev = diag(A);
    diagonal = diag(A);
    A = A - diag(diagonal);
    % Calculates maximum non-diagonal element
    [maxElementVector, maxRowIndexPerCol] = max(abs(A));
    [maxElement, j1] = max(abs(maxElementVector)); 
    i1 = maxRowIndexPerCol(j1);
    % Correct indexes for rotation matrix
    i = min(i1, j1);
    j = max(i1, j1);
    A = A + diag(diagonal); 
    
    % Output part
    fprintf('\n   Iteration � = %d\n', iterStep);
    disp('   Input matrix:');
    disp(A);
    fprintf('   Maximum non-diag |a(i,j)| = a(%d,%d) = ', i, j);
    disp(A(i,j));
    
    d = ((A(i,i) - A(j,j))^2 + 4*A(i,j)^2)^(0.5);
    c = (0.5 * (1 + abs(A(i,i) - A(j,j))/d))^(0.5);
    s = sign(A(i,j)*(A(i,i) - A(j,j)))*(0.5 * (1 - abs(A(i,i) - A(j,j))/d))^(0.5);
    
    % Rotation matrix
    C = eye(length(A));
    C(i,i) = c;
    C(i,j) = -s;
    C(j,i) = s;
    C(j,j) = c;
    A = C'*A*C;
    
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

disp([sort(diag(A)), sort(eig(copyA))]);
