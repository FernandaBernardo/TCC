classdef Features
	properties
		numberOfClasses
		namespaces
		numberOfImages
		classification
	end

	methods
		function obj = Features(mapClass, mapNumberOfImages)
			obj.numberOfClasses = mapClass.Count;
			aux = keys(mapClass);
			obj.namespaces = char(aux);
			obj.numberOfImages = cell2mat(values(mapNumberOfImages));
			obj.classification = cell2mat(values(mapClass));
		end

		function [] = extract(obj, typeFeature)
			for position=1:obj.numberOfClasses
				disp(strcat('class: ', position, ' typeFeature: ', typeFeature));

				for file = 1:obj.numberOfImages(position)
					imgcolor = imread(strcat(obj.namespaces(position,:), num2str(file), '.jpg'));
				    imgcolor = imresize(imgcolor, [50,50]);
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

				    saveFile(typeFeature, feature, obj.classification(position));
				end
			end
		end

		function [] = extractEntropy(obj)
			for position=1:obj.numberOfClasses
				for file = 1:obj.numberOfImages(position)
					imgcolor = imread(strcat(obj.namespaces(position,:), num2str(file), '.jpg'));
				    imgcolor = imresize(imgcolor, [50,50]);
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

				    saveFile('Entropy', entropia, obj.classification(position));
				end
			end
		end
	end
end