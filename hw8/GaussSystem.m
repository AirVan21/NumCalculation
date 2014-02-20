% Схема единственного деления для решения СЛАУ методом Гаусса
function Mat = GaussSystem(inMat)
    rows = size(inMat, 1);
    cols = size(inMat, 2);
    for i = 1 : rows
        % Ограничение на то, чтобы ведущий элемент был не 0
        if (inMat(i,i) ~= 0)
            % Преобразуем коэф(ведущий элемент) в единицу 
            inMat(i, :) = inMat(i, :) ./ inMat(i,i);
            for j = i + 1 : size(inMat, 1)
                % Вычитаем полученное ранее уравнение из всех строк
                % домножим на коэф перед уединяемым x
                inMat(j, :) = inMat(j, :) - inMat(i, :) .* inMat(j, i);
            end
        end
        disp('      a1        a2        a3        a4        a5        b ');
        disp(inMat(:,1:cols - 1));
    end
    Mat = inMat;
end