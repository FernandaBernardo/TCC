function[result] = opponentColorSpace(img)
	[h, w, c] = size(img);

	result = img;
	for i=1:h
		for j=1:w
			r = img(i,j,1);
			g = img(i,j,2);
			b = img(i,j,3);
			result(i,j,1) = (r - g) / sqrt(2);
			result(i,j,2) = (r + g - 2*b) / sqrt(3);
			result(i,j,3) = (r + g + b) / sqrt(3);
		end
	end