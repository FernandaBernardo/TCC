% c=[0 0;0 1;1 0;1 1;0.5 0.5];
% X=[];
% for i=1:100
%     X=[X;normrnd(c(1,:),0.1)];
% end
% for i=1:100
%     X=[X;normrnd(c(2,:),0.1)];
% end
% for i=1:100
%     X=[X;normrnd(c(3,:),0.1)];
% end
% for i=1:100
%     X=[X;normrnd(c(4,:),0.1)];
% end
% for i=1:100
%     X=[X;normrnd(c(5,:),0.1)];
% end


% Y=[ones(400,1);2*ones(100,1)];

% figure(1)
% clf
% plot(X(1:400,1),X(1:400,2),'r*')
% hold on
% plot(X(401:500,1),X(401:500,2),'ko')

% [code wnew w]=trainLVQ1(X,Y,100,10,100);

% plot(wnew(code{1},1),wnew(code{1},2),'ro','linewidth',5)
% x=code{1};
% plot(wnew(x(end)+code{2},1),wnew(x(end)+code{2},2),'ko','linewidth',5)
clear;clc;
X = dlmread('contrast.txt');
[h,w] = size(X);
%Y = X(:, end);
%X = X(:, 1:w-1);

Y = X([11:12, 64:65], end);
X = X([11:12, 64:65], 1:w-1);

%numero iteracoes, numero inicial de neuronios, numero de neuronios reduzidos
[code wnew w] = trainLVQ1(X,Y,20,100,50);



    