% Quadrature formula calculation
classdef quadrature
    
    properties
        pFunc
        fFunc
        alpha 
        lowBound = 0
        highBound = 0.5
    end
    
    methods
        % Constructor
        function obj = quadrature(pFunc, fFunc, alpha)
            obj.alpha = alpha;
            obj.pFunc = pFunc;
            obj.fFunc = fFunc;
        end
        
        % Solving system, calculatin nodes
        % A1*(x1 + x2) + B1*x1*x2 + C1 = 0
        % A2*(x1 + x2) + B2*x1*x2 + C2 = 0
        function [root1, root2] = solveSystemN2(obj)
            % Define variavles
            syms x1 x2
            % Set precalculated values
            A1 = -(0.5)^(2 + obj.alpha) / (2 + obj.alpha);
            B1 = (0.5)^(1 + obj.alpha)  / (1 + obj.alpha);
            C1 = (0.5)^(3 + obj.alpha)  / (3 + obj.alpha);
            A2 = - C1;
            B2 = - A1;
            C2 = (0.5)^(4 + obj.alpha) / (4 + obj.alpha);
            % Solve system
            [root1, root2] = solve (A1*(x1 + x2) + B1*x1*x2 + C1 == 0, A2*(x1 + x2) + B2*x1*x2 + C2 == 0);
            % Take first pair of values
            root1 = eval(root1(1));
            root2 = eval(root2(1));
        end
        
        % Accurate calculating
        function value = idealCalc(obj)
            value = integral(@(x)(obj.pFunc(x) .* obj.fFunc(x)), obj.lowBound, obj.highBound);
        end
        
        % Calculate quadrature fotmula in case n=2 
        function value = quadrN2(obj)
            [x1, x2] = obj.solveSystemN2();
            % Interpolation condition
            A1 = integral(@(x) (obj.pFunc(x) .* (x - x2) ./ (x1 - x2)), obj.lowBound, obj.highBound);
            A2 = integral(@(x) (obj.pFunc(x) .* (x - x1) ./ (x2 - x1)), obj.lowBound, obj.highBound); 
            value = A1 .* obj.fFunc(x1) + A2 .* obj.fFunc(x2);
        end
    end
    
end
 