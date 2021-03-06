%Konrad Bialek
%248993
%czwartek TP 9.15;

% skrypt wyznacza widmo amplitudowe i fazowe
% sygnalu bedacego suma dwoch sinusoid
clear;
f1=11;	% czestotliwosc pierwszej sinosoidy
%f1=21; %a)
A1=1;		% amplituda pierwszej sinusoidy
phi1=0.4;	% faza pierwszej sinusoidy
%phi1=0.8; %phi1=pi/2; %phi1=0; %b)
f2=40;	% czestotliwosc drugiej sinosoidy
%f2=57; %a)
A2=2;		% amplituda drugiej sinusoidy
phi2=0;		% faza drugiej sinusoidy
%phi2=1; %phi2=pi; %phi2=pi/4; %b)	

N=200;		% dlugosc sygnalu
%N=400; %N=600; %N=1200; %a)
fp=200;		% czestotliwosc probkowania
%fp=400; %a)
Nf=200;     % d³ugoœæ transformacji Fouriera
%Nf=400; %Nf=800; %a)
% -------------------------------------------------------------------
%       W tych warunkach odleg³oœæ pomiêdzy pr¹¿kami widma wynosi 1Hz
% -------------------------------------------------------------------

% generuj os czasu
t=0:1/fp:(N-1)/fp;

% generuj sygnal
x=A1*sin(2*pi*f1*t+phi1)+A2*sin(2*pi*f2*t+phi2);
subplot (311);
plot (t,x);
xlabel ('czas[s]');
ylabel ('sygnal');

% wyznacz widmo
widmo=fft(x, Nf) / Nf;
N21 = Nf/2 + 1;
f = linspace (0, fp/2, N21);

% wykres czesci rzeczywistej i urojonej
xr = real (widmo);
subplot (312);
hold off;
stem (f, xr(1:N21), 'g');
hold on;
xi = imag (widmo);
stem (f, xi(1:N21), 'r');
hold off;
xlabel ('czestotl.[Hz]');
ylabel ('re(X) & im(X)');

% wykres modulu i fazy widma
widmo_amp=abs(widmo);
widmo_faz=angle(widmo);
subplot(615);
stem (f, widmo_amp(1:N21), 'k');
ylabel ('|X|');
subplot(616);
stem (f, widmo_faz(1:N21), 'b');
xlabel ('czestotl.[Hz]');
ylabel ('arg(X)');

set (gcf,'Position',[50 50 800 700]);