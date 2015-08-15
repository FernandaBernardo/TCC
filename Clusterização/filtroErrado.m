clear;clc; 

img = imread('Alimentos\A\A2.jpg');
img = imresize(img, [512,512]);

%K = rangefilt(img);
%imshow(K);

ab = double(img(:,:,1:3));
[nrows,ncols] = size(ab);
ncols=ncols/3;
ab = reshape(ab,nrows*ncols,3);

data = data(ab);
[r,a] = train(kmeans('k=2'),data);

cluster = reshape(r.X, 512 , 512);

for k=1:max(max(cluster))
    n_img = img;
    for i=1:512
       for j=1:512
            if cluster(i,j) ~= k 
                n_img(i,j,1) = 0;
                n_img(i,j,2) = 0;
                n_img(i,j,3) = 0;
            end
       end
    end
    imwrite(n_img, strcat('new\A2_', num2str(k), '.jpg'), 'jpg');
end