% This file was created on: 
% Tue Oct 24 19:20:08 CEST 2017
%
% Last edited on: 
% Tue Oct 24 19:21:31 CEST 2017
%
% Usage: [operator, estimation, classification] = standard_SSL_general(A, sigma, mu, Y, varargin);
% Computes the generalized standard SSL classification that has as particular cases the 
% PageRank, Normalized Laplacian and Standard Laplacian methods.
%
% INPUT: 
% A: Adjacency matrix of the graph where classification is to be performed
% sigma: Parameter to select the classification method 
% ------ (sigma = 0) PageRank;
% ------ (sigma = 0.5) Normalized Laplacian;
% ------ (sigma = 1) Standard Laplacian;
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

function [operator, estimation, classification] = standard_SSL_general(A, sigma, mu, Y, varargin)
% initial value of some variables
method = 'Inverse';
stop_val = 1e-10;

% Compute the necesary matrices
N = size(A,1);
D = diag(sum(A,2)); 
Dsigma1 = sparse(D^(-sigma));
Dsigma2 = sparse(D^(sigma-1));
alpha = 2/(2+mu);    

% Initialize the output matrices
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

% Operator 
if nargin == 3
operator = ((1-alpha)*eye(N)) / (eye(N) - alpha*Dsigma1*A*Dsigma2);
end

% Estimation and Classification Matrices
if nargin > 3
	switch method
		case 'Inverse'
			operator = ((1-alpha)*eye(N)) / (eye(N) - alpha*Dsigma1*A*Dsigma2);
			estimation = operator*Y;
			[~,index] = max(estimation');
			classification = index';
		case 'Iterative'
			rw = Dsigma1*A*Dsigma2;
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
		otherwise
	end
end
