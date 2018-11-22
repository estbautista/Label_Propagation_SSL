% This file was created on: 
% Tue Oct 24 16:25:27 CEST 2017
%
% Last edited on: 
% Tue Oct 24 16:25:49 CEST 2017
%
% Usage: A = plantedPartition_graph(N,pi,pe);
% Function to build and adjacency matrix that follows the planted partition
% graph model
%
% INPUT: 
% N = [N(1),N(2)]: two entries vector giving the total points of each class 
% pi = [pi(1),pi(2)]: Class 1 & Class 2 intra class edge probability 
% pe = inter class edge probability
%
% OUTPUT:
% A: adajcency matrix (N-by-N)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function A = sparsePlantedPartition_graph(N,pi,pe)

N1 = N(1);
N2 = N(2);
rows = []; cols = [];

parfor n1 = 1:N1
    randvect = rand(N1-n1,1);
    idx = n1 + find(randvect < pi(1));
    nonzeros = length(idx);
    cols = [cols; n1*ones(nonzeros,1)];
    rows = [rows; idx];
end

parfor n1 = N1+1:N1+N2
    randvect = rand(N1+N2-n1,1);
    idx = n1 + find(randvect < pi(2));
    nonzeros = length(idx);
    cols = [cols; n1*ones(nonzeros,1)];
    rows = [rows; idx];
end

parfor n1 = 1 : N1
    randvect = rand(N2,1);
    idx = N1 + find(randvect < pe);
    nonzeros = length(idx);
    cols = [cols; n1*ones(nonzeros,1)];
    rows = [rows; idx];
end

A = sparse(rows,cols,ones(length(rows),1),sum(N),sum(N));
A = A + sparse(cols,rows,ones(length(rows),1),sum(N),sum(N));
A = A - diag(diag(A));
