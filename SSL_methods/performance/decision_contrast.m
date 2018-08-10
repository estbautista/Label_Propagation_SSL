% This file was created on: 
% Thu Feb  1 13:45:10 CET 2018
%
% Function to compute the contrast between decision functions in SSL
%  
% INPUT: 
% X:                 2-column matrix with the result of the SSL operator
% N=[N(1),N(2)]:     Length of class 1 and class 2 respectively. 
% 
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function contrast = decision_contrast(X,N)

% Compute the cumulative distributions for the classes
[h,p,ks2statC1] = kstest2(X(1:N(1),1),X(1:N(1),2));
[h,p,ks2statC2] = kstest2(X(N(1)+1:end,1),X(N(1)+1:end,2));
contrast = (ks2statC1 + ks2statC2)/2;
end

