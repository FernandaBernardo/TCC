function [feature] = unserVarianceFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	hDiff = histDiff(img, d1, d2);
 	hSum = histSum(img, d1, d2);

 	[h w] = size(hist);

 	meanFeature = 0;

 	for i=1:h
 		meanFeature = meanFeature + (i * hSum(i, 1));
 	end

	meanFeature = meanFeature * 0.5;

	feature = 0;
	sumSum = 0;
	sumDiff = 0;

	for i=1:h
 		sumSum = sumSum + ((i - 2 * meanFeature) ^ 2 * hSum(i, 1));
 		sumDiff = sumDiff + (i ^ 2 * hDiff(i, 1));
 	end
	
	feature = feature * 0.5 * (sumSum + sumDiff);
end