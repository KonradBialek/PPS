%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------
% ----  WP£YW FILTRACJI SYGNA£U NA WYNIKI ESTYMACJI

% ----  wczytanie sygnalu WAV
clear;
[a fa] = audioread ('aut_60_wr.wav');
dr = 12; %dr = 2; %b
x = decimate (a,dr);
fp = fa/dr;
Nx=length(x);
t = 0:1/fp:(Nx-1)/fp;
subplot (521);
plot (t,x);
xlabel ('czas [s]');
ylabel ('sygnal przed fltr');

% ----  projekt filtru i filtracja
M = 301;
h = fir1 (M-1, 0.2);
y = filter (h, 1, x);
subplot (522);
plot (t,y);
xlabel ('czas [s]');
ylabel ('sygnal po fltr');

% ----  estymacja autokorelacji i wykresy
kmax = 400;
Np = 1000;
N = 500;
%N = 50000;
rx = xcorr (x(Np:Np+N), x(Np:Np+N), kmax);
tr = -kmax/fp:1/fp:kmax/fp;
subplot (523);
plot (tr,rx);
xlabel ('opoznienie [s]');
ylabel ('autokorelacja x');

ry = xcorr (y(Np:Np+N), y(Np:Np+N), kmax);
subplot (524);
plot (tr,ry);
xlabel ('opoznienie [s]');
ylabel ('autokorelacja y');

% ---- estymacja widmowej gestosci mocy i wykresy
Nf = 2^10;
N21 = Nf/2+1;
sx = abs(fft(rx,Nf));
f = linspace (0, 0.5*fp, N21);
subplot (525);
plot (f,sx(1:N21));
xlabel ('czestotliwosc [Hz]');
ylabel ('widmowa gestosc mocy');

sy = abs(fft(ry,Nf));
f = linspace (0, 0.5*fp, N21);
subplot (526);
plot (f,sy(1:N21));
xlabel ('czestotliwosc [Hz]');
ylabel ('widmowa gestosc mocy');

% ---- estymacja rozkladu prawdopodobienstwa i wykresy
xa = -0.05:0.002:0.05;
[nx xout] = hist (x(Np:Np+N),xa);
subplot (527);
plot (xout,nx/N);
xlabel ('wartosc chwilowa');
ylabel ('prawdopodobienstwo');

[ny xout] = hist (y(Np:Np+N),xa);
subplot (528);
plot (xout,ny/N);
xlabel ('wartosc chwilowa');
ylabel ('prawdopodobienstwo');

% --- estymacja korelacji wzajemnej unormowanej i wykres
rxy = xcorr (x(Np:Np+N), y(Np:Np+N), kmax);
rxy_norm = rxy / sqrt(rx(kmax+1)*ry(kmax+1));
subplot (515);
plot (tr,rxy_norm);
xlabel ('opoznienie [s]');
ylabel ('unorm.korelacja wzajemn.');

set (gcf,'Position',[50 50 800 700]);

%%Radar

% ############################################################
% ################### model prostego systemu radarowego
clear;
fp = 1*10^9;          % czestotliwoœæ próbkowania
dlugC = 10^-5;        % d³ugoœæ sugna³u emitowanego przez radar - 10us
f1 = 0.4*10^9;        % dolna czêst. graniczna widma
f2 = 0.45*10^9;       % górna czest. graniczna widma
[x,tx] = sygnEmit (fp, dlugC, f1, f2);
tx = 10^6 * tx;       % czas w us (mikrosekundach) 

figure (1);
subplot (221);
plot (tx ,x);
xlabel ('czas[us]');
ylabel ('sygn.emit');

% ------------- widmo sygna³u emitowanego
Nx = length (x)
Nf = 2^16;
N21 = Nf/2 + 1;
wx = abs(fft(x,Nf));
f = linspace (0,(fp/2)/(10^6),N21);  % os czestotliwosci w MHz
subplot (222);
plot (f, wx(1:N21));
xlabel ('czest[MHz]');
ylabel ('widmo sygn.emit');

