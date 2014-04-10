function [yRes,x] = calcMatrixRel(boundA, boundB, stepAmount, q, p, f, alpha2, beta2, alpha1, beta1, A, B)
    x = zeros(stepAmount + 1, 1);
    u = zeros(stepAmount + 1, 1);
    a = zeros(stepAmount + 1, 1);
    b = zeros(stepAmount + 1, 1);
    c = zeros(stepAmount + 1, 1);
    g = zeros(stepAmount + 1, 1);
    v = zeros(stepAmount + 1, 1);
    yRes = zeros(stepAmount + 1, 1);
    eqMat = zeros(stepAmount + 1);
    step = (boundB - boundA)/stepAmount;
    % create x points
    for i = 1 : stepAmount + 1
        x(i) = boundA + (i - 1)*step;
    end
    
    for i = 2 : stepAmount 
            % c(i)
            c(i) = 1 - (step/2)*p(x(i));
            eqMat(i, i - 1) = c(i);
            % -b(i)
            b(i) = 2 - (step^2)*q(x(i));
            eqMat(i, i) = -b(i);
            % a(i)
            a(i) = 1 + (step/2)*p(x(i)); 
            eqMat(i, i + 1) = a(i);
            % g(i)
            g(i) = (step^2)*f(x(i));
    end
    
    % set 3 - diag matrix 
    % 1
    eqMat(1,1) = 1;
    % kappa1
    kappa1 = (-4*alpha2 + b(2)*alpha2./a(2))/(-3*alpha2 + alpha2*c(2)/a(2) + 2*step*alpha1);
    nu1 = (2*step*A + alpha2*g(2)/a(2)) / (-3*alpha2 + alpha2*c(2)/a(2) + 2*step*alpha1);
    eqMat(1,2) = -kappa1;
    g(1) = nu1;
    
    % 1 
    eqMat(stepAmount + 1, stepAmount + 1) = 1;
    % kappa2
    kappa2 = (4*beta2 - b(stepAmount)/c(stepAmount)) / ... 
        (3*beta2 - a(stepAmount)*beta2/c(stepAmount) + 2*step*beta1);
    
    nu2 = (B*2*step - beta2*g(stepAmount)/c(stepAmount))/ ...
        (3*beta2 - a(stepAmount)*beta2/c(stepAmount) + 2*step*beta1);
    eqMat(stepAmount + 1, stepAmount) = -kappa2;
    g(stepAmount + 1) = nu2;
    
    disp('                                                    3 Diagonal   Matrix');
    disp('       y(0)    y(1)      y(2)                                                                                        g');
    disp(eqMat);
    u(1) = kappa1;
    v(1) = nu1;
    for i = 2 : stepAmount
        u(i) = a(i)/(b(i) - c(i)*u(i-1));
        v(i) = (c(i)*v(i-1) - g(i))/(b(i) - c(i)*u(i-1)); 
    end
    disp('      u          v ');
    disp([u , v]);
    
    yRes(stepAmount + 1) = (nu2 + kappa2*v(stepAmount))/(1  - kappa2*u(stepAmount));
    for i = stepAmount : -1: 1
        yRes(i) = u(i)*yRes(i+1) + v(i); 
    end
    
    disp('   y - result ');
    disp(yRes);
    disp('      Check product');
    disp([eqMat*yRes, g]); 
end