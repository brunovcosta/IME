close all;clear all;clc;
passo=0.1;
t=0:passo:100;  
m=zeros(1,length(t)); %sinal de mensagem
for tt=1:length(t)
        m(tt)=2*sinc(10*10^-3*t(tt))*cos(2*pi*20*10^-3*t(tt)); % m(t)=2*sinc(10*t)*cos(40*pi*t)
end
fs=100; 
Ts=(1/fs)/10^-3; %microsegundos
g=zeros(1,length(t)); %portadora
Tp=4; %tamanho do pulso da portadora 
m_max=max(m); %valor máximo de m(t)
kp=(Ts/2)/m_max - 2.3; % achei na literatura que kp*mod(m_max) < Ts/2
%kp=0.0001;
ppm=zeros(1,length(t)); % sinal PPM
for tt=1:length(t) 
    %nn é o índice do período de amostragem em que t(tt) se encontra
    nn=(t(tt)-mod(t(tt),Ts))/Ts;
    
    %g(t) é a portadora trem de pulsos
    g(tt)=sum(rect((t(tt)-Tp/2-nn*Ts)/Tp));
    
    %ind_NTs é o indice referente ao instante de amostragem nn
    ind_NTs=(nn*Ts/(passo))+1;
    
    %Geração do sinal PPM
    if ((t(tt)-nn*Ts-kp*m(ind_NTs))>1)            
        ppm(tt)=g(round((t(tt)-nn*Ts-kp*m(ind_NTs)))); %ppm = sum(g(t - n*Ts - Kpm(n*Ts))), achei na internet, não achei no haykin;
    end;
end;
figure();
subplot(3,1,1);
plot(t,m,'linewidth', 1.5); ylabel('m(t)'); hold on
subplot(3,1,2);
plot(t,g,'linewidth', 1.5);axis([0 100 -0.2 1.2]); ylabel('Trem de Pulsos');
subplot(3,1,3);
plot(t,ppm,'r','linewidth', 1.5);axis([0 100 -2.2 2.2]); ylabel('PPM');