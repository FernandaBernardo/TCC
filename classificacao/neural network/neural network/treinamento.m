%**************************************************************
% Utiliza gradiente conjugado escalonado hibrido
% Hessiana calculado pelo metodo exato
% n = [numero de unidades ocultas , numero de saidas];
% X = entrada 
% S = saida desejada
% REDE ESTATICA
% Universidade de São Paulo - EACH
% Disciplina de Inteligencia Computacional
% Prof. Clodoaldo A. M. Lima
% Prof. Sarajane Marques
%*************************************************************
function[A,B,EQM]=treinamento(X,S,h,nepocamax)

% Carrega o banco de dados
%disp('*****************************************')
%disp('Treinamento de uma Redes Neural')
%disp('Gradiente Conjugado Hibrido')
%disp('*****************************************')

% Calcula o numero de entradas e saidas
[~,ne]=size(X);
[N,ns]=size(S);

% Monta o vetor n
n=[h,ns];

% Inicializa as matrizes
A=rands(h,ne+1)/5;
B=rands(ns,h+1)/5;

%Inicializa o vetor de erros
nerro=[];

%Define o erro minimo
erromin=1e-3;

if nargin < 4
   % Define o numero de epocas maximo
   nepocamax=2000;
end

%Inicializa a epoca inicial
nepocas=0;

% Constantes do algoritmo
lambatual=0;       % pode variar de 0 -- 10e-6
lambant=0;         % lambda barra
sucesso=1;         % 1 - verdaddeiro, 0 - falso

% Inicializa o contador
cont=1;

% Calcula o numero de parâmetros
npar=h*(ne+1)+ns*(h+1);

% Calcula o gradiente
[Ew,dEw] = processa(X,S,A,B,n,ne,N);

% Armazena o valor do erro
EQM=2*Ew/N;
nerro=[nerro,EQM];


pat=-dEw;
rat=-dEw;
rant=-dEw;
prevnepocas = nepocas;
while EQM>erromin && nepocas<nepocamax
   	
   if sucesso ==1
      %Calculando a infromação de Segunda Ordem
      vetdJdAv=pat(1:h*(ne+1));
      vetdJdBv=pat(1+h*(ne+1):end);
      Av=reshape(vetdJdAv,ne+1,h)';
      Bv=reshape(vetdJdBv,h+1,ns)';
      s=hprocessa(X,S,A,B,Av,Bv,n,ne,N);
      pHp=pat'*s;
      normapat=pat'*pat;
      delta=pHp;
   end
   
   delta=delta+(lambatual-lambant)*normapat;
   
   if delta <=0
      lambant=lambatual;
      lambatual=2*(lambant-delta/normapat);
      delta=-delta+lambant*normapat;
    end
      
   mi=pat'*rat;
      
   alfa=mi/delta;
      
   Aaux=A+alfa*Av;
   Baux=B+alfa*Bv;
   
   [Ewaux,dEwaux] = processa(X,S,Aaux,Baux,n,ne,N);
   
   Ewp=Ew+alfa*pat'*dEw+(1/2)*(alfa*pHp*alfa);
   
   deltacomp=(Ew-Ewaux)/(Ew-Ewp);   %Ewv --> calculado corretamente
      
   if deltacomp >= 0      
      prevnepocas = nepocas;
	   nepocas=nepocas+1;
      
      lambant=0;
      
      sucesso=1;
      
      A=Aaux;
      
      B=Baux;
         
      dEw=dEwaux;
      
      Ew=Ewaux;
            
      rant=rat;
      
      rat=-dEw;
      
      EQM=2*Ew/N;
      nerro=[nerro,EQM];
      
      if cont == npar
         beta=0;
         pat=rat;
         cont=1;
      else      
         betaPR=(rat'*rat-rat'*rant)/(rant'*rant);
         betaFR=rat'*rat/(rant'*rant);
         
         if betaPR>0 && betaPR<betaFR
            pat=rat+betaPR*pat;
            cont=cont+1;
            beta=betaPR;
            
            if (pat'*rat)<0
               beta=0;
               pat=rat;
               cont=1;
 %              disp('Alfa será negativo')
            end
            
            %elseif betaPR>betaFR
         elseif betaPR>betaFR
            pat=rat+betaFR*pat;
            cont=cont+1;
            beta=betaFR;
            
            if (pat'*rat)<0
               beta=0;
               pat=rat;
               cont=1;
  %             disp('Alfa será negativo')
            end
            
         else
            beta=0;
            pat=rat;
            cont=1;
   %         disp('Reinicializando')   
         end
                 
      end
      
      if deltacomp >= 0.75
         lambatual=(1/4)*lambatual;
      end
      
   else
      
      sucesso=0;
         
      if deltacomp < 0.25
         lambant=lambatual;
         lambatual=lambant+delta*(1-deltacomp)/normapat;
      end
      
   end
   
   %Sr = perceptrons(X,A,B);
   % Plota o grafico da saida
   %{
   figure(1)
   clf
   plot(S,'r--')
   hold on
   plot(Sr,'b')
   grid
    %}
   %fprintf('EQM=%f epoca=%d\n', EQM, nepoca);
   if prevnepocas == nepocas && prevnepocas ~= 0 
        save('C:\Users\Renan\Desktop\Estudos\EEG\data', 'X', 'S', 'h' );
   end
end

% Salva as matrizes A B
if h == 5
   save matfinal5 A B;   
   save nerro5 nerro;
elseif h==10
   save matfinal10 A B;      
   save nerro10 nerro;
elseif h==15
   save matfinal15 A B;      
   save nerro15 nerro;
elseif h==20
   save matfinal20 A B;   
   save nerro20 nerro;
end

%{
figure(2)
clf
plot(S,'r--')
grid
hold on
plot(Sr,'b')
title('Saída Desejada(ver) x Saída da Rede Neural(azul)')
xlabel('DADOS DE TREINAMENTO')

figure(3)
clf
plot(0:length(nerro)-1,nerro)
grid
title('Erro Quadrático Médio (EQM)')
xlabel('Número de Épocas')
ylabel('EQM')
%}


