clear;
alimentos = ['A', 'F', 'B', 'M', 'P'];
qtd_img = [ 18, 15, 17, 14, 13];
img_size = 512;

for q = 1:5
    for n = 1:qtd_img(q)
        img = imread(strcat('Alimentos\', alimentos(q), '\', alimentos(q), num2str(n), '.jpg'));
        img = imresize(img, [img_size ,img_size ]);

        ab = double(img(:,:,1:3));
        [nrows,ncols] = size(ab);
        ncols=ncols/3;
        ab = reshape(ab,nrows*ncols,3);

        data = data(ab);
        [r,a] = train(kmeans('k=4'),data);

        cluster = reshape(r.X, img_size , img_size);

        for k=1:max(max(cluster))
            n_img = img;
            for i=1:img_size
               for j=1:img_size
                    if cluster(i,j) ~= k 
                        n_img(i,j,1) = 0;
                        n_img(i,j,2) = 0;
                        n_img(i,j,3) = 0;
                    end
               end
            end
            imwrite(n_img, strcat('new\', alimentos(q), num2str(n), '_', num2str(k), '.jpg'), 'jpg');
        end
        clear data ab;
    end
end