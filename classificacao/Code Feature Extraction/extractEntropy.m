function [feature] = extractEntropy(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	gray = rgb2gray(imgColor);
    [h, w] = size(gray);

    tam = 4;

    for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			aux = gray(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
			rgb = reshape(imgColor(i,j,:), 1, 3);
			feature = [feature entropy(aux) rgb];
       	end
    end
end