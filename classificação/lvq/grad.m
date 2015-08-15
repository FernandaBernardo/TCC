function [dJdA,dJdB]=grad(X,A,B,saida,h)

N=size(X,1);

Z=[X,ones(N,1)]*A';

%V=tanh(Z);
V=1./(1+exp(-Z));

Y=[V,ones(N,1)]*B';

%Yr= tanh(Y);
%Yr=1./(1+exp(-Y));
Yr=Y;

erro=Yr-saida;

%derro=erro.*(1-Yr).*Yr;


%derro

derro= erro;

dJdB=derro'*[V,ones(N,1)];

sig=derro*B(:,1:h).*(1-V).*V;

dJdA=sig'*[X,ones(N,1)];

