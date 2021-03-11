clear all
close all

%% Paramètre du modulateur
Fe = 24000; %Frequence echantillonage
Te = 1/Fe;
Rb = 6000; % Debit binaire des bits
Tb = 1/Rb; % Temps de 1 bit
m = 1; %1 bit par symbole pour le mapping
Rs = Rb/m; % Debit des sumboles
Ts = 1/Rs; % Tenps d'un symbole
Ns = Fe*Ts; % Nombre d'échantillons par symbole

%% Information binaire a transmettre
N = 5000; %Nombre de bit a transmettre
Nt = N*Ns; %Nombre d'échantillon totale. On rajoute des zeros !
bits = randi([0, 1], 1, N); %Signal aleatoire de N bits.

%% Mapping 3 : Symbole binaire de moyenne nulle
ak = [-1, 1]; %Mapping 2-aires a moyenne nulle
map = reshape(bits, N/m, m); %m=1
map = bi2de(map)';
f = @(x) (ak(2)-ak(1))*x + ak(1);
map = f(map);

%% Surechantillonnage
map = kron(map, [1 zeros(1, Ns-1)]);

%%Filtrage de mise en forme
h = [-ones(1, fix(Ns/2)), ones(1, fix(Ns/2))]; %Reponse impulsionnelle de type front de duree Ts=Ns*Te
filt = filter(h, 1, map); 

%% Plot
fig = figure(1);
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
saveas(fig, "figures/mod3_NRZ.png");

%% Signal transmis

fig = figure(2);
plot(0:Te:Te*(30*Ns), filt(1:30*Ns+1));
xlabel('Temps t en sec');
ylabel('filt(t)');
title('Signal transmis ');
saveas(fig, "figures/mod3_signal.png");

%% DSP theorique 
Sx_theo = @(f) Nt*(Ts/2)*((1./(pi*f*Ts/2)).^2).*sin(pi*f*Ts/2).^4;

%% DSP du signal transmis: Methode N7

fig = figure(3);
periodogramme_filt = 1/Nt * abs( fft(filt, 2^nextpow2(length(filt))) ).^2;
semilogy(linspace(-Fe/2, Fe/2, length(periodogramme_filt)), fftshift(periodogramme_filt));
hold on;
semilogy(linspace(-Fe/2, Fe/2, length(periodogramme_filt)), Sx_theo(linspace(-Fe/2, Fe/2, length(periodogramme_filt))));
xlabel('Fréquence f en Hz');
ylabel('|F(Rx)|');
legend("DSP", "DSP Théorique");
title('Densité spectrale de puissance du signal transmis: ');
hold off;
saveas(fig, "figures/mod3_DSP1.png");

%% DSP du signal transmis: Methode Welch

fig = figure(4);
subplot(211);
pwelch(filt);
subplot(212);
PSDx = 10*log10(pwelch(filt));
plot(linspace(0, Fe/2, length(PSDx)), PSDx);
hold on;
plot(linspace(0, Fe/2, length(PSDx)), 10*log10(Sx_theo(linspace(0, Fe/2, length(PSDx)))));
hold off;
legend("DSP", "DSP Théorique");
saveas(fig, "figures/mod3_DSP2.png");
