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

function A = plantedPartition_graph(N,pi,pe)

N1 = N(1);
N2 = N(2);
A0 = eye(N1+N2);
A0(1:N1,1:N1) = 1;
A0(N1+1:N1+N2,N1+1:N1+N2) = 1;

A = eye(N1+N2);

for n1 = 1:N1
    for n2 = n1+1:N1
    if rand(1)<pi(1); A(n1,n2)=1; A(n2,n1)=1; end
    end
end

for n1 = N1+1:N1+N2
    for n2 = n1+1:N1+N2
    if rand(1)<pi(2); A(n1,n2)=1; A(n2,n1)=1; end
    end
end

for n1 = 1:N1+N2
    for n2 = n1+1:N1+N2
    if A0(n1,n2)==0 && rand(1) < pe; A(n1,n2)=1; A(n2,n1)=1; end
    end
end
for n=1:N1+N2; A(n,n)=0; end

