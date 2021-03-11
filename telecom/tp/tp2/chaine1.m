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
x1 = filter(h1, 1, map);
x2 = filter(h2, 1, map);

%% Filtre canal
hc1 = [1, zeros(1, Ns-1)]; %Reponse impulsionnelle de type dirac
hc2 = [1, zeros(1, Ns-1)]; %Reponse impulsionnelle de type dirac
x1c = filter(hc1, 1, x1);
x2c = filter(hc2, 1, x2);

%% Filtre reception
hr1 = ones(1, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
hr2 = rcosdesign(alpha, span, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
x1r = filter(hr1, 1, x1c);
x2r = filter(hr2, 1, x2c);

%% Reponse impulsionnelle g et diagramme de l'oeil
g1 = conv(h1, hr1);
g2 = conv(h2, hr2);
fig = figure();
subplot(211);
plot(g1); %g=h1*h2
legend("g_{1}");
title('Réponse Impulsionnelle filtre 1');
subplot(212);
plot(g2);
legend("g_{2}");
title('Réponse Impulsionnelle filtre 2');
saveas(fig, "Chaine1_g.png");
%Diagramme de l'oeil
fig = figure();
subplot(211);
plot(reshape(x1r, [Ns, N]))
title("Diagramme de l'oeil filtre 1");
hold on;
subplot(212);
plot(reshape(x2r, [Ns, N]))
hold off;
title("Diagramme de l'oeil filtre 2");
saveas(fig, "Chaine1_Oeil.png");

%% Echantillonnage
% Premiere chaine
n01 = 8;
z1 = x1r(n01:Ns:end);
n02 = 1;
z2 = x2r(n02:Ns:end);
retard = span; % retard en symbole ! =8
z2 = [z2(retard+1:end) zeros(1, retard)];

%% Decision+Demapping
y1 = (sign(z1)+1)/2;
y2 = (sign(z2)+1)/2;

%% Taux Erreur Binaire
t1 = mean(y1~=bits);
t2 = mean(y2~=bits);
