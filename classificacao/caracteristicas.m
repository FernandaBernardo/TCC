%food type classification
%1-A / 2-B / 3-F / 4-M / 5-P / 6-Fundo

clear;clc;
keySet = {'Alimentos\recorte_alimento\A', 'Alimentos\recorte_fundo\F'};
valuesClass = {1,6};
valuesNumberOfImages = {10,60};

mapClass = containers.Map(keySet, valuesClass);
mapNumberOfImages = containers.Map(keySet, valuesNumberOfImages);

obj = Features(mapClass, mapNumberOfImages);
%obj.extractEntropy()
%obj.extract('Contrast');
%obj.extract('Correlation');
%obj.extract('Energy');
%obj.extract('Homogeneity');

%obj.extractOpponentColorSpace();
%obj.extractNormalizedRG();
%obj.extractHUE();
%obj.extractTransformedRGB();