% Определение неизвестных по треугольной матрице
% inMat = [A,B]
function answerX = CalcAnswerUp(inMat)
    rows = size(inMat, 1);
    cols = size(inMat, 2);
    answerX = zeros(rows,1);
    for i = rows : -1 : 1
        % Оставляем единицу перед x(i), который ищем
        inMat(i, :) = inMat(i, :) ./ inMat(i,i); 
        % Добавляем значение из столбца b
        answerX(i) = inMat(i, cols);
        % Вычитаем известные значения
        for j = i : rows -1
            answerX(i) = answerX(i) - inMat(i, j + 1) * answerX(j + 1);
        end
    end
end