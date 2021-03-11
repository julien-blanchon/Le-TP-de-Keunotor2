%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP3 - Classification bayésienne
% estimation_mu_Sigma.m
%--------------------------------------------------------------------------

function [mu, Sigma] = estimation_mu_Sigma(X)
% Estimateur des moments
% Paramètres en entrés
% --------------------
% 
% Paramètres en sortie
% --------------------
% 
n = length(X);
mu = X'*ones(n, 1)/n;
Xc = X - mu';
Sigma = Xc'*Xc/n;

end