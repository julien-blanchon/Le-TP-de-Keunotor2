clear all
close all

%% Paramètre du modulateur
Rb = 6000; % Debit binaire des bits
Tb = 1/Rb; % Temps de 1 bit
M = 2;
m = 1; %1 bit par symbole pour le mapping. log2(M)
Rs = Rb/m; % Debit des symboles
Ts = 1/Rs; % Tenps d'un symbole


%% Information binaire a transmettre
N = 90000; %Nombre de bit a transmettre
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
h1 = ones(1, Ns);
x1 = filter(h1, 1, map);

%% Filtre canal1
Px = mean(abs(x1).^2);
EbN0 = 0.5:0.5:8; %en Db
X1 = [];
T1 = [];
X2 = [];
T2 = [];
for i=1:length(EbN0)
    E = 10^(EbN0(i)/10);
    sigma2 = Px*Ns/(2*log2(M)*E);
    bruit = sqrt(sigma2)*randn(1, Nt);
    x1b = x1 + bruit;
    x1c = x1b; %Reponse impulsionnelle de type dirac
    x2c = x1b; %Reponse impulsionnelle de type dirac2

    %% Filtre reception1
    hr1 = ones(1, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
    x1r = filter(hr1, 1, x1c);
    X1 = [X1; x1r];
    
    %% Filtre reception2
    hr2 = [ones(1, Ns/2) zeros(1, Ns/2)]; %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
    x2r = filter(hr2, 1, x2c);
    X2 = [X2; x2r];
    
    %% Echantillonnage1
    n01 = 4; %Cf diagrame de l'oeil
    z1 = x1r(n01:Ns:end); 
    
    %% Echantillonnage2
    n02 = 2; %Cf diagrame de l'oeil: 2, 3 et 4. Entre Ts/2 et Ts.
    z2 = x2r(n01:Ns:end); 

    %% Decision+Demapping
    y1 = (sign(z1)+1)/2;
    y2 = (sign(z2)+1)/2;

    %% Taux Erreur Binaire
    t1 = mean(y1~=bits);
    T1 = [T1; t1];
    t2 = mean(y2~=bits);
    T2 = [T2; t2];
end

%% Graph
% TEB=f(Eb/N0)
fig = figure();
plot(EbN0, T1);
hold on
%plot(linspace(EbN0(1), EbN0(end), 1000), qfunc(sqrt(2*linspace(EbN0(1), EbN0(end), 1000))));
plot(EbN0, T2);
set(gca,'yscale','log');
hold off
legend('TEB simulé chaine de référence','TEB simulé chaine 1');
title(sprintf("Taux erreur binaire TEB = f(E_b/N_0) en dB"));
xlabel("E_b/N_0 en dB");
ylabel("TEB");

saveas(fig, "figures/ComparaisonChaineRefEt1.png");