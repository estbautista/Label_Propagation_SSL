% This file was created on: 
% Thu Aug  9 21:39:03 CDT 2018
%
% Last edited on: 
% Thu Aug  9 21:39:12 CDT 2018
%
% Usage: [data, groundTruth] = BBC_data( path )
% Function to read the phoneme dataset
%
% INPUT: 
% path : The path to the four data files
%
% OUTPUT: 
% data		: frequency of words features
% groundTruth	: true class for every node
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.  
% Information: estbautista@ieee.org

function [data, groundTruth] = bbc_data(path)

% For a file the attributes are words and the value of the attribute is 
% The frequency of words 
fileData = load([path,'/bbc.mtx']);
header = fileData(1,:);
fileData(1,:) = [];

data = sparse(header(2),header(1));
for k = 1 : header(2)
    node_idx = fileData(:,2) == k;
    data(k,fileData(node_idx,1)) = fileData(node_idx,3);
end

ClassValue = load([path,'/bbc.classes']);
groundTruth = ClassValue(:,2) + 1;
