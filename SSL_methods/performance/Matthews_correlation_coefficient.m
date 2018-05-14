% This file was created on: 
% Sat May 12 17:43:54 CEST 2018
%
% Last edited on: 
% Sat May 12 17:44:07 CEST 2018
%
% Usage: 
% Function to compute the Matthews Correlation Coefficient 
% to assess the performance of imbalanced classifiers
%
% INPUT: TP: True Positive Examples
% 	 TN: True negative Examples
%	 FN: False Negative Examples
%	 FP: False Positive Examples
%	 
%
% OUTPUT: MCC: Matthews correlation coefficient 
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function MCC = Matthews_correlation_coefficient(TP,TN,FP,FN)
	num = (TP*TN - FP*FN);
	den = sqrt((TP + FP)*(TP + FN)*(TN + FP)*(TN + FN));
	if den == 0
		MCC = 0;
	else
		MCC = num/den;
	end
end
