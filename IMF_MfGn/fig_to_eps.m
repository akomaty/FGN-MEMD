%% convert .fig to .eps
h = msgbox('Do you really want to run all the conversion script?', 'WARNING!!!','Warn');

%% lnE_m and lnE_lnT
close all
clear all
NDel = [0 0.2 0.5 0.8];
for i=1:length(NDel)
    FigName = ['/idiap/user/akomaty/mfGn_results/Results/lnE_m_MEMD_NDel_' num2str(int8(10*NDel(i))) '.fig'];
    openfig(FigName);
    title('')
    xlabel('m')
%     savefig(gcf,FigName,'compact')
    epsName = ['/idiap/user/akomaty/mfGn_results/Results/lnE_m_MEMD_NDel_' num2str(int8(10*NDel(i))) '.eps'];
    saveas(gcf,epsName,'epsc')
end

%% Correlogram
close all
clear all
NDel = [0 0.2 0.5 0.8];
H    = [0.2 0.4 0.6 0.8];
for i=1:length(NDel)
    for j=1:length(H)
        FigName = ['/idiap/user/akomaty/mfGn_results/Results/Correlogram_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.fig'];
        openfig(FigName);
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        savefig(gcf,FigName,'compact')
        epsName = ['/idiap/user/akomaty/mfGn_results/Results/Correlogram_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.eps'];
        saveas(gcf,epsName,'epsc')
    end
end