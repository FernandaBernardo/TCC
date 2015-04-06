img = imread('Alimentos\M\M1.jpg');
img = imresize(img, [512 ,512 ]);

ab = double(img(:,:,1:3));
[nrows,ncols] = size(ab);
ncols=ncols/3;
ab = reshape(ab,nrows*ncols,3);

[C,S] = subclust(ab, 0.5);