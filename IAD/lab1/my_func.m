function [X,Y]=my_func(X_left, X_right, Y_left, Y_right, N)
%��������� N �������� ��������� �������� X � ������� ������� X
X=X_left + rand(N,1)*(X_right - X_left);
%��������� N �������� ��������� �������� Y � ������� ������� Y
Y=Y_left + rand(N,1)*(Y_right - Y_left); 