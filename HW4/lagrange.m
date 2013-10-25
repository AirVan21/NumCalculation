classdef lagrange
    
    properties
        % Number of parts, on which will divide interval
        nPart = 20;
        % Nodes for interpolation
        nodes
        % Current function for interpolation
        intFunc
        % Interval of existence
        interval
        % Lagrange polynomial
        lagPol    
        % Column amount
        col = 5
        % Maximum value
        aMax
        % Test amount
        testAmount = 5
    end
    
    methods (Access = public) 
        
        % Constructor
        % inputNode - interpolation nodes
        function obj = lagrange(func, curInterval, inputNode)
            obj.nodes = inputNode; 
            obj.intFunc = func;
            obj.interval = curInterval;
            obj.lagPol = obj.setLagPol();
            obj.aMax = obj.calcMax();
            obj.output();
            % Add error calc for all + File Output
        end
        
        % Building plot for all
        function buildAllPlot(obj)
            figure;
            ezplot(obj.intFunc, [obj.interval(1) obj.interval(2)]);
            hold all
            MatCus = obj.fillMat(1);
            plot(MatCus(:, 1), MatCus(:,3), 'Color', 'r');
            MatLeft = obj.fillMat(2);
            %plot(MatLeft(:, 1), MatLeft(:,3), 'Color', 'g');
            MatMiddle = obj.fillMat(3);
            %plot(MatMiddle(:, 1), MatMiddle(:,3), 'Color', 'g');
            MatRight = obj.fillMat(4);
            %plot(MatRight(:, 1), MatRight(:,3), 'Color', 'r');
            MatFull = obj.fillMat(5);
            %plot(MatFull(:, 1), MatFull(:,3), 'Color', 'g');
            hold off
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
                matrix(i, 3) = subs(obj.lagPol(index), x, arg);
                % |f(x) - PLagrange(x)|
                matrix(i, 4) = abs(matrix(i, 2) - matrix(i, 3));
                % A - Error
                matrix(i, 5) = obj.calcError(obj.nodes, arg);
            end
        end
        
        % Calculating error quantity
        function error = calcError(obj, nodes, curX)
            wProduct = 1;
            for i = 1:length(nodes)
                wProduct = wProduct * (curX - nodes(i));
            end
            wProduct = abs(wProduct);
            error = (wProduct * obj.aMax) / factorial(length(nodes));
        end
        
        % Calculates derivation maximum on interval
        function maxValue = calcMax(obj)
            syms x;
            % Calculates derivation
            devFunction = @(x) -abs(diff(obj.intFunc, length(obj.nodes)));
            % Finding argument for maximum value on interval
            maxArg = fminbnd(devFunction, obj.interval(1), obj.interval(2));
            % Calculates maximum value abs
            maxValue = abs(subs(diff(obj.intFunc, length(obj.nodes)), x, maxArg));
        end 
        
        % Create Lagrange polynoms for 'testAmount' cases 
        function polynoms = setLagPol(obj)
            % Polynom on input data
            polynoms(1) = obj.initPol(obj.nodes);
            % Nodes in a left, middle, right part of an interval 
            len = length(obj.nodes);
            leftNodes = zeros(1, len);
            rightNodes = zeros(1, len);
            middleNodes = zeros(1, len);
            % Could be rewritten using rand()
            state = obj.interval(1);
            step = (obj.interval(2) - obj.interval(1)) / (2 * len);
            for i = 1:len
                leftNodes(i) = state;
                middleNodes(i) = state + (len / 2) * step;
                rightNodes(i) = state + len * step;
                state = state + step;
            end
            % Double amount of nodes
            doubleNodes = obj.interval(1) + rand(1,2 * len) * (obj.interval(2) - obj.interval(1));
            % Create appropriate polynoms
            polynoms(2) = obj.initPol(leftNodes);
            polynoms(3) = obj.initPol(middleNodes);
            polynoms(4) = obj.initPol(rightNodes);
            polynoms(5) = obj.initPol(doubleNodes);
        end
        
        % Build interpolation-plots for all cases
        function output(obj)
            for i = 1:obj.testAmount
                figure;
                ezplot(obj.intFunc, [obj.interval(1) obj.interval(2)]);
                hold all
                % Current case statistic matrix
                % Take arguments and Lagrange polynom value
                Mat = obj.fillMat(i);
                plot(Mat(:, 1), Mat(:,3), 'Color', 'r');
                hold off
            end
        end
                 
    end
            
end