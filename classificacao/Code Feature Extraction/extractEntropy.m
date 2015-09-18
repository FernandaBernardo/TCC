function [feature] = extractEntropy(X, ~)
	imgColor = [];

	for i=1:length(X)
		x = X{i};

		imgColor(i,:,1) = x(1,:); % R
		imgColor(i,:,2) = x(2,:); % G
		imgColor(i,:,3) = x(3,:); % B
	end

	feature = [];

	gray = rgb2gray(imgColor);
    [h, w] = size(gray);

    tam = 4;
    cont = 0;

    for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			cont=cont+1;
			aux = gray(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
			rgb = reshape(imgColor(i,j,:), 1, 3);
			feature = [feature entropy(aux) double(rgb)];
       	end
    end
end