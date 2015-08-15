clear; clc;
alimentos = ['A', 'F', 'B', 'M', 'P'];
qtd_img = [ 18, 15, 17, 14, 13];
img_size = 512;

for q = 1:5
    for n = 1:qtd_img(q)
        rgb = imread(strcat('Alimentos\', alimentos(q), '\', alimentos(q), num2str(n), '.jpg'));
        rgb  = imresize(rgb, [img_size,img_size]);

        hsv = rgb2hsv(rgb);
        h = hsv(:,:,1);
        s = hsv(:,:,2);
        v = hsv(:,:,3);

        [GLCM,SI]= graycomatrix(h,'NumLevels',6);
        SI = SI * 16;
        h = SI;
        nimg = [512, 512];
        for i=1:512
            for j=1:512
                nummaxi = mod(i+2,512)+1;
                nummaxj = mod(j+2,512)+1;
                nimg(i,j) = cont(h(i:nummaxi,j:nummaxj));
            end
        end
        h = mat2gray(nimg);

        [GLCM,SI]= graycomatrix(s,'NumLevels',6);
        SI = SI * 16;
        s = SI;
        nimg = [512, 512];
        for i=1:512
            for j=1:512
                nummaxi = mod(i+2,512)+1;
                nummaxj = mod(j+2,512)+1;
                nimg(i,j) = cont(s(i:nummaxi,j:nummaxj));
            end
        end
        s = mat2gray(nimg);

        [GLCM,SI]= graycomatrix(v,'NumLevels',6);
        SI = SI * 16;
        v = SI;
        nimg = [512, 512];
        for i=1:512
            for j=1:512
                nummaxi = mod(i+2,512)+1;
                nummaxj = mod(j+2,512)+1;
                nimg(i,j) = cont(v(i:nummaxi,j:nummaxj));
            end
        end
        v = mat2gray(nimg);

        hsv(:,:,1) = h;
        hsv(:,:,2) = s;
        hsv(:,:,3) = v;

        ab = double(hsv(:,:,1:3));
        [nrows,ncols] = size(ab);
        ncols=ncols/3;
        ab = reshape(ab,nrows*ncols,3);

        data = data(ab);
        [r,a] = train(kmeans('k=3'),data);

        cluster = reshape(r.X, 512, 512);

        n_img = rgb;
        for i=1:img_size
            for j=1:img_size
                if cluster(i,j) ~= 1 
                    n_img(i,j,1) = 255;
                    n_img(i,j,2) = 255;
                    n_img(i,j,3) = 255;
                else
                    n_img(i,j,1) = 0;
                    n_img(i,j,2) = 0;
                    n_img(i,j,3) = 0;
                end
            end
        end
        
        imwrite(n_img, strcat('new\', alimentos(q), num2str(n), '_hsv.jpg'), 'jpg');
       
        clear data ab;
    end
end