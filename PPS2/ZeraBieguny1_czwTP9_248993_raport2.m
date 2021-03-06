%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------------------
% Skrypt pozwala na:
% - zadanie po�o�enia zer lub/i biegun�w
% - wykre�lenie ich po�o�enia
% - obliczenie i wykre�lenie odpowiedzi impulsowej
% - obliczenie i wykreslenie modu�u i fazy transmitancji

clear;
% --------  polozenie pary zer
mz = 0.95; % 0.5 0.25 1.95 1.1 0.6 %a
pz = 0.3; % 0.7 0.1 0.25 0.5 1.3 0.4 %a
zer = mz * exp(-j*2*pi*[pz -pz]');
% --------  polozenie pojedynczego zera
% zer = 1.5; % -0.95 0.5 1.5 %b
% --------  polozenie biegun�w
pol = 0;
subplot (221);
zplane (zer, pol);
% --------- przeliczenie po�o�enia zer i biegun�w na wsp�czynniki
% --------- r�wanania r�nicowego
% --------- ostatni parametr oznacza mno�nik transmitancji
[b a] = zp2tf (zer, pol, 1);
% --------- wyznaczenie odpowiedzi impulsowej
% --------- ostatni parametr oznacza d�ugo�� odpowioedzi impulsowej
% --------- da d�ugo�� ma sens jedynie w przypadku filtr�w IIR
N = 512;
h = impz (b, a, N);
th = 0 : 1 : N-1;
subplot (222);
plot (h);
xlabel ('nr probki OI');
ylabel ('odpowiedz impulsowa');
% -------- obliczenie modu�u funkcji transmitancji
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
ylabel ('faza transmitancji');

set (gcf,'Position',[50 50 800 700]);