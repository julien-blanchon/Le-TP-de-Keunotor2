%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% Question 4
% tpq4.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Calcul de la perte d'orthogonalite

% Rang de la matrice
n = 4;

% Puissance de 10 maximale pour le conditionnement
k = 20;

% Matrice U de test
U = gallery('orthog',n);

% Matrice de reference
D = eye(n);

% Initialisation de la matrice pour recuperer les pertes d'orthogonalite
po1 = zeros(2,k);
po2 = zeros(2,k);

for i = 1:k
  
  % Conditionnement de la matrice A
  %TO DO: modifier D pour obtenir A tel K(A)=10^k
  D = diag([10^i ones(1, n-1)])
  A = U*D*U';
  
  
  %Iteration 1
  
  % Perte d'orthogonalite avec algorithme classique
  Qcgs1 = cgs(A);
  po1(1,i) = norm(eye(n)-Qcgs1'*Qcgs1);
  
  % Perte d'orthogonalite avec algorithme modifie
  Qmgs1 = mgs(A);
  po1(2,i) = norm(eye(n)-Qmgs1'*Qmgs1);
  
  %Iteration 2
  
  % Perte d'orthogonalite avec algorithme classique
  Qcgs2 = cgs(Qcgs1);
  po2(1,i) = norm(eye(n)-Qcgs2'*Qcgs2);
  
  % Perte d'orthogonalite avec algorithme modifie
  Qmgs2 = mgs(Qmgs1);
  po2(2,i) = norm(eye(n)-Qmgs2'*Qmgs2);
  
end

%% Affichage des courbes d'erreur

x = 10.^(1:k);

figure('Position',[0.1*L,0.1*H,0.8*L,0.75*H])

    loglog(x,po1(1,:),'r','lineWidth',2)
    hold on
    loglog(x,po1(2,:),'b','lineWidth',2)
    loglog(x,po2(1,:),'r','lineWidth',2)
    loglog(x,po2(2,:),'y','lineWidth',2)
    grid on
    leg = legend('Gram-Schmidt classique 1 it',...
                 'Gram-Schmidt modifie 1 it',...
                 'Gram-Schmidt classique 2 it',...
                 'Gram-Schmidt modifie 2 it',...
                 'Location','NorthWest');
    set(leg,'FontSize',14);
    xlim([x(1) x(end)])
    hx = xlabel('\textbf{Conditionnement $\mathbf{\kappa(A_k)}$}',...
                'FontSize',14,'FontWeight','bold');
    set(hx,'Interpreter','Latex')
    hy = ylabel('$\mathbf{|| I - Q_k^\top Q_k ||}$','FontSize',14,'FontWeight','bold');
    set(hy,'Interpreter','Latex')
    title('Evolution de la perte d''orthogonalite en fonction du conditionnement',...
          'FontSize',20)


