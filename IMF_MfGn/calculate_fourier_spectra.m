%% Calculate Fourier spectra of IMFs
% This code calculates the Fourier spectra of IMFs obtained from decomposing 
% mfGn using MEMD
%__________________________________________________________________________

clear all
close all
clc

% Specify the values of NDel and H to exract the corresponding saved IMFs
% Available values are:
NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];

for i=1:length(NDel)
    for j=1:length(H)
        load(['/idiap/user/akomaty/mfGn_results/IMFs_4D_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        pause
        all_spec = [];
        for k = 1:5000
            imf = squeeze(all_imfs(:,:,:,k)); % remove the singularity dimensions
            [pspec, freq] = spec(imf); % calculate the spectrum
            all_spec = cat(4, all_spec, pspec); % store the calculated spectrum
        end
        mean_spec = mean(all_spec,4); % find the mean speactrum
        outputFolder = '/idiap/user/akomaty/mfGn_results/'; % save data in the current directory
        outputFilename = sprintf('%s/SPEC_4D_MEMD_NDel_%d_H_%d.mat', outputFolder, int8(NDel(i)*10), int8(H(j)*10));
        save(outputFilename, 'mean_spec', '-v7.3') % save the spectrum
    end
end
