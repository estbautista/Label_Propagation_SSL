% This file was created on: 
% Sat Feb  2 23:54:43 CET 2019
%
% Last edited on: 
% Sat Feb  2 23:54:52 CET 2019
% 
% Usage: [NewA, NewD, NewN] = clean_graph(A,N)
% Script to clean the Planted Partition from disconnected
% nodes
% 
% INPUT:
% A: 	   	     Graph Adjacency matrix of the graph
% N = [N(1),N(2)]:   Class sizes
% 
% OUTPUT:
% NewA: 	     New Adjacency matrix
% NewD: 	     New Degree matrix
% NewN:		     New vector of cluster sizes
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.  
% Information: estbautista@ieee.org

function [NewA, NewD, NewN] = clean_graph(A, N)

D = diag(sum(A,2));
idx = find(diag(D) == 0);

A(idx,:) = []; A(:,idx) = [];
D(idx,:) = []; D(:,idx) = [];

NewN = [N(1) - sum(idx <= N(1)), N(2) - sum(idx <= sum(N) & idx > N(1))];
NewA = A;
NewD = D;

