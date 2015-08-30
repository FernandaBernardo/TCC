%food type classification
%1-A / 2-B / 3-F / 4-M / 5-P / 6-Fundo

clear;clc;
keySet = {'Alimentos\recorte_alimento\A', 'Alimentos\recorte_alimento\B', 'Alimentos\recorte_alimento\F', 'Alimentos\recorte_alimento\M', 'Alimentos\recorte_alimento\P', 'Alimentos\recorte_fundo\F'};
valuesClass = {1,2,3,4,5,6};
valuesNumberOfImages = {10,10,10,10,10,60};

mapClass = containers.Map(keySet, valuesClass);
mapNumberOfImages = containers.Map(keySet, valuesNumberOfImages);

obj = Features(mapClass, mapNumberOfImages);
obj.extractEntropy()
obj.extract('Contrast');
obj.extract('Correlation');
obj.extract('Energy');
obj.extract('Homogeneity');