% http://www.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html
img = imread('Alimentos\Melância\M1.jpg');
%img = imread('Alimentos\Arroz\A1.jpg');
img = imresize(img, [512,512]);

cform = makecform('srgb2lab');
lab_img = applycform(img, cform);

ab = double(lab_img(:,:,1:3));
[nrows,ncols] = size(ab);
ncols=ncols/3;
ab = reshape(ab,nrows*ncols,3);

nColors = 3;
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', 'Replicates', 2);

pixel_labels = reshape(cluster_idx,nrows,ncols);
% imshow(pixel_labels,[]);

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
    imwrite(segmented_images{k}, strcat(num2str(k),'.jpg'), 'jpg');
end

% mean_cluster_value = mean(cluster_center,2);
% [tmp, idx] = sort(mean_cluster_value);
% blue_cluster_num = idx(1);
% 
% L = lab_img(:,:,1);
% blue_idx = find(pixel_labels == blue_cluster_num);
% L_blue = L(blue_idx);
% is_light_blue = im2bw(L_blue,graythresh(L_blue));
% 
% nuclei_labels = repmat(uint8(0),[nrows ncols]);
% nuclei_labels(blue_idx(is_light_blue==false)) = 1;
% nuclei_labels = repmat(nuclei_labels,[1 1 3]);
% blue_nuclei = img;
% blue_nuclei(nuclei_labels ~= 1) = 0;
% imshow(blue_nuclei);