% This file was created on: 
% Sat Jun 23 11:36:34 CEST 2018
%
% Last edited on: 
% Sat Jun 23 11:36:48 CEST 2018
%
% Usage: [train_images, train_labels, test_images, test_labels] = mnist_data( path )
% Function to read the MNIST dataset
%
% INPUT: 
% path : The path where the 4 data files are 
%
% OUTPUT: 
% train_images: Images for training
% train_labels: Labels asociated to the training images
% test_images: Images for testing 
% test_labels: Labels asociated to the test images
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [train_images,train_labels,test_images,test_labels] = mnist_data(path)

% Read the file for training images 
fileID = fopen([path,'/train-images.idx3-ubyte']);
train_images = fread(fileID);

numDim = train_images(4);
numRows = 0;
for i = 0 : 3;
    numRows = numRows + train_images(8-i)*2^(8*i);
end

k = numDim - 1;
tmpCols = zeros(k,1);
for j = 1 : k
    jend = 8 + 4*j;
    for i = 0 : 3;
        tmpCols(j) = tmpCols(j) + train_images(jend - i)*2^(8*i);
    end
end
numCols = prod(tmpCols);

train_images = train_images(8 + 4*k + 1 : end);
train_images = reshape(train_images,[numCols,numRows])';

% Read the file for training labels 
fileID = fopen([path,'/train-labels.idx1-ubyte']);
train_labels = fread(fileID);

numDim = train_labels(4);
numRows = 0;
for i = 0 : 3;
    numRows = numRows + train_labels(8-i)*2^(8*i);
end

k = numDim - 1;
tmpCols = zeros(k,1);
for j = 1 : k
    jend = 8 + 4*j;
    for i = 0 : 3;
        tmpCols(j) = tmpCols(j) + train_labels(jend - i)*2^(8*i);
    end
end
numCols = prod(tmpCols);

train_labels = train_labels(8 + 4*k + 1 : end);
train_labels = reshape(train_labels,[numCols,numRows])';
 
% Read the file for training labels 
fileID = fopen([path,'/t10k-images.idx3-ubyte']);
test_images = fread(fileID);

numDim = test_images(4);

numRows = 0;
for i = 0 : 3;
    numRows = numRows + test_images(8-i)*2^(8*i);
end

k = numDim - 1;
tmpCols = zeros(k,1);
for j = 1 : k
    jend = 8 + 4*j;
    for i = 0 : 3;
        tmpCols(j) = tmpCols(j) + test_images(jend - i)*2^(8*i);
    end
end
numCols = prod(tmpCols);

test_images = test_images(8 + 4*k + 1 : end);
test_images = reshape(test_images,[numCols,numRows])';

% Read the file for training labels 
fileID = fopen([path, '/t10k-labels.idx1-ubyte']);
test_labels = fread(fileID);

numDim = test_labels(4);

numRows = 0;
for i = 0 : 3;
    numRows = numRows + test_labels(8-i)*2^(8*i);
end

k = numDim - 1;
tmpCols = zeros(k,1);
for j = 1 : k
    jend = 8 + 4*j;
    for i = 0 : 3;
        tmpCols(j) = tmpCols(j) + test_labels(jend - i)*2^(8*i);
    end
end
numCols = prod(tmpCols);

test_labels = test_labels(8 + 4*k + 1 : end);
test_labels = reshape(test_labels,[numCols,numRows])';
