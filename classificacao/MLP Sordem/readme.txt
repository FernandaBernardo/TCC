% Para Realizar Treinamento 
X - matriz de entrada de treinamento
S - vetor de saida
[A,B,EQM]=treinamento(X,S,h)

% Para testar a Rede Neural Treinada
X - matriz de entrada de teste
A - vetor de pesos da camada de entrada obtida no treinamento
B - vetor de pesos da camada de saída obtida no treinamento  
Y=perceptrons(X,A,B)

