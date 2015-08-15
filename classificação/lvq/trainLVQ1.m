function [code wnew w]=trainLVQ1(X,S,maxit,nclust,nmax)

alfa=0.8;
[N,ne]=size(X);
ns=length(unique(S));
w=rands(ns*nclust,ne);
distance = zeros(ns*nclust,1); %vetor de zeros

for iter=1:maxit,
    pos=randperm(N);
    X=X(pos,:);
    S=S(pos,:);
    
    for k=1:N,
        wvenc = 1;
        for i=1:ns*nclust,
            distance(i) = (w(i,:) - X(k,:))*(w(i,:) - X(k,:))';
            if distance(i)<distance(wvenc)
                wvenc = i;
            end
        end
        p=ceil(wvenc/nclust);
        if S(k) == p
            w(wvenc,:) = w(wvenc,:) + alfa*(X(k,:)-w(wvenc,:));
        else
            w(wvenc,:) = w(wvenc,:) - alfa*(X(k,:)-w(wvenc,:));
        end
    end
    alfa = alfa*0.9;
    disp(iter);
end

disp('1');

p={};
for i=1:ns %encontra os pontos de cada classe
    p{i} = find(S==i);
    
end

disp('2');

neuronio = zeros(ns,nclust);
distance = zeros(nclust,1); %vetor de zeros
for i=1:ns
    Xc=X(p{i},:);
    for k=1:length(p{i})
        wvenc = 1;
        cont=0;
        for m=(i-1)*nclust+1:i*nclust,
            cont=cont+1;
            distance(cont) = (w(m,:) - Xc(k,:))*(w(m,:) - Xc(k,:))';
            if distance(cont)<distance(wvenc)
                wvenc = cont;
            end
        end
        neuronio(i,wvenc)=neuronio(i,wvenc)+1;
    end
end    

disp('3');    
  
val=sum(neuronio>0,2); %numero de neuronios mais proximos
code={};
wnew=[];
for i=1:ns
    n=min(val(i),nmax); %numero de neuronios a serem escolhidos por classe
    [~,pos]=sort(-neuronio(i,:));
    pos=pos(1:n);
    code{i}=1:n;
    wnew=[wnew;w((i-1)*nclust+pos,:)]
end

save all