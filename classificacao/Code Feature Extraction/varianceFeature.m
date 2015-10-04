function [feature] = varianceFeature(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	img = rgb2gray(uint8(imgColor));
    [h, w] = size(gray);

    tam = 4;
    cont = 0;

    for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			cont=cont+1;
			aux = gray(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
			feature = [feature var(aux)];
       	end
    end
end