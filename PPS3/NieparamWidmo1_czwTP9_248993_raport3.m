%Konrad Bialek
%248993
%czwartek TP 9.15;

% ############################################################
% ################### NIEPARAMETRYCZNE METODY ESTYMACJI WIDMA
clear;
fp = 100;          % czestotliwoœæ próbkowania
N = 50;            % d³ugoœæ sugna³u 
%N = 200; %b
%N = 1000;
[x,tx] = sygnTestEstymWidma (fp, N);
subplot (221);
plot (tx ,x);
xlabel ('czas [s]');
ylabel ('sygnal');

% ------------- periodogram
Nf = 2^13;
N21 = Nf/2 + 1;
[Pxx1, f] = periodogram (x, [], Nf, fp);
subplot (222);
semilogy (f, Pxx1(1:N21));
ylim ([0.0001 100]);
legend ('periodogram');
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

% ------------- periodogram z oknem - widmo Cooleya
w = blackmanharris (N);
[Pxx2, f] = periodogram (x, w, Nf, fp);
subplot (223);
semilogy (f, Pxx2(1:N21));
ylim ([0.0001 100]);
legend ('periodogram z oknem blackmanharris');
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

% ------------- wgm z definicji
R = xcorr (x,x,N/2)/N;
w = blackmanharris (N+1);
R = R .* w';
Pxx3 = abs(fft(R,Nf))/sqrt(Nf);
subplot (224);
semilogy (f, Pxx3(1:N21));
ylim ([0.0001 100]);
legend ('widmo blackmana');
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

set (gcf,'Position',[50 50 800 700]);

%%NieparamWidmo2

% ############################################################
% ################### NIEPARAMETRYCZNE METODY ESTYMACJI WIDMA
clear;
[a fa] = audioread ('aut_60_wr.wav');
dr = 12;
x = decimate (a,dr);
fp = fa/dr;
Nx=length(x);
Np = 10000;
N = 50;
%N = 200; %b
%N = 1000;
tx = 0:1/fp:(Nx-1)/fp;
subplot (221);
plot (tx(Np:Np+N) ,x(Np:Np+N));
xlabel ('czas [s]');
ylabel ('sygnal');

% ------------- periodogram
Nf = 2^14;
N21 = Nf/2 + 1;
[Pxx1, f] = periodogram (x(Np:Np+N-1), [], Nf, fp);
subplot (222);
semilogy (f, Pxx1(1:N21));
ylim ([10^-9 10^-5]);
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

% ------------- periodogram z oknem - widmo Cooleya
z = x(Np:Np+N-1);
w = blackmanharris (N);
[Pxx2, f] = periodogram (z, w, Nf, fp);
subplot (223);
semilogy (f, Pxx2(1:N21));
ylim ([10^-9 10^-5]);
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

% ------------- wgm z definicji
R = xcorr (x(Np:Np+N), x(Np:Np+N), N/2) / N;
w = blackmanharris (N+1);
R = R .* w;
Pxx3 = abs(fft(R,Nf))/sqrt(Nf);
subplot (224);
semilogy (f, Pxx3(1:N21));
ylim ([10^-9 10^-5]);
%legend ('widmo blackmana',3);
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

set (gcf,'Position',[50 50 800 700]);

%%ParamWidmo

% ############################################################
% ################### PARAMETRYCZNE METODY ESTYMACJI WIDMA
clear;
fp = 100;          % czestotliwoœæ próbkowania
N = 50;            % d³ugoœæ sugna³u 
%N = 200; %b
%N = 1000;
[x,tx] = sygnTestEstymWidma (fp, N);
subplot (221);
plot (tx ,x);
xlabel ('czas [s]');
ylabel ('sygnal');

% ------------- periodogram
Nf = 2^13;
N21 = Nf/2 + 1;
p = 6;             %  d³ugoœæ filtru prognozuj¹cego
%p = 12; %b
%p = 24;
[Pxx1, f] = pcov (x, p, Nf, fp);
subplot (222);
semilogy (f, Pxx1(1:N21));
ylim ([0.0001 100]);
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

% ------------- periodogram z oknem - widmo Cooleya
[Pxx2, f] = pburg (x, p, Nf, fp);
subplot (223);
semilogy (f, Pxx2(1:N21));
ylim ([0.0001 100]);
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

% ------------- wgm z definicji
[Pxx3, f] = pyulear (x, p, Nf, fp);
subplot (224);
semilogy (f, Pxx3(1:N21));
ylim ([0.0001 100]);
xlabel ('czest [Hz]');
ylabel ('widm.gest.mocy');

set (gcf,'Position',[50 50 800 700]);