classdef integration
    
    properties
        % First integration bound
        lowBound
        % Second integration bound
        highBound
        % Function
        mainFunc
        % Anonymus type main Function
        anonymousFunc 
        % Data matrix
        dataMatrix
    end
    
    properties (Constant)
        % Node amount
        nodeNum1 = 8;
        nodeNum2 = 16;
    end
    
    methods (Access = public)
        % Constructor for Integration object
        % inputFunc - function, that should be integrated
        % bounds - intergating bounds
        function obj = integration(inputFunc, anFunc, bounds)
            obj.mainFunc = inputFunc;
            obj.anonymousFunc = anFunc;
            obj.lowBound = bounds(1);
            obj.highBound = bounds(2);
            obj.dataMatrix = obj.buildData();
            obj.output();
        end
        
        % Calculating intergal, using middle rectangle method
        function value = rectangleCalc(obj, nodeAmount)
            syms x;
            step = (obj.highBound - obj.lowBound) / nodeAmount;
            sigmaSum = 0;
            for i = 1:nodeAmount
                % Middle point
                point = obj.lowBound + (2*i - 1) * step / 2;
                sigmaSum = sigmaSum + subs(obj.mainFunc, x, point);
            end
            value = sigmaSum * step;
        end
        
        % Calculating intergal, using trapeze method
        function value = trapezeCalc(obj, nodeAmount)
            syms x;
            step = (obj.highBound - obj.lowBound) / nodeAmount;
            sigmaSum = 0;
            % Using formula for trapeze square
            for i = 1:(nodeAmount - 1)
                point = obj.lowBound + step * i;
                sigmaSum = sigmaSum + subs(obj.mainFunc, x, point);
            end
            extraSum = (subs(obj.mainFunc, x, obj.lowBound) + subs(obj.mainFunc, x, obj.highBound)) / 2;
            value = step * (extraSum + sigmaSum);  
        end

        % Calculating intergal, using Simpson's method
        function value = simpsonCalc(obj, nodeAmount)
            syms x;
            step = (obj.highBound - obj.lowBound) / nodeAmount;
            sigmaSum1 = 0;
            sigmaSum2 = 0;
            for i = 1:(nodeAmount - 1)
                point = obj.lowBound + step * i;
                sigmaSum1 = sigmaSum1 + subs(obj.mainFunc, x, point);
                point = obj.lowBound + (2*i - 1) * step / 2;
                sigmaSum2 = sigmaSum2 + subs(obj.mainFunc, x, point);
            end
            % Last point calc, that wasn't included in cycle
            sigmaSum2 = sigmaSum2 + subs(obj.mainFunc, x, obj.highBound - step / 2);
            extraSum = (subs(obj.mainFunc, x, obj.lowBound) + subs(obj.mainFunc, x, obj.highBound));
            value = (step / 6) * (2 * sigmaSum1 + extraSum + 4 * sigmaSum2);   
        end;
        
        % Accurate calculating
        function value = idealCalc(obj)
            value = integral(obj.anonymousFunc, obj.lowBound, obj.highBound);
        end
        
        % Creates Data matrix
        function matrix = buildData(obj)
            matrix = zeros(3, 2);
            matrix(1, 1) = vpa(obj.rectangleCalc(obj.nodeNum1));
            matrix(1, 2) = vpa(obj.rectangleCalc(obj.nodeNum2));
            matrix(2, 1) = vpa(obj.trapezeCalc(obj.nodeNum1));
            matrix(2, 2) = vpa(obj.trapezeCalc(obj.nodeNum2));
            matrix(3, 1) = vpa(obj.simpsonCalc(obj.nodeNum1));
            matrix(3, 2) = vpa(obj.simpsonCalc(obj.nodeNum2));
        end
        
        % Printing results
        function output(obj)
            format long;
%             matrix(1,1) = 'Rectang';
%             matrix(2,1) = 'Trapeze';
%             matrix(3,1) = 'Simpson';
            fprintf('\n   Optimal = ');
            disp(vpa(obj.idealCalc()));
            disp('           n8                 n16');
            disp(obj.dataMatrix);
        end
    end
    
end

