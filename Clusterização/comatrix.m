clear;
alimentos = ['A', 'F', 'B', 'M', 'P'];
qtd_img = [ 18, 15, 17, 14, 13];
img_size = 512;

for q = 1:5
    for n = 1:qtd_img(q)
        I = imread(strcat('Alimentos\', alimentos(q), '\', alimentos(q), num2str(n), '.jpg'));
        
        I = imresize(I, [512,512]);
        I = rgb2gray(I);
        vizinhanca = [0 1; 0 2; 0 3; 0 4];
        [GLCM,SI]= graycomatrix(I,'NumLevels',6);
        SI = SI * 16;
        
        img = SI;
        nimg = [512, 512];
        for i=1:512
            for j=1:512
                nummaxi = mod(i+2,512)+1;
                nummaxj = mod(j+2,512)+1;
                nimg(i,j) = cont(img(i:nummaxi,j:nummaxj));
            end
        end

        nimg = mat2gray(nimg);
        level = graythresh(nimg);
        BW = im2bw(I,level);
        
        imwrite(BW, strcat('new\', alimentos(q), num2str(n), '_otsu.jpg'), 'jpg');
        ab = double(img(:,:));
        ab = reshape(ab,512*512,1);

        data = data(ab);
        [r,a] = train(kmeans('k=2'),data);

        cluster = reshape(r.X, 512, 512);

        n_img = I;
        for i=1:512
           for j=1:512
                if cluster(i,j) ~= 1 
                    n_img(i,j) = 0;
                else 
                    n_img(i,j) = 255;
                end
           end
        end
        imwrite(n_img, strcat('new\', alimentos(q), num2str(n), '_kmeans.jpg'), 'jpg');
       
        clear data ab;
   end
end