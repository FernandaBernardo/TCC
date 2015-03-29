img = imread('Alimentos\Arroz\A1.jpg');
img = imresize(img, [512,512]);

[m,n] = size(img);
for i=1:m
   if img(i, end)>=1
       img(i,end)=1;
   else
       img(i,end)=0;
   end
end

for i = 1:n
    range(1,i) = min(img(:,i));
    range(2,i) = max(img(:,i));
end

xx = Normaliza(double(img), -1,1); 
x=[];
for i=1:3
    z=xx(:,:,i);
    z=z(:);
    x=[x,z];
end

x(:,end) = []; 
[m,n] = size(x);

nc = 2;

c = zeros(nc,n);
for i = 1:nc
    rnd = int16(rand*m + 1); 
    c(i,:) = x(rnd,:); 
end

delta = 1e-5;
n = 1000;
iter = 1;
while (iter < n)
    for i = 1:nc
        for j = 1:m
            d = euc_dist(x(j,:),c(i,:));
            u(i,j) = 1;
            for k = 1:nc
                if k~=i
                    if euc_dist(x(j,:),c(k,:)) < d
                        u(i,j) = 0;
                    end
                end
            end
        end
    end
    J(iter) = 0;
    for i = 1:nc
        JJ(i) = 0;
        for k = 1:m
            if u(i,k)==1
                JJ(i) = JJ(i) + euc_dist(x(k,:),c(i,:));
            end
        end
        J(iter) = J(iter) + JJ(i);
    end
    str = sprintf('iteration: %.0d, J=%d', iter, J(iter));
    disp(str);
    if (iter~=1) & (abs(J(iter-1) - J(iter)) < delta)
        break;
    end
    for i = 1:nc
        sum_x = 0;
        G(i) = sum(u(i,:));
        for k = 1:m
            if u(i,k)==1
                sum_x = sum_x + x(k,:);
            end
        end
        c(i,:) = sum_x ./ G(i);
    end
    iter = iter + 1;
end % while
disp('Clustering Done.');


imshow(img);