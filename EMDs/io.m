function [ort, Gio] = io(x,imf)

% ort = IO(x,imf) computes the index of orthogonality
%
% inputs : - x    : analyzed signal
%          - imf  : empirical mode decomposition

lx = size(imf,2);
n  = size(imf,1);

s   = 0;
Gio = 0;
for i = 1:n-1
    for j =1:n-1
        if i~=j;
            %i
            %j
            %(sum(imf(i,:).*imf(j,:)))./((sqrt(sum(imf(i,:).^2))).*(sqrt(sum(imf(j,:).^2))))

            s     = s   + abs(sum(imf(i,:).*imf(j,:))/sum(x.^2));
            
            ValIO = (sum(imf(i,:).*imf(j,:)))./((sqrt(sum(imf(i,:).^2))).*(sqrt(sum(imf(j,:).^2))));
            Gio   = Gio + ValIO;%.*ValIO;
            %disp([num2str(i), ' ', num2str(j), ' : ', num2str(ValIO)]);
        else
            ValIJ = (sum(imf(i,:).*imf(j,:)))./((sqrt(sum(imf(i,:).^2))).*(sqrt(sum(imf(j,:).^2))));
            %disp([num2str(i), ' ', num2str(j), ' : ', num2str(ValIJ)]);
        end;
    end;
end;

Gio = 0.5*Gio;
ort = 0.5*s;
