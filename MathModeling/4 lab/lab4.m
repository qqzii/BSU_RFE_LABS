clear all;
close all;
clc;

f = @(x)3*(x - 1).^2; %pdf
a = 1;
b = 2;
n = 100;
x = linspace(a,b,n); %разбили на 100 точек
F = f(x);
int_f = @(x)(x - 1)^3;
maxF = max(F);

N = 10000;
X = zeros(1, N);
i = 1;
while i<=N
    ay = maxF*rand;
    ax = a + (b - a)*rand;
    if ay < f(ax)
        X(i) = ax;
        i = i + 1;
    end
end

figure;
[X_hist , c] = hist(X, n);
X_hist = X_hist/(N * (c(2) - c(1)));
plot(x,f(x), c, X_hist, 'r--');

Q = sort(X);
W2 = 1 / (12 * N);
for i = 1:1:N
    W2 =  W2 + (int_f(Q(i)) - (i - 0.5) / N)^2;
end
disp(['w^2: ' num2str(W2)]);

k = 400;
x = linspace(a,b,k);
P = zeros(1, k);
n = hist(X, x);

for i = 2:1:k
    P(i) = int_f(x(i)) - int_f(x(i - 1));
end

x2n = 0;

for i = 2:1:k
    x2n = x2n + (n(i)/ N - P(i))^2/P(i);
end
x2n = x2n*N;
disp(x2n);
disp(chi2inv(0.95, k - 1));

