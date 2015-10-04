function [result] = histDiff(img, d1, d2)
	[h, w] = size(img);
	hist = [];

	for k=1:h
		for l=1:w
			hist(k,l)= d(img, k, l, d1, d2);
		end
	end

	uDiff = unique(hist);
	result = sum(histc(hist,uDiff), 2);
end