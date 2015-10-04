function [result] = histSum(img, d1, d2)
	[h, w] = size(img);
	hist = [];

	for k=1:h
		for l=1:w
			hist(k,l)= s(img, k, l, d1, d2);
		end
	end

	uSum = unique(hist);
	result = sum(histc(hist,uSum), 2);
end