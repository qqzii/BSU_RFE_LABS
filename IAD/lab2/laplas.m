function result = laplas(argument3, X) 

a = argument3(1);
b = argument3(2);

result = (a/2)*exp(-a*abs(X-b));

end