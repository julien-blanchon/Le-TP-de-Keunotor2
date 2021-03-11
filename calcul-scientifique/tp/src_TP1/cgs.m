%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function Q = cgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    % Algorithme de Gram-Schmidt classique
    for j = 1:m
        A_prime = A;
        for k = 1:j-1
            A_prime(:, j) = A_prime(:, j) - A(:, j)'*Q(:, k)*Q(:, k);
        end
        Q(:, j) = A_prime(:, j)/norm(A_prime(:, j));
    end
    %------------------------------------------------

end