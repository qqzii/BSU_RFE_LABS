clc;
clear all;
close all;

a = 0;
b = 1.5;
M = 11750;
K = 18;
LAMBDA = 8.0;
N = 1;
L = [32 316 1000 3162 M];

norm_random_variable = normrnd(a, b, N, M);
%disp(norm_random_variable);
discrete_random_variable = poissrnd(LAMBDA, N, M);
%disp(norm_random_variable(1:20));
disp(['norm_random_variable(1:' num2str(K) '):']);
disp(norm_random_variable(1:K));
disp(['discrete_random_variable(1:' num2str(K) '):']);
disp(discrete_random_variable(1:K));

disp(['max continuos: ' num2str(max(norm_random_variable))]);
disp(['min continuos: ' num2str(min(norm_random_variable))]);
disp(' ');
disp(['max discrete: ' num2str(max(discrete_random_variable))]);
disp(['min discrete: ' num2str(min(discrete_random_variable))]);
disp(' ');
disp(['mean continuos: ' num2str(mean(norm_random_variable)) ' mean_teor continuos: ' num2str((a + b) / 2)]);
disp(['mean discrete: ' num2str(mean(discrete_random_variable)) ' mean_teor discrete: ' num2str(LAMBDA)]);
%4.4
temp = [];
for i = L
    temp(end + 1) = mean(norm_random_variable(1:i));
end

plot(log10(L), temp);
hold on;
temp = [a a a a a];
plot(log10(L), temp); 
hold off;

disp(['std: ' num2str(std(norm_random_variable)) ' std_teor: ' num2str(sqrt((b - a) ^ 2 / 12))]);
disp(['std: ' num2str(std(discrete_random_variable)) ' std_teor: ' num2str(sqrt(LAMBDA))]);
discrete_hist = 1:max(discrete_random_variable);

figure; 
hist_estim = hist(discrete_random_variable, discrete_hist);  
hist_estim_norm = hist_estim/length(discrete_random_variable); 
pdf_theory = poisspdf(discrete_hist,LAMBDA);  % <----
bar(discrete_hist,hist_estim_norm)      
hold on; 
plot(discrete_hist, pdf_theory, 'b');    
hold off; 
title('PDF for normorm discrete distribution'); 
xlabel('value'); 
ylabel('PDF'); 
grid on; 

figure;
%norm_random_variable
min_continuos = floor(min(norm_random_variable));
max_continuos = ceil(max(norm_random_variable));
continuos_step = (max_continuos - min_continuos) / 20;
continuos_hits = min_continuos + continuos_step / 2 : continuos_step : max_continuos -  continuos_step/ 2;
hist_estim = hist(norm_random_variable,continuos_hits);
hist_estim_norm = hist_estim/(continuos_step * length(norm_random_variable));
bar(continuos_hits,hist_estim_norm);  
hold on;
plot(continuos_hits,normpdf(continuos_hits, a, b));
hold off;

figure;
cumsum_c = cumsum(hist_estim);
cumsum_c_norm = cumsum_c / max(cumsum_c);
stairs(continuos_hits,cumsum_c_norm);
cumsum_sdf = normcdf(continuos_hits, a, b);
hold on;
plot(continuos_hits, cumsum_sdf);
hold off;

