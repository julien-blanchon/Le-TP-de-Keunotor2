clear all
close all

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
N = 10000; %Nombre de bit a transmettre
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
map_sur = kron(map, [1 zeros(1, Ns-1)]);

%% Filtre mise en forme
h1 = ones(1, Ns);
x1 = filter(h1, 1, map_sur);

%% Filtre canal
Px = mean(abs(x1).^2);
EbN0 = 0.5:0.5:8; %en Db
X = [];
TEB1 = [];
TES1 = [];
for i=1:length(EbN0)
    E = 10^(EbN0(i)/10);
    sigma2 = Px*Ns/(2*log2(M)*E);
    bruit = sqrt(sigma2)*randn(1, Nt);
    x1b = x1 + bruit;
    x1c = x1b; %Reponse impulsionnelle de type dirac

    %% Filtre reception
    hr1 = ones(1, Ns); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
    x1r = filter(hr1, 1, x1c);
    X = [X; x1r];
    %% Echantillonnage
    n01 = 4; %Cf diagrame de l'oeil
    z1 = x1r(n01:Ns:end); 

    %% Decision+Demapping
    SymbolesDecides1 = sign(z1);
    y1 = (SymbolesDecides1+1)/2;

    %% Taux Erreur Binaire
    t1 = mean(y1~=bits);
    TEB1 = [TEB1; t1];
    
    %% Taux Erreur Symbole
    ts1 = mean(SymbolesDecides1~=map);
    TES1 = [TES1; ts1];
end

%% Paramètre du modulateur
Rb = 6000; % Debit binaire des bits
Tb = 1/Rb; % Temps de 1 bit
M = 4;
m = 2; %1 bit par symbole pour le mapping. log2(M)
Rs = Rb/m; % Debit des symboles
Ts = 1/Rs; % Tenps d'un symbole


%% Information binaire a transmettre
N = 5000; %Nombre de bit a transmettre
bits = randi([0, 1], 1, N); %Signal aleatoire de N bits.

%% Mapping: Symbole 4-aire de moyenne nulle ak={-3, -1, 1, 3}
ak = [-3, -1, 1, 3]; %Mapping 4-aire a moyenne nulle
map = reshape(bits, N/m, m); %m=2
map = bi2de(map)';
f = @(x) (ak(2)-ak(1))*x + ak(1); %Fonction de mapping 4_aire de moyenne nulle generique
g = @(y) (y-ak(1))/(ak(2)-ak(1)); %Fonction de demapping 4_aire de moyenne nulle generique
map_signal = f(map);
% Same as Symboles = (2*bi2de(reshape(bits, 2, length(bits)/2).' ) − 3).' 

%% Surechantillonnage
Fe = 24000; %Frequence echantillonage
Te = 1/Fe;
Ns = Fe*Ts; %Nombre d'échantillons par symbole
Nt = N*Ns; %=size(map). Nombre d'échantillon totale. On rajoute des zeros !
map = kron(map_signal, [1 zeros(1, Ns-1)]);

%% Filtre mise en forme
h1 = ones(1, Ns);
x1 = filter(h1, 1, map);

%% Filtre canal
Px = mean(abs(x1).^2);
EbN0 = 0.5:0.5:8; %en Db
X = [];
TEB2 = [];
TES2 = [];
for i=1:length(EbN0)
    E = 10^(EbN0(i)/10);
    sigma2 = Px*Ns/(2*log2(M)*E);
    bruit = sqrt(sigma2)*randn(1, length(x1));
    % bruit = 0; %sans bruit
    x1b = x1 + bruit;
    x1c = x1b; %Reponse impulsionnelle de type dirac

    %% Filtre reception
    hr1 = ones(1, Ns);
    x1r = filter(hr1, 1, x1c);
    X = [X; x1r];
    
    %% Echantillonnage
    n01 = 8; %Cf diagrame de l'oeil
    z1 = x1r(n01:Ns:end); 

    %% Decision+Demapping
    SymbolesDecides = zeros(size(z1));
    SymbolesDecides(find(z1 < -16)) = -3;
    SymbolesDecides(find(z1 > -16)) = -1;
    SymbolesDecides(find(z1 > 0)) = 1;
    SymbolesDecides(find(z1 > 16)) = 3;
    y1 = reshape(de2bi(g(SymbolesDecides)), 1, length(bits))
    % Same as BitsDecides = reshape(de2bi((SymbolesDecides + 3)/2).' , 1, length(bits))

    %% Taux Erreur Binaire
    t1 = mean(y1~=bits)
    TEB2 = [TEB2; t1]
    
    %% Taux Erreur Symbole
    t1 = mean(SymbolesDecides~=map_signal);
    TES2 = [TES2; t1]
    
end


%% Graph
% TEB=f(Eb/N0)
fig = figure();
plot(EbN0, TEB1);
hold on
plot(EbN0, TEB2);
set(gca,'yscale','log');
hold off
legend('TEB simulé chaine de référence','TEB simulé chaine 2');
title(sprintf("Taux erreur binaire TEB = f(E_b/N_0) en dB"));
xlabel("E_b/N_0 en dB");
ylabel("TEB");
saveas(fig, "figures/ComparaisonChaineRefEt2TEB.png");

% TES=f(Eb/N0)
fig = figure();
plot(EbN0, TES1);
hold on
plot(EbN0, TES2);
set(gca,'yscale','log');
hold off
legend('TES simulé chaine de référence','TES simulé chaine 2');
title(sprintf("Taux erreur symbole TES = f(E_b/N_0) en dB"));
xlabel("E_b/N_0 en dB");
ylabel("TES");
saveas(fig, "figures/ComparaisonChaineRefEt2TES.png");
