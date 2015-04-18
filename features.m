clear; clc; 

imgsize = 512;
[img,colormap] = imread('Alimentos\B\B2.jpg');
img = imresize(img, [imgsize,imgsize]);
img = rgb2gray(img);

nimg = [imgsize,imgsize];

for i=1:imgsize
    for j=1:imgsize
        nummaxi = mod(i+2,imgsize)+1;
        nummaxj = mod(j+2,imgsize)+1;
        nimg(i,j) = homo(img(i:nummaxi,j:nummaxj));
    end
end

figure;imshow(nimg);

ab = double(nimg(:,:));
ab = reshape(ab,512*512,1);

data = data(ab);
[r,a] = train(kmeans('k=2'),data);

cluster = reshape(r.X, 512, 512);

for k=1:max(max(cluster))
    n_img = img;
    for i=1:imgsize
       for j=1:imgsize
            if cluster(i,j) ~= k 
                n_img(i,j,1) = 0;
                n_img(i,j,2) = 0;
                n_img(i,j,3) = 0;
            end
       end
    end
    figure; imshow(n_img);
end