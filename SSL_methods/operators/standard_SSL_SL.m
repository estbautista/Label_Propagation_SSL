% This file was created on: 
% Tue Oct 24 21:07:50 CEST 2017
%
% Last edited on: 
% Fri Nov  3 18:46:14 CET 2017
%
% Usage: [operator, estimation, classification] = standard_SSL_SL(A, mu, Y, varargin);
% Computes the standard SSL classification for the Standard Laplacian method
%
% INPUT: 
% A: Adjacency matrix of the graph where classification is to be performed
% mu: tradeoff between the smoothness and fitting term
% Y: matrix of labels
% 'Method': method to compute SSL either 'Iterative' or 'Inverse'
% if not specified the. DEFAULT:  method is 'Inverse'
% 'StopValue': if the difference between the new iteration and the previous is less than
% this value we stop the algorithm. DEFAULT: 1e-10
%
% OUTPUT:
% operator: Matrix that models classification and is applied to the labels
% estimation: Matrix result of applying the operator to the labels (soft classification)
% classification: Vector of classes obtained after thresholding the estimation matrix
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function [operator, estimation, classification] = standard_SSL_SL(A, mu, Y, varargin)
% initial value of some variables
method = 'Inverse';
stop_val = 1e-10;

% Compute the necesary matrices
N = size(A,1);
D = diag(sum(A,2)); 
alpha = 2/(2+mu);    


% Estimation and Classification Matrices
operator = 0;
estimation = 0;
classification = 0;

% Verify which options were set for computing the classification
for i = 1 : length(varargin)
	variable = varargin{i};
	switch variable
		case 'Method'
			method = varargin{i+1};
		case 'StopValue'
			stop_val = varargin{i+1};
		otherwise;
	end
end					

% If no labels are provided only return the operator
if nargin == 2
operator = ((1-alpha)*eye(N)) / (eye(N) - alpha*D^(-1)*A);
end

% If the labels are provided perform classification via applying the operator to 
% the labels or via the iterative approach
if nargin > 2  
	switch method
		case 'Inverse'
			operator = ((1-alpha)*eye(N)) / (eye(N) - alpha*D^(-1)*A);
			estimation = operator*Y;
			[~,index] = max(estimation');
			classification = index';
		case 'Iterative'
			rw = D^(-1)*A;
			stopCondition = 0;
			k = 1;
			F_iter{k} = Y;
			while stopCondition == 0
				% Approximate iterative solution to G-SSL
				F_iter{k+1} = alpha*rw*F_iter{k} + (1-alpha)*Y;
			
				% Verify if we have converged to a solution using the
				% Frobenius norm of the difference between two iterations 
				if norm(F_iter{k+1}-F_iter{k},'fro') < stop_val
					stopCondition = 1;
					N_iter = k + 1;
				else
					k = k + 1;
				end
			end
			estimation = F_iter{N_iter};
			[~,index] = max(estimation');
			classification = index';
		otherwise;
	end
end
