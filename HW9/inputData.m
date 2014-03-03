% ������� ��� ������� ����������� �����
% matA - ������������ �������
matA = [2.34,  0.91, 0.91, -0.5; 
        0.91,  -2.12, 0.91, 1.02;
        0.91,  0.91, 2.07, 1.02;
        -0.5,  1.02, 1.02, 2.14];
B = [5.7565; -3.5570; 3.9305; 0.3590]; 
disp('������� ������ A * X = B');
disp([matA,B]);
matA2 = matA * matA;
AB = matA * B;
disp('������� � ������� A^(2) * X = A * B'); 
disp([matA2,AB]);
matS = calcMatS(matA2);
disp('���������������� ������� S ��� ������ �������');
disp(matS);
disp('���������������� ������� S` ��� ����� �������');
disp(matS');
disp('�������� S` * S = A^2');
disp(matS' * matS);
% S' * S * X = A * B
% S' * Y = A * B, ��� S * X = Y
matY = CalcAnswerDown([matS', AB]);
matX = CalcAnswerUp([matS, matY]);
disp('   ������� (X) :');
disp(matX);
disp('  �������� | �������');
disp([matA * matX, B]);



 