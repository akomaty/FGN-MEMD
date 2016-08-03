% EMD as a filter Bank (Fractional Gaussian noise)
clear all
close all

% outputFolder = 'C:\Users\ali.komaty\Desktop\tes'; % save data in this folder

L= 2^10;
Fs = L;
t = 1/Fs:1/Fs:1;
NFFT = 2^nextpow2(L);
f = [-NFFT/2:(NFFT/2)-1]/NFFT;

mean_spectrum_matrix_EMD  = [];
kk=1;

for H = 0.2:0.2
        % counter
        H  
spectrum_matrix_EMD = [];

% index of skew
H = 0.8;    

for k=1:2
    % counter
    k
    FGN = ffgn(1,H,1,L,0);
    %EMD
    IMF = emd(FGN);
    
    if size(IMF,1)>=8
    rx = [];
    spectrum = [];
    for i=1:8
        rxx = xcorr(IMF(i,:));
        rx = [rx ; rxx(L:2*L-1)];
        spectrum = [spectrum ; fftshift(abs(fft(rx(i,:),NFFT)))];  
    end
    spectrum_matrix_EMD = cat(3,spectrum_matrix_EMD,spectrum);
    end
end

mean_spectrum_EMD = mean(spectrum_matrix_EMD,3);
mean_spectrum_matrix_EMD = cat(3,mean_spectrum_matrix_EMD,mean_spectrum_EMD); % MSM stands for mean_spectrum_matrix

%# Save EMD data
% outputFilename = sprintf('%s/spectrum_matrix_EMD%02d.mat', outputFolder, H*10);
% save(outputFilename, 'spectrum_matrix_EMD')


figure(kk)
for i=1:8
    cstring='rgbcmyk'; % color string
    m = mean_spectrum_EMD(i,NFFT/2:NFFT);
    plot(f(NFFT/2:NFFT),m,cstring(mod(i,7)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
title(['EMD -- H=',num2str(H)])
xlabel('frequency')
ylabel('FT(xcorr(noise))')
legend(legendInfo)
kk=kk+1;



% Normalized filter bank
m = mean_spectrum_EMD(2,NFFT/2:NFFT);
figure,loglog(f(NFFT/2:NFFT),m,'k+-')
for i=1:6
    cstring='rgbcmyk'; % color string
    m1 = 2^(-0.6*i)*mean_spectrum_EMD(2+i,NFFT/2:NFFT);
    loglog(2^i*f(NFFT/2:NFFT),m1,'k+-')  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
legend(legendInfo)
end