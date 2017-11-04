% This file was created on: 
% Tue Oct 24 17:30:08 CEST 2017
%
% Last edited on: 
% Tue Oct 24 17:30:20 CEST 2017
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
    for j = 1 : N
        TempA(i,j) = exp((-norm(data(i,:)-data(j,:),2)^2)/sigma^2); 
    end
end
TempA = TempA - diag(diag(TempA)); 

% Prune the graph let the KNN nearest neighbors rest connected 
A = zeros(N);
for i = 1 : N
    [sortA,index] = sort(TempA(i,:),'descend');
    sortA(uint32(round(KNN))+1:N) = 0;
    A(i,index) = sortA;
end
for i = 1 : N
    index = find(A(i,:) == 0);
    A(i,index) = A(index,i);
    index = find(A(:,1) == 0);
    A(index,i) = A(i,index);
end
end
