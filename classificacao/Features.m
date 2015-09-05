classdef Features
	properties
		numberOfClasses
		namespaces
		numberOfImages
		classification
	end
	properties(Constant)
		imgSize = 50
		numberOfClusters = 5
	end

	methods
		function obj = Features(mapClass, mapNumberOfImages)
			obj.numberOfClasses = mapClass.Count;
			aux = keys(mapClass);
			obj.namespaces = char(aux);
			obj.numberOfImages = cell2mat(values(mapNumberOfImages));
			obj.classification = cell2mat(values(mapClass));
		end

		function [] = extract(this, typeFeature)
			for position=1:this.numberOfClasses
				disp(strcat('class: ', position, ' typeFeature: ', typeFeature));

				for file = 1:this.numberOfImages(position)
					imgcolor = imread(strcat(this.namespaces(position,:), num2str(file), '.jpg'));
				    imgcolor = imresize(imgcolor, [this.imgSize, this.imgSize]);
				    img = rgb2gray(imgcolor);
				    [h, w] = size(img);

				    tam = 4;
				    cont = 0;

				    feature = [];

				    for i = tam/2+1:h-tam/2
						for j = tam/2+1:w-tam/2
				        	cont=cont+1;
							aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
							vizinhanca = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];
							[GLCM,SI]= graycomatrix(aux, 'offset', vizinhanca);
							x = graycoprops(GLCM, {typeFeature});
							rgb = reshape(imgcolor(i,j,:), 1, 3);
							feature = [feature; getfield(x, typeFeature) double(rgb)];
						end
				    end

				    saveFile(typeFeature, feature, this.classification(position));
				end
			end
		end

		function [] = extractEntropy(this)
			for position=1:this.numberOfClasses
				for file = 1:this.numberOfImages(position)
					imgcolor = imread(strcat(this.namespaces(position,:), num2str(file), '.jpg'));
				    imgcolor = imresize(imgcolor, [this.imgSize, this.imgSize]);
				    img = rgb2gray(imgcolor);
				    [h, w] = size(img);

				    tam = 4;
				    cont = 0;

					entropia = [];

				    for i = tam/2+1:h-tam/2
						for j = tam/2+1:w-tam/2
							cont=cont+1;
							aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
							rgb = reshape(imgcolor(i,j,:), 1, 3);
							entropia = [entropia; entropy(aux) double(rgb)];
				       	end
				    end

				    saveFile('Entropy', entropia, this.classification(position));
				end
			end
		end

		function [] = extractOpponentColorSpace(this)
			for position=1:this.numberOfClasses
				for file = 1:this.numberOfImages(position)
					allCenters = [];

					imgColor = imread(strcat(this.namespaces(position,:), num2str(file), '.jpg'));
					imgColor = imresize(imgColor, [this.imgSize this.imgSize]);

					% pre process image with formulas from article
					obj = PreProcessing(imgColor);

					%%%%%%%%%%%%% OPPONENT COLOR SPACE 1 %%%%%%%%%%%%%
					processedImage = obj.opponentColorSpace1;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];


					%%%%%%%%%%%%% OPPONENT COLOR SPACE 2 %%%%%%%%%%%%%
					processedImage = obj.opponentColorSpace2;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];


					%%%%%%%%%%%%% OPPONENT COLOR SPACE 3 %%%%%%%%%%%%%
					processedImage = obj.opponentColorSpace3;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];

					saveFile('opponentColorSpace', allCenters, this.classification(position));
				end
			end
		end

		function [] = extractNormalizedRG(this)
			for position=1:this.numberOfClasses
				for file = 1:this.numberOfImages(position)
					allCenters = [];

					imgColor = imread(strcat(this.namespaces(position,:), num2str(file), '.jpg'));
					imgColor = imresize(imgColor, [this.imgSize this.imgSize]);

					% pre process image with formulas from article
					obj = PreProcessing(imgColor);

					%%%%%%%%%%%%% NORMALIZED R %%%%%%%%%%%%%
					processedImage = obj.normalizedR;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];


					%%%%%%%%%%%%% NORMALIZED G %%%%%%%%%%%%%
					processedImage = obj.normalizedG;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];

					saveFile('normalizedRG', allCenters, this.classification(position));
				end
			end
		end

		function [] = extractHUE(this)
			for position=1:this.numberOfClasses
				for file = 1:this.numberOfImages(position)
					allCenters = [];

					imgColor = imread(strcat(this.namespaces(position,:), num2str(file), '.jpg'));
					imgColor = imresize(imgColor, [this.imgSize this.imgSize]);

					% pre process image with formulas from article
					obj = PreProcessing(imgColor);
					processedImage = obj.hue;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];

					saveFile('hue', allCenters, this.classification(position));
				end
			end
		end

		function [] = extractTransformedRGB(this)
			for position=1:this.numberOfClasses
				for file = 1:this.numberOfImages(position)
					allCenters = [];

					imgColor = imread(strcat(this.namespaces(position,:), num2str(file), '.jpg'));
					imgColor = imresize(imgColor, [this.imgSize this.imgSize]);

					% pre process image with formulas from article
					obj = PreProcessing(imgColor);

					%%%%%%%%%%%%% TRANSFORMED R %%%%%%%%%%%%%
					processedImage = obj.transformedR;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];


					%%%%%%%%%%%%% TRANSFORMED G %%%%%%%%%%%%%
					processedImage = obj.transformedG;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];


					%%%%%%%%%%%%% TRANSFORMED B %%%%%%%%%%%%%
					processedImage = obj.transformedB;

					features = this.extractBagOfFeatures(processedImage);

					% organize array of features to cluster
					[h w] = size(features);
					f = reshape(features', [h*w 1]);
					[idx, centers] = kmeans(f, this.numberOfClusters);
					allCenters = [allCenters; centers];

					saveFile('transformedRGB', allCenters, this.classification(position));
				end
			end
		end

		function [features] = extractBagOfFeatures(this, processedImage)
			features = [];
			v = Verification;

			% apply gradient on image
			[mag dir] = imgradient(processedImage);

			% extract key points from image
			points = detectFASTFeatures(mag);

			location = v.verifyKeyPoints(points.Location, this.numberOfClusters);
			[h w] = size(location);
			%image(mag); hold on;

			% on each key point...
			for i=1:h
				% ...get coordinates from key point
				x = location(i, 1); 
				y = location(i, 2); 
			
				[xi,xf,yi,yf] = v.verifyBorder(x, y, this.imgSize);

				% ...apply a square 16x16
				region = mag(xi:xf, yi:yf);
				%[h w] = size(region);
				
				%rectangle('Position',[xi yi w h], 'LineWidth',2, 'EdgeColor','r');

				% ...get histogram 8 bins with region that contains gradient
				[histElements histCenters] = hist(region, 8);

				[h w] = size(histElements);
				elements = reshape(histElements', [1 h*w]);

				features = [features; elements];
			end		
		end
	end
end