% This file was created on: 
% Thu Aug  9 21:39:03 CDT 2018
%
% Last edited on: 
% Thu Aug  9 21:39:12 CDT 2018
%
% Usage: [data_nasal, data_oral] = phoneme_data( path )
% Function to read the phoneme dataset
%
% INPUT: 
% path : The path to the .mat file is
%
% OUTPUT: 
% data_nasal	: features for nasal sounds
% data_oral	: features for oral sounds
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.  
% Information: estbautista@ieee.org

function [data_nasal, data_oral] = phoneme_data(path)

Phoneme = load([path,'/Phoneme-dataset.mat']);

class_1_idx = Phoneme.Class == 1;
class_2_idx = Phoneme.Class == 2;

data_nasal = Phoneme.data(class_1_idx,:);
data_oral = Phoneme.data(class_2_idx,:);
