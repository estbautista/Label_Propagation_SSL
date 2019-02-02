% This file was created on: 
% Sat Feb  2 23:40:07 CET 2019
%
% Last edited on:
% Sat Feb  2 23:40:46 CET 2019
%
% Script to return an indicator function for a set un indices 
% 
% INPUT:
% N: 	The size of the vector	
% idx:  The indices where the value is 1
%
% OUTPUT:	
% ind: 	Indicator function of the set indexed by idx
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function ind = indic_fun(N,idx)

ind = zeros(N,1); ind(idx) = 1;
