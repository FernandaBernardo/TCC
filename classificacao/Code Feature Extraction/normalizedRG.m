function [feature] = normalizedRG(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	[h w ~] = size(imgColor);

	tam = 16;

	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			normalized = [];
			aux = imgColor(i-tam/2:i+tam/2, j-tam/2:j+tam/2, :);

			% pre process image with formulas from article
			obj = PreProcessing(aux);

			%%%%%%%%%%%%% NORMALIZED R %%%%%%%%%%%%%
			processedImage = obj.normalizedR;

			features = [];
			features = extractBagOfFeatures(processedImage, tam);

			% organize array of features to cluster
			[hFeat wFeat] = size(features);
			f = reshape(features', [hFeat*wFeat 1]);
			[idx, centers] = kmeans(f, 5,'Maxiter',300);
			normalized = [normalized centers'];

			%%%%%%%%%%%%% NORMALIZED G %%%%%%%%%%%%%
			processedImage = obj.normalizedG;

			features = [];
			features = extractBagOfFeatures(processedImage, tam);

			% organize array of features to cluster
			[hFeat wFeat] = size(features);
			f = reshape(features', [hFeat*wFeat 1]);
			[idx, centers] = kmeans(f, 5, 'Maxiter',300);
			normalized = [normalized centers'];
			
			feature = [feature; normalized];
		end
	end
end