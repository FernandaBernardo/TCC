function [homo] = homo(x)
[l, c] = size(x);
homo= zeros(1);
for i = 1:l
    for j=1:c
        p = double(x(i,j)/255*100);
        s = abs(i-j);
        homo = double(p/1+s);
    end
end
