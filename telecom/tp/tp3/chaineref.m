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
map = kron(map, [1 zeros(1, Ns-1)]);

%% Filtre mise en forme
h1 = ones(1, Ns);
x1 = filter(h1, 1, map);

%% Filtre canal
Px = mean(abs(x1).^2);
EbN0 = 0.5:0.5:8; %en Db
X = [];
T = [];
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
    y1 = (sign(z1)+1)/2;

    %% Taux Erreur Binaire
    t1 = mean(y1~=bits);
    T = [T; t1];
end

%% Graph
% Diagramme de l'oeil pour diffeerentes valeurs de Eb/N0.
%fig = figure();
%for i=1:4
%    j = i*floor(length(EbN0)/4)
%    subplot(2, 2, i);
%    plot( reshape(X(j, :), [Ns, N]) );
%    EN = EbN0(j);
%    title(sprintf("Diagramme de l'oeil pour E_b/N_0 = %f dB", EN));
%end
%saveas(fig, "figures/ChaineRefOeilEbN0.png");
% TEB=f(Eb/N0)
fig = figure();
scatter(EbN0, T, 'b+');
hold on
%plot(linspace(EbN0(1), EbN0(end), 1000), qfunc(sqrt(2*linspace(EbN0(1), EbN0(end), 1000))));
plot(EbN0, qfunc(sqrt(2*10.^(EbN0/10))));
set(gca,'yscale','log');
hold off
legend('TEB simule','TEB theorique');
title(sprintf("Taux erreur binaire TEB = f(E_b/N_0) en dB"));
xlabel("E_b/N_0 en dB");
ylabel("TEB");

%saveas(fig, "figures/ChaineRefTEBEbN0.png");