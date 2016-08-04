%% This code calculates the zero crossings of mfGn processes
%% the case of MEMD

close all
clear all
clc

NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];

for i=1:length(NDel)
    for j=1:length(H)
        ZC_all = [];
        slope_all = [];
        load(['/idiap/user/akomaty/mfGn_results/IMFs_4D_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        for k = 1:size(all_imfs,4) % run through all MC simulations (ex. 5000)
            RHO = []; % stores the correlation of each imf index
            imf = all_imfs(:,:,:,k);
            [ZC,slope]  = zero_crossing(imf, 0);
            ZCm = mean(ZC,2);
            ZC_all = [ZC_all ZCm];
            slope_all = [slope_all slope];
            % The size of ZC_all will be n x m, in our special
            % case, it will be 8 x 5000
            % n is the number of imfs (imf index)
            % m is the number of MC simulations
        end
        outputFolder = '/idiap/user/akomaty/mfGn_results/Results/'; % save data in the current directory
        outputFilename = sprintf('%s/ZC_MEMD_NDel_%d_H_%d.mat', outputFolder, int8(NDel(i)*10), int8(H(j)*10));
        save(outputFilename, 'ZC_all', 'slope_all', '-v7.3') % save the ZC matrix
    end
end