% -------------  dekl. parametrów odbiæ i szumu, modelowanie odbicia
t1 = 11*10^-6;        % opóŸnienie 1.go odbicia - 1us
a1 = 0.003;            % mno¿nik 1.go odbicia
t2 = 11.3*10^-6;      % opóŸnienie 2.go odbicia - 2us
a2 = 0.0015;           % mno¿nik 2.go odbicia
b = 0.01;             % mnoznik szumu
odleglosc1 = t1 * 3*10^8     % 3*10^8 to predkoœæ œwiat³a
odleglosc2 = t2 * 3*10^8
[y,ty] = sygnOdbity (x, fp, t1, a1, t2, a2, b); 
ty = 10^6 * ty;
subplot (223);
plot (ty, y);
xlabel ('czas[us]');
ylabel ('sygn.odebrany');

% ------------- widmo sygna³u odebranego
wy = abs(fft(y,Nf));
subplot (224);
plot (f, wy(1:N21));
xlabel ('czest[MHz]');
ylabel ('widmo sygn.odebranego');
set (gcf,'Position',[50 300 700 500]);

% ---------------  korelacja wzajemna
tmax = 15*10^-6;         % maksymalne opoŸnienie czasowe
kmax = floor (tmax*fp);
R = xcorr (x, y, kmax);
tR = -kmax/fp:1/fp:kmax/fp;
tR = 3*10^8 * tR;    % przeliczenie opóŸnienia na odleg³oœæ
figure (2);
plot (tR, R);
xlabel ('odleglosc [m]');
ylabel ('korel.wzajemna');
set (gcf,'Position',[700 50 700 500]);

%%Szumy

% -------------------------------------------------
% ----  LOSOWOŒÆ
% ----  KORELACJA WZAJEMNA - NIESKORELOWANIE

% ----  wczytanie sygnalu WAV nr 1
clear;
[a fa] = audioread ('kos_60_wr.wav');
dr = 12; %dr=2; %b
x = decimate (a,dr);
fp = fa/dr;
Nx=length(x);
t = 0:1/fp:(Nx-1)/fp;
subplot (421);
plot (t,x,'g');
xlabel ('czas [s]');
ylabel ('wartosc chwilowa');
% ----  wczytanie sygnalu WAV nr 2
[a fa] = audioread ('aut_60_wr.wav');
dr = 12; %dr=2; %b
y = decimate (a,dr);
fp = fa/dr;
Ny=length(y);
t = 0:1/fp:(Ny-1)/fp;
subplot (422);
plot (t,y,'g');
xlabel ('czas [s]');
ylabel ('wartosc chwilowa');

% ----  estymacje autokorelacji i wykresy
Np = 1000;
N = 5000;
%N = 50000;
kmax = 600;
rx = xcorr (x(Np:Np+N), x(Np:Np+N), kmax);
tr = -kmax:1:kmax;
subplot (423);
plot (tr,rx/rx(kmax+1));
xlabel ('opoznienie [pr]');
ylabel ('autokorelacja x');

ry = xcorr (y(Np:Np+N), y(Np:Np+N), kmax);
subplot (424);
plot (tr,ry/ry(kmax+1));
xlabel ('opoznienie [pr]');
ylabel ('autokorelacja y');

% ---- estymacja widmowych gestosci mocy i wykresy
Nf = 2^10;
N21 = Nf/2+1;
sx = abs(fft(rx,Nf));
f = linspace (0, 0.5*fp, N21);
subplot (425);
plot (f,sx(1:N21));
xlabel ('czestotliwosc [Hz]');
ylabel ('widmowa gestosc mocy');

sy = abs(fft(ry,Nf));
subplot (426);
plot (f,sy(1:N21));
xlabel ('czestotliwosc [Hz]');
ylabel ('widmowa gestosc mocy');

% ---- estymacja korelacji wzajemnej i wykres
rxy = xcorr (x(Np:Np+N), y(Np:Np+N), kmax);
subplot (414);
plot (tr,rxy/sqrt(rx(kmax+1)*ry(kmax+1)));
xlabel ('opoznienie [pr]');
ylabel ('korelacja wzajemna');

set (gcf,'Position',[50 50 800 700]);

