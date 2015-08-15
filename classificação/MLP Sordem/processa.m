%************************************************************************
% function [Ew,dEw] = processa(X,S,w1,w2,n,m,N)
% Para rede MLP estatica
% Fornece o erro quadratico medio na saida e o vetor gradiente 
% Metodo de apresentacao dos padroes em lote
% n: [numero de unidades ocultas  numero de saidas]
% m: numero de entradas (reais)
%************************************************************************

function [Ew,dEw] = processa(X,S,w1,w2,n,m,N)
x1 = [X  ones(N,1)];      % acrescenta bias as entradas
y1 = tanh(x1*w1');        % somas para as unidades ocultas
x2 = [y1  ones(N,1)];     % entradas para as unidades de saida
y2 = x2*w2';              % saidas da rede com ativacoes lineares
erro = y2-S;
erro2 = erro;
dw2 = erro2'*x2;          % dET/dW2
erro1 = (erro2*w2(:,1:n(1))).*(1.0-y1.*y1);
dw1 = erro1'*x1;          % dET/dW1
verro = reshape(erro,N*n(2),1);    % vetor de erros
Ew = (0.5)*verro'*verro;       % somas dos erros quadraticos
dEw = [reshape(dw1',n(1)*(m+1),1);reshape(dw2',n(2)*(n(1)+1),1)]; % vetor gradiente


% dEw = [dET/dw1(1,1) dET/dw1(1,2)...dET/dw1(1,0) dET/dw1(2,1) dET/dw1(2,2)...dET/dw1(2,0)
%      ...dET/dw1(h,1) dET/dw1(h,2)...dET/dw1(h,0) dET/dw2(1,1) dET/dw2(1,2)...dET/dw2(1,0)
%      ...dET/dw2(2,1) dET/dw2(2,2)...dET/dw2(2,0)  ....
%      ...dET/dw2(C,1) dET/dw2(C,2)...dET/dw2(C,0)]'