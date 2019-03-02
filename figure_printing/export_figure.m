% This file was created on: 
% Tue Nov 27 10:52:26 CET 2018
%
% Scrip to generate the pertinent plots the from the PageRank experiment
% 
% AUTHORS: Paulo Goncalves, Patrice Abry, Esteban Bautista.
% Information: estbautista@ieee.org

function export_figure(fig,fileName,varargin)

if isempty(varargin)
	fig_par.width = 5;
	fig_par.height = 5;
	fig_par.alw = 1;
	fig_par.fsz = 12;
else
	fig_par = varargin{1};
end

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) fig_par.width*100, fig_par.height*100]); %<- Set size
set(gca, 'FontSize', fig_par.fsz, 'LineWidth', fig_par.alw); %<- Set properties
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- fig_par.width)/2;
bottom = (papersize(2)- fig_par.height)/2;
myfiguresize = [left, bottom, fig_par.width, fig_par.height];
set(gcf,'PaperPosition', myfiguresize);
print(fig,fileName,'-dpng','-r300');
