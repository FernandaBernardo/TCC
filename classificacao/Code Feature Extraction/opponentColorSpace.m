function [feature] = opponentColorSpace(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	[h w ~] = size(imgColor);

	tam = 16;

	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			opponent = [];
			aux = imgColor(i-tam/2:i+tam/2, j-tam/2:j+tam/2, :);

			% pre process image with formulas from article
			obj = PreProcessing(aux);

			%%%%%%%%%%%%% OPPONENT COLOR SPACE 1 %%%%%%%%%%%%%
			processedImage = obj.opponentColorSpace1;

			features = [];
			features = extractBagOfFeatures(processedImage, tam);

			% organize array of features to cluster
			[hFeat wFeat] = size(features);
			f = reshape(features', [hFeat*wFeat 1]);
			[idx, centers] = kmeans(f, 5);
			opponent = [opponent centers'];

			%%%%%%%%%%%%% OPPONENT COLOR SPACE 2 %%%%%%%%%%%%%
			processedImage = obj.opponentColorSpace2;

			features = [];
			features = extractBagOfFeatures(processedImage, tam);

			% organize array of features to cluster
			[hFeat wFeat] = size(features);
			f = reshape(features', [hFeat*wFeat 1]);
			[idx, centers] = kmeans(f, 5);
			opponent = [opponent centers'];

			%%%%%%%%%%%%% OPPONENT COLOR SPACE 3 %%%%%%%%%%%%%
			processedImage = obj.opponentColorSpace3;

			features = [];
			features = extractBagOfFeatures(processedImage, tam);

			% organize array of features to cluster
			[hFeat wFeat] = size(features);
			f = reshape(features', [hFeat*wFeat 1]);
			[idx, centers] = kmeans(f, 5);
			opponent = [opponent centers'];

			feature = [feature; opponent];
		end
	end
end