%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP3 - Classification bayésienne
% moyenne.m
%--------------------------------------------------------------------------

function x = moyenne(im)
%
% Paramètres en entrés
% --------------------
% 
% Paramètres en sortie
% --------------------
% 
im = single(im);
r = im(:, :, 1);
v = im(:, :, 2);
b = im(:, :, 3);

r_bar = r./max(1,r+v+b);
v_bar = v./max(1,r+v+b);
b_bar = b./max(1,r+v+b);

r_bar = mean(r_bar(:));
v_bar = mean(v_bar(:));
b_bar = mean(b_bar(:));

x = [r_bar v_bar];

end