%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------------------
% Skrypt pozwala na:
% - wyznaczenie wspó³czynnikow a i b opisuj¹cych transmitancjê filtru
% - wyznaczenie po³o¿enia zer i biegunów transmitancji
% - wyznaczenie odpow. impulsowej fitru IIR
% - obliczenie i wykreslenie modu³u i fazy transmitancji

clear;
N = 10; % 18 19 65 %c
[b a] = butter (N, 0.4); %b
%[b a] = cheby1 (N, 2.0, 0.4);
%[b a] = cheby2 (N, 60.0, 0.4);
%[b a] = ellip (N, 2.0, 60.0, 0.4);
% --- wyznaczenie po³o¿enia zer i biegunów i ich wykres
zer = roots (b)
pol = roots (a);
figure (1);
zplane (zer, pol);
%set (gcf,'Position',[0 200 600 400]);
% --- wyznaczenie odpowiedzi impulsowej i wykres
K = 701;
h = impz (b,a,K);
figure (2);
plot (h);
xlabel ('czas [pr]');
ylabel ('odpowiedz impulsowa');
set (gcf,'Position',[50 100 500 300]);
% --- wyznaczenie i wykres transmitancji
figure (3);
freqz (b, a);
set (gcf,'Position',[700 50 600 400]);