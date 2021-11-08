%открываем файл для чтения
file = fopen('D:\Education\IAD_labs\Morozov_lab4\data1.txt', 'r');
%читаем из файла в матрицу X0, использую тип "плавающая точка"; 8 колонок до
%конца
X0 = fscanf(file, '%g %g', [2 inf]); %24x2 
fclose(file);

X=X0';
figure
plot(X(:,1),X(:,2), '*');

qualityFactor = zeros(3);
%The Euclidean distance
DEuclidean = pdist(X, 'euclidean'); %DEuclidean 1x276(m-1)*m/2
%Евклидово расстояние
%функция позволяет рассчитать вектор Евклидовых расстояний 
%между парами объектов исходного множества данных, заданных матрицей Х.


EuclideanComplete = linkage(DEuclidean,'complete');%Алгоритм "дальнего соседа".
%функция позволяет сформировать иерархическое дерево бинарных кластеров 
%с использованием алгоритма. 
%Входной аргумент Deuclidean является вектором расстояний между парами объектов 
%исходного множества данных в многомерном пространстве.
%Выходной параметр EuclideanAverage является матрицей, содержащей информацию 
%о дереве кластеров. Размерность EuclideanComplete равна (m-1)x3
%Столбцы 1 и 2 матрицы EuclideanComplete содержат индексы объектов, связанных в новый кластер. 
%Количество сформированных бинарных кластеров будет равно (m-1).
%3-й столбец матрицы EuclideanComplete содержит значение расстояний между парами объектов, 
%объединенных в кластеры.
qualityFactor(1,1) = cophenet(EuclideanComplete, DEuclidean);
%Расчет коэффициента качества разбиения исходных данных на кластеры 
%(этот коэффициент можно рассматривать как аналог коэффициента корреляции, 
%чем его значение ближе к 1, тем лучше выполнено разбиение на кластеры)
EuclideanAverage = linkage(DEuclidean,'average');%Алгоритм "средней связи"
qualityFactor(1,2) = cophenet(EuclideanAverage, DEuclidean);

EuclideanCentroid = linkage(DEuclidean,'centroid');
%Центроидный алгоритм, использующий расстояние по "центрам тяжести" выборок.
qualityFactor(1,3) = cophenet(EuclideanCentroid, DEuclidean);

%Mahalanobis
DMahalanobis = pdist(X, 'mahalanobis');%Расстояние Махаланобиса.

MahalanobisComplete = linkage(DMahalanobis,'complete');
qualityFactor(2,1) = cophenet(MahalanobisComplete,DMahalanobis);

MahalanobisAverage = linkage(DMahalanobis,'average');
qualityFactor(2,2) = cophenet(MahalanobisAverage,DMahalanobis);

MahalanobisCentroid = linkage(DMahalanobis,'centroid');
qualityFactor(2,3) = cophenet(MahalanobisCentroid,DMahalanobis);

%Chebyshev
DChebychev = pdist(X, 'chebychev');

ChebychevComplete = linkage(DChebychev,'complete');
qualityFactor(3,1) = cophenet(ChebychevComplete,DChebychev);

ChebychevAverage = linkage(DChebychev,'average');
qualityFactor(3,2) = cophenet(ChebychevAverage,DChebychev);

ChebychevCentroid = linkage(DChebychev,'centroid');
qualityFactor(3,3) = cophenet(ChebychevCentroid,DChebychev);

figure
dendrogram(MahalanobisAverage);
title('MostEffective');
T = cluster(MahalanobisAverage, 'maxclust',4);
% создает максимальное из 4 кластеров с использованием
% расстояние в качестве критерия. Высота каждого узла в дереве представляет
% расстояние между двумя подузлами слились в этом узле. кластер находит
% наименьшая высота, на которой "горизонтальный срез" через дерево
% оставить 4 или меньше кластеров. Если 4-вектор, T-это матрица кластера
% задания с одним столбце на максимальное значение.

figure
gscatter(X(:,1),X(:,2),T);
%График рассеяния двух переменных группированных по значениям третьей переменной
hold on
k1=1;
k2=1;
k3=1;
k4=1;

for i=1:24;
     if (T(i) == 1)
        clust1(k1,:) = X(i,:);
        k1 = k1+1;
     end
     if (T(i) == 2)
        clust2(k2,:) = X(i,:);
        k2 = k2+1;
     end
     if (T(i) == 3)
        clust3(k3,:) = X(i,:);
        k3 = k3+1;
     end
     if (T(i) == 4)
        clust4(k4,:) = X(i,:);
        k4 = k4+1;
     end
end

M = [mean(clust1);mean(clust2);mean(clust3);mean(clust4)];
VAR = [var(clust1);var(clust2);var(clust3);var(clust4)];

DCenters = pdist(M,'euclidean');
Dclust1 = squareform(pdist([clust1;mean(clust1)],'euclidean'));
%Преобразование вектора выходных данных функции pdist 
%в симметричную квадратную матрицу
Dclust1_ = Dclust1(1,:);

Dclust2 = squareform(pdist([clust2;mean(clust2)],'euclidean'));
Dclust2_ = Dclust2(1,:);

Dclust3 = squareform(pdist([clust3;mean(clust3)],'euclidean'));
Dclust3_ = Dclust3(1,:);

Dclust4 = squareform(pdist([clust4;mean(clust4)],'euclidean'));
Dclust4_ = Dclust4(1,:);
plot(M(:,1),M(:,2), '*');
hold off