classdef Verification
	properties
		recLeft, recRight;
	end

	methods
		function obj = Verification(rect) 
			obj.recLeft = rect / 2;
			obj.recRight = (rect / 2) - 1;
		end

		function [xi,xf,yi,yf] = verifyBorder(obj, x, y, imgSize)
			xi = x - obj.recLeft;
			xf = x + obj.recRight;
			yi = y - obj.recLeft;
			yf = y + obj.recRight;

			if(x <= obj.recLeft)
				xi = 1;
				xf = obj.recLeft + obj.recRight + 1;
			elseif(x >= imgSize - obj.recRight)
				xi = imgSize - obj.recRight - obj.recLeft;
				xf = imgSize;
			end
			if(y <= obj.recLeft)
				yi = 1;
				yf = obj.recLeft + obj.recRight + 1;
			elseif(y >= imgSize - obj.recRight)
				yi = imgSize - obj.recRight - obj.recLeft;
				yf = imgSize;
			end
		end

		function [location] = verifyKeyPoints(obj, location, numberOfClusters, tam)
			[h w] = size(location);
			if(h < numberOfClusters)
				for i = h:(numberOfClusters-1)
					location(h+1,1) = randi(tam);
					location(h+1,2) = randi(tam);
				end
			elseif (h > numberOfClusters)
				location = location(1:numberOfClusters, :);
			end
		end
	end
end