clear;

alimentos = ['A', 'F', 'B', 'M', 'P'];
qtd_img = [ 18, 15, 17, 14, 13];
img_size = 512;
map = [0,0,0;0.5,0.5,0.5;1,1,1];
for q = 1:5
    for n = 1:qtd_img(q)
        img = imread(strcat('Alimentos\', alimentos(q), '\', alimentos(q), num2str(n), '.jpg'));
        img= imresize(img, [img_size ,img_size ]);

        i = rgb2gray(img);

        S = qtdecomp(i,.27);
        blocks = repmat(uint8(0),size(S));

        for dim = [512 256 128 64 32 16 8 4 2 1];    
          numblocks = length(find(S==dim));    
          if (numblocks > 0)        
            values = repmat(uint8(1),[dim dim numblocks]);
            values(2:dim,2:dim,:) = 0;
            blocks = qtsetblk(blocks,S,dim,values);
          end
        end

        blocks(end,1:end) = 1;
        blocks(1:end,end) = 1;

        imwrite(i, strcat('new\', alimentos(q), num2str(n), '_1','.jpg'), 'jpg');
        imwrite(blocks, map, strcat('new\', alimentos(q), num2str(n), '_2', '.jpg'));
    end
end