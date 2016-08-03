%% Test the mfBm function

% M : number of samples
% H : Hurst parameter (0 < H < 1); H is a vector of dimension p.
% rho : covariance matrix (!! not the correlation)
% eta :  second parameter (should be antisymmetric)
clear all
close all
clc

M = 1000;
H = [0.2 0.3];
rho = [1 0.2; 0.2 1]

[B,x,eta] = Vfbm(M,H,rho) ;

figure
plot(x(1,:),'r'), hold on
plot(x(2,:),'g')
title('Multivariate fractional Gaussian noise')

figure
plot(B(1,:),'r'), hold on
plot(B(2,:),'g')
title('Multivariate fractional Brownian motion')