function matS = calcMatS(matA)
% calcMatS ��������� ��������������� ����������������� �������
    rows = size(matA, 2);
    cols = size(matA, 2);
    matS = zeros(rows);
    % ��������� ������� ������ ������
    matS(1,1) = sqrt(matA(1,1));
    matS(1,2 : cols) = matA(1,2 : cols) ./ matS(1,1); 
    % ��������� ���������� ��������
    for i = 2 : rows
        % ����� ������������ ���������
        sum1 = matS(1:i - 1, i)'* matS(1:i - 1, i);
        matS(i,i) = sqrt(matA(i,i) - sum1);
        
        %����� ���������� (��������������) ���������
        for j = i + 1 : rows
            sum2 = matS(1 : i -1, i)' * matS(1 : i-1, j);
            matS(i, j) = (matA(i, j) - sum2) / matS(i,i);
        end
    end  
end

