%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------------------
% Skrypt pozwala na:

clear;
[a fa] = audioread ('mbi04osiem.wav');
dr = 4;
x = decimate (a, dr);
N = length (x);
fp = fa / dr;
t = 0:1/fp:(N-1)/fp;
subplot (321);
plot (t, x);
xlabel ('czas [s]');
ylabel ('sygnal wejsciowy');

Nf = 2^13;
wx = abs(fft(x, Nf));
N21 = Nf/2+1;
f = linspace (0, fp/2, N21);
subplot (322);
plot (f, wx(1:N21));
xlabel ('unormowana czestotl.');
ylabel ('modul widma');

% --------- odpowiedü impulsowa filtra
M = 1291; % 2291 11291 %c
h = fir1 (M-1, [0.02 0.4], gausswin(M));
subplot (323);
plot (h);

% ----------  modu≥ transmitancji
wh = abs(fft(h, Nf));
subplot (324);
plot (f, wh(1:N21));
xlabel ('unormowana czestotl.');
ylabel ('modul transmitancji');

% -------   filtracja
y = filter (h, 1, x);
subplot (325);
plot (t, y);
xlabel ('czas [s]');
ylabel ('sygnal po filtracji');

% -------   modul widma po filtracji
wy = abs(fft(y, Nf));
subplot (326);
plot (f, wy(1:N21));
xlabel ('unormowana czestotl.');
ylabel ('modul widma');

set (gcf,'Position',[50 50 1000 700]);