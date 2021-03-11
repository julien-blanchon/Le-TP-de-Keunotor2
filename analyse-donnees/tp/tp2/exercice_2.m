load Data_Exo_2/SG5.mat
Data;
DataMod;
I = Data;
J = DataMod;

%% MCO
%% Estimation avec une portion
figure(1);
subplot(211);
imshow(I);
subplot(212);
[alpha beta] = reconstruction(I, J);
Irecons = (log(J)-beta)/(-alpha);
imshow(Irecons);

%% Estimation image totale
Jtot = ImMod;
Itotrecons = (log(Jtot)-beta)/(-alpha);
figure(2);
imshow(Itotrecons);

%% Erreur moindre carre
erreur = norm(I(:) - Irecons(:));

%% MCT



