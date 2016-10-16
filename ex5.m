% David Rafael Ferreira Gomes
% Joao Guilherme Assafrao Craveiro
% Rui Pedro Pereira Mendes
%

%Exercicio 5

close all
clear all
clc

%5.1.1
xn = load('dadostp2_2.dat');
xn(xn==0) = [];
t = 0:length(xn)-1;
T0 = length(xn);
m_max = 70; %introduzir 0 < m_max <= 100
[Cm, tetam] = SerieFourier(t, xn, T0, m_max);
subplot(1,2,1);
plot(Cm,'.');
xlim([0,m_max]);
title('5.1.1 - Cm');
subplot(1,2,2);
plot(tetam,'.');
xlim([0,m_max]);
title('5.1.1 - Tetam');


%5.1.2
figure(2);
f1 = InvFourier(Cm,tetam,t,T0,m_max);
subplot(3,1,1);
plot(t,xn);
hold on;
plot(t,f1,'r');
hold off;
title('5.1.2 - Comparacao do sinal original e da aproximacao'),xlabel('w'),ylabel('modulo');

%5.1.3
cm = coefComp(Cm,tetam);
subplot(3,1,2);
plot(abs(cm),'o');
title('5.1.3 - Coeficientes da serie de Fourier complexa'),xlabel('w'),ylabel('modulo');
xlim([0,length(cm)]);
subplot(3,1,3);
plot(angle(cm),'o');
title('5.1.3 - Coeficientes da serie de Fourier complexa'),xlabel('w'),ylabel('fase');
xlim([0,length(cm)]);

%apresentar figuras em cada metade do ecr?
screensize = get(0, 'screensize');
screensize(3) = screensize(3)/2;
figure(1);
set(gcf, 'Position', screensize);
screensize(1) = screensize(3);
figure(2);
set(gcf, 'Position', screensize);
