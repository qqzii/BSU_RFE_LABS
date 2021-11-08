x = -5:0.001:5;
y = the_value_of_the_pollynomial(x);
% for i = -5:0.001:5
%     x = [x i];
%     y = [y the_value_of_the_pollynomial(i)]; 
% end

plot(x, y); 
title('y = 7 * x^3 + 5 * x^2 + 5');
xlabel('x');
ylabel('y');
grid on;
hold on;
y1 = f(x);
plot(x, y1);

