function [feature] = comatrixProps(X, ~, typeFeature)
	imgColor = getRGBImage(X);
	img = rgb2gray(imgColor);

	[h w] = size(img);

	tam = 4;

	feature = [];
	vizinhanca = [0 0; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];

	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
			[GLCM ~]= graycomatrix(aux, 'offset', vizinhanca);
			x = graycoprops(GLCM, {typeFeature});
			rgb = reshape(imgColor(i,j,:), 1, 3);
			feature = [feature double(getfield(x, typeFeature)) double(rgb)];
		end
	end	
end