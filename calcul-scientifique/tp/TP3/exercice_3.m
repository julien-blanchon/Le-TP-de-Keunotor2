%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP3 - Classification bayésienne
% exercice_3.m
%--------------------------------------------------------------------------

clear
close all
clc

% Chargement des données de l'exercice 2
load resultats_ex2

%% Classifieur par maximum de vraisemblance
% code_classe est la matrice contenant des 1 pour les chrysanthemes
%                                          2 pour les oeillets
%                                          3 pour les pensees
% l'attribution de 1,2 ou 3 correspond au maximum des trois vraisemblances
V = cat(3, V_chrysanthemes, V_oeillets, V_pensees);
[Vmax, code_classe] = max(V, [], 3);

%% Affichage des classes

figure('Name','Classification par maximum de vraisemblance',...
       'Position',[0.25*L,0.1*H,0.5*L,0.8*H])
axis equal ij
axis([r(1) r(end) v(1) v(end)]);
hold on
imagesc(r,v,code_classe)
carte_couleurs = [.45 .45 .65 ; .45 .65 .45 ; .65 .45 .45];
colormap(carte_couleurs)
hx = xlabel('$\overline{r}$','FontSize',20);
set(hx,'Interpreter','Latex')
hy = ylabel('$\bar{v}$','FontSize',20);
set(hy,'Interpreter','Latex')
%legend("chry", "oreillets", "pensees");
view(-90,90)

%% Comptage des images correctement classees

err_pensees = 0;
[mu_pensees, Sigma_pensees] = estimation_mu_Sigma(X_pensees);
[mu_oeillets, Sigma_oeillets] = estimation_mu_Sigma(X_oeillets);
[mu_chrysanthemes, Sigma_chrysanthemes] = estimation_mu_Sigma(X_chrysanthemes);
denominateur_classe_i = -1;
for i=1:nb_images_pensees
    xi = X_pensees(i, :);
    [P_pensees, denominateur] = vraisemblance(xi(1), xi(2), mu_pensees, Sigma_pensees, denominateur_classe_i);
    [P_oeillets, denominateur] = vraisemblance(xi(1), xi(2), mu_oeillets, Sigma_oeillets, denominateur_classe_i);
    [P_chrysanthemes, denominateur] = vraisemblance(xi(1), xi(2), mu_chrysanthemes, Sigma_chrysanthemes, denominateur_classe_i);
    err_pensees = err_pensees + (max([P_pensees; P_oeillets; P_chrysanthemes])~=P_pensees);
end
err_pensees = err_pensees/nb_images_pensees

err_oeillets = 0;
for i=1:nb_images_oeillets
    xi = X_oeillets(i, :);
    [P_pensees, denominateur] = vraisemblance(xi(1), xi(2), mu_pensees, Sigma_pensees, denominateur_classe_i);
    [P_oeillets, denominateur] = vraisemblance(xi(1), xi(2), mu_oeillets, Sigma_oeillets, denominateur_classe_i);
    [P_chrysanthemes, denominateur] = vraisemblance(xi(1), xi(2), mu_chrysanthemes, Sigma_chrysanthemes, denominateur_classe_i);
    err_oeillets = err_oeillets + (max([P_pensees; P_oeillets; P_chrysanthemes])~=P_oeillets);
end
err_oeillets = err_oeillets/nb_images_oeillets

err_chrysanthemes = 0;
for i=1:nb_images_chrysanthemes
    xi = X_chrysanthemes(i, :);
    [P_pensees, denominateur] = vraisemblance(xi(1), xi(2), mu_pensees, Sigma_pensees, denominateur_classe_i);
    [P_oeillets, denominateur] = vraisemblance(xi(1), xi(2), mu_oeillets, Sigma_oeillets, denominateur_classe_i);
    [P_chrysanthemes, denominateur] = vraisemblance(xi(1), xi(2), mu_chrysanthemes, Sigma_chrysanthemes, denominateur_classe_i);
    err_oeillets = err_oeillets + (max([P_pensees; P_oeillets; P_chrysanthemes])~=P_chrysanthemes);
end
err_chrysanthemes = err_chrysanthemes/nb_images_chrysanthemes


