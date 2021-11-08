%открываем файл для чтения
file = fopen('D:\Education\IAD_labs\Morozov_lab3\data1.txt', 'r');
Xr = fscanf(file, '%g %g %g', [8 inf]); %8x100 
fclose(file);

X=Xr';

for i=1:8
    expec(i) = mean(X(:,i));%мат ожидание столбцов, массив 1x8
    deviat(i) = std(X(:,i));%среднеквадратическое отклонение столбцов, массив 1x8
end

%нормировка
for i=1:100
    for j= 1:8
        new_X(i,j) = (X(i,j) - expec(j))/deviat(j);
    end
end
%display(new_X)
for i=1:8
    new_expec(i) = mean(new_X(:,i)); %мат ожидание столбцов, миссив 1x8
    new_deviat(i) = std(new_X(:,i)); %среднеквадратическое отклонение столбцов, массив 1x8
end
%матрица ковариации
R = (new_X'*new_X)/(100-1);

d = 0;
for i=1:8                           
    for j=(i+1):8
        d = d + R(i,j).^2;
    end
end

d = d*100
Chi = chi2inv(0.95, (8*(8-1))/2)% критерий согласия 
%Чтобы применение метода главных компонент было целесообразно, должно быть d > Chi

%Вычислить матрицы A и путем решения систем линейных уравнений
[A, D] = eig(R);
%eig - поиск собственных векторов, удовлетворяющих соотношению R* A = A * D 
%Норма каждого из этих векторов = 1
A=fliplr(A);
D=fliplr(D);
D=flipud(D);

Z = new_X * A;%проекции объектов на главные компоненты

answer = sum(sqrt(new_deviat)) - trace(D)

%Относительная доля разброса, приходящаяся на j-ую главную компоненту
Alpha = zeros(8, 1); %8x1
for j=1:8
    Alpha(j) = D(j,j)/trace(D);     
end

%Относительная доля разброса, приходящаяся на i первых компонент
Gamma = zeros(8, 1);%8x1
for j=1:8
    Gamma(j)=0;
    for i=1:j
        Gamma(j) = Gamma(j) + Alpha(i);
    end
end

%матрица ковариации
COV = cov(Z);

scatter(Z(:,1),Z(:,2),'filled')

%хорошего дня