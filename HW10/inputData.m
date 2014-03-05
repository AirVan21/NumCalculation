% Input data
matA = [10.409187, 1.2494191, -3.2136953;
        1.2494191, 7.9045365,  0.74772162;
       -3.2136953, 0.74772162, 6.2719819;];
B = [2.6696963; -6.9807383; 0.1542235];
B1 = [15.37747; 1.015936; -8.59566];
delta = 10^(-5);
fprintf('\n\n');
disp('   Simple test. Diagonal dominance - true');
disp('      a1        a2        a3        b');
disp([matA, B]);
[ansX, iterStep] = iterMethod([matA,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matA * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
fprintf('\n\n');


disp('   Test diagonal * 10. Diagonal dominance - true');
matA10 = matA;
for i = 1 : length(matA)
    matA10(i,i) = matA10(i,i) * 10;
end
disp('      a1        a2        a3        b');
disp([matA10, B]);
[ansX, iterStep] = iterMethod([matA10,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matA10 * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
fprintf('\n\n');


disp('   Test diagonal * 100. Diagonal dominance - true');
matA100 = matA;
for i = 1 : length(matA)
    matA100(i,i) = matA100(i,i) * 100;
end
disp('      a1        a2        a3        b');
disp([matA100, B]);
[ansX, iterStep] = iterMethod([matA100,B], B1, delta);
disp('    Solution (X) :');
disp(ansX);
disp('   Test(A*X)  Data(b)');
disp([matA100 * ansX, B]);
fprintf('   Iteration number = %d\n', iterStep);
fprintf('\n\n');



