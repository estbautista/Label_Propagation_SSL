%  This file was created on: 
%  Tue Oct 31 16:43:50 CET 2017
% 
%  Last edited on: 
%  Tue Oct 31 16:44:05 CET 2017
% 
%  Usage: print_histogram(fileName,figureName,varName,varargin)
%  Function to plot an histogram of the varName data column stored
%  in fileName
%
%  INPUT: 
%  fileName: file where data is contained as columns with a header 
%  figureName: path and name of the resulting figure 
%  varName: header name of the column intended to be analysed
%
%  OPTIONAL:
%
%  'DelimeterType':	'\t' for tab sepparated data
%			' ' for space separated data
%			',' for comma separated data
% 
%  'HeaderLines':	lines used for header. DEFAULT: 1
%
%  'Width':	Figure width. DEFAULT: 5
%  'Height':	Figure height. DEFAULT: 5
%  'AxesLineWidth': 	Width of axes lines. DEFAULT: 2
%  'FontSize':	Font Size. DEFAULT: 12
%  'LineWidth': Plot lines width. DEFAULT: 2
%  'MarkerSize':	Marker Size. DEFAULT: 3 %
%
%  'Title':	Figure title. DEFAULT: no title
%  'xlabel': 	X axis label. DEFAULT: no label
%  'ylabel':	Y axis label. DEFAULT: no label
%  
%  Bins: 	Number of histogram bins
%  Legend: 	No option after this argument. If it is not written
%		no legend will be displayed
%
%  OUTPUT: 
%  saves a figure in the path given by figureName
% 
%  AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
%  Information: estbautista@ieee.org

function print_histogram(fileName,figureName,varName,varargin)

% Initialize values
Bins_opt = 'auto';
delimeterType = '\t';
headerLines = 1; 
width = 5;
height = 5;
alw = 2;
fsz = 12;
lw = 2;
msz = 3;

% extract useful information for reading the file
for i = 1 : length(varargin)
	variable = varargin{i};
	switch variable
		case 'DelimeterType'
			delimeterType = varargin{i+1};
		case 'HeaderLines'
			headerLines = varargin{i+1};
		otherwise;
	end
end

% read data from file
data = importdata(fileName,delimeterType,headerLines);

% extract information for plotting
for i = 1 : length(varargin)
	variable = varargin{i};
	switch variable
		case 'Width'
			width = varargin{i+1};
		case 'Height'
			height = varargin{i+1};
		case 'AxesLineWidth'
			alw = varargin{i+1};
		case 'FontSize'
			fsz = varargin{i+1};
		case 'LineWidth'
			lw = varargin{i+1};
		case 'MarkerSize'
			msz = varargin{i+1};
		case 'Bins'
			nbins = varargin{i+1};
			Bins_opt = 'manual';
		otherwise;
	end
end					

% plot the histogram
var_labels = data.textdata(1,:);
num_figs = size(data.data,2);
init_fig = length(var_labels) - num_figs + 1;
index_figs = ismember(var_labels,varName);
fig = figure('visible','off');
h = histogram(data.data(:,index_figs(init_fig:end)));	
while strcmp('manual',Bins_opt)
	h.NumBins = nbins;
	Bins_opt = 'off';
end	

% extract information for plot labeling
for i = 1 : length(varargin)
	variable = varargin{i};
	switch variable
		case 'Title'
			title(varargin{i+1});
		case 'xlabel'
			xlabel(varargin{i+1});
		case 'ylabel'
			ylabel(varargin{i+1});
		case 'Legend'
			legend(varName);
	end
end

% store the figure in figureName
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
set(gcf,'InvertHardcopy','on');

set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

print(fig,figureName,'-dpng','-r300');
end

