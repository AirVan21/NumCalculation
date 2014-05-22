% Implicit Net method for thermal equation
function [decisionMat] = implicitNet(x, t, h, tau, f, u_x0, u_at, u_bt)
    format short;
    xLength = length(x);
    yResult = zeros(1, xLength);
    rightPart = zeros(xLength, 1);
    u = zeros(xLength, 1);
    v = zeros(xLength, 1);
    diagMat = zeros(xLength);
    mLayers = length(t);
    decisionMat = zeros(mLayers, xLength);
    
    % Filling bottom 
    for i = 1 : xLength  
        decisionMat(1, i) = u_x0(x(i));
    end
    % Filling sides
    for i = 1 : mLayers
        decisionMat(i, 1) = u_at(t(i));
        decisionMat(i, xLength) = u_bt(t(i)); 
    end
    % Creating const matrix
    diagMat(1,1) = 1;
    diagMat(xLength, xLength) = 1;
    a = -tau/(h^2);
    b = - 1 - 2*tau/(h^2);
    c = -tau/(h^2);
    for j = 2 : xLength - 1
        diagMat(j, j-1) = -tau/(h^2);
        diagMat(j, j) = (1 + 2*tau/(h^2));
        diagMat(j, j+1) = -tau/(h^2);
    end
    
    for k = 2 : mLayers
        % Sets right part of help matrix
        rightPart(1) = u_at(t(k));
        rightPart(xLength) = u_bt(t(k));
        for i = 2 : xLength - 1
            rightPart(i) = decisionMat(k-1,i) + tau*f(x(i), t(k));
        end 
        u(1) = 0;
        v(1) = rightPart(1);
        for j = 2 : xLength
            u(j) = a/(b - c*u(j-1));
            v(j) = (c*v(j-1)-rightPart(j))/(b - c*u(j-1));
        end
%         disp([u, v]);
        yResult(xLength) = rightPart(xLength);
        for i = xLength - 1 : -1 : 1
            yResult(i) = u(i)*yResult(i+1) + v(i);
        end
%         disp(rightPart);
%         disp(yResult);
%         disp('Check product');
%         disp([diagMat*yResult', rightPart]); 
        decisionMat(k,:) = yResult;
    end
end