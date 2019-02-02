% This file was created on: 
% Tue Oct 24 17:30:08 CEST 2017
%
% Last edited on: 
% Sat Feb  2 23:50:02 CET 2019
%
% Usage: A = RBF_graph_construction(data,KNN,sigma)
% Function to build a graph using the Radial Basis Function Kernel 
% A_{ij} = exp{-d(i,j)/sigma}
%
% INPUT: 
% data: Nx2 matrix of data
% KNN: Connect only the KNN nearest neighbors 
% sigma: Parameter to control the weights of the RBF
%
% OUTPUT:
% A: adajcency matrix (N-by-N)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [A] = RBF_graph_construction(data,KNN,sigma)

% Compute the weights for every pair of nodes using the RBF kernel
N = size(data,1);        
TempA = zeros(N);          
for i = 1 : N
    data_i = data(i,:);
    for j = i + 1 : N
        data_j = data(j,:);
        sim = exp((-norm(data_i-data_j,2)^2)/sigma^2); 
        TempA(i,j) = sim; TempA(j,i) = sim;
    end
end

% Prune the graph let the KNN nearest neighbors rest connected 
A = zeros(N);
KNN = uint32(round(KNN));
for i = 1 : N
    [sortA,index] = sort(TempA(i,:),'descend');
    A(i,index(1:KNN)) = sortA(1:KNN);
    A(index(1:KNN),i) = sortA(1:KNN);
end

end
