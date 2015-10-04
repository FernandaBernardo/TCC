function [feature] = unserContrastFeature(X, ~)
	imgColor = [];

	for i=1:length(X)
		x = X{i};

		imgColor(i,:,1) = x(1,:); % R
		imgColor(i,:,2) = x(2,:); % G
		imgColor(i,:,3) = x(3,:); % B
	end

	img = rgb2gray(imgColor);

	d1 = 4;
 	d2 = 5;

 	hist = histDiff(img, d1, d2);

 	[h w] = size(hist);

 	feature = 0;

 	for i=1:h
 		feature = feature + (i ^ 2 * hist(i, 1));
 	end
end