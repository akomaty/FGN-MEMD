clear all
close all

% outputFolder = 'C:\Documents and Settings\Administrateur\Mes documents\Dropbox\MATLAB\Résultats\FGN EMD'; % save data in this folder

outputFolder = 'C:\Users\ali.komaty\Documents\MATLAB\11111Resultats thèse\MEMD_FGN';
L= 2^9;
Fs = L;
t = 1/Fs:1/Fs:1;


NFFT = 2^nextpow2(L+1);
f = linspace(2/Fs,1,NFFT/2+1);
T = 1./f;

for H=0.1:0.1:0.9
spectrum_4D_matrix = [];
for k=1:1000
spectrum_matrix = [];
x = ffgn(1,H,3,L,0); % Fractional gaussian noise
    % sigma = std(x);
    % NE = 50;
    % IMF = eemd(x,sigma,NE);
    % IMF=IMF';
IMFm = memd(x);

    for index = 1:3
    IMF = squeeze(IMFm(index,:,:));
    spectrum = [];
        for i=1:8       
            spect = abs(fft(IMF(i,:),NFFT))./(L);
            spectrum = [spectrum ; 2*spect(1:NFFT/2+1)];
        end
    spectrum_matrix = cat(3,spectrum_matrix,spectrum);
    end
    spectrum_4D_matrix = cat(4,spectrum_4D_matrix,spectrum_matrix);
end
outputFilename = sprintf('%s/spectrum_matrix_1000_H=%d.mat', outputFolder, H*10);
save(outputFilename, 'spectrum_4D_matrix')
end
% 
% figure,
% mean_spectrum = mean(spectrum_matrix,3);
% for i=1:8 
%     cstring='rgbcmyk'; % color string
%     plot(log(T),mean_spectrum(i,:),cstring(mod(i,7)+1))  % plot with a different color each time
%     hold on,
%     legendInfo{i} = ['IMF_' num2str(i)];
% end
% legend(legendInfo)
% 
% 
% lnT = log(T);
% % rho = 2.01+0.2*(H-0.5)+0.12*(H-0.5)^2;
% rho=2;
% a = 2*H-1;
% figure,plot(lnT,mean_spectrum(2,:))
% for i=1:8
%     cstring='rgbcmyk'; % color string
%     plot(lnT-i*log(2),rho^(-a*0.5*i)*mean_spectrum(i+1,:),cstring(mod(i,7)+1))
%     hold on,
% %     xlim([-1,3]);
% end