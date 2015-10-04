function [feature] = unserContrastFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	hist = histDiff(img, d1, d2);

 	[h w] = size(hist);

 	feature = 0;

 	for i=1:h
 		feature = feature + (i ^ 2 * hist(i, 1));
 	end
end