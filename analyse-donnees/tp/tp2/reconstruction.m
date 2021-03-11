function [alpha beta] = reconstruction(I, J)
    
    LJ = log(J); %LJ = A*x
    LJv = LJ(:);
    [n, m] = size(J);
    A = [-I(:) ones(n*m, 1)];
    x_hat = pinv(A)*LJv;
    alpha = x_hat(1)
    beta = x_hat(2)
end