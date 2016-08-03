
% Thid code calculates the number of peaks and the mean period in an IMF using MEMD to
% fill the values in table 1
clear
% function [] = WhiteNoiseCarateristicsEMDvsMEMD();  
imfstruct = load('E:\Seagate Sync\VOL\Personal folder\Documents\MATLAB\11111Resultats thèse\MEMD_FGN\All_IMFs_All_spectrums_All_ZCs\IMFs_4D_MEMD=9.mat');
all_imfs = imfstruct.all_imfs;
R = size(all_imfs,4); % Number of Realizations
L = size(all_imfs,3); % IMF Size
M = size(all_imfs,2); % IMF number
C = size(all_imfs,1); % Number of Channels

TE = [];
for r=1:R
  % MEMD
    imfR = squeeze(all_imfs(:,:,:,r));
    
    for c = 1:C
        imfC = squeeze(imfR(c,:,:));
        T=[];
        E=[];
            for m=1:M
%                 [indmin, indmax, indzer] = extr(imfC(m,:));
%                 T = [T L/length(indmax)]; % average period estimation
                [indmin, indmax, indzer] = extr(xcorr(imfC(m,:)));
                diffs = diff(indmax);
                T = [T mean(diffs)];
                E = [E sum(imfC(m,:).^2)/L]; % Energy density estimation
            end
            TE = [TE; T E];
%     scatterPlot(T,E);
    end
end
%%
xx = log2(TE(:,1:M));
yy = log2(TE(:,M+1:2*M))+40;
xm = [];
ym = [];
CoCe = [];
figure(1);
for m=1:8
xm = [xm mean(xx(:,m))];
ym = [ym mean(yy(:,m))];

if(mod(m,2)==0)
scatter(xx(:,m),yy(:,m),'*','g'), hold on
else
scatter(xx(:,m),yy(:,m),'*','r'), hold on
end

end

p = polyfit(xm,ym,1);
ym1 = polyval(p,[0:8]);
plot([0:8],ym1,'k', 'LineWidth',1)
