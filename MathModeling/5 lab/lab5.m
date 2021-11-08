clear all;
close all;
clc;

P = @(x) 3./4.^(x+1);
N = 100;
n = 20;
k = 0:n;
z = rand(1, N);
x = zeros(1, N);
p = P(k);
q = 1;
for i = z
    s = i;
    j = 0;
    while s > 0
        j = j + 1;
        s = s - p(j);
    end
    x(q) = k(j);
    q = q + 1;
end

mean_pract = sum(k.*p);
disp(['mean pract: ' num2str(mean_pract)]);
disp(['mean teor:  ' num2str(mean(x))]);

disp_pract = sum(k.*k.*p) - mean_pract^2;
disp(['disp pract: ' num2str(disp_pract)]);
disp(['disp teor:  ' num2str(var(x))]);


figure;
X_hist = hist(x, k);
X_hist = X_hist/N;
plot(k, p, '*b--', k, X_hist, 'r--');


x2n = 0;
X_hist = hist(x, k);
for i = k + 1;
    x2n = x2n + (X_hist(i)/ N - p(i))^2/p(i);
end
x2n = x2n*N;
disp(x2n);
disp(chi2inv(0.95, n - 1));
