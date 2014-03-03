% ����������� ����������� �� ����������� �������
% inMat = [A,B]
function answerX = CalcAnswerUp(inMat)
    rows = size(inMat, 1);
    cols = size(inMat, 2);
    answerX = zeros(rows,1);
    for i = rows : -1 : 1
        % ��������� ������� ����� x(i), ������� ����
        inMat(i, :) = inMat(i, :) ./ inMat(i,i); 
        % ��������� �������� �� ������� b
        answerX(i) = inMat(i, cols);
        % �������� ��������� ��������
        for j = i : rows -1
            answerX(i) = answerX(i) - inMat(i, j + 1) * answerX(j + 1);
        end
    end
end