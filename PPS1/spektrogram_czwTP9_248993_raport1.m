%Konrad Bialek
%248993
%czwartek TP 9.15;

% skrypt generuje spektrogramy sygnalu modelowego
% w postaci szumu bialego i sygnalu chirp oraz sygnalu
% mowy

% generacja sygnalu modelowego
N = 5000; 
%N=12000; %c)
fp = 2000; 
%fp=3000; %c)
t = 0:1/fp:(N-1)/fp;
x = chirp (t, 100, 2.5, 900, 'q');
%x = chirp (t, 300, 4, 1200, 'q'); %c)

% narysowanie wykresow czasowych
subplot(221);
plot(t,x);
xlabel('czas [s]');
ylabel('x(n)');

% generacja spektrogramow
subplot (222);
spectrogram (x, 512, 256, 512, fp);
%specgram(x,128,120,128,fp);

%c)
%{
subplot (222);
spectrogram (x, 1024, 256, 512, fp);
subplot (223);
spectrogram (x, 512, 128, 512, fp);
subplot (224);
spectrogram (x, 512, 256, 1024, fp);
%}

%d) i e)
% wczytywanie sygnalu mowy
[x,fpx]=audioread('mbi04becz.wav');

Nx= length(x);
tx=0:1/fpx:(Nx-1)/fpx;
dr=4;   % rzad decymacji
y=decimate(x,dr);
Ny=length(y);

fpy=fpx/dr;
t=0:1/fpy:(Ny-1)/fpy;

% narysowanie wykresow czasowych

subplot(221); %d)
plot(tx,x);
xlabel('czas [s]');
ylabel('x(n)');

%subplot(221); %e) 
subplot(222); %d)
plot(t,y);
xlabel('czas [s]');
ylabel('x(n)');

% generacja spektrogramow

subplot (223); %d)
spectrogram (y, 512, 256, 512, fpy);
%specgram(y,128,120,128,fp);

%e)
%{
subplot (222);
spectrogram (y, 1024, 256, 512, fpy);
subplot (223);
spectrogram (y, 512, 128, 512, fpy);
subplot (224);
spectrogram (y, 512, 256, 1024, fpy);
%}

set (gcf,'Position',[50 50 1200 700]);