clear all
close all
clc

mu = [2,3];
sigma = [1,1.5;1.5,3];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,100);

figure
plot(r(:,1),r(:,2),'+')