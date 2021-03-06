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
            obj.nodes = cell(obj.testAmount);
            obj.nodes{1} = inputNode;
            obj.intFunc = func;
            obj.interval = curInterval;
            [obj.lagPol, obj.nodes] = obj.setLagPol();
            obj.aMax = obj.calcMax();
            obj.casePlots();
            obj.showOutput();
        end
        
        % Building plot for all
        % Rewrite it
        function showOutput(obj)
            titles = cell(obj.testAmount);
            titles{1} = 'Input data';
            titles{2} = 'Left side nodes';
            titles{3} = 'Middle side nodes';
            titles{4} = 'Right side nodes';
            titles{5} = 'Double precision';
            for i = 1:obj.testAmount 
                format long;
                fprintf('                                          %s\n\n',titles{i});
                fprintf('          x(i)             f(x(i))           Lagrange(x(i))      |f - Lagrange|          A(i)\n');
                disp(obj.fillMat(i));
                fprintf('\n');
            end
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
                matrix(i, 5) = obj.calcError(obj.nodes{index}, arg);
            end
        end
        
        % Calculating error quantity
        function error = calcError(obj, nodes, curX)
            wProduct = 1;
            for i = 1:length(nodes)
                wProduct = wProduct * (curX - nodes(i));
            end
            wProduct = abs(wProduct);
            error = (wProduct * obj.aMax) / factorial(length(obj.nodes{1}));
        end
        
        % Calculates derivation maximum on interval
        function maxValue = calcMax(obj)
            syms x;
            % Calculates derivation
            derivative = diff(obj.intFunc, length(obj.nodes{1}));
            % Finding argument for maximum value on interval
            % HARDCODE 
            % cos(x), sin(8x)
            maxArg = [0, pi/16];
            % Calculates maximum value abs
            test = abs(subs(derivative, x, maxArg(1)));
            if test < abs(subs(derivative, x, maxArg(2)))
                test = abs(subs(derivative, x, maxArg(2)));
            end
            maxValue = test;
        end 
        
        % Create Lagrange polynoms for 'testAmount' cases 
        function [polynoms, nodes] = setLagPol(obj)
            nodes = cell(obj.testAmount);
            % Polynom on input data
            polynoms(1) = obj.initPol(obj.nodes{1});
            nodes{1} = obj.nodes{1};
            % Nodes in a left, middle, right part of an interval 
            len = length(obj.nodes{1});
            state = obj.interval(1);
            % 1/2 Intreval length
            nodeArea = (obj.interval(2) - obj.interval(1)) / 2;
            % 1/8 Interval length
            step = (obj.interval(2) - obj.interval(1)) / (2 * len);
            leftNodes = state + rand(1, len) * nodeArea;
            rightNodes = state + 4*step +  rand(1, len) * nodeArea;
            middleNodes = state + 2*step +  rand(1, len) * nodeArea;
            % Double amount of nodes
            doubleNodes = obj.interval(1) + rand(1,2 * len) * 2 * nodeArea;
            nodes{2} = leftNodes;
            nodes{3} = middleNodes;
            nodes{4} = rightNodes;
            nodes{5} = doubleNodes;
            % Create appropriate polynoms
            polynoms(2) = obj.initPol(leftNodes);
            polynoms(3) = obj.initPol(middleNodes);
            polynoms(4) = obj.initPol(rightNodes);
            polynoms(5) = obj.initPol(doubleNodes);
        end
        
        % Build interpolation-plots for all cases
        function casePlots(obj)
            titles = cell(obj.testAmount);
            titles{1} = 'Input data';
            titles{2} = 'Left side nodes';
            titles{3} = 'Middle side nodes';
            titles{4} = 'Right side nodes';
            titles{5} = 'Double precision';
            for i = 1:obj.testAmount
                figure;
                ezplot(obj.intFunc, [obj.interval(1) obj.interval(2)]);
                hold all
                % Current case statistic matrix
                % Take arguments and Lagrange polynom value
                Mat = obj.fillMat(i);
                plot(Mat(:, 1), Mat(:,3), 'Color', 'r');
                title(titles{i});
                hold off
            end
        end
                 
    end
            
end