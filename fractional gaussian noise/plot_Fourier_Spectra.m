%% plot Fourier Spectra
close all
L= 2^10;
Fs = L;
t = 1/Fs:1/Fs:1;

H = 0.7;

NFFT = 2^nextpow2(L+1);
f = linspace(2/Fs,1,NFFT/2+1);
T = 1./f;

spectrum_matrix = mean(spectrum_4D_matrix,4);
%%
figure,
mean_spectrum = mean(spectrum_matrix,3);
for i=1:8 
    cstring='bybrbrbrb'; % color string
    semilogx(f,10*log(mean_spectrum(i,:)),cstring(mod(i,8)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
hx = xlabel('frequency [Hz]');
hy = ylabel('PSD [dB]');
axis tight; grid off
set(hx, 'FontSize', 24) 
% set(hx,'FontWeight','bold')
set(hy, 'FontSize', 24) 
% set(hy,'FontWeight','bold')
set(gca,'fontsize',14)
ylim([-70 -20])
% legend(legendInfo)

%%
lnT = log(T);
% rho = 2.01+0.2*(H-0.5)+0.12*(H-0.5)^2;
rho=1.8;
a = 1-2*H;
figure,plot(lnT,mean_spectrum(2,:))
for i=1:7
    cstring='rgbcmyk'; % color string
    plot(lnT-i*log(rho),rho^(a*0.5*i)*mean_spectrum(i+1,:),cstring(mod(i,7)+1))
    hold on,
%     xlim([-1,3]);
end

%%
figure,
for i=1:8 
    cstring='rgbcmyk'; % color string
    plot(log2(f),log2(mean_spectrum(i,:)),cstring(mod(i,7)+1))  % plot with a different color each time
    hold on,
    legendInfo{i} = ['IMF_' num2str(i)];
end
legend(legendInfo)

%%
% rho = 2.01+0.2*(H-0.5)+0.12*(H-0.5)^2;
rho=1.8;
a = 2*H-1;
figure,plot(log2(f),log2(mean_spectrum(2,:)))
for i=1:7
    cstring='rgbcmyk'; % color string
    plot(rho^(a*(i+1))*log2(f)-log2(i*f),rho^(a*(i+1))*log2(mean_spectrum(i+1,:)),cstring(mod(i,7)+1))
    hold on,
%     xlim([-1,3]);
end