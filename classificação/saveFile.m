function [] = saveFile (prop, values, foodType)
[h, w] = size(values);
aux = reshape(values', h*w, 1);
file = fopen(strcat(prop, '.txt'), 'a');
fprintf(file, '%6.4f ', aux);
fprintf(file, '%d\n', foodType);
fclose(file);