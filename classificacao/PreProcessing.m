classdef PreProcessing
	properties
		img
		r
		g
		b
	end

	methods
		%constructor - img must be RGB
		function obj = PreProcessing(img)
			obj.img = img;
			obj.r = double(img(:,:,1));
			obj.g = double(img(:,:,2));
			obj.b = double(img(:,:,3));
		end

		function [out] = opponentColorSpace1(obj)
			out = (obj.r - obj.g) / sqrt(2);
		end

		function [out] = opponentColorSpace2(obj)
			out = (obj.r + obj.g - 2 * obj.b) / sqrt(2);
		end

		function [out] = opponentColorSpace3(obj)
			out = (obj.r + obj.g + obj.b) / sqrt(3);
		end

		function [out] = normalizedR(obj)
			out = obj.r ./ (obj.r + obj.g + obj.b);
		end

		function [out] = normalizedG(obj)
			out = obj.g ./ (obj.r + obj.g + obj.b);
		end

		function [out] = hue(obj)
			out = atan2(sqrt(3) * (obj.g - obj.b), 2 * obj.r - obj.g - obj.b);
		end

		function [out] = transformedR(obj)
			out = (obj.r - mean2(obj.r)) / std2(obj.r);
		end

		function [out] = transformedG(obj)
			out = (obj.g - mean2(obj.g)) / std2(obj.g);
		end

		function [out] = transformedB(obj)
			out = (obj.b - mean2(obj.b)) / std2(obj.b);
		end
	end
end