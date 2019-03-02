function [mu, CI] = confidence_interval(x)
                             
mu = mean(x);                               % Mean value
SEM = std(x)/sqrt(length(x));               % Standard Error
ts = tinv([0.025  0.975],length(x)-1);      % T-Score
CI = mean(x) + ts*SEM;                      % Confidence Intervals
CI = abs(mu-CI(1));