clear all
close all

%% Paramètre du modulateur
Rb = 3000; % Debit binaire des bits
Tb = 1/Rb; % Temps de 1 bit
m = 1; %1 bit par symbole pour le mapping
Rs = Rb/m; % Debit des symboles
Ts = 1/Rs; % Tenps d'un symbole


%% Information binaire a transmettre
N = 400; %Nombre de bit a transmettre
bits = randi([0, 1], 1, N); %Signal aleatoire de N bits.

%% Mapping: Symbole binaire de moyenne nulle ak={-1, 1}
ak = [-1, 1]; %Mapping binaires a moyenne nulle
map(bits==0) = ak(1);
map(bits==1) = ak(2);

%% Surechantillonnage
Fe = 24000; %Frequence echantillonage
Te = 1/Fe;
Ns = Fe*Ts; %Nombre d'échantillons par symbole
Nt = N*Ns; %=size(map). Nombre d'échantillon totale. On rajoute des zeros !
map = kron(map, [1 zeros(1, Ns-1)]);

%% Filtre mise en forme
alpha = 0.5; %roll off fixe la largeur de bande
h1 = ones(1, Ns);
span = 8;
h2 = rcosdesign(alpha, span, Ns); %Reponse impulsionnelle de racine de cosinus sur ́elev ́e
x1 = filter_nodelay(h1, 1, map);
x2 = filter_nodelay(h2, 1, map);

%% Filtre canal
BW = 4000;
fc = BW;
ordre = 10*Ns;
hc1 = (2*fc/Fe)*sinc(2*fc*[-(ordre-1)*Te/2:Te:(ordre-1)*Te/2]); %Reponse impulsionnelle de type filtre passe bas
hc2 = (2*fc/Fe)*sinc(2*fc*[-(ordre-1)*Te/2:Te:(ordre-1)*Te/2]); %Reponse impulsionnelle de type filtre passe bas
x1c = filter_nodelay(hc1, 1, x1);
x2c = filter_nodelay(hc2, 1, x2);

%% Filtre reception
hr1 = ones(1, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
hr2 = rcosdesign(alpha, span, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
x1r = filter_nodelay(hr1, 1, x1c);
x2r = filter_nodelay(hr2, 1, x2c);
%x1r = filter_nodelay(conv(conv(h1, hc1), hr1), 1, map);

%% Plot des |H|
H1 = fft([h1 zeros(1, 1024-length(h1))]); % Trés IMPORTANT: Pour avoir une fft
% plus précise il faut augmenter le taille de vecteur de fft.
% Car la sortie auras la même taille. Voir kn/N
H2 = fft([h2 zeros(1, 1024-length(h2))]);
Hr1 = fft([hr1 zeros(1, 1024-length(hr1))]);
Hr2 = fft([hr2 zeros(1, 1024-length(hr2))]);
Hc1 = fft([hc1 zeros(1, 1024-length(hc1))]);
Hc2 = fft([hc2 zeros(1, 1024-length(hc2))]);

fig = figure();
subplot(211);
plot(linspace(-Fe/2, Fe/2, length(H1)), fftshift(abs(H1.*Hr1)) );
title('|H(f)*H_{r}(f)| Canal 1');
subplot(212);
plot(linspace(-Fe/2, Fe/2, length(Hc1)), fftshift(abs(Hc1)) );
title('|H_{c}(f)| Canal 1');
saveas(fig, sprintf("figures/Chaine2_H1_%f.png", BW));

fig = figure();
subplot(211);
plot(linspace(-Fe/2, Fe/2, length(H2)), fftshift(abs(H2.*Hr2)) );
title('|H(f)*H_{r}(f)| Canal 2');
subplot(212);
plot(linspace(-Fe/2, Fe/2, length(Hc2)), fftshift(abs(Hc2)) );
title('|H_{c}(f)| Canal 2');
saveas(fig, sprintf("figures/Chaine2_H2_%f.png", BW));

fig = figure();
hold on;
title("Canal 1: Réponse en fréquence en log");
plot(linspace(-Fe/2, Fe/2, length(H1)), 20*log10(fftshift(abs(H1.*Hr1))) );
plot(linspace(-Fe/2, Fe/2, length(Hc1)), 20*log10(fftshift(abs(Hc1))) );
legend('|H(f)*H_{r}(f)|', '|H_{c}(f)|');
hold off;
saveas(fig, sprintf("figures/Chaine2_logH1_%f.png", BW));

fig = figure();
hold on;
title("Canal 2: Réponse en fréquence en log");
plot(linspace(-Fe/2, Fe/2, length(H1)), 20*log10(fftshift(abs(H2.*Hr2))) );
plot(linspace(-Fe/2, Fe/2, length(Hc1)), 20*log10(fftshift(abs(Hc2))) );
legend('|H(f)*H_{r}(f)|', '|H_{c}(f)|');
hold off;
saveas(fig, sprintf("figures/Chaine2_logH2_%f.png", BW));

%Diagramme de l'oeil
fig = figure();
subplot(211);
plot(reshape(x1r, [Ns, N]))
title("Diagramme de l'oeil: Canal 1");
hold on;
subplot(212);
plot(reshape(x2r, [Ns, N]))
title("Diagramme de l'oeil: Canal 2");
hold off;
saveas(fig, sprintf("figures/Chaine2_H1_%f.png", BW));

%% Echantillonnage
% Premiere chaine
n01 = 2; %Cf diagrame de l'oeil (moyenne). BW=4k
%n01=7; %BW=1k
z1 = x1r(n01:Ns:end); 
n02 = 1; %Cf diagrame de l'oeil (moyenne). BW=4k
%n02=5; %BW=1k
z2 = x2r(n02:Ns:end);

%% Decision+Demapping
y1 = (sign(z1)+1)/2;
y2 = (sign(z2)+1)/2;

%% Taux Erreur Binaire
t1 = mean(y1~=bits)
t2 = mean(y2~=bits)

%% BW = 4000 Hz
% Reponse en frequence:
% H*Hr seul satisfait le critere de Nyquiste.
% 
% Pour le Canal1: Le support du canal |Hc| c'est trop petit on ne récuperre
% pas totalement H*Hr. Ne sattisfait pas Nyquiste.
% Pour le Canal2: Le support du canal |Hc| est suffisamenent grand pour
% récupérer entierement H*Hr. Satisfait pas Nyquiste.
%
% Diagramme de l'oeil:
% Pour le Canal1: Ne satisfait pas Nyquist (aucun n0 valide) : le mieux est
% entre 2 et 3.
% Pour le Canal2: Satisfait presque Nyquist avec entre 1 et 2.


%% BW = 1000 Hz
% H*Hr seul satisfait le critere de Nyquiste.
% 
% Pour le Canal1: Le support du canal |Hc| c'est BEAUCOUP trop petit on ne récuperre
% pas totalement H*Hr. Ne satisfait pas Nyquiste.
% Pour le Canal2: Le support du canal |Hc| c'est trop petit on ne récuperre
% pas totalement H*Hr. Ne satisfait pas Nyquiste.
%
% Diagramme de l'oeil:
% Pour le Canal1: Ne satisfait pas Nyquist (aucun n0 valide).
% Pour le Canal2: Ne satisfait pas Nyquist (aucun n0 valide).