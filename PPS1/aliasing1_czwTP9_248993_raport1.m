%Konrad Bialek
%248993
%czwartek TP 9.15;

clear;
% ----------------  generowanie sinusa
fpx = 2000;
Nx = 2000;
tx = 0:1/fpx:(Nx-1)/fpx;
f0 = 700;
%f0 = 800; %f0 = 1400; %f0 = 1000; %a) 
%c) 
%f0 = 700; f1 = 800; %f0 = 700; f1 = 1100; %f0 = 600; f1 = 1100; %f0 = 700; f1 = 1300; 
%f0 = 400; %f0 = 1400; %f0 = 700; f1 = 300; %d)
x = sin (2*pi*f0*tx) + 0.2*randn(1,Nx);
%x = sin (2*pi*f0*tx) + sin (2*pi*f1*tx) + 0.2*randn(1,Nx); %c) i d)
subplot (221);
plot (tx,x);
xlabel ('czas[s]');
ylabel ('sygnal przed decymacja');

Nf = 2^11;
N21 = Nf/2 + 1;
wx = abs(fft(x,Nf));
fx = linspace(0, fpx/2, N21);
subplot (222);
plot (fx, wx(1:N21));
xlabel ('czest[Hz]');
ylabel ('modul widma');

% ------------------------------------------------------------------
%      decymacja w petli
%      gdyz funkcja decimate przeprowadza filtracje antyaliasingow¹
% ------------------------------------------------------------------
dr = 2;
%dr = 3; %dr = 5; %dr = 10; %b) 
Ny = floor (Nx / dr); 
fpy = fpx / dr;
%y=decimate(x,dr); %d)
for i=1:Ny
  y(i) = x((i-1)*dr+1); 
end;    
ty = 0:1/fpy:(Ny-1)/fpy;
subplot (223);
plot (ty,y);
xlabel ('czas[s]');
ylabel ('sygnal po decymacji');

wy = abs(fft(y,Nf));
fy = linspace(0, fpy/2, N21);
subplot (224);
plot (fy, wy(1:N21));
xlabel ('czest[Hz]');
ylabel ('modul widma');

set (gcf,'Position',[50 50 800 700]);
%print -depsc ProbkAlias1