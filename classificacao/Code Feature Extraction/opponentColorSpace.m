function [feature] = opponentColorSpace(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	% pre process image with formulas from article
	obj = PreProcessing(imgColor);

	%%%%%%%%%%%%% OPPONENT COLOR SPACE 1 %%%%%%%%%%%%%
	processedImage = obj.opponentColorSpace1;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];


	%%%%%%%%%%%%% OPPONENT COLOR SPACE 2 %%%%%%%%%%%%%
	processedImage = obj.opponentColorSpace2;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];


	%%%%%%%%%%%%% OPPONENT COLOR SPACE 3 %%%%%%%%%%%%%
	processedImage = obj.opponentColorSpace3;

	features = extractBagOfFeatures(processedImage);

	% organize array of features to cluster
	[h w] = size(features);
	f = reshape(features', [h*w 1]);
	[idx, centers] = kmeans(f, 5);
	feature = [feature centers'];
end