clear all
close all

%% Paramètre du modulateur
Fe = 24000;
Te = 1/Fe;
Rb = 6000;
m = 1; %1 bit par symbole
Rs = Rb/m;
Ns = Fe/Rs;
Ts = Ns*Te;

%% Information binaire a transmettre
N = 5000;
Nt = N*Ns;
bits = randi([0, 1], 1, N); %Signal aleatoire de 300 bits.

%% Mapping 1 : Symbole binaire de moyenne nulle
ak = [-1, 1]; %Mapping binaires a moyenne nulle
map(bits==0) = ak(1);
map(bits==1) = ak(2);

%% Surechantillonnage
map = kron(map, [1 zeros(1, Ns-1)]);

%%Filtrage de mise en forme
h = ones(1, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
filt = filter(h, 1, map); 

%% Plot
figure(1);
subplot(211);
stairs(1:1:10, bits(1:10), '-.x');
xlabel('Numero');
ylabel('bits(t)');
title('bits ');
subplot(212);
stairs(0:Te:Te*(5*Ns)*Ns, map(1:5*Ns*Ns+1), '-.x');
xlabel('Temps t en sec');
ylabel('map(t)');
title('Mapping ');

%% Signal transmis

figure(2);
plot(0:Te:Te*(30*Ns), filt(1:30*Ns+1));
xlabel('Temps t en sec');
ylabel('filt(t)');
title('Signal transmis ');

%% DSP du signal transmis: Methode N7

figure(3)
periodogramme_filt = 1/Nt * abs( fft(filt, 2^nextpow2(length(filt))) ).^2;
semilogy(linspace(-Fe/2, Fe/2, length(periodogramme_filt)), fftshift(periodogramme_filt));
xlabel('Fréquence f en Hz');
ylabel('|F(Rx)|');
title('Densité spectrale de puissance du signal transmis: ');

%% DSP du signal transmis: Methode Welch

figure(4)
subplot(211);
pwelch(filt);
subplot(212);
PSDx = 10*log10(pwelch(filt));
plot(linspace(0, Fe/2, length(PSDx)), PSDx);

%% DSP theorique 