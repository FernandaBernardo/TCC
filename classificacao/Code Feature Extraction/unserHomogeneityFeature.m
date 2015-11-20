function [feature] = unserHomogeneityFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	tam = 16;

 	[h w] = size(img);

 	feature = [];
 	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			homogeneity = 0;

			aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);

			histogram = histDiff(aux, d1, d2);

			[len ~] = size(histogram);

			for k=1:len
				homogeneity = homogeneity + ((1/(1 + k ^ 2)) * histogram(k, 1));
		 	end

		 	feature = [feature; homogeneity];
		end
	end
end