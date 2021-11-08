%��������� ���� ��� ������
file = fopen('D:\Education\IAD_labs\Morozov_lab4\data1.txt', 'r');
%������ �� ����� � ������� X0, ��������� ��� "��������� �����"; 8 ������� ��
%�����
X0 = fscanf(file, '%g %g', [2 inf]); %24x2 
fclose(file);

X=X0';
figure
plot(X(:,1),X(:,2), '*');

qualityFactor = zeros(3);
%The Euclidean distance
DEuclidean = pdist(X, 'euclidean'); %DEuclidean 1x276(m-1)*m/2
%��������� ����������
%������� ��������� ���������� ������ ���������� ���������� 
%����� ������ �������� ��������� ��������� ������, �������� �������� �.


EuclideanComplete = linkage(DEuclidean,'complete');%�������� "�������� ������".
%������� ��������� ������������ ������������� ������ �������� ��������� 
%� �������������� ���������. 
%������� �������� Deuclidean �������� �������� ���������� ����� ������ �������� 
%��������� ��������� ������ � ����������� ������������.
%�������� �������� EuclideanAverage �������� ��������, ���������� ���������� 
%� ������ ���������. ����������� EuclideanComplete ����� (m-1)x3
%������� 1 � 2 ������� EuclideanComplete �������� ������� ��������, ��������� � ����� �������. 
%���������� �������������� �������� ��������� ����� ����� (m-1).
%3-� ������� ������� EuclideanComplete �������� �������� ���������� ����� ������ ��������, 
%������������ � ��������.
qualityFactor(1,1) = cophenet(EuclideanComplete, DEuclidean);
%������ ������������ �������� ��������� �������� ������ �� �������� 
%(���� ����������� ����� ������������� ��� ������ ������������ ����������, 
%��� ��� �������� ����� � 1, ��� ����� ��������� ��������� �� ��������)
EuclideanAverage = linkage(DEuclidean,'average');%�������� "������� �����"
qualityFactor(1,2) = cophenet(EuclideanAverage, DEuclidean);

EuclideanCentroid = linkage(DEuclidean,'centroid');
%����������� ��������, ������������ ���������� �� "������� �������" �������.
qualityFactor(1,3) = cophenet(EuclideanCentroid, DEuclidean);

%Mahalanobis
DMahalanobis = pdist(X, 'mahalanobis');%���������� ������������.

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
% ������� ������������ �� 4 ��������� � ��������������
% ���������� � �������� ��������. ������ ������� ���� � ������ ������������
% ���������� ����� ����� ��������� ������� � ���� ����. ������� �������
% ���������� ������, �� ������� "�������������� ����" ����� ������
% �������� 4 ��� ������ ���������. ���� 4-������, T-��� ������� ��������
% ������� � ����� ������� �� ������������ ��������.

figure
gscatter(X(:,1),X(:,2),T);
%������ ��������� ���� ���������� �������������� �� ��������� ������� ����������
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
%�������������� ������� �������� ������ ������� pdist 
%� ������������ ���������� �������
Dclust1_ = Dclust1(1,:);

Dclust2 = squareform(pdist([clust2;mean(clust2)],'euclidean'));
Dclust2_ = Dclust2(1,:);

Dclust3 = squareform(pdist([clust3;mean(clust3)],'euclidean'));
Dclust3_ = Dclust3(1,:);

Dclust4 = squareform(pdist([clust4;mean(clust4)],'euclidean'));
Dclust4_ = Dclust4(1,:);
plot(M(:,1),M(:,2), '*');
hold off