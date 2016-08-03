% EMD as a filter Bank
clear all
close all

L= 10000;
Fs = L;
t = 1/Fs:1/Fs:1;
NFFT = 2^nextpow2(L);
f = [-NFFT/2:(NFFT/2)-1]/NFFT;

spectrum_matrix = [];

for j=1:5000
    x = wgn(1,L,10);
    IMF = emd_basic(x);
    rx = [];
    spectrum = [];
    for i=1:7
        rxx = xcorr(IMF(i,:));
        rx = [rx ; rxx(L:2*L-1)];
        spectrum = [spectrum ; fftshift(abs(fft(rx(i,:),NFFT)))];  
    end
    spectrum_matrix = cat(3,spectrum_matrix,spectrum);
end

mean_spectrum = mean(spectrum_matrix,3);

for i=1:7
    cstring='rgbcmyk'; % color string
    plot(f(NFFT/2:NFFT),mean_spectrum(i,NFFT/2:NFFT),cstring(mod(i,7)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
legend(legendInfo)

figure,
for i=1:7
    cstring='rgbcmyk'; % color string
    plot(f(NFFT/2:NFFT),spectrum(i,NFFT/2:NFFT),cstring(mod(i,7)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
legend(legendInfo)

for i=1:25
%%%%%%%%%%%%%
L= 10000;
x = wgn(1,L,10);
[h,xout] = hist(x,100); % plot de l'histogramme
% Normalisation de l'histogram
% 1. Calcul de l'air
dx=(xout(2)-xout(1));
air=sum(h)*dx;
h=h/air; % Normalization de l'histogram de façon que la surface sera égale à 1.

[ff,xx]=ksdensity(x); % estimation de la fonction de densité de probabilité
figure
bar(xout,h,'k'),hold on
plot(xx,ff,'r');title(['IMF_' num2str(i)]);hold off
end