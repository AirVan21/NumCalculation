% Input data matrix A
A = [2.68, 1.83, 0.94;
     1.83, 2.71, 0.47;
     0.94, 0.47, 2.53];

 copyA = A;

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
while ((max(abs(diagCur - diagPrev))> epsilon))
    disp('_______________________________________________________');
    % Stores diagonal elements
    diagPrev = diag(A);
    diagonal = diag(A);
    A = A - diag(diagonal);
    % Calculates maximum non-diagonal element
    [maxElementVector, maxRowIndexPerCol] = max(abs(A));
    [maxElement, j] = max(abs(maxElementVector)); 
    i = maxRowIndexPerCol(j);
    A = A + diag(diagonal); 
    
    % Fix for diagonal iteration
    if i == j
        i = 1;
        j = 2;
    end
    
    % Output part
%     fprintf('\n   Iteration ¹ = %d\n', iterStep);
%     disp('   Input matrix:');
%     disp(A);
%     fprintf('   Maximum non-diag |a(i,j)| = a(%d,%d) = ', i, j);
%     disp(A(i,j));
    
    % Sets maximum abs() element to zero
    C = A;
    
    d = ((A(i,i) - A(j,j))^2 + 4*A(i,j)^2)^(0.5);
    c = (0.5 * (1 + abs(A(i,i) - A(j,j))/d))^(0.5);
    s = sign(A(i,j)*(A(i,i) - A(j,j)))*(0.5 * (1 - abs(A(i,i) - A(j,j))/d))^(0.5);
    
    for k = 1 : length(A)
        C(k,i) = c*A(k,i) + s*A(k,j);
        C(i,k) = C(k,i);
    end
    
    for k = 1 : length(A)
        if (k ~= i && k ~= j)
            C(k,j) = -s*A(k,i) + c*A(k,j);
            C(j,k) = C(k,j);
        end
    end
    
    C(i,i) = (A(i,i) + A(j,j))/2 + sign(A(i,i) - A(j,j))*(d/2);
    C(j,j) = (A(i,i) + A(j,j))/2 - sign(A(i,i) - A(j,j))*(d/2);
    C(i,j) = 0;
    C(j,i) = 0;
    A = C;
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
