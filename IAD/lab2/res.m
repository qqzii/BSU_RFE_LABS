function [res__] = res(Fx, Y, Sigma)

for k=1:200
    res__(k) = (Fx(k) - Y(k))/Sigma(k);
end

end

