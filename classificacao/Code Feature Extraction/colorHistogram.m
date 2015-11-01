function [feature] = colorHistogram(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	[h w ~] = size(imgColor);

	tam = 4;

	for i = tam/2+1:h-tam/2
		for j = tam/2+1:w-tam/2
			aux = imgColor(i-tam/2:i+tam/2, j-tam/2:j+tam/2, :);

			[colors, map] = rgb2ind(aux, 64, 'nodither');
			[elements centers] = imhist(colors, map);

			feature = [feature; elements'];
		end
	end
end