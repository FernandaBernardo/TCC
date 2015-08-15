%food type classification
%1-A / 2-B / 3-F / 4-M / 5-P / 6-Fundo

clear;clc
foodType = 6;
for number=1:60
    imgcolor = imread(strcat('Alimentos\recorte_fundo\F',num2str(number),'.jpg'));
    imgcolor = imresize(imgcolor, [50,50]);
    img = rgb2gray(imgcolor);
    [h, w] = size(img);
    tam=4;
    cont=0;
    entropia=[];
    %contrast=[];
    %correlation = [];
    %energy = [];
    %homogeneity = [];
    disp(number);

    for i=tam/2+1:h-tam/2
       for j=tam/2+1:w-tam/2
           cont=cont+1;
           aux = img(i-tam/2:i+tam/2, j-tam/2:j+tam/2);
           %vizinhanca = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];
           %[GLCM,SI]= graycomatrix(aux, 'offset', vizinhanca);
           %x = graycoprops(GLCM, {'contrast', 'correlation', 'energy', 'homogeneity'});
           rgb = reshape(imgcolor(i,j,:), 1, 3);
           entropia = [entropia; entropy(aux) double(rgb)];
           %contrast = [contrast; x.Contrast double(rgb)];
           %correlation = [correlation; x.Correlation double(rgb)];
           %energy = [energy; x.Energy double(rgb)];
           %homogeneity = [homogeneity; x.Homogeneity double(rgb)];
       end
    end
    saveFile('entropy', entropia, foodType);
    %saveFile('contrast', contrast, foodType);
    %saveFile('correlation', correlation, foodType);
    %saveFile('energy', energy, foodType);
    %saveFile('homogeneity', homogeneity, foodType);
end