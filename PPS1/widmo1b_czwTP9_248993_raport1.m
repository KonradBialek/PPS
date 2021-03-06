%Konrad Bialek
%248993
%czwartek TP 9.15;

% skrypt wyznacza widmo amplitudowe i fazowe
% sygnalu bedacego suma dwoch sinusoid
clear;
f1=39.5;	% czestotliwosc pierwszej sinosoidy
%f1=87.5;  %b)
A1=1;		% amplituda pierwszej sinusoidy
phi1=0.4;	% faza pierwszej sinusoidy

f2=40;	% czestotliwosc drugiej sinosoidy
%f2=87; %b)
A2=2;		% amplituda drugiej sinusoidy
phi2=0;		% faza drugiej sinusoidy

N=200;		% dlugosc sygnalu
%N=400; %N=700; %N=800; %a) i b)
fp=200;		% czestotliwosc probkowania
Nf=N;     % d³ugoœæ transformacji Fouriera
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
plot (f, xr(1:N21), 'g');
hold on;
xi = imag (widmo);
plot (f, xi(1:N21), 'r');
hold off;
xlabel ('czestotl.[Hz]');
ylabel ('re(X) & im(X)');

% wykres modulu i fazy widma
widmo_amp=abs(widmo);
widmo_faz=angle(widmo);
subplot(313);
plot (f, widmo_amp(1:N21), 'k');
xlabel ('czestotl.[Hz]');
ylabel ('|X|');

set (gcf,'Position',[50 50 800 700]);

