% David Rafael Ferreira Gomes
% Joao Guilherme Assafrao Craveiro
% Rui Pedro Pereira Mendes
%
% Exercicio 3

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

w0 = 2*pi/T0
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

%3.1.1 e 3.1.2

escolha = menu('Escolha o tipo de ruido:','Ruido aleatorio','Ruido aleatorio dentro de uma gama de frequencias','Ruido a partir de expressao a introduzir', 'Sem ruido');
switch(escolha)
    case 1
        r =0.4*rand(size(t))-0.2;
        xr = x + r;
    case 2
        freq_min = input('Frequencia minima: ');
        freq_max = input('Frequencia maxima: ');
        
        %criar o Cm e Om a partir da gama dada
        m_min = floor(freq_min/w0);
        m_max = ceil(freq_max/w0);

        mr = m_min:m_max;
        
        Cmr=0.2*rand(size(mr));
        tetamr=2*pi*rand(size(mr))-pi;
        total = 0;
        r = zeros(size(t));
        
        for j=1:length(r);
            total = 0;
            for i=1:length(mr)
                total = total + Cmr(i)*cos((2*pi/T0)*mr(i)*t(j) + tetamr(i));
            end
            r(j) = total;
        end
        
        xr = x + r;

    case 3
        exp = input('Expressao do ruido: ');
        r = eval(exp);
        xr = x + r;
    case 4
end
    
xr = xr';

%3.1.3
mm = 100;
[Cm,tetam] = SerieFourier(t,xr,T0,mm);
Cmr = Cm;
tetamr = tetam;
escolha = menu('Escolha o filtro:', 'Passa-Baixo', 'Passa-Alto', 'Passa-Banda', 'Rejeita-banda');

   switch(escolha)
       case 1
           
            freq_max = input('Frequencia: ');
            m_max = ceil(freq_max/w0);

            for m = m_max:mm
                Cmr(m) = 0;
            end

             xrf=InvFourier(Cmr,tetamr,t,T0,mm);
             
             
       case 2
            freq_min = input('Frequencia: ');
            m_min = floor(freq_min/w0);

            for m = 1:m_min
                Cmr(m) = 0;
            end

            xrf=InvFourier(Cmr,tetamr,t,T0,mm);
       case 3
            freq_min = input('Frequencia minima: ');
            freq_max = input('Frequencia maxima: ');
            
            m_min = floor(freq_min/w0);
            m_max = ceil(freq_max/w0);

            for m = 1:m_min
                Cmr(m) = 0;
            end

            for m = m_max:mm
                Cmr(m) = 0;
            end

            xrf=InvFourier(Cmr,tetamr,t,T0,mm);
       case 4

            freq_min = input('Frequencia minima: ');
            freq_max = input('Frequencia maxima: ');
            
            m_min = floor(freq_min/w0);
            m_max = ceil(freq_max/w0);

            for m = m_min:m_max+1
                Cmr(m) = 0;
            end

            xrf=InvFourier(Cmr,tetamr,t,T0,mm);
   end

figure(1),subplot(1,3,1),plot(t,x),title('Original'),subplot(1,3,2),plot(t,xr),title('Com Ruido'),subplot(1,3,3),plot(t,xrf),title('Filtrado');
figure(2),subplot(1,2,1),plot(Cm,'.'),title('Cm com ruido'),subplot(1,2,2),plot(Cmr,'.'),title('Cm Filtrado');

