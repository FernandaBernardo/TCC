function [features] = extractBagOfFeatures(processedImage, rectSize)
	features = [];
	v = Verification(rectSize);
	[imgSize ~] = size(processedImage);

	% apply gradient on image
	[mag dir] = imgradient(processedImage);

	% extract key points from image
	points = detectFASTFeatures(mag);

	location = v.verifyKeyPoints(points.Location, 5, rectSize);
	[h w] = size(location);
	%image(mag); hold on;

	% on each key point...
	for i=1:h
		% ...get coordinates from key point
		x = location(i, 1); 
		y = location(i, 2); 
	
		[xi,xf,yi,yf] = v.verifyBorder(x, y, imgSize);

		% ...apply a square 16x16
		region = mag(xi:xf, yi:yf);
		%[h w] = size(region);
		
		%rectangle('Position',[xi yi w h], 'LineWidth',2, 'EdgeColor','r');

		% ...get histogram 8 bins with region that contains gradient
		[histElements histCenters] = hist(region, 8);

		[hElem wElem] = size(histElements);
		elements = reshape(histElements', [1 hElem*wElem]);

		features = [features elements];
	end		
end