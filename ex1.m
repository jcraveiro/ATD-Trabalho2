% David Rafael Ferreira Gomes
% Joao Guilherme Assafrao Craveiro
% Rui Pedro Pereira Mendes
%
% Exercicio 1

close all
clear all
clc

disp('Exercicio 1');

G = 13;

a1 = -2.1 - 0.2 * mod(G, 2);
a2 = 1.43 + 0.31 * mod(G, 2);
a3 = -0.315 - 0.117 * mod(G, 2);
b2 = 0.9167 * mod(1+G, 2);
b3 = 0.3137 * mod(G, 2);
b4 = -0.5867 * mod(1+G, 2);
b5 = -0.1537 * mod(G, 2);

% 1.2
disp('1.2');
B = [0 0 b2 b3 b4 b5];
A = [1 a1 a2 a3 0 0];

% 1.2.1
disp('1.2.1');
figure(1), zplane(B, A);
disp('Zeros:');
zr = roots(B);
disp(zr);
disp('Polos:');
pl = roots(A);
disp(pl);
title('Polos e Zero de G(z)');
pause();

% 1.2.2
disp('1.2.2');
disp('O sistema e estavel porque os seus polos estao dentro do circulo trigonometrico de raio 1');
pause();

% 1.2.3
disp('1.2.3');
syms z;
Bs = b2*z^-2 + b3*z^-3 + b4*z^-4 + b5*z^-5;
As = 1 + a1 * z^-1 + a2 * z^-2 + a3 * z^-3;
G = Bs / As;
hs = iztrans(G);

disp('Resposta a impulso:');
pretty(hs);
pause();

% 1.2.4
disp('1.2.4');
n = 0:70;
h1 = double(subs(hs, n));
h2 = impz(B, A, length(n));
h3 = dimpulse(B, A, length(n));
figure(2), stairs(n, h1), hold on, plot(n, h2, 'o', n, h3, '+'), hold off 
title('Resposta a impulso'), xlabel('n'), ylabel('h');
pause();

% 1.2.5
disp('1.2.5');
Xs = 1 / (1 - z^-1);
Ys = G * Xs;
ys = iztrans(Ys);
disp('Expressao da resposta a degrau:')
pretty(ys);
pause();

% 1.2.6
disp('1.2.6');
y = double(subs(ys, n));
y2 = dstep(B, A, length(n));

figure(3), stairs(n, y), hold on, 
plot(n, y2, 'o'), hold off
title('Resposta a degrau unitario')
pause();

% 1.2.7
disp('1.2.7')
xs = sym('4*(kroneckerDelta(n-3, 0) + kroneckerDelta(n-4, 0) + kroneckerDelta(n-5, 0) + kroneckerDelta(n-6, 0) + kroneckerDelta(n-7, 0) + kroneckerDelta(n-8, 0))')
Xs = ztrans(xs);
Ys = G * Xs;
ys = iztrans(Ys);
disp('Expressao da resposta do sistema:')
pretty(ys)
pause();

% 1.2.8
disp('1.2.8');
n = 0:70;
y1 = double(subs(ys, n));
xn = double(subs(xs, n));
y2 = filter(B, A, xn);
y3 = dlsim(B, A, xn);
figure(5), stairs(n, y1), hold on,
plot(n, y2, 'o'),
plot(n, y3, '+'), hold off
title('Resposta a entrada');
pause();

% 1.2.9
disp('1.2.9');
W = 0:0.01:pi;
H = freqz(B, A, W);

figure(6)
MH = abs(H);
amp = 20*log10(MH);
subplot(2, 1, 1), plot(W, amp)
title('Amplitude em dB');
f = unwrap(angle(H));
subplot(2, 1, 2), plot(W, f)
title('Fase em radianos')
pause();

% 1.2.10
disp('1.2.10');
gain = ddcgain(B, A)
