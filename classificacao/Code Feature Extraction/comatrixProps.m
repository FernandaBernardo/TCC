function [feature] = comatrixProps(X, ~, typeFeature)
	imgColor = [];

	for i=1:length(X)
		x = X{i};

		imgColor(i,:,1) = x(1,:); % R
		imgColor(i,:,2) = x(2,:); % G
		imgColor(i,:,3) = x(3,:); % B
	end
	
	[h w p] = size(imgColor);

	tam = 4;
	cont = 0;

	feature = [];

	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			cont=cont+1;
			aux = imgColor(i-tam/2:i+tam/2, j-tam/2:j+tam/2, :);
			vizinhanca = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];
			[GLCM,SI]= graycomatrix(rgb2gray(aux), 'offset', vizinhanca);
			x = graycoprops(GLCM, {typeFeature});
			rgb = reshape(imgColor(i,j,:), 1, 3);
			feature = [feature getfield(x, typeFeature) double(rgb)];
		end
	end	
end