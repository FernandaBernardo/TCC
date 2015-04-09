img = imread('Alimentos\M\M1.jpg');
img = imresize(img, [512,512]);
img = rgb2gray(img);
img = double(img);
thres_new = 120;
thres = 0;
[r c] = size(img);
while (thres ~= thres_new)
    m1 = 0;
    m2 = 0;
    thres = thres_new;
    for i=1:r
        for j = 1:c
            if (img(i,j) >= thres)
                m1 = m1 + img(i,j);
            else
                m2 = m2 + img(i,j);
            end
        end
    end
    [x y] = size(find(img>=thres));
    m1_len = x;
    [x y] = size(find(img < thres));
    m2_len = x;
    avg = ((m1/m1_len)+(m2/m2_len))/2;
    thres_new = avg;
end
img_thresh = img>thres_new;
subplot(2,1,1)
imshow(uint8(img))
subplot(2,1,2)
imshow(img_thresh)