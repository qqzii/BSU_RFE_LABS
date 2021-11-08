fid = fopen('D:\Education\IAD_labs\Morozov_lab6\data1.txt', 'r');

X0 = fscanf(fid, '%g %g ', [2 inf]);
X = X0';
fclose(fid);

figure;
plot(X(:,1), X(:,2), '*');

numNeuron = 2; % количество центров кластеров
C = zeros(numNeuron,2); % задание начальных центров кластеров numNeuronx2
mnX = min(X(:,1));
mxX = max(X(:,1));
mnY = min(X(:,2));
mxY = max(X(:,2));

C(1,1) = mnX + (mxX-mnX)*rand();
C(2,1) = mnX + (mxX-mnX)*rand();
C(1,2) = mnY + (mxY-mnY)*rand();
C(2,2) = mnY + (mxY-mnY)*rand();

k_max = 1000;
h=0.5;
%F = 1000; f = 0;


R = zeros(1,numNeuron);

for k = 1:k_max
   
    num = ceil(1+(length(X)-1).*rand());
    
    for n = 1 : numNeuron
         R(n) = pdist([X(num , :) ; C(n , :)],'euclidean');
    end 
    
    nC = C;
    
    for n = 1 : numNeuron
        if R(n) == min(R)
          nC(n,1) = C(n,1)+ h*(X(num,1)-C(n,1));
          nC(n,2) = C(n,2)+ h*(X(num,2)-C(n,2));
        end
    end 
    
   % if(((nC(1,1) - C(1,1) > 1e-6) && (nC(1,2)-C(1,2)>1e-6))&&((nC(2,1) - C(2,1) > 1e-6) && (nC(2,2)-C(2,2)>1e-6))))
%     compare = nC-C;
%    if(compare == 0) 
%          k
%         break;
%     end


    C = nC;
    
end

U = zeros(length(X));
for i = 1 : length(X) % расчёт расстояний до центров кластеров, заполнение матрицы U
        for n = 1 : numNeuron
        P(n) = pdist([X(i , :) ; C(n , :)],'euclidean');
        end 

        for n = 1 : numNeuron
            if P(n) == min(P)
                U(i) = n;
                %U(i,2) = P(n);
            end
        end
end 

figure
scatter(C(:,1),C(:,2),'*')
hold on
gscatter(X(:,1), X(:,2), U(:,1))
