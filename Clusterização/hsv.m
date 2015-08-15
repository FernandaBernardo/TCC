clear; clc;
load trees

I = imread('Alimentos\B\B2.jpg');
I  = imresize(I, [512,512]);
I  = rgb2hsv(I);
I = I(:,:,3);

[GLCM,SI]= graycomatrix(I,'NumLevels',6);
SI = SI * 16;

img = SI;

nimg = [512, 512];
for i=1:512
    for j=1:512
        nummaxi = mod(i+2,512)+1;
        nummaxj = mod(j+2,512)+1;
        nimg(i,j) = cont(img(i:nummaxi,j:nummaxj));
    end
end

nimg = mat2gray(nimg);
level = graythresh(nimg);
BW = im2bw(I,level);

subplot(1,1,1), imshow(BW);

ab = double(img(:,:));
ab = reshape(ab,512*512,1);

data = data(ab);
[r,a] = train(kmeans('k=2'),data);

cluster = reshape(r.X, 512, 512);
n_img = I;

for i=1:512
    for j=1:512
        if cluster(i,j) ~= 1
            n_img(i,j) = 0;
        else
          n_img(i,j) = 255;
        end
    end
end
subplot(2,2,2), imshow(n_img);