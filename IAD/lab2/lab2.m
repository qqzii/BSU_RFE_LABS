%открытие файла с данными по данному пути
file = fopen('D:\Education\IAD_labs\Morozov_lab2\data1.txt', 'r');
%читает из файла в вектор matrix, использует тип "плавающая точка"
%колонок - 3, строк - сколько есть
matrix = fscanf(file, '%g %g %g', [3, inf]);
fclose(file);

%транспонируем полученную матрицу
t_matrix = matrix';
X = t_matrix(: , 1);
Y = t_matrix(: , 2);
Sigma = t_matrix(: , 3);

plot(X,Y, 'kx', X,Y,'r');
title ('Исходные данные');
xlabel ('Ось X');
ylabel ('Ось Y');

%вариант 1 - законы распределения: показательный(6), Релея(3), Лапласа(5)

%beta - коэф бетта
%R - остатки
%J - якобиан
%Covb - матрица ковариаций

%показательное распределение (6)
argument1 = [1, 1];
[beta1, R1, J1, Covb1] = nlinfit(X, Y, @pokazat, argument1);
figure;
plot (X, Y, 'kx');
title ('Аппроксимация по показательному распределению');
xlabel ('Ось X');
ylabel ('Ось Y');
hold on
Y1 = pokazat(beta1,X);
plot (X, Y1, 'r');
hold off

%распределение Релея(3)
argument2 = [1, 1]; 
[beta2, R2, J2, Covb2] = nlinfit(X, Y, @relay, argument2);
figure;
plot (X, Y, 'kx');
title ('Аппроксимация по Релею');
xlabel ('Ось X');
ylabel ('Ось Y');
hold on
Y2 = relay(beta2,X);
plot(X, Y2, 'r');
hold off

%распределение Лапласа(5)
argument3 = [1, 1];
[beta3, R3, J3, Covb3] = nlinfit(X, Y, @laplas, argument3);
figure;
plot (X, Y, 'kx');
title ('Аппроксимация по Лапласу');
xlabel ('Ось X');
ylabel ('Ось Y');
hold on 
Y3 = laplas(beta3, X);
plot (X, Y3, 'r');
hold off

%критерий кси v^2
ksiv2_pokaz = ksiv2(Y1, Y, Sigma,(200 - 2 - 1));
ksiv2_relay = ksiv2(Y2, Y, Sigma,(200 - 2 - 1));
ksiv2_laplas = ksiv2(Y3, Y, Sigma,(200 - 1 - 1));

%Взвешенные остатки
res_pokaz = res(Y1, Y, Sigma);
res_relay = res(Y2, Y, Sigma);
res_laplas = res(Y3, Y, Sigma);

figure;
plot(X,res_pokaz, X,zeros(1,200),'r');
title('График взвешенных остатков по показательному распределению');
xlabel('Ось X');
ylabel('Ось Y');

%Автокорреляционная функция взвешенных остатков
N=1:100;
auto_pokaz = autocorr(res_pokaz);
auto_relay = autocorr(res_relay);
auto_laplas = autocorr(res_laplas);
figure;
plot(N, auto_pokaz,N,zeros(1,100),'r');
title('Автокорреляционная функция')
xlabel('k');
ylabel('Автокорреляция(k)');

%Доверительный интервал
%теоритическая
interv_pokaz = nlparci(beta1, R1, 'jacobian', J1, 'alpha', 0.68);
interv_relay = nlparci(beta2, R2, 'jacobian', J2, 'alpha', 0.68);
interv_laplas = nlparci(beta3, R3, 'jacobian', J3, 'alpha', 0.68);

%практическая
interv_pokaz2(1,1) = beta1(1,1) - tinv(0.68, 199)*sqrt(Covb1(1,1));
interv_pokaz2(1,2) = beta1(1,1) + tinv(0.68, 199)*sqrt(Covb1(1,1));
interv_pokaz2(2,1) = beta1(1,2) - tinv(0.68, 199)*sqrt(Covb1(2,2));
interv_pokaz2(2,2) = beta1(1,2) + tinv(0.68, 199)*sqrt(Covb1(2,2));

interv_relay2(1,1) = beta2(1,1) - tinv(0.68, 199)*sqrt(Covb2(1,1));
interv_relay2(1,2) = beta2(1,1) + tinv(0.68, 199)*sqrt(Covb2(1,1));
interv_relay2(2,1) = beta2(1,2) - tinv(0.68, 199)*sqrt(Covb2(2,2));
interv_relay2(2,2) = beta2(1,2) + tinv(0.68, 199)*sqrt(Covb2(2,2));

interv_laplas2(1,1) = beta3(1,1) - tinv(0.68, 199)*sqrt(Covb3(1,1));
interv_laplas2(1,2) = beta3(1,1) + tinv(0.68, 199)*sqrt(Covb3(1,1));
interv_laplas2(2,1) = beta3(1,2) - tinv(0.68, 199)*sqrt(Covb3(2,2));
interv_laplas2(2,2) = beta3(1,2) + tinv(0.68, 199)*sqrt(Covb3(2,2));

%хорошего дня