% This file was created on: 
% Sat Feb  2 23:54:43 CET 2019
%
% Last edited on: 
% Sat Feb  2 23:54:52 CET 2019
% 
% Usage: hs = Cheeger_ratio(Lap,indic,varargin)
% Function to compute the Cheeger ratio of a group
% of nodes
% 
% INPUT:
% Lap: 	   Graph Laplacian matrix of the graph
% indic:   Indicator function of the group of nodes
% 
% OUTPUT:
% hs: 	   Cheeger ratio (boundary/volume) of the set
%
% OPTIONS:
% 'nomin': Avoid computing the min between vol(S) and 
% 	   vol(S^c)
% 'min':   (DEFAULT) Computes the Cheeger ratio using 
%    	   the minimum volume between vol(S) and vol(S^c)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.  
% Information: estbautista@ieee.org


function [hs] = Cheeger_ratio(Lap,indic,varargin)

variable = 'min';
for i = 1 : length(varargin)
	variable = varargin{i};
end

% Degree matrix (diag Laplacian entries)
Deg = diag(diag(Lap));

% Volume of entire graph
volG = sum(diag(Deg));

% Volume of the partition under test
volS = indic'*Deg*indic;

% boundary 
boundary  = indic'*Lap*indic;

% Cheeger ratio
switch variable
    case 'nomin'
        hs = boundary/volS;
    case 'min'
        hs = boundary/min(volS, volG - volS);
    otherwise;
end

