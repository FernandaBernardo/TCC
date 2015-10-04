function feature = waveletCoefsImage( X, cols, wname, level )
	imgColor = getRGBImage(X);
	
	feature = [];
    	
	lvl = 1;

	[cA,  ~, ~, ~] = dwt2( imgColor, wname );
	
	while lvl < level
	    [cA,  ~, ~, ~] = dwt2( cA, wname );
	    lvl = lvl + 1;
	end
    	
	feature = [feature cA(:)'];
end