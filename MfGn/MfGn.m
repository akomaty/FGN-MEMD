%% Generate MfGn process
% This function returns an MfGn process
% ----------------------
% INPUTS: 
% M         : the number of samples
% H0        : Initial Hurst enxponent
% NDel      : Value of the Non Diagonal elements of the covariance Matrix
% p         : Number of components
% -----------------------
% OUTPUTS:
% x         : H-fGn Multivariate fractional Guassian noise

function x = MfGn(M,H0,NDel,p)

H = zeros(1, p);

for j = 1:p
%     H(j) = H0 + 0.1*(j-1)/(p-1);
    H(j) = H0;
end


rho = zeros(p,p);

for j = 1:p
    for k = 1:p
        if j == k
            rho(j,k) = 1;
        else
            rho(j,k) = NDel;
        end
    end
end

[B,x,eta] = Vfbm(M,H,rho);