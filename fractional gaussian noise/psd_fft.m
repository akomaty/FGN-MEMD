function[freq,psdx] = psd_fft(x,Fs)
N = length(x);
xdft = abs(fft(x))./(N/2);
psdx = xdft(1:N/2).^2;
freq = 0:N/2-1;
% xdft = fft(x);
% xdft = xdft(1:N/2+1);
% psdx = (1/(Fs*N)).*abs(xdft).^2;
% psdx(2:end-1) = 2*psdx(2:end-1);
% freq = 0:Fs/N:Fs/2;
end