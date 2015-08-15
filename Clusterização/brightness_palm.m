clear; clc;

alimentos = ['A', 'F', 'B', 'M', 'P'];
qtd_img = [ 18, 15, 17, 14, 13];
img_size = 512;

for q = 1:5
    for n = 1:qtd_img(q)
        img = imread(strcat('Alimentos\', alimentos(q), '\', alimentos(q), num2str(n), '.jpg'));
        img = imresize(img, [img_size, img_size]);
        gray = rgb2gray(img);

        seg_m = gray;
        seg_h = gray;
        seg_y = gray;
        for i=1:img_size 
            for j=1:img_size 
                cinza = (img(i, j, 1) + img(i, j, 2) + img(i, j, 3)) / 3;
                m = (0.571 * img(i, j, 1)) + (0.286 * img(i, j, 2)) + (0.143 * img(i, j, 3));
                h = max(img(i, j));
                y = (0.299 * img(i, j, 1)) + (0.587 * img(i, j, 2)) + (0.114 * img(i, j, 3));

                bool = (m-cinza) >= 1;
                seg_m(i,j) = bool.*255 + (~bool).*0; %bool ? 255 : 0
                bool = (h-cinza) >= 18;
                seg_h(i,j) = bool.*255 + (~bool).*0; %bool ? 255 : 0
                bool = (y-cinza) >= 10;
                seg_y(i,j) = bool.*255 + (~bool).*0; %bool ? 255 : 0
            end
        end
        
        imwrite(seg_m, strcat('new\', alimentos(q), num2str(n), '_m.jpg'), 'jpg');
        imwrite(seg_h, strcat('new\', alimentos(q), num2str(n), '_h.jpg'), 'jpg');
        imwrite(seg_y, strcat('new\', alimentos(q), num2str(n), '_y.jpg'), 'jpg');
    end
end