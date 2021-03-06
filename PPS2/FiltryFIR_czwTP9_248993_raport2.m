%Konrad Bialek
%248993
%czwartek TP 9.15;

% -------------------------------------------------------------
% Skrypt pozwala na:
% - wyznaczenie odpow. impulsowej fitru FIR o zadanych parametrach
% - wykreslenie odpow. impulsowej w oknie 1
% - obliczenie i wykreslenie modu³u i fazy transmitancji w oknie 2

clear;
M = 91; % 201 31 %a b
w = rectwin (M);    % --- okno prostok¹tne %c d e
%w = triang(M);      % --- okno trojkatne
%w = blackman(M);
%w = hamming(M);
%w = kaiser(M,5);
%w = gausswin(M);
%w = blackmanharris(M);
figure (1);
subplot (211);
plot (w);
xlabel ('czas [pr]');
ylabel ('okno czasowe');

h = fir1 (M-1, 0.3, w);   
subplot (212);
plot (h);
xlabel ('czas [pr]');
ylabel ('odpowiedz impulsowa');
set (gcf,'Position',[50 50 600 600]);

figure (2);
freqz (h, 1);
set (gcf,'Position',[700 50 800 600]);