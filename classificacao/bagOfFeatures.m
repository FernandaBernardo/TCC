clear;clc;
tam = 200;
recLeft = 8;
recRight = 7;
features = [];

imgColor = imread('Alimentos/originais/A1.jpg');
imgColor = imresize(imgColor, [tam tam]);
img = rgb2gray(imgColor);

% pre process image with formulas from article
obj = PreProcessing(imgColor);
processedVector = obj.opponentColorSpace1;

% apply gradient on image
[mag dir] = imgradient(processedVector);

% extract key points from image
points = detectFASTFeatures(mag);

image(mag); hold on;

% on each key point...
for i=1:points.Count
	% ...get coordinates from key point
	x = points.Location(i, 1); 
	y = points.Location(i, 2); 

	xi = x-recLeft;
	xf = x+recRight;
	yi = y-recLeft;
	yf = y+recRight;

	% ...verify borders 
	if(x<=recLeft)
		xi = 1;
		xf = recLeft+recRight+1;
	elseif(x>=tam-recRight)
		xi = tam-recRight-recLeft;
		xf = tam;
	end
	if(y<=recLeft)
		yi = 1;
		yf = recLeft+recRight+1;
	elseif(y>=tam-recRight)
		yi = tam-recRight-recLeft;
		yf = tam;
	end

	% ...apply a square 16x16
	region = mag(xi:xf, yi:yf);
	[h w] = size(region);
	
	rectangle('Position',[xi yi w h], 'LineWidth',2, 'EdgeColor','r');

	% ...get histogram 8 bins with region that contains gradient
	[histElements histCenters] = hist(region, 8);

	[h w] = size(histElements);
	elements = reshape(histElements', [1 h*w]);

	features = [features; elements];
end

% organize array of features to cluster
[h w] = size(features);
f = reshape(features', [h*w 1]);
[idx, centers] = kmeans(f, 5);

saveFile('bagOfFeatures', centers, 1);