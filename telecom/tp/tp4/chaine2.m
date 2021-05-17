clear all
close all
%% Chaine de transmission QPSK

figure(6);
title(sprintf("Taux erreur binaire TEB"));
xlabel("E_b/N_0 en dB");
ylabel("TEB");
    
%% Paramètre du modulateur
Rb = 2000; % Rb = 2kHz debit binaire
Fe = 10000; % Fe = 10kHz frequence echantillonage
Te = 1/Fe;
%% Information binaire a transmettre
N = 1000; %Nombre de bit a transmettre
bits = randi([0, 1], 1, N); %Signal aleatoire de N bits.

%% Mapping de Gray a moyenne nulle: QPSK 4 pts sur le cercle/grille
m = 2;
M = 4;
ak = [1, 1, -1, -1]; %Mapping 4-aire a moyenne nulle
bk = [1, -1, 1, -1]; %Mapping 4-aire a moyenne nulle
dk = ak + j*bk;

map = reshape(bits, m, N/m)'; %m=2
symbole = bi2de(map, 'left-msb')';
symbole(find(symbole==0)) = dk(1); % 00->1+i
symbole(find(symbole==1)) = dk(2); % 01->1-i
symbole(find(symbole==2)) = dk(3); % 10->-1+i
symbole(find(symbole==3)) = dk(4); % 11->-1-i
Nsymbole = N/m;

% % Constellation
% fig1 = figure(1);
% scatter(real(symbole), -imag(symbole));
% title(sprintf("Constellation mapping"));
% %saveas(fig1, sprintf("figures/Chaine2_Constellation_Mapping.png"));

%% Surechantillonnage
Rs = Rb/m; % Debit des symboles
Ts = 1/Rs; % Temps d'un symbole
Ns = Fe*Ts; %Nombre d'échantillons par symbole
Nt = N*Ns; %=size(map). Nombre d'échantillon totale. On rajoute des zeros !
symbole_sur = kron(symbole, [1 zeros(1, Ns-1)]);
Nsymbole_sur = Nsymbole*Ns;

%% Filtre mise en forme
alpha = 0.35;
span = 8;
h = rcosdesign(alpha, span, Ns);
symbole_bandebase = filter_nodelay(h, 1, symbole_sur);
Nsymbole_bandebase = Nsymbole_sur;

%% Transposition en fréquence
fp = 2000; %fp = 2kHz frequence porteuse
symbole_fp = symbole_bandebase.*exp(2*j*pi*fp*Te*(0:Nsymbole_bandebase-1));
x = real(symbole_fp);
Nx = Nsymbole_bandebase;

%%Boucle EbN0
Px = mean(abs(x).^2);
EbN0m = 1:0.25:8; %en Db
%% Filtre canal
for EbN0 = EbN0m
    E = 10^(EbN0/10); %Eb/N0 en 10^
    sigma2 = Px*Ns/(2*log2(M)*E);
    n = sqrt(sigma2)*randn(1, Nx);
    % n = 0; %Sans bruit
    signal_transmis = x + n;

    %% Retour en bande base
    signal_cos = signal_transmis.*cos(2*pi*fp*Te*(0:Nsymbole_bandebase-1));
    signal_sin = signal_transmis.*sin(2*pi*fp*Te*(0:Nsymbole_bandebase-1));

    %% Filtre passe bas: Inutile !
    % ordre = 2*Ns+1;
    % fc = fp;
    % h_pb = (2*fc/Fe) * sinc(2*fc*( -(ordre-1)/2 : (ordre-1)/2)*Te);
    % signal_filtre_cos = filter(h_pb, 1, signal_cos);
    % signal_filtre_sin = filter(h_pb, 1, signal_sin);

    %le filtre passe bas est inutile car conv(h_pb, hr) = hr voir support de h_pb!
    signal_filtre_sin = signal_sin;
    signal_filtre_cos = signal_cos;

%     % Diagramme de l'oeil pour différentes valeurs de Eb/N0.
%     fig2 = figure(2);
%     plot( reshape(signal_filtre_cos, [Ns, N/2]) );
%     title(sprintf("Diagramme de l'oeil sans bruit du signal cos pour Eb/N_0 = %.2f", EbN0));
%     %saveas(fig2, sprintf("figures/Chaine1OeilSansBruitSin_%.2f.png", EbN0));
%     fig3 = figure(3);
%     plot( reshape(signal_filtre_sin, [Ns, N/2]) );
%     title(sprintf("Diagramme de l'oeil sans bruit du signal sin pour Eb/N_0 = %.2f", EbN0));
%     %saveas(fig3, sprintf("figures/Chaine1OeilSansBruitSin_%.2f.png", EbN0));
    
    signal_bande_base = signal_filtre_cos + j*signal_filtre_sin;
    
    %% Filtre de reception
    hr = h;
    signal_reception = filter_nodelay(hr, 1, signal_bande_base);

    %% Echantillonage
    n0 = 1;
    signal_bande_echantilloner = signal_reception(n0:Ns:end);
%     % Constellation
%     fig4 = figure(4);
%     scatter(real(signal_bande_echantilloner), -imag(signal_bande_echantilloner));
%     title(sprintf("Constellation echantillonneur pour Eb/N_0 = %.2f", EbN0));
%     %saveas(fig4, sprintf("figures/Chaine2_Constellation_%.2f.png", EbN0));
    
    %% Décision
%     % Histogramme
%     fig5 = figure(5)
%     hist(angle(signal_bande_echantilloner), 100);
%     title(sprintf("Histogramme de arg(z_m) pour Eb/N_0 = %.2f", EbN0));
%     %saveas(fig5, sprintf("figures/Chaine2Hist%.2f.png", EbN0));
    
    % 4 angle qui code chaque symbole.
    % Plutôt que de faire avec les angles, on peut directement utiliser
    % sign(Reel) - j*sign(Imag)
    SymbolesDecides = sign(real(signal_bande_echantilloner)) - j*sign(imag(signal_bande_echantilloner));

    %% Demapping
    desymbole(find(SymbolesDecides==dk(1))) = 0; % 1+i --> 00
    desymbole(find(SymbolesDecides==dk(2))) = 1; % 1-i --> 01
    desymbole(find(SymbolesDecides==dk(3))) = 2; % -1+i --> 10
    desymbole(find(SymbolesDecides==dk(4))) = 3; % -1-i --> 11
    bits_deco = de2bi(desymbole, 'left-msb')';
    bits_deco = reshape(bits_deco, N, 1)';

    %% Taux erreur binaire
    TEB = mean(bits_deco~=bits);
    
    fig6 = figure(6);
    hold on;
    scatter(EbN0, TEB, 'b+');

end

plot(EbN0m, qfunc(sqrt(10.^(EbN0m/10))));
set(gca,'yscale','log');
%saveas(fig6, sprintf("figures/Chaine2TEB.png"));


