img = imread('Alimentos\M\M1.jpg');
img = im2double(img);
[r c p] = size(img);

imgR = squeeze(img(:,:,1));
imgG = squeeze(img(:,:,2));
imgB = squeeze(img(:,:,3));

imgBinaryR = im2bw(imgR, graythresh(imgR));
imgBinaryG = im2bw(imgG, graythresh(imgG));
imgBinaryB = im2bw(imgB, graythresh(imgB));
imgBinary = imcomplement(imgBinaryR & imgBinaryG & imgBinaryB);

%imshow(imgBinary);

se = strel('disk', 7);
imClean = imopen(imgBinary, se);

imClean = imfill(imClean, 'holes');
imClean = imclearborder(imClean);
%imshow(imClean);




