function [dJdA,dJdB]=grad(X,A,B,saida)

[N,ns]=size(saida);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Codigo Usando For%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[h,ne]=size(A);
Zin = zeros(N, h);
Z = zeros(N,h);
Yin = zeros(N,ns);
Y = zeros(N,ns);
for i=1:N
    for j=1: h,
        Zin(i,j) = A(j,:)*[X(i,:),1]'; % calcula Zin
        Z(i,j) = 1/(1+exp(-Zin(i,j)));  % calcula Z
    end
    for j=1:ns,
        Yin(i,j) = B(j,:)*[Z(i,:),1]'; % calcula Yin 
        Y(i,j) = Yin(i,j); % função linear na saida
    end
end

erro = Y - saida;
dJdB = zeros(ns,h+1);
dJdA = zeros(h,ne);
sig = zeros(h,1);
for i=1:N
    for j=1: ns,
       dJdB(j,:) = dJdB(j,:) +  erro(i,j)*[Z(i,:),1];
    end
    for j=1:h,
        sig(j,1)= erro(i,:)*B(:,j);
    end
    
    for j=1:h
       dJdA(j,:) = dJdA(j,:) + sig(j,1)*((1-Z(i,j)).*Z(i,j))*[X(i,:),1];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%Codigo Sem For%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N=size(X,1);
% [h,ne]=size(A);
% Zin=[X,ones(N,1)]*A';
% Z=1./(1+exp(-Zin));
% Yin=[Z,ones(N,1)]*B';
% Y=Yin;
% erro=Y-saida;
% dJdB=erro'*[Z,ones(N,1)];
% sig=erro*B(:,1:h).*(1-Z).*Z;
% dJdA=sig'*[X,ones(N,1)];