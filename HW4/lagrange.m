classdef lagrange
    
    properties
        % Number of parts, on which will divide interval
        nPart = 25;
        % Nodes for interpolation
        nodes
        % Current function for interpolation
        intFunc
        % Interval of existence
        interval
        % Lagrange polynomial
        lagPol
        % Statistic matrix
        statMat       
        % Column amount
        col = 5
        % Error quantity
        aError
    end
    
    methods (Access = public) 
        
        % Constructor
        % inputNode - interpolation nodes
        function obj = lagrange(func, curInterval, inputNode)
            obj.nodes = inputNode; 
            obj.intFunc = func;
            obj.interval = curInterval;
            obj.lagPol = obj.initPol(obj.nodes);
            obj.statMat = obj.fillMat();
            obj.statMat
        end
        
        % Building plot 
        function buildPlot(obj)
            ezplot(obj.intFunc, [obj.interval(1) obj.interval(2)]);
            hold all;
            plot(obj.statMat(:, 1), obj.statMat(:,3));
        end
        
        % Lagrange polynom creation
        function polynom = initPol(obj, nodes)
            syms x;
            wProduct = 1;
            polynom = 0;
            for i = 1:length(nodes)
                wProduct = wProduct * (x - nodes(i));
            end
            for j = 1:length(nodes)
                % Calculatong value of function in the node
                fVal = subs(obj.intFunc, x, nodes(j));
                % Counting wDif = w'(curx)
                % Multiple in Lagrange polynom
                wDif = 1;
                for i = 1:length(nodes)
                    if i ~= j
                        wDif = wDif * (nodes(j) - nodes(i));
                    end
                end
                % Summing for all nodes
                polynom = polynom + fVal * wProduct / ((x - nodes(j)) * wDif);
            end
        end
        
        % Fullfilling statistic matrix
        % Index shows interpolation case
        function matrix = fillMat(obj, index)
            syms x;
            matrix = zeros(obj.nPart, obj.col);
            arg = obj.interval(1);
            step = (obj.interval(2) - obj.interval(1))/obj.nPart;
            for i = 1:obj.nPart
                arg = arg + step;
                % Argument column
                matrix(i, 1) = arg;
                % Fucntion values
                matrix(i, 2) = subs(obj.intFunc, x, arg);
                % Lagramge polynom values
                matrix(i, 3) = subs(obj.lagPol, x, arg);
                % |f(x) - PLagrange(x)|
                matrix(i, 4) = abs(matrix(i, 2) - matrix(i, 3));
                % A - Error
                matrix(i, 5) = obj.calcError(obj.nodes, arg);
            end
        end
        
        % Calculating error quantity
        function error = calcError(obj, nodes, curX)
            syms x;
            wProduct = 1;
            len = length(nodes);
            for i = 1:len
                wProduct = wProduct * (x - nodes(i));
            end
            % Finding derivative
            devFunction = abs(diff(obj.intFunc, length(nodes)));
            % Should be fixed
            % Searching in nPart dots in interval
            arg = obj.interval(1);
            step = (obj.interval(2) - obj.interval(1))/(obj.nPart);
            max = subs(devFunction, x, arg);
            for i = 1:obj.nPart
                curVal = subs(devFunction, x, arg);
                if curVal > max
                    max = curVal;
                end
                arg = arg + step;
            end
            error = subs(wProduct, x, curX) * max / factorial(len);
        end
                 
    end
            
end