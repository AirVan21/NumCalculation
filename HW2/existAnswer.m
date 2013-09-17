% Yes, such values exist.
% a =1.5, k = 1.3
syms x y
a = 1.5;
figure 
for k = 1.2:.1:1.5
    f = tan(x - y + k) - x*y;
    g = a*x^2 + 2*y^2 - 1;
    ezplot(f, [-3,3])
    hold all
    ezplot(g, [-3,3])
end