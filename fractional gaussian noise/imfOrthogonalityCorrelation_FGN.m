%% This code plots the 2D correlogram of two Fractional Gaussian processes in
%% the case of MEMD

close all
clear all
clc

Fs = 1e3;
t = 0:1/Fs:1-1/Fs;

for H = 0.1:0.1:0.9
    RHO_all = [];
    for k = 1:1000
        k
    inp = ffgn(1,H,3,size(t,2),0); % Fractional gaussian noise
    imf = memd(inp);
    imf_x = reshape(imf(1,:,:),size(imf,2),length(inp)); % imfs corresponding to 1st component
    imf_y = reshape(imf(2,:,:),size(imf,2),length(inp)); % imfs corresponding to 2nd component
    % imf_z = reshape(imf(3,:,:),size(imf,2),length(inp)); % imfs corresponding
    % to 3rd component
    RHO = [];
    cc=[];
    p=2;
    for i = 1:8
        for j = 1:8
            normIMF1 = imf_x(i,:)./max(abs(imf_x(i,:)));
            normIMF2 = imf_y(j,:)./max(abs(imf_y(j,:)));
            c = corrcoef(normIMF1',normIMF2');
            RHO = [ RHO c(1,2)]; % Correlation coefficient
    %         cc = [cc covcoeff(imf(i,:),imf(j,:),p,'FLOM')];
        end
    end
    RHO = reshape(RHO,8,8)';
    % cc = reshape(cc,size(imf,1)-1,size(imf,1)-1)';
    % plotIO(RHO,cc)

    RHO_all = cat(3,RHO_all,RHO);
    end
    outpufolder = 'C:\Users\ali.komaty\Documents\MATLAB\11111Resultats th�se\MEMD_FGN';
    outputFilename = sprintf('%s/RHO_FGN_MEMD_H=%d.mat',outpufolder, H*10);
    save(outputFilename, 'RHO_all')
end

figure,
colormap('summer');   % set colormap
imagesc(abs(mean(abs(RHO_all),3)));        % draw image and scale colormap to values range
colorbar;          % show color scale
hx = xlabel('IMF index');
hy = ylabel('IMF index');
set(hx, 'FontSize', 20) 
set(hy, 'FontSize', 20) 
set(gca,'fontsize',20)


% cgo2 = HeatMap(cc);
% set(cgo2,'Colormap',redbluecmap);
% cgo3 = HeatMap(mio);
% set(cgo3,'Colormap',redbluecmap);