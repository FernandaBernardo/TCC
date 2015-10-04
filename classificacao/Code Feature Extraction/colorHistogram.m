function [feature] = colorHistogram(X, ~)
	imgColor = getRGBImage(X);

	feature = [];

	[colors, map] = rgb2ind(imgColor, 64, 'nodither');
	[elements centers] = imhist(colors, map);

	feature = [feature elements'];
end