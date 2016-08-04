%% Plot the correlograms
% You can choose to compare wrt H (the hurst exponent) or wrt NDel (the 
% non-diagonal element of the covariance matrix of the mfGn process)

clear all
close all
clc

NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];

for i=1:length(NDel)
    for j=1:length(H)
        load(['/idiap/user/akomaty/mfGn_results/Results/Corr_Matrix_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        RHO_mean = mean(RHO_all,4);
        figure
        colormap('jet');   % set colormap
        for n = 1:size(RHO_all,3)
            % Plotting
            subplot(2,4,n), imagesc(abs(squeeze(RHO_mean(:,:,n))));
            colorbar;          % show color scale
            hx = xlabel('Channel number');
            hy = ylabel('Channel number');
            set(hx, 'FontSize', 14) 
            set(hy, 'FontSize', 14) 
            set(gca,'fontsize',14)
            title(['IMF_' num2str(n)])
        end
        savefig(['/idiap/user/akomaty/mfGn_results/Results/Correlogram_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.fig'])
    end
end