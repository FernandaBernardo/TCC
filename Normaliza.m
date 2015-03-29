function X=Normaliza(X,lb,ub)

for i=1:3
    Z=X(:,:,i);
    [N,m]=size(Z)
    minX=min(Z);
    maxX=max(Z);
    Z= lb+(ub-lb)*(Z-ones(N,1)*minX)./(ones(N,1)*(maxX-minX));
    X(:,:,i)=Z;
end
