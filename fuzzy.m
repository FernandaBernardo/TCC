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
        
        n_clusters = 4;
        [center,U,obj_fcn] = fcm(ab, n_clusters);

        maxU = max(U);
        index1 = find(U(1,:) == maxU);
        index2 = find(U(2,:) == maxU);
        index3 = find(U(3,:) == maxU);
        index4 = find(U(4,:) == maxU);

        fcmImage(1:length(data))= 0;
        fcmImage(index1)= 1;
        fcmImage(index2)= 0.7;
        fcmImage(index3)= 0.4;
        fcmImage(index4)= 0.1;

        imagNew = reshape(fcmImage,512,512);
        imwrite(imagNew, strcat('new\', alimentos(q), num2str(n), '.jpg'), 'jpg');
        
        clear data ab;
    end
end