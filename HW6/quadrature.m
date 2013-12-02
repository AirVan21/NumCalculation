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
            fprintf('Node(1)=');
            disp(x1); 
            fprintf('Node(2)=');
            disp(x2);
            % Interpolation condition
            A1 = integral(@(x) (obj.pFunc(x) .* (x - x2) ./ (x1 - x2)), obj.lowBound, obj.highBound);
            A2 = integral(@(x) (obj.pFunc(x) .* (x - x1) ./ (x2 - x1)), obj.lowBound, obj.highBound); 
            fprintf('A1 =');
            disp(A1);
            fprintf('A2 =');
            disp(A2);
            value = A1 .* obj.fFunc(x1) + A2 .* obj.fFunc(x2);
        end
        
        % Solving system, calculatin nodes
        function [root1, root2, root3, root4] = solveSystemN4(obj)
            syms x1 x2 x3 x4
      
            A1 = (0.5)^(obj.alpha + 5)  / (obj.alpha + 5);
            B1 = -(0.5)^(obj.alpha + 4) / (obj.alpha + 4);
            C1 = (0.5)^(obj.alpha + 3)  / (obj.alpha + 3);
            D1 = -(0.5)^(obj.alpha + 2) / (obj.alpha + 2);
            E1 = (0.5)^(obj.alpha + 1)  / (obj.alpha + 1);
            
            A2 = (0.5)^(obj.alpha + 6)  / (obj.alpha + 6);
            B2 = -A1;
            C2 = -B1;
            D2 = -C1;
            E2 = -D1;
            
            A3 = (0.5)^(obj.alpha + 7)  / (obj.alpha + 7);
            B3 = -A2;
            C3 = -B2;
            D3 = -C2;
            E3 = -D2;
            
            A4 = (0.5)^(obj.alpha + 8)  / (obj.alpha + 8);
            B4 = -A3;
            C4 = -B3;
            D4 = -C3;
            E4 = -D3;
            [root1, root2, root3, root4] = solve(...
                A1 + B1*(x1) + C1*(x2) + D1*(x3) + E1*(x4) == 0,...
                A2 + B2*(x1) + C2*(x2) + D2*(x3) + E2*(x4) == 0,...
                A3 + B3*(x1) + C3*(x2) + D3*(x3) + E3*(x4) == 0,...
                A4 + B4*(x1) + C4*(x2) + D4*(x3) + E4*(x4) == 0);
            sum1 = root1(1);
            sum2 = root2(1);
            sum3 = root3(1);
            sum4 = root4(1);
            [root1, root2, root3, root4] = solve(...
                x1 + x2 + x3 + x4 == sum1,...
                x1*x2 + x1*x3 + x2*x3 + x1*x4 + x2*x4 + x3*x4 == sum2,...
                x1*x2*x3 + x1*x2*x4 + x1*x3*x4 + x2*x3*x4 == sum3, ...
                x1*x2*x3*x4 == sum4);
            root1 = root1(1);
            root2 = real(root2(1));
            root3 = real(root3(1));
            root4 = root4(1);
        end
        
        % Calculate quadrature fotmula in case n=4
        function value = quadrN4(obj)
            % Precalculated values
            [x1, x2, x3, x4] = obj.solveSystemN4();
            x1 = real(eval(x1));
            x2 = real(eval(x2));
            x3 = real(eval(x3));
            x4 = real(eval(x4));
            fprintf('Node(1)=');
            disp(x1); 
            fprintf('Node(2)=');
            disp(x2);
            fprintf('Node(3)=');
            disp(x3); 
            fprintf('Node(4)=');
            disp(x4);
            A1func = integral(@(x) (obj.pFunc(x).*(x - x2).*(x - x3).*(x - x4)), obj.lowBound, obj.highBound);
            A2func = integral(@(x) (obj.pFunc(x).*(x - x1).*(x - x3).*(x - x4)), obj.lowBound, obj.highBound);
            A3func = integral(@(x) (obj.pFunc(x).*(x - x1).*(x - x2).*(x - x4)), obj.lowBound, obj.highBound);
            A4func = integral(@(x) (obj.pFunc(x).*(x - x1).*(x - x2).*(x - x3)), obj.lowBound, obj.highBound);
            % Interpolation condition
            A1 = A1func./((x1 - x2)*(x1 - x3)*(x1 - x4));
            A2 = A2func./((x2-x1)*(x2-x3)*(x2-x4));
            A3 = A3func./((x3-x1)*(x3-x2)*(x3-x4));
            A4 = A4func./((x4-x1)*(x4-x2)*(x4-x3));
            fprintf('A(1) =');
            disp(A1);
            fprintf('A(2) =');
            disp(A2);
            fprintf('A(3) =');
            disp(A3);
            fprintf('A(4) =');
            disp(A4);
            value = A1 .* obj.fFunc(x1) + A2 .* obj.fFunc(x2)+ A3 .* obj.fFunc(x3) + A4 .* obj.fFunc(x4);
        end
        
        function output(obj)
            format long;
            disp('                   Quadrature formula calculation');
            fprintf('\n');
            
            disp('                             CASE N == 2');
            answer1 = obj.quadrN2;
            fprintf('Integral value  = ');
            disp(obj.idealCalc);
            fprintf('Quadrature(N=2) = ');
            disp(answer1);
            
            fprintf('\n');
            fprintf('\n');
            
            disp('                            CASE N == 4');
            answer2 = obj.quadrN4;
            fprintf('Integral value  = ');
            disp(obj.idealCalc);
            fprintf('Quadrature(N=4) = ');
            disp(answer2);
        end
    end
    
end
 