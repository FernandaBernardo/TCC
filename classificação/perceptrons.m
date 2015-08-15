function Yr=perceptrons(X,A,B)

N=size(X,1);

Z=[X,ones(N,1)]*A';

%V=tanh(Z);
V=1./(1+exp(-Z));


Y=[V,ones(N,1)]*B';

%Yr=tanh(Y);
%Yr=1./(1+exp(-Y));
Yr=Y;

