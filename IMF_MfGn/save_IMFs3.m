close all
clear all
clc

Fs = 1e3;
t = 0:1/Fs:1-1/Fs;

% MfGn parameters
NDel = 0.8;
p = 8;
M = Fs;

for H = [0.4 0.6 0.8]
    all_imfs =[];
    
    for i = 1:5000
        imf = [];
        x = MfGn(M,H,NDel,p) ;
        % MEMD
        imf = memd(x);
        if size(imf,2)>=8
            all_imfs = cat(4,all_imfs, imf(:,1:8,:));        
        end
    end
    outputFolder = '/idiap/user/akomaty/mfGn_results/'; % save data in the current directory
    outputFilename = sprintf('%s/IMFs_4D_MEMD_NDel_%d_H_%d.mat', outputFolder, int8(NDel*10), int8(H*10));
    save(outputFilename, 'all_imfs', '-v7.3')
end
