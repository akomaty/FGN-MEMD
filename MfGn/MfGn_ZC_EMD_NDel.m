close all
clear all
clc

Fs = 1e3;
t = 0:1/Fs:1-1/Fs;

% MfGn parameters
NDel = 0.2;
p = 8;
M = Fs;

pspec = [];
ZC_H = [];

for H = [0.3, 0.5, 0.7]
    ZC1 = zeros(8, 8, 1000);
    spec1 = zeros(8,500,8,1000);
    
    for i = 1:10000
        imf = [];
        x = MfGn(M,H,NDel,p) ;
        % EMD
        for j=1:8
            imfbuff = emd(x(j,:));
            if size(imfbuff,1) >= 8
                imf = cat(3,imf, imfbuff(1:8,:));
            end
        end
        imf   = permute(imf,[3 1 2]);
        spec  = filt_bank(imf,0);
        ZC    = zero_crossing(imf,0);
        if (size(spec,1) >= 8) && (size(ZC,2) >= 8)
            spec1(:,:,:,i)= spec(1:8,1:500,1:8);
            ZC1(:,:,i)    = ZC(1:8,1:8);
        end
    end
%     ZC_H = [ZC_H mean(ZC1,2)];
    outputFolder = '/remote/idiap.svm/home.active/akomaty/Documents/MATLAB/MfGn/Results_NDel_2'; % save data in this folder
    outputFilename = sprintf('%s/ZC1_EMD=%d.mat', outputFolder, H*10);
    save(outputFilename, 'ZC1', '-v7.3')
    outputFilename = sprintf('%s/pspec_all_EMD=%d.mat', outputFolder, H*10);
    save(outputFilename, 'spec1', '-v7.3')
    pspec = mean(spec1,4);
    outputFilename = sprintf('%s/pspec_EMD=%d.mat', outputFolder, H*10);
    save(outputFilename, 'pspec', '-v7.3')
%     plotSpect(pspec,'FGN',ffgnparam)  
    close all
end
plotSpect(pspec,'FGN',zeros(10,1))
set(gcf, 'PaperPosition', [0 0 70 50]); %Position plot at left hand corner with width 5 and height 5.
set(gcf, 'PaperSize', [70 50]); %Set the paper to have width 5 and height 5.
print(gcf, '-dpdf', '-r300', 'filename.pdf')

%%
%%% Plot of ZC line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(100)
for i=0:size(ZC1,2)-1
    plot(log2(ZC1(:,i+1)),'color',0.8*[1 1 1])
    hold on,
end

m = log2(mean(ZC1,2));
a = [1 1;8 1];
b = [m(1) m(8)]';
slope = inv(a)*b;

hp = plot(m,'k.-','LineWidth',3,'MarkerSize', 30); 
legend(hp,['slope=' num2str(slope(1))]);
hx = xlabel('IMF index');
hy = ylabel('log_2(zero-crossing)');
axis tight; grid on
set(hx, 'FontSize', 14) 
set(hx,'FontWeight','bold')
set(hy, 'FontSize', 14) 
set(hy,'FontWeight','bold')
set(gca,'fontsize',14),hold off