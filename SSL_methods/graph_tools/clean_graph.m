function [NewA, NewD, NewN] = clean_graph(A, N)

D = diag(sum(A,2));
idx = find(diag(D) == 0);

A(idx,:) = []; A(:,idx) = [];
D(idx,:) = []; D(:,idx) = [];

NewN = [N(1) - sum(idx <= N(1)), N(2) - sum(idx <= sum(N) & idx > N(1))];
NewA = A;
NewD = D;

