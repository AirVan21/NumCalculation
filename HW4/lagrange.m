classdef lagrange
    
    properties
        % Number of parts, on which will divide interval
        nPart = 21;
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
        col = 4
    end
    
    methods (Access = public) 
        
        % Constructor
        % inputNode - interpolation nodes
        function obj = lagrange(func, curInterval, inputNode)
            obj.nodes = inputNode; 
            obj.intFunc = func;
            obj.interval = curInterval;
            obj.lagPol = obj.initPol();
            obj.statMat = obj.fillMat();
        end
        
        % Building plot 
        function buildPlot(obj)
            ezplot(obj.intFunc, [obj.interval(1) obj.interval(2)]);
            hold all;
            plot(obj.statMat(:, 1), obj.statMat(:,3));
        end
        
        % Lagrange polynom creation
        function polynom = initPol(obj)
            syms x;
            wProduct = 1;
            polynom = 0;
            for i = 1:length(obj.nodes)
                wProduct = wProduct * (x - obj.nodes(i));
            end
            for j = 1:length(obj.nodes)
                % Calculatong value of function in the node
                fVal = subs(obj.intFunc, x, obj.nodes(j));
                % Counting wDif = w'(curx)
                % Multiple in Lagrange polynom
                wDif = 1;
                for i = 1:length(obj.nodes)
                    if i ~= j
                        wDif = wDif * (obj.nodes(j) - obj.nodes(i));
                    end
                end
                % Summing for all nodes
                polynom = polynom + fVal * wProduct / ((x - obj.nodes(j)) * wDif);
            end
        end
        
        % Fullfilling statistic matrix
        function matrix = fillMat(obj)
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
            end
        end
                 
    end
            
end