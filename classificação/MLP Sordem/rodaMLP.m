clear;clc;
%dados1 = dlmread('contrast.txt');
%dados2 = dlmread('energy.txt');

%dados = [dados1; dados2];
dados = dlmread('contrast.txt');

dados(isnan(dados)) = 0;

X = dados(:, 1:end-1);
Y = dados(:, end);

[l c] = size(X);

colunas = 11;
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
Yn = zeros(l, 6);
for i =1:l
	if Ya(i,1) == 1
		Yn(i, 1) = 1;
	elseif Ya(i,1) == 2
		Yn(i, 2) = 1;
	elseif Ya(i,1) == 3
		Yn(i, 3) = 1;
	elseif Ya(i,1) == 4
		Yn(i, 4) = 1;
	elseif Ya(i,1) == 5
		Yn(i, 5) = 1;
	else
		Yn(i, 6) = 1;
	end
end

[A,B,EQM] = treinamento(Xn,Yn, 5);
[A,B,EQM] = treinamento(Xn,Yn, 10);
[A,B,EQM] = treinamento(Xn,Yn, 20);
[A,B,EQM] = treinamento(Xn,Yn, 30);