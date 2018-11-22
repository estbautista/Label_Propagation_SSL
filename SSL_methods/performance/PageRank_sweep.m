function [MCC,hs] = PageRank_sweep(Lap,mu,y,gT)

% PageRank operator 
Deg = diag(diag(Lap));
Op = Lap*Deg^(-1) + mu*speye(size(Lap));

% graph parameters
N = size(Lap,1);
volG = sum(diag(Deg));

% computation of PageRank
pr = mu*(Op\y);

% PageRank sweep
sweep = zeros(N-1,1);
[~, idx_pr] = sort(pr./diag(Deg),'descend');
for i = 1 : N - 1
    indic = zeros(N,1); indic(idx_pr(1:i)) = 1;
    sweep(i) = Cheeger_ratio(Lap,indic);
end
[hs, min_idx] = min(sweep);

% Accuracy of partition
partition = zeros(1,N);
partition(idx_pr(1:min_idx)) = 1; partition(idx_pr(min_idx + 1 : end)) = 2;
[TP, TN, FP, FN] = accuracy(partition', gT);
MCC_tmp1 = Matthews_correlation_coefficient(TP,TN,FP,FN);

partition = zeros(1,N);
partition(idx_pr(1:min_idx)) = 2; partition(idx_pr(min_idx + 1 : end)) = 1;
[TP, TN, FP, FN] = accuracy(partition', gT);
MCC_tmp2 = Matthews_correlation_coefficient(TP,TN,FP,FN);
MCC = max(MCC_tmp1,MCC_tmp2);
