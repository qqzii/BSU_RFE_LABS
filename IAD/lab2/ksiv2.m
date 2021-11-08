function [ksiv2__] = ksiv2(Fx, Y, Sigma,V)

ksiv=0;

for k=1:200
    ksiv = ksiv + ((Fx(k)-Y(k))/Sigma(k)).^2;
end

ksiv2__ = ksiv/V;

end

