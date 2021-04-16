%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% TP4AD.m
%--------------------------------------------------------------------------

clear
close all
clc

% Chargement des images d'apprentissage et de test
load MNIST

%   database_test_images       10000x784             
%   database_test_labels       10000x1             
%   database_train_images      60000x784           
%   database_train_labels      60000x1      

DataA = database_train_images;
clear database_train_images
DataT = database_test_images;
clear database_test_images
labelA = database_train_labels;
clear database_train_labels
labelT = database_test_labels;
clear database_test_labels

% Choix du nombre de voisins
K = 10;

% Initialisation du vecteur des classes
ListeClass = 0:9;

% Nombre d'images test
[Nt,~] = size(DataT);
Nt_test = Nt/100; % A changer, pouvant aller de 1 jusqu'à Nt

% Classement par l'algorithme des k-ppv
[Partition, err] = kppv(DataA, labelA, DataT, labelT, Nt_test, K, ListeClass);

% affichage des images avec leur label calculé
l = 28;
h = 28;
fig = figure(1);
for i = 1:min(Nt_test, 9)
    ImgT = DataT(i, :);
    ImgT = reshape(ImgT,[28,28]);
    subplot(3, 3, i);
    imagesc(ImgT);
    colormap gray;
    hold on;
    axis image;
    title(['Image numéro ' num2str(i) ', Partition : ' num2str(Partition(i))]);
end
disp(err);