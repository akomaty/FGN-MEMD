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
            RHO = cat(3,corr(imf_n));
            end
            RHO_all = cat(4,RHO); % stores every correlation matrix
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


%% Plot the Correlogram
% 
% figure,
% colormap('summer');   % set colormap
% imagesc(abs(mean(abs(RHO_all),3)));        % draw image and scale colormap to values range
% colorbar;          % show color scale
% hx = xlabel('IMF index');
% hy = ylabel('IMF index');
% set(hx, 'FontSize', 20) 
% set(hy, 'FontSize', 20) 
% set(gca,'fontsize',20)


% cgo2 = HeatMap(cc);
% set(cgo2,'Colormap',redbluecmap);
% cgo3 = HeatMap(mio);
% set(cgo3,'Colormap',redbluecmap);