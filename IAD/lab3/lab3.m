%��������� ���� ��� ������
file = fopen('D:\Education\IAD_labs\Morozov_lab3\data1.txt', 'r');
Xr = fscanf(file, '%g %g %g', [8 inf]); %8x100 
fclose(file);

X=Xr';

for i=1:8
    expec(i) = mean(X(:,i));%��� �������� ��������, ������ 1x8
    deviat(i) = std(X(:,i));%�������������������� ���������� ��������, ������ 1x8
end

%����������
for i=1:100
    for j= 1:8
        new_X(i,j) = (X(i,j) - expec(j))/deviat(j);
    end
end
%display(new_X)
for i=1:8
    new_expec(i) = mean(new_X(:,i)); %��� �������� ��������, ������ 1x8
    new_deviat(i) = std(new_X(:,i)); %�������������������� ���������� ��������, ������ 1x8
end
%������� ����������
R = (new_X'*new_X)/(100-1);

d = 0;
for i=1:8                           
    for j=(i+1):8
        d = d + R(i,j).^2;
    end
end

d = d*100
Chi = chi2inv(0.95, (8*(8-1))/2)% �������� �������� 
%����� ���������� ������ ������� ��������� ���� �������������, ������ ���� d > Chi

%��������� ������� A � ����� ������� ������ �������� ���������
[A, D] = eig(R);
%eig - ����� ����������� ��������, ��������������� ����������� R* A = A * D 
%����� ������� �� ���� �������� = 1
A=fliplr(A);
D=fliplr(D);
D=flipud(D);

Z = new_X * A;%�������� �������� �� ������� ����������

answer = sum(sqrt(new_deviat)) - trace(D)

%������������� ���� ��������, ������������ �� j-�� ������� ����������
Alpha = zeros(8, 1); %8x1
for j=1:8
    Alpha(j) = D(j,j)/trace(D);     
end

%������������� ���� ��������, ������������ �� i ������ ���������
Gamma = zeros(8, 1);%8x1
for j=1:8
    Gamma(j)=0;
    for i=1:j
        Gamma(j) = Gamma(j) + Alpha(i);
    end
end

%������� ����������
COV = cov(Z);

scatter(Z(:,1),Z(:,2),'filled')

%�������� ���