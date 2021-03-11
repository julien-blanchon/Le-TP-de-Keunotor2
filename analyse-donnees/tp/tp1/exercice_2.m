clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('enseeiht.jpg');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance :
n = length(X);
x_bar = mean(X);
X_c = X - repmat(x_bar, n , 1);
Sigma = (1/n)*X_c'*X_c;

% Valeur Propre de Sigma
[W,D] = eig(Sigma); %W est orthogonal car Sigma symetrique reel (Th spectrale)
[B,I] = sort(diag(D), 'descend');
W = W(:, I);

% Matrice C des composantes principales
c = X_c*W;
C = reshape(c, [size(R), 3]);

figure(3)
% Affichage proj lambda_1 :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(C(:, :, 1));
axis off;
axis equal;
title('Projet \lambda_1','FontSize',20);

% Affichage proj lambda_2 :
subplot(2,2,3);
imagesc(C(:, :, 2));
axis off;
axis equal;
title('Projet \lambda_2','FontSize',20);

% Affichage proj lambda_3 :
subplot(2,2,4);
imagesc(C(:, :, 3));
axis off;
axis equal;
title('Projet \lambda_3','FontSize',20);

% Matrice de variance/covariance :
n = length(c);
c_bar = mean(c);
c_c = c - repmat(c_bar, n , 1);
SigmaC = (1/n)*c_c'*c_c;

% Coefficients de correlation lineaire :
l1 = 1;
l2 = 2;
l3 = 3;
r_l1l2 = sqrt(SigmaC(l1, l2)/(SigmaC(l1,l1)*SigmaC(l2,l2))) %r_l1l2 =   6.8553e-09
r_l1l3 = sqrt(SigmaC(l1, l3)/(SigmaC(l1,l1)*SigmaC(l3,l3))) %r_l1l3 =   0.0000e+00 + 4.4513e-08i
r_l2l3 = sqrt(SigmaC(l2, l3)/(SigmaC(l2,l2)*SigmaC(l3,l3))) %r_l2l3 =   1.2662e-07


% Proportions de contraste : Beaucoup de variance relativement a la
% variance globale
c_l1 = SigmaC(l1,l1)/(SigmaC(l1,l1)+SigmaC(l2,l2)+SigmaC(l3,l3)) %c_l1 =    0.9310
c_l2 = SigmaC(l2,l2)/(SigmaC(l1,l1)+SigmaC(l2,l2)+SigmaC(l3,l3)) %c_l2 =    0.0630
c_l3 = SigmaC(l3,l3)/(SigmaC(l1,l1)+SigmaC(l2,l2)+SigmaC(l3,l3)) %c_l3 =    0.0059

