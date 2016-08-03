%% Sample path of vfGn with p = 20 components (reproducing fig 5)

% M : number of samples
% H : Hurst parameter (0 < H < 1); H is a vector of dimension p.
% rho : covariance matrix (!! not the correlation)
% eta :  second parameter (should be antisymmetric)
clear all
close all
clc

M = 500;       % number of samples
p = 20; % number of components

H = zeros(1, p);

for j = 1:p
    H(j) = 0.7+0.1*(j-1)/19;
end


rho = zeros(p,p);

for j = 1:p
    for k = 1:p
        if j == k
            rho(j,k) = 1;
        else
            rho(j,k) = 0.8;
        end
    end
end

[B,x,eta] = Vfbm(M,H,rho) ;

figure
for i = 1:size(B,1)
plot(B(i,:), 'color', rand(1,3)), hold on
end
title('Multivariate fractional Brownian motion')

figure
for i = 1:size(x,1)
plot(x(i,:), 'color', rand(1,3)), hold on
end
title('Multivariate fractional Gaussian noise')
