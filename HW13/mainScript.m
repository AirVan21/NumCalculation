% Решение уравнения теплопроводности методом сеток

% du/dt = a * (d^(2)u / dx^(2)) + f(x,t)

% Parameter's initialization
f = @(x,t) -x*(1-x)/(10+t)^2 + 2/(10+t);
ux0 = @(x) cos(0.5*x) + x*(1-x)/10;
u0t = @(t) exp(-0.25*t);
u1t = @(t) exp(-0.25*t)*cos(0.5);
result = @(x,t) exp(-0.25*t)*cos(0.5*x) + x*(1-x)/(10+t); 

aBound = 0;
bBound = 1;
nStep1 = 10;
nStep2 = 100;

% Step for 'x' line 
stepLength1 = (bBound - aBound) / nStep1;
stepLength2 = (bBound - aBound) / nStep2;

xN1 = zeros(nStep1 + 1, 1);
xN2 = zeros(nStep2 + 1, 1);
% Creates 'x' points
for i = 1 : nStep1 + 1
    xN1(i) = aBound + (i - 1)*stepLength1;
end
% Creates 'x' points
for i = 1 : nStep2 + 1
    xN2(i) = aBound + (i - 1)*stepLength2;
end

% Step for 't' line 
tau1 = (stepLength1^2) / 3;
tau2 = (stepLength2^2) / 3;
mLayers = 950;

T1 = mLayers * tau1;
T2 = mLayers * tau2;

tN1 = zeros(mLayers + 1, 1);
tN2 = zeros(mLayers + 1, 1);
% Creates 't' points
for i = 1 : mLayers + 1
    tN1(i) = aBound + (i - 1)*tau1;
end

% Creates 't' points
for i = 1 : mLayers + 1
    tN2(i) = aBound + (i - 1)*tau2;
end

disp('Test N = 10');
% format short
% [decision10, accurate10] = netMethod(xN1, tN1, stepLength1, tau1, f, ux0, u0t, u1t, nStep1, mLayers, result);
% for k = 1 : mLayers
%     if mod(k, 50) == 0
%         disp('____________________________________________________________________________________________________________');
%         fprintf('n=10  t=%d:',  k); 
%         disp(decision10(k,:));
%         fprintf('Test model :');
%         disp(accurate10(k,:));
%     end
% end
% disp(' ');
% disp(' ');
format long
for k = 1 : mLayers
    if mod(k, 50) == 0
        disp('____________________________________________________________________________________________________________');
        fprintf('n=10  t=%d:',  k); 
        disp(decision10(k,2:5));
        fprintf('Test model :');
        disp(accurate10(k,2:5));
    end
end
disp(' ');
disp(' ');
disp('Test N = 100');
[decision10, accurate10] = netMethod(xN1, tN2, stepLength1, tau2, f, ux0, u0t, u1t, nStep1, mLayers, result);
[decision100, accurate100] = netMethod(xN2, tN2, stepLength2, tau2, f, ux0, u0t, u1t, nStep2, mLayers, result);
% format short
% for k = 1 : mLayers
%     if mod(k, 50) == 0
%         disp('____________________________________________________________________________________________________________');
%         fprintf('n=10  t=%d:',  k); 
%         disp(decision10(k,:));
%         fprintf('n=100 t=%d:',  k); 
%         disp(decision100(k,1:10:101));
%         fprintf('Test model :');
%         disp(accurate100(k,1:10:101));
%     end
% end
disp(' ');
disp(' ');
disp('Test = 100, Columns: 2, 3, 4, 5');
format long;
for k = 1 : mLayers
    if mod(k, 50) == 0
        disp('____________________________________________________________________________________________________________');
        fprintf('n=10  t=%d:',  k); 
        disp(decision10(k,2:5));
        fprintf('n=100 t=%d:',  k); 
        disp(decision100(k,10:10:41));
        fprintf('Test model :');
        disp(accurate100(k,10:10:41));
    end
end







