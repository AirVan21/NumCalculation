x = -15:0.1:15;
y = sin(x)./x;
v = sin(x.^3/100);
z = sin(x);
plot(x, y, x, z, '-',x ,v , ':');