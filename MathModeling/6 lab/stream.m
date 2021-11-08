function [y] = stream(start, finish, lambd)
    y = [];
    y(1) = start;
    while y(end) < finish
    y(end + 1) = y(end) - log(rand)/lambd;
    end
end