
% Thid code calculates the number of peaks and the mean period in an IMF using MEMD to
% fill the values in table 1
% clear
% function [] = WhiteNoiseCarateristicsEMDvsMEMD();  
close all
clear

for iii = 1: 9
imfstruct = load(['C:\Users\ZeinAli\Documents\MATLAB\11111Resultats thèse\EMD_FGN_\IMFs_4D_EMD=' num2str(iii) '.mat']);
% imfstruct = load('C:\Users\ZeinAli\Documents\MATLAB\11111Resultats
% thèse\EMD_FGN_\IMFs_4D_EMD=6.mat');
all_imfs = imfstruct.all_imfs;
all_imfs = all_imfs(:,:,:,1:100);
R = size(all_imfs,4); % Number of Realizations
L = size(all_imfs,3); % IMF Size
M = size(all_imfs,2); % IMF number
C = size(all_imfs,1); % Number of Channels

N = 0;
rkH_R = [];
pH_R =[];
for r=1:R
  % EMD
    imfR = squeeze(all_imfs(:,:,:,r));
    rkH_C = [];
    pH_C = [];
    for c = 1:C
        imfC = squeeze(imfR(c,:,:));
        rkH = [];
        pH = [];
            for m=1:M
                [pxx,f] = periodogram(imfC(m,:),[],[],1e3);
                pH = [pH pxx];
            end
        pH_C = cat(3,pH_C,pH);
    end
    pH_R = cat(4,pH_R,pH_C);
end
pH_R = pH_R/(R*C);
figure,
for i=1:C
    Ph_per_Channel = squeeze(pH_R(:,:,i,:));
    mean_Ph_per_Channel = mean(Ph_per_Channel,3);
    plot(log2(f),log2(mean_Ph_per_Channel))
    title(['H=' num2str(iii)])
    hx = xlabel('log_2(frequency)');
    hy = ylabel('log2-PSD (dB)');
    axis tight; grid off
    set(hx, 'FontSize', 14) 
    set(hx,'FontWeight','bold')
    set(hy, 'FontSize', 14) 
    set(hy,'FontWeight','bold')
    set(gca,'fontsize',14),hold on
end

end

