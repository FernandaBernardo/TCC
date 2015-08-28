%food type classification
%1-A / 2-B / 3-F / 4-M / 5-P / 6-Fundo

clear;clc
for number=1:10
  disp(number)
    featureExtraction(strcat('Alimentos\recorte_alimento\A',num2str(number),'.jpg'), 1);
end

%for number=1:10
%    featureExtraction(strcat('Alimentos\recorte_alimento\B',num2str(number),'.jpg'), 2);
%end

%for number=1:10
%    featureExtraction(strcat('Alimentos\recorte_alimento\F',num2str(number),'.jpg'), 3);
%end

%for number=1:10
%    featureExtraction(strcat('Alimentos\recorte_alimento\M',num2str(number),'.jpg'), 4);
%end

%for number=1:10
%    featureExtraction(strcat('Alimentos\recorte_alimento\P',num2str(number),'.jpg'), 5);
%end

%for number=1:60
%    featureExtraction(strcat('Alimentos\recorte_fundo\F',num2str(number),'.jpg'), 6);
%end