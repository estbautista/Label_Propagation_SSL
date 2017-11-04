% This file was created on: 
% Tue Oct 24 18:51:50 CEST 2017
%
% Last edited on: 
% Tue Oct 24 18:51:58 CEST 2017
%
% Usage: Y = label_rnd_generator(n,s);
% Function to generate labels at random. 
% The nodes in the graph should be ordered according to their class
%
% INPUT: 
% n = [n(1),n(2)]: number of nodes in the first and second class, respectively 
% s = [s(1),s(2)]: number of labeled points of the first and second class, respectively.
%
% OUTPUT:
% Y: n(1)+n(2) x 2 matrix of labels
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function Y = label_rnd_generator(n,s)

Y = zeros(n(1)+n(2),2);
l1 = randperm(n(1),s(1));
l2 = randperm(n(2),s(2));
Y(l1,1) = 1;
Y(double(l2)+double(n(1)),2) = 1;

end
