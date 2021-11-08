clear all;
close all;
clc;

lambda = 5;
a = 0;
b = 2;

m = 100;
bins = 10; 
vectHists = []; 
vectLens = zeros(1, m);
lam = zeros(1, bins); 

for i = 1:m
    temp = stream(a, b, lambda);
    vectHists = [vectHists; hist(temp, bins)]; 
    vectLens(i) = length(temp);
end 
step = (b - a)/ bins;
result = sum(vectHists);

for i = 1:bins
    lam(i) = result(i)/(m * step);
end


k = 0:max(vectLens); 
nk = hist(vectLens, k);
p = zeros(1, length(k));

for i = 1:length(k)
   p(i) = nk(i)/ m; 
end

bar(1:length(k),p);
figure;
bar(a+step/2:step:b-step/2,lam);