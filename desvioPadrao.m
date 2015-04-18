clear;clc;

img = imread('Alimentos\M\M1.jpg');
img = imresize(img, [128,128]);
img = rgb2gray(img);
subplot(2, 2, 1);
imshow(img, []);
title('Original Image', 'FontSize', 20);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

blurredImage = conv2(double(img), ones(5,5)/25);
subplot(2, 2, 2);
imshow(blurredImage, []);
title('Blurred Image', 'FontSize', 20);

VarianceFilterFunction = @(x) var(x(:));
varianceImage = nlfilter(double(img), [3 3], VarianceFilterFunction);

subplot(2, 2, 3);
imshow(varianceImage, [])
title('Variance Image', 'FontSize', 20);
standardDeviationImage = sqrt(varianceImage);
subplot(2, 2, 4);
imshow(standardDeviationImage, [])
title('Standard Deviation Image', 'FontSize', 20);

