fid = fopen('D:\Education\IAD_labs\Morozov_lab5\data1.txt', 'r');

X0 = fscanf(fid, '%g %g ', [2 inf]);
X = X0';
fclose(fid);

figure;
plot(X(:,1), X(:,2), '*');


numClust = 2; % количество центров кластеров
C = zeros(numClust,2); % задание начальных центров кластеров 4x2

for i = 1 : numClust
    C(i, :) = X(i , :);
end

%В первом столбце матрицы U содержатся индексы кластеров, к которым
%относятся объекты данных, во втором столбце – расстояния от объектов до
%соответственных центров кластеров.
U = zeros(length(X) , 2);
eps = 1e-6;
Q = 1000;%функционал качества кластеризации
q = 0;

R = zeros(1,numClust);%1x2
for i = 1 : length(X) % расчёт расстояний до центров кластеров, заполнение матрицы U
        for n = 1 : numClust
        R(n) = pdist([X(i , :) ; C(n , :)],'minkowski', 4);
%функция позволяет рассчитать расстояния
%между парами объектов исходного множества данных
        end 

    for n = 1 : numClust
        if R(n) == min(R)
            U(i,1) = n;
            U(i,2) = R(n);
        end
    end
end

%качества кластеризации

while abs(Q - q)>eps
    
    Q = q
    
    C = zeros(numClust,2); %зануление прежних координат, для того чтобы записать на их место новые
    for l = 1 : numClust  % расчёт новых центров кластеров, заполнение С
        n = 0;
        for j = 1 : length(U)
            if (U(j,1)==l)
                n = n+1;
                C(l, :) = C(l, :) + X(j , :);
            end
        end
        C(l, :) = C(l, :)./n; %поделили сумму всех координат точек 
        %принадлежащих этому кластеру на число этих точек - 
        %получили координаты центра этого кластера
    end
    
    P = zeros(1,numClust);
    for i = 1 : length(X) % расчёт расстояний до центров кластеров, заполнение матрицы U
        for n = 1 : numClust
        P(n) = pdist([X(i , :) ; C(n , :)],'minkowski', 4);
        end 

        for n = 1 : numClust
            if P(n) == min(P)
                U(i,1) = n;
                U(i,2) = P(n);
            end
        end
    end 
    
    u = zeros(1,numClust);
    for l = 1 : numClust  % расчёт и заполнение Q
        for j = 1 : length(U)
            if (U(j,1)==l)
                u(l) = u(l)+U(j,2);
            end
        end
    end
    q = sum(u); % пересчитанный параметр
  
end

figure
gscatter(X(:,1), X(:,2), U(:,1))
hold on
scatter(C(:,1),C(:,2),'*')    

   