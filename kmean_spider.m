clear;
img_size = 512;
img = imread('Alimentos\Melância\M2.jpg');
img = imresize(img, [img_size ,img_size ]);

ab = double(img(:,:,1:3));
[nrows,ncols] = size(ab);
ncols=ncols/3;
ab = reshape(ab,nrows*ncols,3);

data = data(ab);
[r,a] = train(kmeans('k=2'),data);

cluster = reshape(r.X, img_size , img_size);

for k=1:max(max(cluster))
    n_img = size(img);
    for i=1:img_size
       for j=1:img_size
           rotulo = cluster(i,j);
            if rotulo == k 
                n_img(i,j,1) = img(i,j,1);
                n_img(i,j,2) = img(i,j,2);
                n_img(i,j,3) = img(i,j,3);
            else
                n_img(i,j,1) = 0;
                n_img(i,j,2) = 0;
                n_img(i,j,3) = 0;
            end
       end
    end
    imwrite(n_img, strcat(num2str(k),'.jpg'), 'jpg');
end
imshow(img);