function [feature] = transformedRGB(X, ~)
	imgColor = getRGBImage(X);
	
	feature = [];

	% pre process image with formulas from article
	obj = PreProcessing(imgColor);

	%%%%%%%%%%%%% TRANSFORMED R %%%%%%%%%%%%%
	processedImage = obj.transformedR;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];


	%%%%%%%%%%%%% TRANSFORMED G %%%%%%%%%%%%%
	processedImage = obj.transformedG;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];


	%%%%%%%%%%%%% TRANSFORMED B %%%%%%%%%%%%%
	processedImage = obj.transformedB;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];
end