%% Plot the zeros corssings for different IMFs and compare them
% You can choose to compare the IMFs wrt H (the hurst
% exponent) or wrt NDel (the non-diagonal element of the covariance matrix 
% of the mfGn process)

clear all
close all
clc
NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];

%% Launch this part of the code if you want to compare the ZC wrt H
% for each of NDel, all values of H will be comapred against each others

for i=1:length(NDel)
    figure
    for j=1:length(H)
        load(['/idiap/user/akomaty/mfGn_results/Results/ZC_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        mean_ZC = mean(ZC_all,2);
        % Plotting
        cstring='rgbcmyk'; % color string
        plot(1:8,log2(mean_ZC), cstring(mod(j,7)+1),'LineWidth',2)
        hold on,
        legendInfo{j} = ['H=0.' num2str(int8(10*H(j))) ];
    end
    legend(legendInfo)
    xlabel('IMF index')
    ylabel('log(zro-crossing)')
    title(['NDel = 0.' num2str(int8(10*NDel(i)))])
end


%% Launch this part of the code if you want to compare the ZC wrt NDel
% for each of H, all values of NDel will be comapred against each others

for j=1:length(H)
    figure
    for i=1:length(NDel)
        load(['/idiap/user/akomaty/mfGn_results/Results/ZC_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        mean_ZC = mean(ZC_all,2);
        % Plotting
        cstring='rgbcmyk'; % color string
        plot(1:8,log2(mean_ZC), cstring(mod(i,7)+1),'LineWidth',2)
        hold on,
        legendInfo{i} = ['NDel=0.' num2str(int8(10*H(i))) ];
    end
    legend(legendInfo)
    xlabel('IMF index')
    ylabel('log(zro-crossing)')
    title(['H = 0.' num2str(int8(10*H(j)))])
end