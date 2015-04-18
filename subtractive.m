img = imread('Alimentos\M\M1.jpg');
img = imresize(img, [128 ,128]);
img = rgb2gray(img);
figure;imshow(img);

[C,S] = subclust(double(img), 1);

figure;imshow(C);
