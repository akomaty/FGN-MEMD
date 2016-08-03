clear
close all
clc

n = 3; % number of paths
L = 1e3; %data length

for i=1:2
imf1 = [];    
inp = randn(L,n);

% % EMD
%     for j=1:n
%         imf1buff = emd(inp(:,j));
%         imf1 = cat(3,imf1, imf1buff(1:8,:));
%     end
%     imf1   = permute(imf1,[3 1 2]);
% [ZCrosPerimf1, slope1] = zero_crossing(imf1);
% title('EMD')
%     
% MEMD
imf2 = memd(inp);
[ZCrosPerimf2, slope2] = zero_crossing(imf2);
title('MEMD')
%     for k =1:n
%         imf_k = reshape(imf2(k,:,:),size(imf2,2),length(inp));% imfs corresponding to kth component
%     end
end