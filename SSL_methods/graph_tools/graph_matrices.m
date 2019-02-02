% This file was created on: 
% Sat Feb  2 23:40:07 CET 2019
%
% Last edited on:
% Sat Feb  2 23:40:46 CET 2019
%
% Script to return the Laplacian and the Degree matrix from
% an adjacency matrix
% 
% INPUT:
% A: 	The graph adjacency matrix (square symmetric matrix)
%
% OUTPUT:	
% D: 	Diagonal degree matrix
% L: 	Laplacian matrix (D - A)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [D,L]= graph_matrices(A)

D = diag(sum(A,2));
L = D - A;
