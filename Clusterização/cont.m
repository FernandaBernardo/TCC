function [contrast] = cont(x)
[l, c] = size(x);
i=(ones(l,1))*(1:c);
j=(1:l)'*(ones(1,c));
contrast = sum(sum(((i-j).^2).*x));