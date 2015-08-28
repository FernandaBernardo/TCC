clear;clc;
dados = dlmread('contrast.txt');

X = dados([1,2,61,62], 1:end-1);
Y = dados([1,2,61,62], end);

[l c] = size(X);

colunas = 8;
colunasPorImagem = c/colunas;
linhas = l*colunasPorImagem;

% estruturar X para cada linha ser um pixel e ter 8 colunas
Xn = reshape(X', colunas, linhas)';

% estrutura Y para acompanhar X
[l c] = size(Y);
Ya = [];
cont = 1;
for i=1:l
	for j=1:colunasPorImagem
		Ya(cont,1) = Y(i,1);
		cont = cont + 1;
	end
end

% transforma Y para 0 e 1
[l c] = size(Ya);
Yn = zeros(l, 2);
for i =1:l
	if Ya(i,1)==1
		Yn(i, Ya(i,1)) = 1;
	else
		Yn(i, 2) = 1;
	end
end

%[A,B,veterro_tr] = treinamento(Xn,Yn, '','', 15, 10000);
[A,B,veterro_tr] = treinamento(Xn,Yn, '','', 2, 5000);