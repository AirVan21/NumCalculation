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
            obj = obj.calcError();
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
            matrix = zeros(3, 4);
            % First node set
            matrix(1, 1) = vpa(obj.rectangleCalc(obj.nodeNum1));
            matrix(1, 2) = vpa(obj.rectangleCalc(obj.nodeNum2));
            matrix(2, 1) = vpa(obj.trapezeCalc(obj.nodeNum1));
            % Second node set
            matrix(2, 2) = vpa(obj.trapezeCalc(obj.nodeNum2));
            matrix(3, 1) = vpa(obj.simpsonCalc(obj.nodeNum1));
            matrix(3, 2) = vpa(obj.simpsonCalc(obj.nodeNum2));
            % Runge optimization
            % For rectangel, trapeze k = 2
            % For simpson k = 4
            runge2 = 2^2;
            runge4 = 2^4;
            matrix(1, 3) = (matrix(1,1) - runge2 * matrix(1, 2)) / (1 - runge2);
            matrix(2, 3) = (matrix(2,1) - runge2 * matrix(2, 2)) / (1 - runge2);
            matrix(3, 3) = (matrix(3,1) - runge4 * matrix(3, 2)) / (1 - runge4);
        end
        
        % Calculating integration error
        function obj = calcError(obj)
            syms x;
            % Search for max derivative
            % 2nd diff
            diffTwo = diff(obj.mainFunc, 2);
            % 4th diff
            diffFour = diff(obj.mainFunc, 4);
            figure;
            ezplot(diffTwo, [obj.lowBound, obj.highBound]);
            prompt = 'Argument for Maximum for derivative = ';
            result = input(prompt);
            max2 = abs(subs(diffTwo, x, result));
            figure;
            ezplot(diffFour, [obj.lowBound, obj.highBound]);
            result = input(prompt);
            max4 = abs(subs(diffFour, x, result));
            % For rectangle & trapeze, using equal error estimation k = 2
            obj.dataMatrix(1,4) = abs((obj.highBound - obj.lowBound)^3 / (24*(obj.nodeNum1)^2)) * max2;
            obj.dataMatrix(2,4) = obj.dataMatrix(1,4);
            % For simpson another error estimation k = 4
            obj.dataMatrix(3, 4) = abs((obj.highBound - obj.lowBound)^5 / (2880*(obj.nodeNum1)^4)) * max4;
        end
        
        % Printing results
        function output(obj)
            format long;
            fprintf('\n   Optimal = ');
            disp(vpa(obj.idealCalc()));
            disp('           n8                 n16                Runge              Error ');
            disp(obj.dataMatrix);
            disp('Rectang');
            disp('Trapeze');
            disp('Simpson');
        end
    end
    
end

