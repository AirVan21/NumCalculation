syms t
% Function for t - interation function
G = 26.277*(1.6802 - 1.6568 - t*(t-1)/2*(-0.00433) - 0.000044*t*(t-1)*(t-2)/6 - 0.000021*t*(t-1)*(t-2)*(t-3)/24);
devG = diff(G,t);
% Shows that |degG(t)| < 1
ezplot(devG, [0 2]);