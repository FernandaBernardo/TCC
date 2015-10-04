function [feature] = unserMeanFeature(X, ~)
	imgColor = getRGBImage(X);

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	tam = 16;

 	[h w] = size(img);

 	feature = [];
 	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
		 	media = 0;

			aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);

			hist = histSum(aux, d1, d2);

			[len ~] = size(hist);

			for k=1:len
				media = media + (k * hist(k, 1));
			end

			media = media * 0.5;

			feature = [feature media];
		end
	end
end