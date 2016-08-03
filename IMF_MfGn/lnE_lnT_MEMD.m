% This code plots the relationship between VH [m] and (log2(T),m) for MEMD
% This code would produce a scatter plot similar to that in the Figure IV.5
% in the PhD thesis report of A. Komaty (chapter IV - page 126).

clear all
clc

hshift = 0;
ppp= [];
pppR=[];
bias_R = [];
meanH= [];
std_R = [];

% Specify the values of NDel and H to exract the corresponding saved IMFs
% Available values are:
NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];

% % Select the file corresponding to the following indexes:
% i = 1; % pointer to the NDel vector
% j = 1; % pointer to the H vector

for i=1:length(NDel)
    close all
    for j=1:length(H)

load(['/idiap/user/akomaty/mfGn_results/IMFs_4D_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])

% Select the number of realizations you want to use for the scatter plot
% The default number is 5000, we recommand to use a smaller number to avoid
% memory problems when plotting the scatter plot.
all_imfs = all_imfs(:,:,:,1:4000);

estim_H_R = [];

R = size(all_imfs,4); % Number of Realizations
L = size(all_imfs,3); % IMF Size
M = size(all_imfs,2); % IMF number
C = size(all_imfs,1); % Number of Channels

TE = [];
for r=1:R
  % MEMD
    imfR = squeeze(all_imfs(:,:,:,r)); % remove the singularity dimensions
    
    for c = 1:C
        imfC = squeeze(imfR(c,:,:));
        T=[];
        E=[];
            for m=1:M
                [indmin, indmax, indzer] = extr(xcorr(imfC(m,:)));
                diffs = diff(indmax);
                T = [T mean(diffs)];
                E = [E sum(imfC(m,:).^2)/L]; % Energy density estimation
            end
            TE = [TE; T E];
%     scatterplot(T,E);
    end
end

TER = TE;    
xxR = log2(TER(:,1:M));
yyR = log2(TER(:,M+1:2*M)); 
for ind=1:C*R
xmR = xxR(ind,:);
ymR = yyR(ind,:);
pR = polyfit(xmR(2:6),ymR(2:6),1);
estim_H_R = [estim_H_R (1+pR(1)/2)];
end
bias_R1 = (H(j)-estim_H_R).^2;
meanH = [meanH mean(estim_H_R)];
bias_R = [bias_R mean(bias_R1)];
std_R = [std_R std(estim_H_R)];

%%
xx = log2(TE(:,1:M));
yy = log2(TE(:,M+1:2*M))+hshift;
hshift = hshift+5;
xm = [];
ym = [];
CoCe = [];% i = 1; % pointer to the NDel vector
% j = 1; % pointer to the H vector

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
title(['NDel=' num2str(NDel(j))])
hy = ylabel('log_2(V_H[m])');
hx = xlabel('log_2(T)');
axis tight; grid off
set(hx, 'FontSize', 24) 
% set(hx,'FontWeight','bold')
set(hy, 'FontSize', 24) 
% set(hy,'FontWeight','bold')
set(gca,'fontsize',14)
    end
    savefig(['/idiap/user/akomaty/mfGn_results/lnE_m_MEMD_NDel_' num2str(int8(10*NDel(i))) '.fig'])
end
% if iii<7
% plot([2:6],ym1-0.5,'k', 'LineWidth',2),hold on
% elseif iii==7
% plot([2:6],ym1-0.3,'k', 'LineWidth',2),hold on  
% else
% plot([2:6],ym1-0.2,'k', 'LineWidth',2),hold on 
% end