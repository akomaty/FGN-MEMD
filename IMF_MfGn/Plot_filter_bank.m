%% Plot all saved spectrum with their normalized and shifted version

freq = 0:499;
for i=1:length(NDel)
    for j=1:length(H)
        load(['/idiap/user/akomaty/mfGn_results/Results/SPEC_4D_MEMD_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.mat'])
        spec_plot(mean_spec,H(j),freq,1)
        figName = ['/idiap/user/akomaty/mfGn_results/Results/SPEC_Norm_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.fig'];
        savefig(gcf,figName,'compact')
        epsName = ['/idiap/user/akomaty/mfGn_results/Results/SPEC_Norm_NDel_' num2str(int8(10*NDel(i))) '_H_' num2str(int8(10*H(j))) '.eps'];
        saveas(gcf,epsName,'epsc')
    end
end
