% Net method for thermal equation
function [decisionMat, resultMat] = netMethod(x, t, h, tau, f, u_x0, u_at, u_bt, nStep, mLayers, resultFunc)
    resultMat = zeros(mLayers + 1, nStep + 1);
    decisionMat = zeros(mLayers + 1, nStep + 1);
    % Filling bottom 
    for i = 1 : nStep + 1  
        decisionMat(1, i) = u_x0(x(i));
    end
    % Filling sides
    for i = 1 : mLayers + 1
        decisionMat(i, 1) = u_at(t(i));
        decisionMat(i, nStep + 1) = u_bt(t(i)); 
        resultMat(i, 1) = resultFunc(0, t(i));
        resultMat(i, nStep + 1) = resultFunc(1, t(i)); 
    end
    % Filling center 
    for k = 1 : mLayers     
        for i = 2 : nStep
             decisionMat(k + 1, i) = decisionMat(k,i) + (tau/h^(2))*(decisionMat(k,i + 1) + decisionMat(k,i - 1) ...
                 -2*decisionMat(k,i)) + tau*f(x(i),t(k));
             resultMat(k, i) = resultFunc(x(i), t(k));
        end
    end
    % Fill last layers for accurate result matrix
    for i = 2 : nStep
        resultMat(mLayers+1, i) = resultFunc(x(i), t(mLayers+1));
    end
end