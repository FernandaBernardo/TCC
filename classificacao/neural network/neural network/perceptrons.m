function Y = perceptrons(X,A,B)

    N=size(X,1);
    Z=[X,ones(N,1)]*A';
    V=tanh(Z);
    Y=[V,ones(N,1)]*B';

end

