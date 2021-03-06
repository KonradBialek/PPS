%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------------------
% Skrypt pozwala na:
% - zadanie po³o¿enia zer lub/i biegunów
% - wykreœlenie ich po³o¿enia
% - obliczenie i wykreœlenie odpowiedzi impulsowej
% - obliczenie i wykreslenie modu³u i fazy transmitancji

clear;
% --------  polozenie pary zer i biegunów
mz = 1/0.9; % 1/0.2 1/1.9 1/0.7 %a b
pz = 0.3;   % 0.4 %a b
zer = mz * exp(-j*2*pi*[pz -pz]');
mb = 0.9; % 0.2 1.9 %a b
pb = 0.3; % 0.4 %a b
pol = mb * exp(-j*2*pi*[pb -pb]');

subplot (221);
zplane (zer, pol);
% --------- przeliczenie po³o¿enia zer i biegunów na wspó³czynniki
% --------- rówanania ró¿nicowego
% --------- ostatni parametr oznacza mno¿nik transmitancji
[b a] = zp2tf (zer, pol, 1);
% --------- wyznaczenie odpowiedzi impulsowej
% --------- ostatni parametr oznacza d³ugoœæ odpowioedzi impulsowej
% --------- da d³ugoœæ ma sens jedynie w przypadku filtrów IIR
N = 512;
h = impz (b, a, N);
th = 0 : 1 : N-1;
subplot (222);
plot (h);
xlabel ('nr probki OI');
ylabel ('odpowiedz impulsowa');
% -------- obliczenie modu³u funkcji transmitancji
v = fft(h, N);
wh = abs(v);
N21 = N / 2 + 1;
f = linspace (0, 0.5, N21);
subplot (223);
plot (f, wh(1:N21));
xlabel ('unormowana czestotl');
ylabel ('modul transmitancji');
% -------- obliczenie fazy funkcji transmitancji
ph = angle (v);
subplot (224);
plot (f, ph(1:N21));
xlabel ('unormowana czestotl');
ylabel ('faza transmitancji [rd]');

set (gcf,'Position',[50 50 800 700]);