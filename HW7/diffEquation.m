classdef diffEquation
    %   Calculating Cauchy problem for differential equations
    %   Euler, Adams, Runge - Kutta
    
    properties
        % Main function
        diffFunc
        % Low bound of interval for x
        lowBound 
        % High bound of interval for x
        highBound
        % Step for x
        step
    end
    
    methods
        % Constructor
        function obj = diffEquation(diffFunction, lowBound, highBound, step)
            obj.diffFunc = diffFunction;
            obj.lowBound = lowBound;
            obj.highBound = highBound;
            obj.step = step;
        end
        
        % Calculating yPoints, using Euler's method
        % step - difference between x-points, y(0) = 0
        function [xPoints, yPoints] = eulerMethod(obj, step)
            % Init values
            yPoints(1) = 0;
            xPoints(1) = obj.lowBound;
            % Counter
            i = 1;
            % Starts from second point
            for x = obj.lowBound + step : step : obj.highBound
                xPoints(i + 1) = x;
                yPoints(i + 1) = yPoints(i) + step * obj.diffFunc(xPoints(i),yPoints(i));
                i = i + 1;
            end
        end
        
        % Calculating yPoints, using Adams's method
        % yPoinds - precalculated Runge-Kutt points
        function [xPoints, yPoints] = adamsMethod(obj, step, yRunge)
            % Init values
            yPoints(1) = 0;
            xPoints(1) = obj.lowBound;
            ceil(obj.highBound / step)
            % Amount of node points
            amount = ceil(obj.highBound / step) + 1;
            divideMat = zeros(amount, amount);
            divideMat(1,1) = xPoints(1);
            divideMat(1,2) = yPoints(1);
            % Counter
            for i = 2 : amount
                xPoints(i) = xPoints(i - 1) + step;
                yPoints(i) = yRunge(i - 1);
                divideMat(i, 1) = xPoints(i);
            end
            disp(divideMat);
        end
        
        % Calculating yPoints, using (Runge-Kutta)'s method
        function [xPoints, yPoints] = rungekuttMethod(obj, step)
            % Init values
            yPoints(1) = 0;
            xPoints(1) = obj.lowBound;
            % Counter
            i = 1;
            % Starts from second point
            for x = obj.lowBound + step : step : obj.highBound
                xPoints(i + 1) = x;
                % Parametrs of Runge - Kutta
                k1 = step * obj.diffFunc(xPoints(i), yPoints(i));
                k2 = step * obj.diffFunc(xPoints(i) + step/2, yPoints(i) + k1/2);
                k3 = step * obj.diffFunc(xPoints(i) + step/2, yPoints(i) + k2/2);
                k4 = step * obj.diffFunc(xPoints(i) + step, k3);
                yPoints(i + 1) = yPoints(i) + 1/6 * (k1 + 2*k2 + 2*k3 + k4);
                i = i + 1;
            end
        end
        
        % Makes plots
        function output(obj)
            % Euler method 
            figure
            title('Cauchy problem');
            [x1, y1] = obj.eulerMethod(obj.step);
            [x2, y2] = obj.eulerMethod(obj.step / 2);
            [x3, y3] = obj.eulerMethod(2 * obj.step);
            [x4, y4] = obj.rungekuttMethod(obj.step);
            fprintf('y(5) Runge-Kutta =');
            disp(y4(6));
            [x5, y5] = obj.adamsMethod(obj.step, y4);
            plot(x1, y1, x2, y2, x3, y3, x4, y4);
            hleg = legend('Euler h', 'Euler h/2', 'Euler 2h','Runge-Kutta h', 'Location', 'NorthEastOutside');
            set(hleg);
            ylabel('dy/dx');
            xlabel('x');
            
        end
        
    end
    
end

