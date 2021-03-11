clear all
close all

%% Paramètre du modulateur
Fe = 24000;
Te = 1/Fe;
Rb = 6000;

%% Information binaire a transmettre
N = 3000;
bits = randi([0, 1], 1, N); %Signal aleatoire de N bits.

%% Mapping 1 : Symbole binaire de moyenne nulle
m1 = 1;
Rs1 = Rb/m1;
Ns1 = Fe/Rs1;
Ts1 = Ns1*Te;
Nt1 = N*Ns1;
ak1 = [-1, 1]; %Mapping binaires a moyenne nulle
map1(bits==0) = ak1(1);
map1(bits==1) = ak1(2);

%% Mapping 2 : Symbole 4-aires de moyenne nulle
m2 = 2;
Rs2 = Rb/m2;
Ns2 = Fe/Rs2;
Ts2 = Ns2*Te;
Nt2 = N*Ns2;
ak2 = [-3, -1, 1, 3]; %Mapping 4-aires a moyenne nulle
map2 = reshape(bits, N/m2, m2); %m=2
map2 = bi2de(map2)';
f2= @(x) (ak2(2)-ak2(1))*x + ak2(1);
map2 = f2(map2);

%% Mapping 3 : Symbole binaire de moyenne nulle
m3 = 1;
Rs3 = Rb/m3;
Ns3 = Fe/Rs3;
Ts3 = Ns3*Te;
Nt3 = N*Ns3;
ak3 = [-1, 1]; %Mapping 2-aires a moyenne nulle
map3 = reshape(bits, N/m3, m3); %m=1
map3 = bi2de(map3)';
f3 = @(x) (ak3(2)-ak3(1))*x + ak3(1);
map3 = f3(map3);

%% Mapping 4 : Symbole binaire de moyenne nulle
m4 = 1;
Rs4 = Rb/m4;
Ns4 = Fe/Rs4;
Ts4 = Ns4*Te;
Nt4 = N*Ns4;
ak4 = [-1, 1]; %Mapping 2-aires a moyenne nulle
map4 = reshape(bits, N/m4, m4); %m=1
map4 = bi2de(map4)';
f4 = @(x) (ak4(2)-ak4(1))*x + ak4(1);
map4 = f4(map4);

%% Surechantillonnage
map1 = kron(map1, [1 zeros(1, Ns1-1)]);
map2 = kron(map2, [1 zeros(1, Ns2-1)]);
map3 = kron(map3, [1 zeros(1, Ns3-1)]);
map4 = kron(map4, [1 zeros(1, Ns4-1)]);


%%Filtrage de mise en forme
h1 = ones(1, Ns1); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
h2 = ones(1, Ns2); %Reponse impulsionnelle de type rectangulaire de duree Ts=Ns*Te
h3 = [-ones(1, fix(Ns3/2)), ones(1, fix(Ns3/2))]; %Reponse impulsionnelle de type front de duree Ts=Ns*Te
h4 = rcosdesign(0.5, 8, Ns4); %Reponse impulsionnelle cos
filt1 = filter(h1, 1, map1); 
filt2 = filter(h2, 1, map2); 
filt3 = filter(h3, 1, map3); 
filt4 = filter(h4, 1, map4);

%% DSP du signal transmis: Methode Welch

fig = figure(1)
PSDx1 = 20*log10(pwelch(filt1)); %10log(Sy(f)) = 10log(|H(f)^2|Sx(f)) = 20log(..)
p1 = plot(linspace(-Fe/2, Fe/2, 2*length(PSDx1)), [flip(PSDx1); PSDx1]);

hold on
PSDx2 = 20*log10(pwelch(filt2));
p2 = plot(linspace(-Fe/2, Fe/2, 2*length(PSDx2)), [flip(PSDx2); PSDx2]);

PSDx3 = 20*log10(pwelch(filt3));
p3 = plot(linspace(-Fe/2, Fe/2, 2*length(PSDx3)), [flip(PSDx3); PSDx3]);

PSDx4 = 20*log10(pwelch(filt4));
p4 = plot(linspace(-Fe/2, Fe/2, 2*length(PSDx4)), [flip(PSDx4); PSDx4]);

xlabel('Fréquence f en Hz');
ylabel('|F(Rx)|');
title('Densité spectrale de puissance du signal transmis: ');
legend("mod1", "mod2", "mod3", "mod4")
hold off

saveas(fig, "figures/mod1234_DSP.png");


%% Réponse: Efficacité = (Rb)/Bande = log2(M)/k.
% Modulateur i  || Ordre M  || B        || Rs   || k(B=k*Rs)        || Efficacité
% Modulateur 1  || 2        || 6000Hz   || 6000 || 1                || 1
% Modulateur 2  || 4        || 3000Hz   || 3000 || 1                || 2
% Modulateur 3  || 2        || 6000Hz   || 3000 || 2                || 1
% Modulateur 4  || 2        || 4700Hz   || 6000 || 0.78=(1+alpha)/2 || 1,28
%
% Classement: 1>3>4>2
%
% Pour améliorer l'efficacité on peut augmenter l'ordre M, ou choisir un
% filtre h avec un coefficient k plus faible (dont les fréquence sont moins 
% étendu).

