function [feature] = unserCorrelationFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	tam = 4;

 	[h w] = size(img);

 	feature = [];
 	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
		 	meanFeature = 0;
			correlation = 0;
			sumSum = 0;
			sumDiff = 0;
		 	
			aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);

		 	hDiff = histDiff(aux, d1, d2);
		 	hSum = histSum(aux, d1, d2);

		 	[len ~] = size(hSum);

		 	for k=1:len
		 		meanFeature = meanFeature + (k * hSum(k, 1));
		 	end

			meanFeature = meanFeature * 0.5;

			for k=1:len
		 		sumSum = sumSum + ((k - 2 * meanFeature) ^ 2 * hSum(k, 1));
		 	end

		 	[len ~] = size(hDiff);
		 	for k=1:len
		 		sumDiff = sumDiff + (k ^ 2 * hDiff(k, 1));
		 	end
			
			correlation = 0.5 * (sumSum - sumDiff);

			feature = [feature; correlation];
		end
	end
end