[Xplot,Yplot] = meshgrid(-10:0.5:10,-10:0.5:10);
Zplot = myFunction(Xplot,Yplot);
surf(Xplot,Yplot,Zplot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=10000;
M=2;
Ksi = rand(M,N);
A = [-500 -500];
B = [500 500];
for k=1:M
    for i=1:N
        Ke(k,i) = A(k) + (B(k)-A(k)).*Ksi(k,i);
    end
end
Ze = myFunction(Ke(1,:),Ke(2,:));
Min = min(Ze)

for i=1:N
    if(Min == Ze(i))
    Ke(:,i)
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 50;
T0 = 0.0001;
Nu = 0.99;
X0 = [420.98 420.98];
X=X0;
l=0;
while (T>T0)
    l = l + 1;
    z = randn(2,1);
    Ks = rand(2,1);
    
    flag = 0;
    for k=1:M
        Xnew(k) = X(k) + z(k)*T*((1+l/T)^(2*Ks(k)-1)-1);
        if ((A(k) > Xnew(k))||(B(k) < Xnew(k)))
            flag = 1;
        end
    end
    if (flag == 1)
        continue;
    end
    Z = myFunction(X(:,1),X(:,2));
    Znew = myFunction(Xnew(:,1),Xnew(:,2));
    DeltaE = Znew - Z;
    if (DeltaE<0)
        X=Xnew;
    else
        P = exp(-DeltaE/T);
        if (rand()<P)
            X = Xnew;
        else
            T=Nu*T;
        end
    end  
end
X
myFunction(X(1),X(2))