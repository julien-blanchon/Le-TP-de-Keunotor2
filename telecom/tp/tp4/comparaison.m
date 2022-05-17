clear all
close all
%% Chaine de transmission : Passe bas équivalent

figure(6);
title(sprintf("Taux erreur binaire TEB"));
xlabel("E_b/N_0 en dB");
ylabel("TEB");
    
%% Paramètre du modulateur
Rb = 2000; % Rb = 2kHz debit binaire
Fe = 10000; % Fe = 10kHz frequence echantillonage
Te = 1/Fe;

%% Information binaire a transmettre
N = 2*3*4*100; %Nombre de bit a transmettre
bits = randi([0, 1], 1, N); %Signal aleatoire de N bits.

%% Mapping
% 4-ASK
M1 = 4;
m1 = 2;
map1 = bi2de(reshape(bits, m1, N/m1)', 'left-msb')';
symbole1 = pammod(map1, M1);
% 4-PSK
M2 = 4;
m2 = 2;
map2 = bi2de(reshape(bits, m2, N/m2)', 'left-msb')';
symbole2 = pskmod(map2, M2);
% 8-PSK
M3 = 8;
m3 = 3;
map3 = bi2de(reshape(bits, m3, N/m3)', 'left-msb')';
symbole3 = pskmod(map3, M3);
% 16-QAM
M4 = 16;
m4 = 4;
map4 = bi2de(reshape(bits, m4, N/m4)', 'left-msb')';
symbole4 = pskmod(map4, M4);

%% Surechantillonnage
Rs1 = Rb/m1; % Debit des symboles
Rs2 = Rb/m2;
Rs3 = Rb/m3;
Rs4 = Rb/m4;
Ns1 = Fe/Rs1; %Nombre d'échantillons par symbole
Ns2 = Fe/Rs2;
Ns3 = Fe/Rs3;
Ns4 = Fe/Rs4;
symbole_sur1 = kron(symbole1, [1 zeros(1, Ns1-1)]);
symbole_sur2 = kron(symbole2, [1 zeros(1, Ns2-1)]);
symbole_sur3 = kron(symbole3, [1 zeros(1, Ns3-1)]);
symbole_sur4 = kron(symbole4, [1 zeros(1, Ns4-1)]);

%% Filtre mise en forme
alpha = 0.35;
span = 8;
h1 = rcosdesign(alpha, span, Ns1);
x1 = filter_nodelay(h1, 1, symbole_sur1);
Nx1 = (N/m1)*Ns1;
h2 = rcosdesign(alpha, span, Ns2);
x2 = filter_nodelay(h2, 1, symbole_sur2);
Nx2 = (N/m2)*Ns2;
h3 = rcosdesign(alpha, span, Ns3);
x3 = filter_nodelay(h3, 1, symbole_sur3);
Nx3 = (N/m3)*Ns3;
h4 = rcosdesign(alpha, span, Ns4);
x4 = filter_nodelay(h4, 1, symbole_sur4);
Nx4 = (N/m4)*Ns4;

%% DSP
fig7 = figure(7);
title(sprintf("DSP"));
xlabel("Fréquence en kHz");
ylabel("Puissance en dB");
[Px1,Fx1] = periodogram(x1,[], Nx1, 'centered');
[Px2,Fx2] = periodogram(x2,[], Nx2, 'centered');
[Px3,Fx3] = periodogram(x3,[], Nx3, 'centered');
[Px4,Fx4] = periodogram(x4,[], Nx4, 'centered');
plot(Fx1, 10*log10(Px1)); hold on;
plot(Fx2, 10*log10(Px2)); hold on;
plot(Fx3, 10*log10(Px3)); hold on;
plot(Fx4, 10*log10(Px4)); hold on;
hold off;
legend('4-ASK','4-PSK', '8-PSK', '16-QAM', 'Location','Best');
saveas(fig7, sprintf("figures/ComparaisonDSP.png"));

fig8 = figure(8);
pwelch(x1, [],[], [], Fe, 'centered');
saveas(fig8, sprintf("figures/ComparaisonPwelch4ASK.png"));
fig9 = figure(9);
pwelch(x2, [],[], [], Fe, 'centered');
saveas(fig9, sprintf("figures/ComparaisonPwelch4PSK.png"));
fig10 = figure(10);
pwelch(x3, [],[], [], Fe, 'centered');
saveas(fig10, sprintf("figures/ComparaisonPwelch8ASK.png"));
fig11 = figure(11);
pwelch(x4, [],[], [], Fe, 'centered');
saveas(fig11, sprintf("figures/ComparaisonPwelch16QAM.png"));



%% Boucle EbN0
Px1 = mean(abs(x1).^2);
Px2 = mean(abs(x2).^2);
Px3 = mean(abs(x3).^2);
Px4 = mean(abs(x4).^2);
EbN0m = 0:0.1:8; %en Db
TEB1 = [];
TEB2 = [];
TEB3 = [];
TEB4 = [];
%% Filtre canal
for EbN0 = EbN0m
    E = 10^(EbN0/10); %Eb/N0 en 10^
    sigma2_1 = Px1*Ns1/(2*log2(M1)*E);
    sigma2_2 = Px2*Ns2/(2*log2(M2)*E);
    sigma2_3 = Px3*Ns3/(2*log2(M3)*E);
    sigma2_4 = Px4*Ns4/(2*log2(M4)*E);
    % n = 0; %Sans bruit
    signal_transmis1 = x1 + sqrt(sigma2_1)*(randn(1, Nx1) +  j*randn(1, Nx1));
    signal_transmis2 = x2 + sqrt(sigma2_2)*(randn(1, Nx2) +  j*randn(1, Nx2));
    signal_transmis3 = x3 + sqrt(sigma2_3)*(randn(1, Nx3) +  j*randn(1, Nx3));
    signal_transmis4 = x4 + sqrt(sigma2_4)*(randn(1, Nx4) +  j*randn(1, Nx4));
    
    %% Filtre de reception
    signal_reception1 = filter_nodelay(h1, 1, signal_transmis1);
    signal_reception2 = filter_nodelay(h2, 1, signal_transmis2);
    signal_reception3 = filter_nodelay(h3, 1, signal_transmis3);
    signal_reception4 = filter_nodelay(h4, 1, signal_transmis4);

    %% Echantillonage
    n0 = 1;
    signal_bande_echantilloner1 = signal_reception1(n0:Ns1:end);
    signal_bande_echantilloner2 = signal_reception2(n0:Ns2:end);
    signal_bande_echantilloner3 = signal_reception3(n0:Ns3:end);
    signal_bande_echantilloner4 = signal_reception4(n0:Ns4:end);
    
    % Constelation pour différentes valeurs de Eb/N0.
    if (EbN0 == EbN0m(1) || EbN0 == EbN0m(1+fix(length(EbN0m)/3)) || EbN0 == EbN0m(1+fix(length(EbN0m)/2)) || EbN0 == EbN0m(end))
        fig = figure();
        subplot(2,2,1)
        scatter(real(signal_transmis1), imag(signal_transmis1));
        title(sprintf("Constellation 4-ASK pour Eb/N_0 = %.2f", EbN0));
        subplot(2,2,2)
        scatter(real(signal_transmis2), imag(signal_transmis2));
        title(sprintf("Constellation 4-PSK pour Eb/N_0 = %.2f", EbN0));
        subplot(2,2,3)
        scatter(real(signal_transmis3), imag(signal_transmis3));
        title(sprintf("Constellation 8-PSK pour Eb/N_0 = %.2f", EbN0));
        subplot(2,2,4)
        scatter(real(signal_transmis4), imag(signal_transmis4));
        title(sprintf("Constellation 16-QAM pour Eb/N_0 = %.2f", EbN0));
        saveas(fig, sprintf("figures/Constellation_%.2f.png", EbN0));
    end
    
    %% Demapping
    % 4-ASK
    demap1 = pamdemod(signal_bande_echantilloner1, M1);
    debits1 = reshape(de2bi(demap1, 'left-msb')', N, 1)';
    % 4-PSK
    demap2 = pskdemod(signal_bande_echantilloner2, M2);
    debits2 = reshape(de2bi(demap2, 'left-msb')', N, 1)';
    % 8-PSK
    demap3 = pskdemod(signal_bande_echantilloner3, M3);
    debits3 = reshape(de2bi(demap3, 'left-msb')', N, 1)';
    % 16-QAM
    demap4 = pskdemod(signal_bande_echantilloner4, M4);
    debits4 = reshape(de2bi(demap4, 'left-msb')', N, 1)';

    %% Taux erreur binaire
    TEB1 = [TEB1 mean(debits1~=bits)];
    TEB2 = [TEB2 mean(debits2~=bits)];
    TEB3 = [TEB3 mean(debits3~=bits)];
    TEB4 = [TEB4 mean(debits4~=bits)];
end

figure(6);
fig6 = figure(6);
hold on;
scatter(EbN0m, TEB1);
scatter(EbN0m, TEB2);
scatter(EbN0m, TEB3);
scatter(EbN0m, TEB4);
plot(EbN0m, qfunc(sqrt(10.^(EbN0m/10))));
legend('4-ASK','4-PSK', '8-PSK', '16-QAM', 'Courbe théorique 4-PSK', 'Location','Best');
set(gca,'yscale','log');
saveas(fig6, sprintf("figures/ComparaisonTEB.png"));


