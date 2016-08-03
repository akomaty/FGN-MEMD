% EMD as a filter Bank (fractional gaussian noise)
clear all
close all

L= 2^9;
Fs = L;
t = 1/Fs:1/Fs:1;
NFFT = 2^nextpow2(L);
f = [-NFFT/2:(NFFT/2)-1]/NFFT;

mean_spectrum_matrix_EMD  = [];
mean_rx_matrix_EMD = [];
fgnSpectrum_matrix = [];
kk=1;
hurst = [0.2 0.5 0.8];
i = 1;

for i=1:2
H = hurst(i);
spectrum_matrix_EMD = [];
rx_matrix_EMD = [];

for k=1:2

fgnoise = ffgn(1,H,1,L,0); % fractional gaussian Noise

fgncorr = xcorr(fgnoise);
fgncorr = fgncorr(L:2*L-1);
fgnSpectrum_matrix = [fgnSpectrum_matrix; fftshift(abs(fft(fgncorr,NFFT)))];

    %EMD
    IMF = emd(fgnoise);
    
    if size(IMF,1)>=8
    rx = [];
    spectrum = [];
    for i=1:8
        rxx = xcorr(IMF(i,:),'biased');
        rx = [rx ; rxx(L:2*L-1)];
        spectrum = [spectrum ; fftshift(abs(fft(rx(i,:),NFFT)))];  
    end
    spectrum_matrix_EMD = cat(3,spectrum_matrix_EMD,spectrum);
    rx_matrix_EMD = cat(3,rx_matrix_EMD,rx);
    end
end

mean_spectrum_EMD = mean(spectrum_matrix_EMD,3);
mean_rx_EMD = mean(rx_matrix_EMD,3);

mean_spectrum_matrix_EMD = cat(3,mean_spectrum_matrix_EMD,mean_spectrum_EMD); % MSM stands for mean_spectrum_matrix
mean_rx_matrix_EMD = cat(3,mean_rx_matrix_EMD,mean_rx_EMD);

mean_spectrum_fgn = mean(fgnSpectrum_matrix);

figure(kk)
for i=1:8
    cstring='rgbcmyk'; % color string
    plot(f(NFFT/2:NFFT),mean_spectrum_EMD(i,NFFT/2:NFFT),cstring(mod(i,7)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
title(['EMD -- H=',num2str(H)])
xlabel('frequency')
ylabel('FT(xcorr(noise))')
legend(legendInfo)

figure(kk+1)
for i=1:8
    meaned_rx = fftshift(abs(fft(mean_rx_EMD(i,:),NFFT)));
    cstring='rgbcmyk'; % color string
    plot(f(NFFT/2:NFFT),meaned_rx(NFFT/2:NFFT),cstring(mod(i,7)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
title(['EMD -- H=',num2str(H)])
xlabel('frequency')
ylabel('FT(xcorr(noise))')
legend(legendInfo)

figure(kk+2)
plot(f(NFFT/2:NFFT),mean_spectrum_fgn(NFFT/2:NFFT),cstring(mod(i,7)+1))  % plot with a different color each time

kk=kk+3;
end