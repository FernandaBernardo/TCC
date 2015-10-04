function [feature] = normalizedRG(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	% pre process image with formulas from article
	obj = PreProcessing(imgColor);

	%%%%%%%%%%%%% NORMALIZED R %%%%%%%%%%%%%
	processedImage = obj.normalizedR;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];

	%%%%%%%%%%%%% NORMALIZED G %%%%%%%%%%%%%
	processedImage = obj.normalizedG;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];
end