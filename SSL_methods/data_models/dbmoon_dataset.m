% This file was created on: 
% Tue Oct 24 11:38:07 CEST 2017

% Last edited on: 
% Tue Oct 24 11:39:30 CEST 2017

% Usage: data=dbmoon_dataset(N,d,r,w)
% Function to create a double moon dataset

% INPUT:
% N: # of samples each class, default = 1000
% d: seperation of two class, negative value means overlapping (default=1)
% r: radius (default=10) 
% w: width of ring (default=6)

% OUTPUT:
% data: N + N x 2 matrix of data

% AUTHORS: Taken from (C) 2010 by Yu Hen Hu

function data = dbmoon_dataset(N,d,r,w)

% Detect how many parameters were imput so as to set variables by default.
if nargin < 4
	w=6;
elseif nargin < 3
	r=10;
elseif nargin < 2
	d=1;
elseif nargin < 1
	N=1000;
end

% First moon:
% uniformly rnd distributed data points from (-r-w/2, 0) to (r+w/2, r+w/2).
N1 = 10*N;
w2=w/2; 
done=0; 
data=[];
tmp1=[];

while ~done, 
    tmp=[2*(r+w2)*(rand(N1,1)-0.5) (r+w2)*rand(N1,1)];
    tmp(:,3)=sqrt(tmp(:,1).*tmp(:,1)+tmp(:,2).*tmp(:,2)); 
    idx=find([tmp(:,3)>r-w2] & [tmp(:,3)<r+w2]);
    tmp1=[tmp1;tmp(idx,1:2)];
    if length(idx)>= N, 
        done=1;
    end
end

% Second moon:
% Create it by mirroring the first moon. 

data=[tmp1(1:N,:) zeros(N,1);
    [tmp1(1:N,1)+r -tmp1(1:N,2)-d ones(N,1)]];
