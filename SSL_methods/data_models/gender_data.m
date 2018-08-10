% This file was created on: 
% Thu Aug  9 21:39:03 CDT 2018
%
% Last edited on: 
% Thu Aug  9 21:39:12 CDT 2018
%
% Usage: [dataFemale, dataMale = gender_data( path )
% Function to read the Gender Face Images dataset
% The images are converted from rgb to grayscale
%
% INPUT: 
% path : The path to the images are
%
% OUTPUT: 
% dataFemale	: Images for female gender
% dataMale	: Images for male gender
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [dataFemale,dataMale]=gender_data(DataPath)


%% Female data
folder1 = dir([DataPath,'/faces94/female']);
n = 1;
for l1 = 1 : length(folder1)
    if strfind(folder1(l1).name,'.')
    else
        path = [DataPath,'/faces94/female/',folder1(l1).name];
        folder2 = dir([path,'/*.jpg']);
        for k = 1 : length(folder2)
            imageName = folder2(k).name;
            currentImage = rgb2gray(imread([path,'/',imageName]));
            dataFemale(n,:) = currentImage(:);
            n = n + 1;
        end
    end
end

%% Male data

folder1 = dir([DataPath,'/faces94/male']);
n = 1;
for l1 = 1 : length(folder1)
    if strfind(folder1(l1).name,'.')
    else
        path = [DataPath,'/faces94/male/',folder1(l1).name];
        folder2 = dir([path,'/*.jpg']);
        for k = 1 : length(folder2)
            imageName = folder2(k).name;
            currentImage = rgb2gray(imread([path,'/',imageName]));
            dataMale(n,:) = currentImage(:);
            n = n + 1;
        end
    end
end

