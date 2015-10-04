function [result] = d(img, k, l, d1, d2)
	result = img(k,l) - img(rem(k+d1,k)+1, rem(l+d2,l)+1);
end