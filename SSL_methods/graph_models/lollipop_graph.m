% This file was created on: 
% Tue Oct 24 17:20:35 CEST 2017
%
% Last edited on: 
% Tue Oct 24 17:20:52 CEST 2017
%
% Usage: A = lollipop_graph(wr,wb)
% Function to define a lollipop graph of 12 nodes
% where we might set the weight of the links in both hubs
%          (2)                                                 (10)
%           o                                                   o
%       /  (wr) \  (4)    (5)    (6)    (7)    (8)    (9)   /  (wb) \
%   o ------------- o ---- o ---- o ---- o ---- o ---- o ---------------o
%  (1)  \       /                                           \       /  (12)
%           o                                                   o
%          (3)                                                (11)
%
% INPUT: 
% wr: edge weight in the left hub
% wb: edge weight in the right hub
%
% OUTPUT:
% A: adajcency matrix (N-by-N)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function A = lollipop_graph(wr,wb)

A = zeros(12);
A(4,5) = 1; A(5,4) = 1;
A(5,6) = 1; A(6,5) = 1;
A(6,7) = 1; A(7,6) = 1;
A(7,8) = 1; A(8,7) = 1;
A(8,9) = 1; A(9,8) = 1;

A(1,2) = wr; A(2,1) = wr;
A(1,3) = wr; A(3,1) = wr;
A(1,4) = wr; A(4,1) = wr;
A(2,3) = wr; A(3,2) = wr;
A(2,4) = wr; A(4,2) = wr;
A(3,4) = wr; A(4,3) = wr;

A(9,10) = wb; A(10,9) = wb;
A(9,11) = wb; A(11,9) = wb;
A(9,12) = wb; A(12,9) = wb;
A(10,11) = wb; A(11,10) = wb;
A(10,12) = wb; A(12,10) = wb;
A(11,12) = wb; A(12,11) = wb;
