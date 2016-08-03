function [He,sigma2,rho,eta] = mfBm_identif(x,ns,ndeb);


% Identification of mfBm 
% 
% uses variance and correlation between wavelet like coefficients 
%
% x : contains the mfBm (a matrix of size p times n number of samples)
% ns : number of dilation used in the least square regression
% ndeb : first scale used
% 
% [He,sigma2,rho,eta] = mfBm_identif(x,ns,ndeb);
% 
% PO Amblard&JF Coeurjolly
% more details in Amblard&Coeurjolly, IEEE Trans SP, 59 (11), 2011.


[p,n]=size(x);
 
% different filters 
%h=[1 -2 1];
%h=[1 -3 3 -1];
h=[1 -4 6 -4 1];
% you can use your preferred filter or your preferred wavelet filter here

% filtering of the fBm

cor=zeros(p,p);cord=cor;v=zeros(ns+1,p);c=zeros(ns+1,p*(p-1)/2);sic=c;d=c;
coremp=cor;cordemp=cord;vs=v;
for s=0:ns
    
    H=zeros(1,length(h)*(1+s)-s);
    H(1:s+1:end)=h;
    
    y=filter(H,1,x,[],2); 
    yc=y-mean(y,2)*ones(1,n);
     
     
    % empirical correlation matrix at lag 0 of the filtered components 
    cor=(yc*yc')/n; 
    v(s+1,:)=log(diag(cor)); % i-th column is vector v_i^m
    
    vs(s+1,:)=sum(triu(cor,1),2);  %matrix of sum of correlations to be used in the expression with weights
    zz=reshape(triu(cor,1),1,p*p);[~,jcor]=find(zz~=0);
    c(s+1,:)=log(abs(zz(jcor)));  % rows indexed by scale (m in the paper) : c_{ij}^m
    sic(s+1,:)=sign(zz(jcor));
  
    corempm=diag(1./sqrt(diag(cor)))*cor*(diag(1./sqrt(diag(cor))));
    coremp=coremp+corempm;
    % empirical correlation matrix at lag s*(length(h)-1)
    cord= (yc(:,1:n-(s+1)*(length(h)-1))*yc(:,1+(s+1)*(length(h)-1):n)')/(n-(s+1)*(length(h)-1));
    zz=reshape(triu(cord,1)-triu(cord',1),1,p*p); 
    %zz=reshape(triu(cord,1),1,p*p)*2; % will estimate rho -eta)
    [~,j]=find(zz~=0); 
    
    d(s+1,:)=log(abs(zz(j)/2));% rows indexed by scale (m in the paper) : d_{ij}^m
    cordemp=cordemp+diag(1./sqrt(diag(cor)))*(cord-cord')*(diag(1./sqrt(diag(cor))));
end

% Remark : V : M*p; C and D : M* p*(p-1)/2 

Lm=mean(log(ndeb:ns));
L=log(ndeb:ns)'-Lm;  %L : M*1

He=v(ndeb:ns,:)'*L/(2*L'*L);

HH=He*ones(1,p)+ones(p,1)*He';
zz=reshape(triu(HH,1),1,p*p);[~,j]=find(zz~=0);HH=zz(j); % creating vector H_i+H_j

alpha=mean(v)'-2*He*Lm;
mu=mean(c)'- HH'*Lm;
nu=mean(d(1:ns,:))'- HH'*mean(log(1:ns));
%nu=mean(d)';

l=length(h)-1;m=toeplitz([0:length(h)-1]);m=triu(m)-triu(m)';

pij0=zeros(p,p);pijl=pij0;
for i=1:p;
    for j=1:p;
        pij0(i,j)=-.5*h*(abs(m).^(max(0,He(i)+He(j))))*h';
        pijl(i,j)=-.5*h*((abs(l+m)).^(He(i)+He(j)))*h';
    end;
end

zz=reshape(triu(pij0,1),1,p*p);[~,j]=find(zz~=0);pi0ij=zz(j);
zz=reshape(triu(pijl,1),1,p*p);[~,j]=find(zz~=0);pilij=zz(j);
sigma2= exp(alpha)./diag(pij0);
S=sigma2*sigma2';
zz=reshape(triu(S,1),1,p*p);[~,j]=find(zz~=0);sigmaij=zz(j);
rho=exp(mu')./sqrt(sigmaij)./pi0ij.*sic(1,:);
eta=exp(nu')./sqrt(sigmaij)./pilij;

pi=diag(1./sqrt(diag(pij0)))*pij0*diag(1./sqrt(diag(pij0)));
coremp=coremp/(ns+1)./pi;

pil=diag(1./sqrt(diag(pij0)))*pijl*diag(1./sqrt(diag(pij0)));
cordemp=cordemp/(ns+1)./pil;






