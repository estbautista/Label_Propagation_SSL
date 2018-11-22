function [MCC,hs] = PageRank_comparing(Lap,mu,y,gT)

% PageRank operator 
Deg = diag(diag(Lap));
Op = Lap*Deg^(-1) + mu*speye(size(Lap));

% graph parameters
N = size(Lap,1);
volG = sum(diag(Deg));

% computation of PageRank
pr = mu*(Op\y);

% PageRank accuracy
[~, partition] = max(pr');
[TP, TN, FP, FN] = accuracy(partition', gT);
MCC = Matthews_correlation_coefficient(TP,TN,FP,FN);

% Cheeger ratio 
indic = 1 - partition' ;
hs = Cheeger_ratio(Lap,indic);
