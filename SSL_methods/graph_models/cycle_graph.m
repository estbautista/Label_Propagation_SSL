% This file was created on: 
% Fri Jun 1 18:13:24 CEST 2018
%
% Last edited on: 
% Fri Jun 1 18:13:35 CEST 2018
%
% Usage: A = cycle_graph(N)
% Function to compute the adjacency matrix of an undirected cycle graph
%
% INPUT: 
% N : number of nodes
% 
% OUTPUT: 
% A : adjacency matrix (N-by-N)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function A = cycle_graph(N)
v = zeros(N,1);
v([2,N]) = 1;
A = zeros(N);
for i = 1 : N
    A(i,:) = circshift(v,i-1,1);
end
end
