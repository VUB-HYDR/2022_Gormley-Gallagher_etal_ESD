function [s, b] = tsreg(x,y)
% This function is a quick two-dimensional implementation of Theil-Sen
% regression. It ONLY works for two-dimensional case. It was inspired by  Theil亡en estimator
% Arnout Tilgenkamp's Theil_Sen_Regress function from the Matlab File
% Exchange posted in 2011.
%
% The major difference is that Arnout's only calculated a slope (i.e. it
% forces through 0,0) and this implementation calculates both slope and
% intercept.
%
% Inputs:  Vectors x and y which must be the same length and represent the
% x,y pairs of data points to be regressed.
%
% Outputs: s and b, which are the estimates of the slope and the intercept
% 
% Requirements:  This function requires the combnk function from the stats
% toolbox.
%
% Note: there is no error checking. I may someday add it. So for now make
% sure that you pass in your data properly :)
%
% V1.0 by James Harynuk, Department of Chemistry, University of Alberta,
% April 2019.


comb = combnk(1:length(x),2);

s = median(diff(y(comb),1,2)./diff(x(comb),1,2));

b = median(y-s*x);
end



