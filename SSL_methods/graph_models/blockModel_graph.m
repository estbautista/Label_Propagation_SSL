% This file was created on: 
% Sat Jun 23 11:56:11 CEST 2018
%
% Last edited on: 
% Sat Jun 23 11:56:17 CEST 2018
%
% Usage: A = blockModel_graph(N,C);
% Function to compute the adjacency matrix of a Stochastic block model of K communities
%
% INPUT: 
% N = [N(1),...,N(K)]: K entries vector denoting the total points of each class 
% C : Symmetric matrix of link probabilties, C(i,j) is the probability of link between class i and j
%
% OUTPUT:
% A: adajcency matrix (sum(N)-by-sum(N))
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function A = blockModel_graph(N,C)

% initialize matrix
A = eye(sum(N));

% size of N and C should be equal 
k = length(N);
if size(C,1) && size(C,2) ~= k
       disp('C and N are incorrect');
       return
end       

% connect nodes of class i connect it to class o
for ki = 1 : length(N)
    for ko = ki : length(N)
	
	% row-column indices where the classes start
	if ki == 1
		init_ki = 1;
	else
		init_ki = sum(N(1:ki - 1)) + 1;
	end
	if ko == 1
		init_ko = 1;
	else
		init_ko = sum(N(1:ko - 1)) + 1;
	end

	% fill the matrix with probabilities given in C
	% we have two cases where Ki = Ko
	if ki == ko
 		for i = init_ki : init_ki + N(ki) - 1
 		    for j = init_ko + i - init_ki : init_ko + N(ko) - 1
 			if rand(1) < C(ki,ko); 
				A(i,j) = 1; A(j,i) = 1;
			end
 		    end
 		end 
 	else
 		for i = init_ki : init_ki + N(ki) - 1
 		    for j = init_ko : init_ko + N(ko) - 1
			    if rand(1) < C(ki,ko); 
				    A(i,j) = 1; A(j,i) = 1; 
			    end
 		    end
 		end 
 	end
    end
end
A = A - diag(diag(A));

