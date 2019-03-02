% This file was created on: 
% Tue Feb 19 17:43:54 CEST 2019
%
% Last edited on: 
% Tue Feb 19 17:44:07 CEST 2019
%
% Usage: gamma_hat = gamma_estimation(A,y,gamma)
%
% Function to estimate the optimal value of gamma 
% Implements Algorithm 1. 
%
% INPUT: 
% A:            Iniutial graph adjacency matrix 
% y:        	labeled points
% gamma:        grid of gamma values to test
% 
% OUTPUT:
% gamma_hat:    estiated value
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function gamma_hat = gamma_estimation(A,y,gamma)

%% Extract transition matrix
[D, L] = graph_matrices(A);
T = D^(-1)*A;

%% compute geodesic distances 
idx_labels = find(y > 0);
dist_labels = distances(graph(A),idx_labels,idx_labels,'Method','Unweighted');
k = max(max(dist_labels));

%% run random walk
p = y'/sum(y);
for i = 1 : k
p = p*T;
end

%% extract proxy of S_{gt}
[sort_vals,idx_sort] = sort(p,'descend'); val_cum = cumsum(sort_vals);
idx_part = idx_sort(val_cum < 0.7);
partition = indic_fun(size(A,1),idx_part);

%% Estimation of optimal gamma
% Done in the spectral domain to account fractional powers but
% for integer powers the eigendecomposition can be avoided (paying the
% price of a less accurate grid)

% Eigendecomposition
[V,Lam] = eig(L);
Lam(1,1) = 0; lam = diag(Lam);

% Coeficients of the Cheeger ratio
cn = (partition'*V).^2;     % numerator
cd = partition'*(V.^2);     % denominator

% compute the cheeger ratios
for g = 1 : length(gamma)
    lamg = lam.^gamma(g); 
    hs(g) = (cn*lamg)/(cd*lamg);
end

% return gamma_hat
[~,idx] = min(hs);
gamma_hat = gamma(idx); 

