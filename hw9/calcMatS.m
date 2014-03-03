function matS = calcMatS(matA)
% calcMatS Вычисляет вспомогательную верхнетреугольную матрицу
    rows = size(matA, 2);
    cols = size(matA, 2);
    matS = zeros(rows);
    disp(rows);
    % Вычисляем элменты первой строки
    matS(1,1) = sqrt(matA(1,1));
    matS(1,2 : cols) = matA(1,2 : cols) ./ matS(1,1); 
    % Вычисляем оставшиеся элементы
    for i = 2 : rows
        % Поиск диагональных элементов
        sum1 = 0;
        for l = 1 : i - 1
            sum1 = sum1 + matS(l,i)^2;
        end
        sum1T = matS(1:i - 1, i)'* matS(1:i - 1, i);
        disp('coolSum1');
        disp(sum1T);
        disp('wow');
        disp(sum1);
        matS(i,i) = sqrt(matA(i,i) - sum1);
        %Поиск оставшихся (недиагональных) элементов
        for j = i + 1 : rows
            sum2 = 0;
            for l = 1 : i - 1
                sum2 = sum2 + matS(l,i) * matS(l,j);
            end
            disp('wow');
            disp(sum2);
            sum2T = matS(1 : i -1, i)' * matS(1 : i-1, j);
            disp('coolSum2');
            disp(sum2T);
            matS(i, j) = (matA(i, j) - sum2) / matS(i,i);
        end
    end
    
end

