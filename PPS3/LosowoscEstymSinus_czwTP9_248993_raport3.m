%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------
% ----  LOSOWOŒÆ
% ----  WP£YW D£UGOŒCI SYGNA£U NA WYNIK ESTYMACJI
clear;
N = 100;
%N = 10000; %a
% ----  generowanie i wykresy sygnalow
t = 0:1:N-1;
x = sin(2*pi*0.0731*t+2*pi*rand(1,1));
y = sin(2*pi*0.0731*t+2*pi*rand(1,1));
z = sin(2*pi*0.0731*t+2*pi*rand(1,1));
t = 0:1:(N-1);
subplot (221);
plot (t,x,'r',t,y,'g',t,z,'b');
xlabel ('czas [pr]');
ylabel ('wartosc chwilowa');

% ----  estymacja autokorelacji i wykresy
kmax = 100;
rx = xcorr (x, x, kmax);
ry = xcorr (y, y, kmax);
rz = xcorr (z, z, kmax);
tr = -kmax:1:kmax;
subplot (222);
plot (tr,rx,'r',tr,ry,'g',tr,rz,'b');
xlabel ('opoznienie [pr]');
ylabel ('autokorelacja');

% ---- estymacja widmowej gestosci mocy i wykresy
Nf = 256;
N21 = Nf/2+1;
sx = abs(fft(rx/N,Nf));
sy = abs(fft(ry/N,Nf));
sz = abs(fft(rz/N,Nf));
f = linspace (0, 0.5, N21);
subplot (223);
plot (f,sx(1:N21),'r',f,sy(1:N21),'g',f,sz(1:N21),'b');
xlabel ('czestotliwosc unormowana');
ylabel ('widmowa gestosc mocy');

% ---- estymacja rozkladu prawdopodobienstwa i wykresy
xa = -1.0:0.02:1.0;
[nx xout] = hist (x,xa);
[ny xout] = hist (y,xa);
[nz xout] = hist (z,xa);
subplot (224);
plot (xout,nx/N,'r',xout,ny/N,'g',xout,nz/N,'b');
xlabel ('wartosc chwilowa');
ylabel ('prawdopodobienstwo');

set (gcf,'Position',[50 50 800 700]);

%%LosowoscEstymSzum1

% -------------------------------------------------
% ----  LOSOWOŒÆ
% ----  WP£YW D£UGOŒCI SYGNA£U NA WYNIK ESTYMACJI
clear;
% ----  zmiana d³ugoœci sygna³u
N = 301;
%N = 3001; %a
%N = 30001;
%N = 300001;
% ----  generowanie i wykresy sygnalow
x = randn (1,N); %x = rand (1,N); %c
y = randn (1,N); %y = rand (1,N);
z = randn (1,N); %z = rand (1,N);
t = 0:1:(N-1);
subplot (221);
plot (t,x,'r',t,y,'g',t,z,'b');
xlabel ('czas [pr]');
ylabel ('wartosc chwilowa');

% ----  estymacja autokorelacji i wykresy
kmax = 100;
rx = xcorr (x, x, kmax);
ry = xcorr (y, y, kmax);
rz = xcorr (z, z, kmax);
tr = -kmax:1:kmax;
subplot (222);
plot (tr,rx,'r',tr,ry,'g',tr,rz,'b');
xlabel ('opoznienie [pr]');
ylabel ('autokorelacja');

% ---- estymacja widmowej gestosci mocy i wykresy
Nf = 256;
N21 = Nf/2+1;
sx = abs(fft(rx/N,Nf));
sy = abs(fft(ry/N,Nf));
sz = abs(fft(rz/N,Nf));
f = linspace (0, 0.5, N21);
subplot (223);
plot (f,sx(1:N21),'r',f,sy(1:N21),'g',f,sz(1:N21),'b');
ylim ([0 6]);
xlabel ('czestotliwosc unormowana');
ylabel ('widmowa gestosc mocy');

% ---- estymacja rozkladu prawdopodobienstwa i wykresy
xa = -4.0:0.2:4.0;
[nx xout] = hist (x,xa);
[ny xout] = hist (y,xa);
[nz xout] = hist (z,xa);
subplot (224);
plot (xout,nx/N,'r',xout,ny/N,'g',xout,nz/N,'b');
xlabel ('wartosc chwilowa');
ylabel ('prawdopodobienstwo');

set (gcf,'Position',[50 50 800 700]);

%%LosowoscEstymSzum2

% -------------------------------------------------
% ----  LOSOWOŒÆ
% ----  WP£YW D£UGOŒCI SYGNA£U NA WYNIK ESTYMACJI

% ----  wczytanie sygnalu WAV
clear;
[a fa] = wavread ('kos_60_wr.wav');
dr = 12; %dr=2; %a
x = decimate (a,dr);
fp = fa/dr;
N=length(x);
t = 0:1/fp:(N-1)/fp;
subplot (221);
plot (t,x,'g');
xlabel ('czas [s]');
ylabel ('wartosc chwilowa');

% ----  estymacja autokorelacji i wykresy5
%kmax = 200; %c
kmax = 600;
r1 = xcorr (x(1000:2000), x(1000:2000), kmax);
r2 = xcorr (x(1000:11000), x(1000:11000), kmax);
r3 = xcorr (x(1000:101000), x(1000:101000), kmax);
tr = -kmax:1:kmax;
subplot (222);
plot (tr,r1/r1(kmax+1),'r',tr,r2/r2(kmax+1),'g',tr,r3/r3(kmax+1),'b');
legend ('1000 pr', '10000 pr', '100000 pr');
xlabel ('opoznienie [pr]');
ylabel ('autokorelacja');

% ---- estymacja widmowej gestosci mocy i wykresy
Nf = 2^10;
N21 = Nf/2+1;
s1 = abs(fft(r1/1000,Nf));
s2 = abs(fft(r2/10000,Nf));
s3 = abs(fft(r3/100000,Nf));
f = linspace (0, 0.5*fp, N21);
subplot (223);
plot (f,s1(1:N21),'r',f,s2(1:N21),'g',f,s3(1:N21),'b');
%ylim ([0 6]);
xlabel ('czestotliwosc [Hz]');
ylabel ('widmowa gestosc mocy');

% ---- estymacja rozkladu prawdopodobienstwa i wykresy
xa = -0.1:0.002:0.1;
[nx xout] = hist (x(1000:2000),xa);
[ny xout] = hist (x(1000:11000),xa);
[nz xout] = hist (x(1000:101000),xa);
subplot (224);
plot (xout,nx/1000,'r',xout,ny/10000,'g',xout,nz/100000,'b');
xlabel ('wartosc chwilowa');
ylabel ('prawdopodobienstwo');

set (gcf,'Position',[50 50 800 700]);

