function [feature] = unserEntropyFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	hDiff = histDiff(img, d1, d2);
 	hSum = histSum(img, d1, d2);

 	[h w] = size(hist);

 	sumSum = 0;
 	sumDiff = 0;

 	for i=1:h
 		sumSum = sumSum + (hSum(i, 1) * log(hSum(i, 1)));
 		sumDiff = sumDiff + (hDiff(i, 1) * log(hDiff(i, 1)));
 	end

 	feature = - sumSum - sumDiff;
end