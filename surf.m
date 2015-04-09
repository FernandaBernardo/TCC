I = imread('Alimentos\B\B2.jpg');
I = rgb2gray(I);
    points = detectSURFFeatures(I);
  imshow(I); hold on;
    plot(points.selectStrongest(10));