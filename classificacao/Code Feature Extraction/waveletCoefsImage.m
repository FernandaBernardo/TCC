function feature = waveletCoefsImage( X, cols, wname, level )
    imgColor = [];

    for i=1:length(X)
        x = X{i};

        imgColor(i,:,1) = x(1,:); % R
        imgColor(i,:,2) = x(2,:); % G
        imgColor(i,:,3) = x(3,:); % B
    end
	
	feature = [];
    	
	lvl = 1;

	[cA,  ~, ~, ~] = dwt2( imgColor, wname );
	
	while lvl < level
	    [cA,  ~, ~, ~] = dwt2( cA, wname );
	    lvl = lvl + 1;
	end
    	
	feature = [feature cA(:)'];
end