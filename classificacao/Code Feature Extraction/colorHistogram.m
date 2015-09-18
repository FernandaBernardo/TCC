function [feature] = colorHistogram(X, ~)
	imgColor = [];

	for i=1:length(X)
		x = X{i};

		imgColor(i,:,1) = x(1,:); % R
		imgColor(i,:,2) = x(2,:); % G
		imgColor(i,:,3) = x(3,:); % B
	end

	feature = [];

	[X, map] = rgb2ind(img, 64, 'nodither');
	[elements centers] = imhist(double(X), map);

	feature = [feature elements'];
end;