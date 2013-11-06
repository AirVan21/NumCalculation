classdef integration
    
    properties
        % First integration bound
        lowBound
        % Second integration bound
        highBound
        % Function
        mainFunc
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
        function obj = integration(inputFunc, bounds)
            obj.mainFunc = inputFunc;
            obj.lowBound = bounds(1);
            obj.highBound = bounds(2);
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
        
        % Accurate calculating
        function value = idealCalc(obj)
            % How to use here obj.mainFunc
            formFunc = @(x) 1 ./ (0.3 + sinh(x));
            value = integral(formFunc, obj.lowBound, obj.highBound);
        end
        
        % Printing results
        function output(obj)
            value1 = vpa(obj.rectangleCalc(obj.nodeNum2));
            fprintf('Rectangle = ');
            disp(value1);
            value2 = vpa(obj.idealCalc());
            fprintf('Ideal = ');
            disp(value2);
            
        end
    end
    
end

