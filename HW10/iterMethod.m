function [X, iterStep] = iterMethod(matAB, startX, delta)
%iterMethod - simple iteration method 
%  Approximate method for linear equation system calculation
    rows = size(matAB, 1);
    cols = size(matAB, 2);
    X = zeros(rows, 1);
    iterStep = 1;
    for i = 1 : rows
        % Gets ones on diagonal
        matAB(i,:) = matAB(i,:) ./ matAB(i,i);
        X(i) = matAB(i, cols);
        for j = 1 : rows
            if (j ~= i)
                X(i) = X(i) - matAB(i,j) * startX(j);
            end
        end
    end
    % Iteration step
    while(abs(startX(1) - X(1)) > delta)
        startX = X;
        X = matAB(:,cols);
        for i = 1 :rows
            for j = 1 : rows
                if (j ~= i)
                    X(i) = X(i) - matAB(i,j) * startX(j);
                end
            end
        end
        iterStep = iterStep + 1;
    end
    disp('    Modified :');
    disp(matAB);
end

