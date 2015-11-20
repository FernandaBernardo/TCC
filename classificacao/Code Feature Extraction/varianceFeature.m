function [feature] = varianceFeature(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	gray = rgb2gray(imgColor);
    [h, w] = size(gray);

    tam = 16;

    for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			aux = gray(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
			feature = [feature; var(double(aux))];
       	end
    end
end