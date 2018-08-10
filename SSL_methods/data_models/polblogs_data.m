% This file was created on: 
% Thu Aug  9 21:39:03 CDT 2018
%
% Last edited on: 
% Thu Aug  9 21:39:12 CDT 2018
%
% Usage: [W, groundTruth = polblogs_data( path )
% Function to read the Polblogs dataset
%
% INPUT: 
% path : The path to the GML file with the data
%
% OUTPUT: 
% W	: Adjacency matrix
% groundTruth: Class labels for every node
%
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org
function [W,groundTruth] = polblogs_data(path)

%% extract the links
inputfile = fopen([path,'/polblogs.gml']);
A=[];
l=0;
k=1;
while 1
      % Get a line from the input file
      tline = fgetl(inputfile);
      % Quit if end of file
      if ~ischar(tline)
          break
      end
      source = regexp(tline,'source \d+','match');
      target = regexp(tline,'target \d+','match');
      if length(source)
          val = regexp(source,'\d+','match');
          A(k,1)=str2num(char(val{1}));  
      elseif length(target)
          val = regexp(target,'\d+','match');
          A(k,2)=str2num(char(val{1}));
          k = k + 1;
      else
          continue;
      end
end
fclose(inputfile);
%% Create adjacency matrix  
N = max(max(A));

groundTruth = zeros(N,1);
groundTruth(1:758) = 1; groundTruth(759:end) = 2;

W = zeros(N);
for i = 1 : size(A,1)
    W(A(i,1),A(i,2)) = 1;
    W(A(i,2),A(i,1)) = 1;
end
