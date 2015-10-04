function [feature] = hue(X, ~)
	imgColor = getRGBImage(X);
	
	feature = [];

	% pre process image with formulas from article
	obj = PreProcessing(imgColor);
	processedImage = obj.hue;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];
end