% Определение неизвестных по треугольной матрице
% inMat = [A,B]
function answerX = CalcAnswerDown(inMat)
    rows = size(inMat, 1);
    cols = size(inMat, 2);
    answerX = zeros(rows,1);
    for i = 1 : rows
        % Оставляем единицу перед x(i), который ищем
        inMat(i,:) = inMat(i, :) ./ inMat(i,i);
        % Добавляем значение из столбца b
        answerX(i) = inMat(i, cols);
        % Вычитаем известные значения
        for j = 1 : i - 1
            answerX(i) = answerX(i) - inMat(i, j) * answerX(j);
        end
    end
end