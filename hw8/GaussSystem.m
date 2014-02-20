% ����� ������������� ������� ��� ������� ���� ������� ������
function Mat = GaussSystem(inMat)
    rows = size(inMat, 1);
    cols = size(inMat, 2);
    for i = 1 : rows
        % ����������� �� ��, ����� ������� ������� ��� �� 0
        if (inMat(i,i) ~= 0)
            % ����������� ����(������� �������) � ������� 
            inMat(i, :) = inMat(i, :) ./ inMat(i,i);
            for j = i + 1 : size(inMat, 1)
                % �������� ���������� ����� ��������� �� ���� �����
                % �������� �� ���� ����� ���������� x
                inMat(j, :) = inMat(j, :) - inMat(i, :) .* inMat(j, i);
            end
        end
        disp('      a1        a2        a3        a4        a5        b ');
        disp(inMat(:,1:cols - 1));
    end
    Mat = inMat;
end