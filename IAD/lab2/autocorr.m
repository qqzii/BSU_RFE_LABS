function [auto__] = autocorr(R)

znam = 0;

for j = 1:200
    znam = znam + R(j).^2;
end



for k = 1:100
    chis = 0;
    for j = 1:(200 - k+1)
        chis= chis + R(j) .* R(j+k-1);
    end
    auto__(k)=(chis./znam).*200./(200 - k + 1);
end

