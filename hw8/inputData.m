% �������� �������
A = [5.11, -2.32,  0.46,  1.52,     0,  6.0109;
     1.17, -4.08, -3.25,  3.25,  2.34,  0.5958; 
        0,  1.04,  3.78,  2.15,  1.83,  16.1971;
        0,  2.32,  2.05, -3.50,  1.25, -0.7410;
        0,     0,  1.82,  2.64, -4.79,  3.8015;];
 % ��������� ������� ������ ��������
 NullTest = zeros(size(A,1),1);
 disp(' ������� ������');
 A = [A, NullTest];
 cols = size(A,2);
 % ��������� ������� �������� (����� ����)
 for i = 1 : size(A,1)
    A(i,cols) = sum(A(i,:));
 end
 disp('      a1        a2        a3        a4        a5        b        ~b1');
 disp(A);
 result = GaussSystem(A);
 % ��������� ����������� �������
 for i = 1 : size(A,1)
     % " - 1" �.�. �� ������� ����������� �������� �������
    NullTest(i,1) = sum(A(i,1:cols - 1));
 end
 disp(' �������� �������� �������');
 disp('     ~b1       ~b2 ');
 disp([A(:, cols), NullTest(:,1)]);
 disp(' ��������� ���������� ����������� ������� X :');
 disp(CalcAnswer(result(:,1 : cols - 1)));
 disp(' ����������� ������� X:');
 disp(linsolve(A(:, 1 : cols - 2), A(:, cols - 1)));
 