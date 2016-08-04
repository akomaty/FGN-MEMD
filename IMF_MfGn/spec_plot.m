%% This function plots the Mulivaraite Spectrum
% Inputs : pspec: 3-D matrix containing IMFs of different simulated paths
%          type : type of the process 'LFSM' or 'FARIMA'
%          v    : vector containing the process parameters

function spec_plot(pspec,h,freq)
N = 2*size(pspec,2);
% freq = 0:N/2-1; % Find the corresponding frequency in Hz
%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(log2(freq'),log2(squeeze(pspec(:,1,:))),'b-'); hold on;
plot(log2(freq'),log2(squeeze(pspec(:,2,:))),'r-'); 
plot(log2(freq'),log2(squeeze(pspec(:,3,:))),'y-'); 
plot(log2(freq'),log2(squeeze(pspec(:,4,:))),'g-'); 
plot(log2(freq'),log2(squeeze(pspec(:,5,:))),'k-');
plot(log2(freq'),log2(squeeze(pspec(:,6,:))),'c-');
plot(log2(freq'),log2(squeeze(pspec(:,7,:))),'m-');
plot(log2(freq'),log2(squeeze(pspec(:,8,:))),'-','color',0.8*[1 1 1]); 
% hand=plot(log(freq'),log(pspec(:,:,7)),'m-');
% set(hand, 'Color', [ 0.4, 0.4, 0.4 ] );  
%hand=plot(log(freq'),log(pspec(:,:,8)),'m-','color',0.8*[1 1 1]); 
% set(hand, 'Color', [ 1, 0.5, 1 ] );  

title(['H=' num2str(h)])
hx = xlabel('log_2(frequency)');
hy = ylabel('log2-PSD (dB)');
axis tight; grid off
set(hx, 'FontSize', 14) 
set(hx,'FontWeight','bold')
set(hy, 'FontSize', 14) 
set(hy,'FontWeight','bold')
set(gca,'fontsize',14)
% hand=loglog(freq',pspec(:,:,9),'b-');
% set(hand, 'Color', [ 0.2, 0.2, 1 ] );
% set(gcf,'DefaultLineLineWidth',1.5);
% xlabel('Frequency');
% axis tight; grid off

% normalized filter bank
freqk = freq;
sk = log(squeeze(pspec(:,2,:)));
figure,plot(log(freqk),10*log(sk),'k+-')
% rho = 2.01+0.2*(h-0.5)+0.12*(h-0.5)^2; % for EMD
rho = 1.772+0.06*(h-0.5)-0.02*(h-0.5).^2; % for MEMD
a = 2*h-1;
cstring='brygkcm';
for i=1:7
    sk = squeeze(pspec(:,i+1,:));
    skp = rho^(-a*(i+1))*sk;
    freqk = rho*freqk;
%     plot(log(freqk)-0.125*i,10*log(skp),cstring(mod(i,7)+1))
    hand = plot(log(freqk-rho*i),10*log(skp),cstring(mod(i,7)+1));
    set(gcf,'DefaultLineLineWidth',1.5);
    if i==8
    set(hand, 'Color', [ 0.8, 0.8, 0.8 ] );
    end
    title(['H=',num2str(h)]);
    xlabel('log(frequency)')
    ylabel('log-PSD (dB)')
    hold on,
end

end