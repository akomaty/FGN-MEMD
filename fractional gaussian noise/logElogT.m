function [TE] = logElogT(imf);
% Ce code rend une matrice de dimension ligne*colonne, tels que ligne =
% nb de canaux et colonne  = [T E] avec T: 1*9 et E:1*9
TE = [];
L = size(imf,3);
for i=1:size(imf,1)
    T = [];
    E = [];
    for j = 1:9 % take only 9 IMFs
        [indmin, indmax, indzer] = extr(imf(i,j,:));
        T = [T (indmax(end)-indmax(1))/(length(indmax)-1)]; % average period estimation
        E = [E sum(imf(i,j,:).^2)/L]; % Energy density estimation
    end
    TE = [TE; T E];
end