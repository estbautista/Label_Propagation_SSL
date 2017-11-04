% This file was created on: 
% Tue Oct 24 13:21:01 CEST 2017
%
% Last edited on: 
% Tue Oct 24 13:21:22 CEST 2017
%
% Usage: data = dbdisc_dataset(a,b,c,d,N)
% Function to create a double disc dataset
%
% INPUT: 
% N = [N(1),N(2)]: two entries vector giving the total points of each class 
% a: inner radius of first circle
% b: outer radius of first circle
% c: inner radius of second circle
% d: outer radius of second circle
%
% OUTPUT: 
% data: N(1)+N(2) x 2 data matrix. 
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function data = dbdisc_dataset(a,b,c,d,N)

% Disc one: 
% Generate first class disc
r1 = (b-a).*rand(N(1),1) + a;
t1 = 2*pi*rand(N(1),1);
data1 = [r1.*cos(t1),r1.*sin(t1)];

% Disc two: 
r2 = (c-d).*rand(N(2),1) + c;
t2 = 2*pi*rand(N(2),1);
data2 = [r2.*cos(t2),r2.*sin(t2)];

data = [data1;data2];
