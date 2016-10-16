% David Rafael Ferreira Gomes
% Joao Guilherme Assafrao Craveiro
% Rui Pedro Pereira Mendes
%
%Exercicio 2

close all
clear all
clc
%Ex 2.1.1
T0 = input('Introduza o valor do periodo fundamental: ');
%Ex 2.1.2
step = T0/500;
t = 0:step:T0-step;
%2.1.3
escolha = menu('Escolha opcao:','Onda quadrada unitaria','Onda em dente de serra','Expressao a introduzir');

switch(escolha)
    case 1
        x = zeros(size(t));
        x(1: length(x)/2) = 1;
    case 2
        x = zeros(size(t));
        x = t/T0;
    case 3
        x = zeros(size(t));
        exp = input('Expressao (funcao de t): ');
        x = eval(exp);
end

x = x';
figure(1),plot(t, x),title('Onda');

%2.1.4
m_max = 100;
[Cm, tetam] = SerieFourier(t, x, T0, m_max);
figure(2),subplot(1,2,1), plot(Cm,'.'), title('Cm'); figure(2),subplot(1,2,2), plot(tetam,'.'),title('tetam');

%2.1.5
f1 = InvFourier(Cm,tetam,t,T0,0);
figure(3), subplot(2,4,1),plot(t,f1,'r',t,x,'b'), title('m_max = 0'); %Para melhor visualizacao das aproximacoes das expressoes introduzidas, pode-se remover t,x,'b' do plot
f2 = InvFourier(Cm,tetam,t,T0,1);
figure(3), subplot(2,4,2),plot(t,f2,'r',t,x,'b'), title('m_max = 1');
f3 = InvFourier(Cm,tetam,t,T0,3);
figure(3), subplot(2,4,3),plot(t,f3,'r',t,x,'b'), title('m_max = 3');
f4 = InvFourier(Cm,tetam,t,T0,5);
figure(3), subplot(2,4,4),plot(t,f4,'r',t,x,'b'), title('m_max = 5');
f5 = InvFourier(Cm,tetam,t,T0,10);
figure(3), subplot(2,4,5),plot(t,f5,'r',t,x,'b'), title('m_max = 10');
f6 = InvFourier(Cm,tetam,t,T0,50);
figure(3), subplot(2,4,6),plot(t,f6,'r',t,x,'b'), title('m_max = 50');
f7 = InvFourier(Cm,tetam,t,T0,100);
figure(3), subplot(2,4,7),plot(t,f7,'r',t,x,'b'), title('m_max = 100');

%2.1.6
[Cm, tetam] = SerieFourier(t, x, T0, 100);

cm = coefComp(Cm,tetam);
Amplitude = abs(cm);
Fase = unwrap(angle(cm));
 
figure(4),subplot(1,2,1),plot(-100:1:100,Amplitude,'.'),title('Amplitude');
figure(4),subplot(1,2,2),plot(-100:1:100,Fase,'.'), title('Fase');

%2.4
figure(5);
G=13;
syms t;
syms m;
xt1 = 1 + 2*mod(G,2)*sin(12*pi*t+pi/4)*cos(21*pi*t)+2*mod(1+G,2)*cos(20*pi*t-pi/4)*sin(45*pi*t);
xt2 = -2 + 4*cos(4*t+pi/3)-2*sin(10*t);
M = 0:20;
M1 = 0:20;
M2 = 0:20;

w0 = 5*pi;
t0 = 2*pi/w0;
cm = (1/t0)*int(xt2*exp(-1i*m*w0*t),t,-t0/2,t0/2);
cm1 = zeros(size(M));
for ind=1:length(M)
    cm1(ind) = limit(cm,m,M(ind));
end
M1(cm1==0)=[];
cm1(cm1==0)=[]; %remover 0's
subplot(2,1,1);
plot(M,cm1,'o');
title('cm do 2.2.3');

w0 = 2;
t0 = 2*pi/w0;
cm = (1/t0)*int(xt2*exp(-1i*m*w0*t),t,-t0/2,t0/2);
cm2 = zeros(size(M));

for ind=1:length(M)
    cm2(ind) = limit(cm,m,M(ind)); %no caso de m->0 daria erro
end
M2(cm2==0)=[];
cm2(cm2==0)=[]; %remover 0's
subplot(2,1,2);
plot(M2,cm2,'o');
title('cm do 2.2.4');
