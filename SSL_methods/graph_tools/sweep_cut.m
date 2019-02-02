% This file was created on: 
% Thu Jan  17 14:41:02 CET 2019
%
% Last edited on: 
% Thu Jan  17 14:41:07 CET 2019
%
% Usage: [partition,hs] = sweep_cut(f,Lap);
% Function that retrieves a partition by employing a sweep_cut on f 
%
% INPUT: 
% f: function where the cut will be performed
% Lap: Combinatorial graph Laplacian 
%
% OUTPUT:
% partition : solution of the sweep cut
% hs : Cheeger ratio of the partition retrieved
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [partition,hs] = sweep_cut(f,Lap)

d = (diag(Lap));
[fs, idx_s] = sort(f./d,'descend');

for i = 1 : length(fs) - 1
    indic = zeros(length(fs),1); indic(idx_s(1:i)) = 1;
    sweep(i) = Cheeger_ratio(Lap,indic);
end
[hs, min_idx] = min(sweep);

partition = zeros(length(fs),1);
partition(idx_s(1:min_idx)) = 1;

