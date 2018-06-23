% This file was created on: 
% Thu Nov  2 14:41:02 CET 2017
%
% Last edited on: 
% Thu Nov  2 14:41:07 CET 2017
%
% Usage: [TP,TN,FP,FN] = accuracy(classification,groundTruth,varargin);
% Function that computes the accuracy of a classifier in terms of the
% elements of a confusion matrix 
%
% INPUT: 
% classification: the classification vector result of SSL
% groundTruth: optimal classification result, it can be a vector with 
% elements 1 and 2, or a subset of the matrix of labeled points to do a 
% type of cross validation evaluation
% 
% OPTIONAL:
% 'Type': the type of groundTruth we posses, either:
%	  'Oracle' which is a vector of classification
%	  'CrossValidation' which is a subset of the matrix of labels
%	   If not specified the DEFAULT is 'Oracle'
%
% OUTPUT:
% TP: True positive (originally class 1, classified class 1)
% TN: True negative (originally class 2, classified class 2)
% FP: False positive (originally class 2, classified class 1)
% FN: False negative (originally class 1, classified class 2)
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [TP,TN,FP,FN] = accuracy(classification,groundTruth,varargin)
measureType = 'Oracle';

for i = 1 : length(varargin)
	var = varargin{i};
	switch var;
		case 'Type'
			measureType = varargin{i+1};
	end
end

switch measureType;
	case 'Oracle';
		oracleClass1 = find(groundTruth == 1);		
		oracleClass2 = find(groundTruth == 2);
	case 'CrossValidation';
		oracleClass1 = find(groundTruth(:,1) == 1);
		oracleClass2 = find(groundTruth(:,2) == 1);	
end

classifClass1 = find(classification == 1);
classifClass2 = find(classification == 2);

% true positive: originally class 1 and classified class 1
% true negative: originally class 2 and classified class 2
% false positive: originally class 2 and classified class 1
% false negative: originally class 1 and classified class 2
TP = numel(intersect(oracleClass1,classifClass1));
TN = numel(intersect(oracleClass2,classifClass2));
FP = numel(intersect(oracleClass2,classifClass1));
FN = numel(intersect(oracleClass1,classifClass2));

end