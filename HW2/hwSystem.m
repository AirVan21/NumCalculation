syms x y
figure 
for k = -0.2:.1:0.2
    for a = 0.5:.1:1
        f = tan(x - y + k) - x*y;
        g = a*x^2 + 2*y^2 - 1;
        ezplot(f, [0,2])
        hold all
        ezplot(g, [0,2])
    end
end