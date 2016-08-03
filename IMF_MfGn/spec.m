function [pspec, freq] = spec(imf8n);

% Plots the filter bank structure for multivariate IMFs

% Bplot is a boolean to enable/disable plotting

% Input represents IMFs from 8 channel gaussian noise of length L

% The data set is then divided in to equally divided chunks of lenght 1000 elements
% each, which are then averaged together. The data set must therefore be
% atleast greater than 1000 for this program to work. 

% To save the computaional effort, we have already saved the imfs from
% 8-channel gaussian noise obtained via MEMD (imf8_memd.mat) and via
% standard EMD (imf_emd). Therefore, to plot the filter bank structure, you
% can use the following code:

% example 1 (filter bank structure of MEMD): imf8_memd=memd(wgn(8,5000,0)); filt_bank(imf8_memd);
% example 2 ( filter bank structure of standard EMD): load g-noise-imfs; % filt_bank(imf_emd);
%%
N = 1000;
L=length(imf8n);
cnt=floor(L/N);
imf8n = reshape(imf8n,size(imf8n,1),size(imf8n,2),N,[]);
pspec = abs(fft(imf8n,[],3))./(N/2); % Absolute value of the fft
pspec = pspec(:,:,1:N/2,:).^2; % Take the power of positve frequency half
pspec = squeeze(sum(pspec,4));
% pspec = permute(pspec,[1 3 2]);
freq = 0:N/2-1; % Find the corresponding frequency in Hz
pspec=pspec./cnt;
end