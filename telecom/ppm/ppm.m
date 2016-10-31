clear all;
clc; close all;

%assumir uma unidade de tempo em milesegundos
passo=0.0001; %incremento de tempo neste exemplo é a cada 10 
%microsegundos
t=(0:passo:0.1); %duração do exemplo de 100ms

%sinal de informação m(t)=sen(80*pi*t)
m=zeros(1,length(t));
for tt=1:length(t)
	m(tt)=2*sinc(10*tt*passo).*cos(40*pi*tt*passo);
end

%empregar uma frequencia de amostragem de 100 amostras/s
%periodo de amostragem - Ts=10^-2seg = 10ms
Ts=0.010;

%duração do pulso da portadora 
Tp=0.004;

%valor mínimo de m(t)
m_min=min(m);
%largura mínima do pulso modulado
T_min=1;
%fator de sensibilidade do PWM
Kp=1;

%sinal modulante(m(t)), portadora(g(t)), PAM
%inicialização das variaveis

g=zeros(1,length(t));
pam=zeros(1,length(t));
pwm=zeros(1,length(t));
ppm=zeros(1,length(t));
triangulos=zeros(1,length(t));

altura_maxima=4;
altura_minima=1;
largura = Tp/2;
ultimo_cruzamento=0;
for tt=1:length(t)
	%nn é o índice do período de amostragem em que t(tt) se encontra
	nn=(t(tt)-mod(t(tt),Ts))/Ts;

	%g(t) é a portadora trem de pulsos
	g(tt)=sum(rect((t(tt)-Tp/2-nn*Ts)/Tp));
%
%	%ind_NTs é o indice referente ao instante de amostragem nn
%	ind_NTs=(nn*Ts/(passo))+1;
%	pam(tt)=g(tt)*(m(ind_NTs));
%
%	Tpl=Kp*(Tp*(m(ind_NTs)-m_min))+T_min;
%	pwm(tt)=rect((t(tt)-Tpl/2-nn*Ts)/Tpl);
%
	triangulos(tt)=altura_maxima*((tt-ultimo_cruzamento)*passo/Ts);
	if(triangulos(tt)>altura_minima+altura_maxima/2+m(tt))
		ultimo_cruzamento = tt;
	end
	if((tt-ultimo_cruzamento)*passo<largura)
		ppm(tt)=1;
	end
end

figure();
subplot(3,1,1);
plot(t,m,'linewidth', 1.5); ylabel('m(t)');
subplot(3,1,2);
plot(t,g,'linewidth', 1.5); ylabel('Trem de Pulsos');
subplot(3,1,3);
plot(t,ppm,'g','linewidth', 1.5);  ylabel('PPM');
