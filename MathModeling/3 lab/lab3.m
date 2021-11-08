clear all;
close all;
clc;

a = 0;
b = pi/2;
n = 10000;
Beta = 0.95;
y_b = norminv(1 - (1 - Beta)/2);


pdf = @(x)1./(1+cos(x));
%pdf_integ = @(x)tan(x / 2);
inv_function = @(x) 2 * atan(x);


z = rand(1, n);
x = inv_function(z);

m = sum(x) / n;
m_pdf = integral(@(x)x.*pdf(x),a, b);

disp(['mean practical ' num2str(m)]);
disp(['mean teor      ' num2str(mean(x))]);
disp(['mean teor pdf  ' num2str(m_pdf)]);

sig=std(x);

true_a = m - (y_b * sig) / sqrt(n);
true_b = m + (y_b * sig) / sqrt(n);

disp(['[' num2str(true_a) '; ' num2str(true_b) ']']);

D = 1/(n - 1) * sum(x.^2) - 1 / (n * (n-1)) * sum(x)^2;
D_pdf = integral(@(x)x*x*pdf(x), a, b,'ArrayValued', true) - m_pdf^2;
disp(['dispers     :     ' num2str(D)]);
disp(['dispers teor:     ' num2str(var(x))]);

disp(['dispers teor pdf: ' num2str(D_pdf)]);

X = linspace(a,b,n);
figure;
[X_hist , c] = hist(x, 100);
X_hist = X_hist/(n * (c(2) - c(1)));
plot(X,pdf(X), c, X_hist, 'r--');