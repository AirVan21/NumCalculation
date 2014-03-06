% Input data
matA = [10.409187, 1.2494191, -3.2136953;
        1.2494191, 7.9045365,  0.74772162;
       -3.2136953, 0.74772162, 6.2719819;];
B = [2.6696963; -6.9807383; 0.1542235];
B1 = [15.37747; 1.015936; -8.59566];
delta = 10^(-5);
% Constant for testing
theta = 0.1;
fprintf('\n\n');
disp('   Nekrasov`s test. Diagonal dominance - true');
disp('      a1        a2        a3        b');
disp([matA, B]);
[ansX, iterStep] = nekrasovMethod([matA,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matA * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
disp('______________________________________________________________________________________');
fprintf('\n\n');


disp('   Test diagonal * 10. Diagonal dominance - true');
matA10 = matA;
for i = 1 : length(matA)
    matA10(i,i) = matA10(i,i) * 10;
end
disp('      a1        a2        a3        b');
disp([matA10, B]);
[ansX, iterStep] = nekrasovMethod([matA10,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matA10 * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
disp('______________________________________________________________________________________');
fprintf('\n\n');


disp('   Test diagonal * 100. Diagonal dominance - true');
matA100 = matA;
for i = 1 : length(matA)
    matA100(i,i) = matA100(i,i) * 100;
end
disp('      a1        a2        a3        b');
disp([matA100, B]);
[ansX, iterStep] = nekrasovMethod([matA100,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matA100 * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
disp('______________________________________________________________________________________');
fprintf('\n\n');


disp('   Test first diagonal (A(1,1) dominance less = 0,1)');
matAD11 = matA;
matAD11(1,1) = sum(abs(matAD11(1,:))) - matAD11(1,1) - theta; 
disp('      a1        a2        a3        b');
disp([matAD11, B]);
[ansX, iterStep] = nekrasovMethod([matAD11,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matAD11 * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
disp('______________________________________________________________________________________');
fprintf('\n\n');

disp('   Test second diagonal (A(1,1) dominance less = 0,1 && A(2,2) dominance less = 0,1;)');
matAD22 = matAD11;
matAD22(2,2) = sum(abs(matAD22(2,:))) - matAD22(2,2) - theta; 
disp('      a1        a2        a3        b');
disp([matAD22, B]);
[ansX, iterStep] = nekrasovMethod([matAD22,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matAD22 * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
disp('______________________________________________________________________________________');
fprintf('\n\n');


for i = -0.5:0.1:0.0
    fprintf('   Test third diagonal (A(1,1) && A(2,2) dominance less = 0.1;\n   A(3,3) dominance less = %d;)\n',i);
    matAD33 = matAD22;
    matAD33(3,3) = sum(abs(matAD33(3,:))) - matAD33(3,3) - i; 
    disp('      a1        a2        a3        b');
    disp([matAD33, B]);
    [ansX, iterStep] = nekrasovMethod([matAD33,B], B1, delta);
    disp('    Solution (X) :');
    disp(ansX);
    disp('   Test(A*X)  Data(b)');
    disp([matAD33 * ansX, B]);
    fprintf('   Iteration number = %d\n', iterStep);
    disp('______________________________________________________________________________________');
    fprintf('\n\n');
end

