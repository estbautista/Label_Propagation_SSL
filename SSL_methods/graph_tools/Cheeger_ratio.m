function [hs] = Cheeger_ratio(Lap,indic)

Deg = diag(diag(Lap));

% volume graph
volG = sum(diag(Deg));

% volume partition
volS = indic'*Deg*indic;

% Cheeger ratio
hs = (indic'*Lap*indic)/min(volS, volG - volS);

