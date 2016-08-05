%% This code plots the 2D correlogram of two Fractional Gaussian processes in
%% the case of MEMD

close all
clear all
clc

NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];

for i=1:length(NDel)
    for j=1:length(H)
        RHO_all = [];
        load(['/idiap/user/akomaty/mfGn_results/IMFs_4D_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        for k = 1:size(all_imfs,4) % run through all MC simulations (ex. 5000)
            RHO = []; % stores the correlation of each imf index
            imf = all_imfs(:,:,:,k);
            for n = 1:size(imf,2) % n is the imf index
                imf_n = squeeze(imf(:,n,:)); % we are choosing all channels corresponding to the n^{th} imf
                imf_n = imf_n';
                RHO = cat(3,RHO,corr(imf_n));
            end
            RHO_all = cat(4,RHO_all,RHO); % stores every correlation matrix
            % The size of RHO_all will be p x p x n x m, in our special
            % case, it will be 8 x 8 x 8 x 5000
            % p is the number of channels
            % n is the number of imfs (imf index)
            % m is the number of MC simulations
        end
        outputFolder = '/idiap/user/akomaty/mfGn_results/Results/'; % save data in the current directory
        outputFilename = sprintf('%s/Corr_Matrix_MEMD_NDel_%d_H_%d.mat', outputFolder, int8(NDel(i)*10), int8(H(j)*10));
        save(outputFilename, 'RHO_all', '-v7.3') % save the spectrum
    end
end

% To better understand the outcome of this function, we'll give some
% examples:
% RHO is of size p x p x n, where p is the nb of channels and n is th nb of
% imfs. What do represent RHO is the following:
%  RHO is the correlation matrix between I_i_1, I_i_2, ...,I_i_p
%  where i \in {1, 2, ..., n} and I stands for IMF
%  The result of this correlation for the 4^{th} IMF will be as follows:
%            I_4_1   I_4_2   I_4_3   I_4_4   I_4_5 ...ect
% I_4_1        1       v       v       v       v
% I_4_2        v       1       v       v       v
% I_4_3        v       v       1       v       v
% I_4_4        v       v       v       1       v
% I_4_5        v       v       v       v       1
%   .          .       .       .       .       .
%   .          .       .       .       .       .
%   .          .       .       .       .       .
%  etc        etc     etc     etc     etc     etc