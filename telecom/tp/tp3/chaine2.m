clear all
close all

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
TEB = [];
TES = [];
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
    TEB = [TEB; t1]
    
    t1 = mean(SymbolesDecides~=map_signal);
    TES = [TES; t1];
end

%% Graph
% Diagramme de l'oeil pour differentes valeurs de Eb/N0.
% fig = figure();
% for i=1:1
%     j = i*floor(length(EbN0)/4)
%     subplot(2, 2, i);
%     plot( reshape(X(j, :), [Ns, N/2]) );
%     EN = EbN0(j);
%     title(sprintf("Diagramme de l'oeil pour E_b/N_0 = %f dB", EN));
%     title(sprintf("Diagramme de l'oeil sans bruit"));
% end
% saveas(fig, "figures/Chaine2OeilEbN0.png");
% saveas(fig, "figures/Chaine2OeilSansBruit.png");

% TEB=f(Eb/N0)
fig = figure();
scatter(EbN0, TEB, 'b+');
hold on
plot(EbN0, 3/4*qfunc(sqrt((4/5)*10.^(EbN0/10))));
% Le coef 3/4 n'est pas présent chez moi ???
set(gca,'yscale','log');
hold off
legend('TEB simule','TEB theorique');
title(sprintf("Taux erreur binaire TEB = f(E_b/N_0) en dB"));
xlabel("E_b/N_0 en dB");
ylabel("TEB");
saveas(fig, "figures/Chaine2TEBEbN0.png");

% TES=f(Eb/N0)
fig = figure();
scatter(EbN0, TES, 'b+');
hold on
plot(EbN0, (3/2)*qfunc(sqrt((4/5)*10.^(EbN0/10))));
set(gca,'yscale','log');
hold off
legend('TES simule','TES theorique');
title(sprintf("Taux erreur symbole TES = f(E_b/N_0) en dB"));
xlabel("E_b/N_0 en dB");
ylabel("TES");

%saveas(fig, "figures/Chaine2TESEbN0.png");

fig = figure();
hist(z1, 100);
title(sprintf("Histogramme de z_m"));
saveas(fig, "figures/Chaine2Hist.png");
