
% Thid code calculates the number of peaks and the mean period in an IMF using MEMD to
% fill the values in table 1
% clear
% function [] = WhiteNoiseCarateristicsEMDvsMEMD();  
close all
clear
hshift = 0;
ppp= [];
pppR=[];
bias_R = [];
meanH= [];
std_R = [];
Hvalues = 0.1:0.1:0.9;
for iii = 1: 1
imfstruct = load(['C:\Users\ZeinAli\Documents\MATLAB\11111Resultats thèse\MEMD_FGN\All_IMFs_All_spectrums_All_ZCs\IMFs_4D_MEMD=' num2str(iii) '.mat']);
% imfstruct = load('C:\Users\ZeinAli\Documents\MATLAB\11111Resultats
% thèse\EMD_FGN_\IMFs_4D_EMD=6.mat');
estim_H_R = [];
H = Hvalues(iii);
all_imfs = imfstruct.all_imfs;
all_imfs = all_imfs(:,:,:,1:100);
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
                [indmin, indmax, indzer] = extr(imfC(m,:));
                T = [T (indmax(end)-indmax(1))/(length(indmax)-1)]; % average period estimation
                E = [E sum(imfC(m,:).^2)/L]; % Energy density estimation
            end
            TE = [TE; T E];
%     scatterPlot(T,E);
    end
end
%%
% TER = TE;    
% xxR = log2(TER(:,1:M));
% yyR = log2(TER(:,M+1:2*M)); 
% for ind=1:C*R
% xmR = xxR(ind,:);
% ymR = yyR(ind,:);
% pR = polyfit(xmR(2:6),ymR(2:6),1);
% estim_H_R = [estim_H_R (1+pR(1)/2)];
% end
% bias_R1 = (H-estim_H_R).^2;
% meanH = [meanH mean(estim_H_R)];
% bias_R = [bias_R mean(bias_R1)];
% std_R = [std_R std(estim_H_R)];

%%
xx = log2(TE(:,1:M));
yy = log2(TE(:,M+1:2*M))+hshift;
hshift = hshift+5;
xm = [];
ym = [];
CoCe = [];
xx = xx(:,1:7);
yy = yy(:,1:7);
figure(1);
errorbar(mean(yy),std(yy),':r*','MarkerSize',8),hold on
for m=1:7
xm = [xm mean(xx(:,m))];
ym = [ym mean(yy(:,m))];

%     if(mod(m,2)==0)
%         scatter(xx(:,m),yy(:,m),4,'*','b'), hold on
%     else
%         scatter(xx(:,m),yy(:,m),4,'*','r'), hold on
%     end
end
p = polyfit(xm(2:6),ym(2:6),1);
ppp = [ppp p(1)];
estim_H = 1+ppp/2;
ym1 = polyval(p,[2:6]);
plot([2:6],ym1,'k', 'LineWidth',1),hold on
title(['H=' num2str(iii)])
hy = ylabel('log_2(V_H[m])');
hx = xlabel('log_2(T)');
axis tight; grid off
set(hx, 'FontSize', 24) 
% set(hx,'FontWeight','bold')
set(hy, 'FontSize', 24) 
% set(hy,'FontWeight','bold')
set(gca,'fontsize',14)
% if iii<7
% plot([2:6],ym1-0.5,'k', 'LineWidth',2),hold on
% elseif iii==7
% plot([2:6],ym1-0.3,'k', 'LineWidth',2),hold on  
% else
% plot([2:6],ym1-0.2,'k', 'LineWidth',2),hold on 
% end
end