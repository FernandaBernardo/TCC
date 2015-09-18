function [] = preProcessDataset( inputPath, outputPath )
	
	Logger.getLogger().log('Preprocessing food');

	foods = {'\recorte_alimento\A', '\recorte_fundo\F'};
	numberOfFoods = {10, 60};

	id = 1;
	class = [];
	values={};

	cont=1;
	for numberOfClass = 1:2
		for image=1:numberOfFoods{numberOfClass}
			img = imread(strcat(inputPath, foods{numberOfClass}, num2str(image), '.jpg'));
			img = imresize(img, [50 50]);
			img = double(img);

			[h w p] = size(img);

			if(numberOfClass==2)
				class(cont) = -1;
			else
				class(cont) = +1;
			end

			for i=1:h
				r = img(i,:,1);
				g = img(i,:,2);
				b = img(i,:,3);
				line = [r; g; b];
				values{cont, i} = line;
			end
			cont=cont+1;
		end
	end

	outputFile = strcat(outputPath, '\preprocessed', num2str(id));

	save(outputFile, 'id', 'values', 'class');
end

%preProcessDataset('Alimentos/', 'outputs/');