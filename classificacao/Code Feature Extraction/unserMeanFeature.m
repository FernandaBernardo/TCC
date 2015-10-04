function [feature] = unserMeanFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	hist = histSum(img, d1, d2);

 	[h w] = size(hist);

 	feature = 0;

 	for i=1:h
 		feature = feature + (i * hist(i, 1));
 	end

	feature = feature * 0.5;
end