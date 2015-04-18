function [contrast] = cont(x)
[l, c] = size(x);
contrast = zeros(1);
for i = 1:l
    for j=1:c
        p = double(x(i,j)/255*100);
        a = double((i-j).^2);
        contrast = contrast + abs(a*p);
    end
end
