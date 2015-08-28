imgcolor = imread('../Alimentos/originais/B9.jpg');
imgcolor = imresize(imgcolor, [50,50]);
img = rgb2gray(imgcolor);
[h, w] = size(img);
tam=4;
cont=0;
contrast=[];
energy = [];
for i=tam/2+1:h-tam/2
	for j=tam/2+1:w-tam/2
		cont=cont+1;
		aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
		vizinhanca = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];
		[GLCM,SI]= graycomatrix(aux, 'offset', vizinhanca);
		x = graycoprops(GLCM, {'contrast', 'energy'});
		rgb = reshape(imgcolor(i,j,:), 1, 3);
        contrast = [contrast; x.Contrast double(rgb)];
        energy = [energy; x.Energy double(rgb)];
	end
end
features = [contrast; energy];
resp = perceptrons(contrast,A,B)
[l c] = size(resp);

for i=1:l
	if(resp(i,1)>resp(i,2))
		aux(i,1) = 1; aux(i,2) = 0;
	else
		aux(i,1) = 0; aux(i,2) = 1;
	end
end

a = [];
for i=1:l
	if(aux(i,1) == 1)
		a(i,1) = 1;
	else
		a(i,1) = 2;
	end
end

%------------------- com 6 classes
bin = [];
for i=1:l
	A = resp(i,:);
	max_val = max(A);
	index = find(A == max_val);
	bin(i,1:6) = 0
	bin(i,index) = 1;
end

a=[];
for i=1:l
	if(bin(i,1) == 1)
		a(i,1) = 1;
	elseif bin(i,2) == 1
		a(i,1) = 2;
	elseif bin(i,3) == 1
		a(i,1) = 3;
	elseif bin(i,4) == 1
		a(i,1) = 4;
	elseif bin(i,5) == 1
		a(i,1) = 5;
	else
		a(i,1) = 6;
	end
end
%-------------------

i = reshape(a, 46, 46)'
image(i)