function [feature] = unserEntropyFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	tam = 16;

 	[h w] = size(img);

 	feature = [];
 	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
		 	sumSum = 0;
		 	sumDiff = 0;
		 	entropia = 0;

		 	aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);

		 	hDiff = histDiff(aux, d1, d2);
		 	hSum = histSum(aux, d1, d2);

		 	[len ~] = size(hDiff);

		 	for i=1:len
		 		sumSum = sumSum + (hSum(i, 1) * log(hSum(i, 1)));
		 		sumDiff = sumDiff + (hDiff(i, 1) * log(hDiff(i, 1)));
		 	end

		 	entropia = - sumSum - sumDiff;

		 	feature = [feature entropia];
		end
	end
end