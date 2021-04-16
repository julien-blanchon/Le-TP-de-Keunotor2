%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%
% Données :
% DataA      : les données d'apprentissage (connues)
% LabelA     : les labels des données d'apprentissage
%
% DataT      : les données de test (on veut trouver leur label)
% Nt_test    : nombre de données tests qu'on veut labelliser
%
% K          : le K de l'algorithme des k-plus-proches-voisins
% ListeClass : les classes possibles (== les labels possibles)
%
% Résultat :
% Partition : pour les Nt_test données de test, le label calculé
%
%--------------------------------------------------------------------------
function [Partition, err] = kppv(DataA, labelA, DataT, labelT, Nt_test, K, ListeClass)

[Na,~] = size(DataA);

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);
Confusion = zeros(length(ListeClass), length(ListeClass));

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])
    xT = DataT(i, :);
    
    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    distances = sum((xT - DataA).^2, 2);
    
    % On ne garde que les indices des K + proches voisins
    [~, K_ind_trie] = mink(distances, K);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    K_label = labelA(K_ind_trie);
    [occ, ind] = histc(K_label(:), ListeClass);
    
    % Recherche de la classe contenant le maximum de voisins
    [Bocc, Iocc] = sort(occ, 'descend');
    Imaxs = Iocc(find(Bocc == max(Bocc)));
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    
    if length(Imaxs)==1
        Imax = Imaxs(1);
    else
        determiner = false;
        j = 1;
        while ~determiner
            if any(Imaxs==(K_label(j)+1))
                Imax = K_label(j)
                determiner = true;
            end
            %A finir, plus petite distance !
            j = j+1;
        end
    end
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    Partition(i) = Imax-1;
    Confusion(Partition(i)+1, labelT(i)+1) = Confusion(Partition(i)+1, labelT(i)+1) +1;
end
err = 1 - sum(diag(Confusion))/sum(Confusion, 'all');

