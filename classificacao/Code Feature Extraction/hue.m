function [feature] = hue(X, ~)
	imgColor = getRGBImage(X);
	
	feature = [];

	[h w ~] = size(imgColor);

	tam = 16;

	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			bagOfFeatures = [];

			aux = imgColor(i-tam/2:i+tam/2, j-tam/2:j+tam/2, :);

			% pre process image with formulas from article
			obj = PreProcessing(aux);
			processedImage = obj.hue;

			bagOfFeatures = extractBagOfFeatures(processedImage, tam);

			% organize array of features to cluster
			[hFeat wFeat] = size(bagOfFeatures);
			f = reshape(bagOfFeatures', [hFeat*wFeat 1]);
			[idx, centers] = kmeans(f, 5,'Maxiter',300);
			feature = [feature; centers'];
		end
	end
end