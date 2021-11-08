function result = relay(argument2, X) 

sigma = argument2(1);

result = (X/(sigma.^2)).*(exp(-((X.^2)/(2.*(sigma.^2)))));

end