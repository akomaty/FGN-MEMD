%% This function computes the number of zero crossings and plots the
%% corresponding curve in function of the IMF index
% This function takes a 3D imf at the input and returns the number of zero
% crossings per imf.
% Bplot is a boolean to enable/disable plotting

function [ZCrosPerimf, slope] = zero_crossing(imf, Bplot);

ZCrosPerimf = [];
for i=1:size(imf,2)
    ZCros = [];
    for j = 1:size(imf,1)
        [indmin, indmax, indzer] = extr(imf(j,i,:));
        ZCros = [ZCros length(indzer)];
    end
    ZCrosPerimf = [ZCrosPerimf; ZCros];
end


m = log2(mean(ZCrosPerimf,2));
a = [1 1;8 1];
b = [m(1) m(8)]';
slope = inv(a)*b;

    if Bplot == 1
        figure,
        plot(m,'--.','LineWidth',2,'MarkerSize', 18); 
        legend(['slope=' num2str(slope(1))]);
        hx = xlabel('IMF index');
        hy = ylabel('log_2(zero-crossing)');
        axis tight; grid on
        set(hx, 'FontSize', 14) 
        set(hx,'FontWeight','bold')
        set(hy, 'FontSize', 14) 
        set(hy,'FontWeight','bold')
        set(gca,'fontsize',14)
    end
end