function Beta_chapeau = MCO(x, y)

    %%Avec gamma
    A = [x.^2 x.*y y.^2 x y ones(length(x), 1); 1 0 1 0 0 0];
    b = [zeros(length(x), 1); 1];
    % A*B = b
    B = A\b;
    
    %%Sans alpha
    A2 = [x.*y (y.^2-x.^2) x y ones(length(x), 1)];
    b2 = [-x.^2];
    % A*B = b
    B2 = A2\b2;
    
    %%Beta chapeau
    Beta_chapeau = [1-B2(2); B2];
    