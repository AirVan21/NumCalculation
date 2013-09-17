syms x y
a = 0.5
k = 0.2
S = solve (a*x^2 + 2*y^2 - 1 == 0, tan(x - y + k) - x*y == 0);
[S.x, S.y]