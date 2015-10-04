function [feature] = unserVarianceFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	tam = 16;

 	[h w] = size(img);

 	feature = [];
 	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
		 	meanFeature = 0;
		 	variance = 0;
			sumSum = 0;
			sumDiff = 0;

		 	aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);

		 	hDiff = histDiff(aux, d1, d2);
		 	hSum = histSum(aux, d1, d2);

		 	[len ~] = size(hist);

		 	for i=1:len
		 		meanFeature = meanFeature + (i * hSum(i, 1));
		 	end

			meanFeature = meanFeature * 0.5;

			for i=1:len
		 		sumSum = sumSum + ((i - 2 * meanFeature) ^ 2 * hSum(i, 1));
		 		sumDiff = sumDiff + (i ^ 2 * hDiff(i, 1));
		 	end
			
			meanFeature = meanFeature * 0.5 * (sumSum + sumDiff);

			feature = [feature meanFeature];
		end
	end
end