%Konrad Bialek
%248993
%czwartek TP 9.15;

clear;
f1=10.1;	% czestotliwosc sinosoidy
%f1=11; %f1=22; %c)
A1=2;		% amplituda sinusoidy
phi1=0.3;	% faza sinusoidy

fp=220;		% czestotliwosc probkowania
%fp=202; %fp=50.5; %d)
N=200;		% dlugosc sygnalu
%N=202; %N=1493; %d)
Nf=200;

% generuj os czasu
t=0:1/fp:(N-1)/fp;

% generuj sygnal i wykres
syg=A1*sin(2*pi*f1*t+phi1);
clf;
subplot(211);
plot(t,syg);
xlabel('czas [s]');
ylabel('x(t)');

% wyznacz widmo
widmo=fft(syg,Nf)/Nf;
widmo_amp=abs(widmo);
subplot (212);
N21 = Nf / 2 + 1;
f = linspace (0, fp/2, N21);
stem (f, widmo_amp(1:N21));
xlabel ('czest. [Hz]');
ylabel ('|X(f)|');

set (gcf,'Position',[50 50 800 700]);

