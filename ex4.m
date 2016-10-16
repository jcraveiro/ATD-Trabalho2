% David Rafael Ferreira Gomes
% Joao Guilherme Assafrao Craveiro
% Rui Pedro Pereira Mendes
%

%Exercicio 4

close all
clear all
clc

disp('Exercicio 4');

%4.1
disp('4.1')
syms t
syms w
A = 2;
a = 0.7;
W = -30*pi: pi/6: 30*pi;

x = A * exp(-a * t) * sin(4 * pi * t);

XW = int(x * exp(-j * w * t), t, 0, 6);
pretty(XW)
ft = double(subs(XW, W));

figure(1)
subplot(2, 1, 1)
plot(W, abs(ft));
title('Transformada de Fourier em modulo');

subplot(2, 1, 2)
plot(W, angle(ft));
title('Transformada de Fourier em fase');
pause();

%4.2
disp('4.2')
ts = 0:0.01:6;

xs = ifourier(XW);
figure(2)
plot(ts, double(subs(xs, ts)), '- r'), hold on
plot(ts, double(subs(xs, ts)), 'o')
title('Comparacao entre o sinal original e reconstituido');
hold off
pause();

%4.3
disp('4.3');
t0 = 6;
w0 = 2*pi/t0;
for m = -25:25
   cm(m + 26) = double(subs(XW, m*w0))/t0;
end

figure(3)
subplot(2,1,1)
plot(W, abs(ft)/t0, 'red'), hold on
plot(-25:25, abs(cm), '. blue');
title('Coeficientes complexos da serie de Fourier - modulo');
hold off
subplot(2,1,2)
plot(W, angle(ft), 'red'), hold on
plot(-25:25, angle(cm), '. blue')
title('Coeficientes complexos da serie de Fourier - fase');
hold off
