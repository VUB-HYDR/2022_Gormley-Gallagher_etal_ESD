
% --------------------------------------------------------------------
% main script to postprocess and visualise CESM output: CTL and IRR
% --------------------------------------------------------------------


tic


% clean up
clc;
clear;
close all;
clearvars;

% flags
flags.loadlinear           = 0; % 0: do not load data using linear regression method
                                % 1: load data using linear regression
flags.loadsens             = 1; % 0: do not load data using sen's slope method
                                % 1: load data using sen's slope method
flags.loadCA               = 0; % 0: do not load CA data using linear regression method
                                % 1: load CA data using linear regression method
flags.loadCAsens           = 0; % 0: do not load CA data using sens slope method
                                % 1: load CA data using sens slope method                                
flags.eval                 = 0; % 0: do not evaluate model
                                % 1: evaluate model
flags.evalthesis           = 0; % 0: do not evaluate model
                                % 1: evaluate model  
flags.evalpriorfieldmean   = 0; % 0: do not evaluate model
                                % 1: evaluate model   
flags.evalpriorfieldmeanCA = 0; % 0: do not evaluate model
                                % 1: evaluate model                              
flags.stat                 = 0; % 0: do not compute statistical significance of change
                                % 1: compute statistical significance of change
flags.STCD                 = 0; % 0: do not decompose the Surface Temperature change
                                % 1: decompose the Surface Temperature change
flags.perc                 = 0; % 0: do not compute percentile changes
                                % 1: compute percentile changes
flags.offli                = 0; % 0: do not process offline simulations
                                % 1: process offline simulations
flags.valp                 = 0; % 0: do not compute values used in the paper
                                % 1: compute values used in the paper
flags.plot                 = 1; % 0: do not plot
                                % 1: plot
flags.plotCA               = 0; % 0: do not plot CA
                                % 1: plot
flags.local                = 0; % 0: do not compute local effect
                                % 1: compute local effect
flags.localthesis          = 0; % 0: no local effects computation
                                % 1: compute local effect                               


% --------------------------------------------------------------------
% initialisation
% --------------------------------------------------------------------


% declare globals
global island                                                              %#ok<NUSED>


% add matlab scripts directory to path
addpath(genpath('C:Users\e200157\Documents\CESM_new'));

% add directory containing nc files to path
addpath(genpath('C:\Users\e200157\Documents\CESM_new\ncfiles'));

% initialise model parameters
nens        = 5;   % number of ensemble members


% initialise time parameters - CESM
time_begin  = [1981, 1, 1, 0,0,0];
time_end    = [2010,12,31,23,0,0];
years       = (time_begin(1):time_end(1))';
nyears      = length(years);

% initialise time parameters - analysis based on Donat
time_begin2  = [1951, 1, 1, 0,0,0];
years2       = (time_begin2(1):time_end(1))';
nyears2      = length(years);

% initialise physical constants
[Lvap, rhow, a_earth] = mf_inicon('Lvap', 'rhow', 'a_earth');


% initialise srex variable/unit/region names - TSA                           
srex_vars    = {'QIRRIG'  , 'TSA'  , 'Qle'    , 'FSH'    , 'FSA'     , 'FIRA'    , 'PRECT'        , 'QRUNOFF'       }; % srex variables considered in this study ...
srex_ylabels = {'Q_i_r_r' , 'T_2_m', 'LHF'    , 'SHF'    , 'SW_n_e_t', 'LW_n_e_t', 'Precipitation', 'Q_R_U_N_O_F_F' }; % ... their y-axis label,
srex_units   = {'mm d^-^1', 'K'    , 'W m^-^1', 'W m^-^1', 'W m^-^1' , 'W m^-^1' , 'mm d^-^1'     , 'mm d^-^1'      }; % ... their units,
srex_block   = {'lnd'     , 'lnd'  , 'lnd'    , 'lnd'    , 'lnd'     , 'lnd'     , 'atm'          , 'lnd'           }; % ... and whether it's a land or atmospheric variable
srex_reg     = {'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS'}; %for IRR                                                     % srex regions considered in this study
%srex_reg     = {'WNA', 'CNA', 'MED','CEU','SSA', 'SAU'}; %for CA

%in for srex_ctl i=1:length(srex_vars), the 8 x7x5 is variables by regions
%so srex_ctl loads tempt/SHF etc average at regions, squeezed into 1D
%so use slope instead

% initialise observational product names   
%prod_names = {'Qirr census', 'LHF LandFlux', 'LHF GLEAM', 'SWnet SRB', 'LWnet SRB', 'T2m CRU', ' Precipitation CRU', ' Precipitation GPCP', 'TXx GHCNDEX', 'TXx HadEx2', 'TNn GHCNDEX', 'TNn HadEx2'};
prod_names = {'T2m CRU', 'TXx GHCNDEX', 'TXx HadEx2'};


% --------------------------------------------------------------------
% load data using linear regression
% --------------------------------------------------------------------

if flags.loadlinear == 1 
   ms_load;
end


% --------------------------------------------------------------------
% load data using Sen's slope regression
% --------------------------------------------------------------------

if flags.loadsens == 1 
   ms_loadsens2;
end


% --------------------------------------------------------------------
% load CA data using linear regression
% --------------------------------------------------------------------

if flags.loadCA == 1 
   ms_loadCA;
end


% --------------------------------------------------------------------
% load CA data using SENS SLOPE
% --------------------------------------------------------------------

if flags.loadCAsens == 1 
   ms_loadCAsens;
end


% --------------------------------------------------------------------
% manipulations: general
% --------------------------------------------------------------------

ms_manip


% --------------------------------------------------------------------
% CA mask
% --------------------------------------------------------------------

ca_mask_cesm

% --------------------------------------------------------------------
% Model evaluation
% --------------------------------------------------------------------


if flags.eval == 1   
   ms_evaluation;
end


% --------------------------------------------------------------------
% Model evaluation for thesis-specific
% --------------------------------------------------------------------


if flags.evalthesis == 1   
   ms_evalthesis;
end


% --------------------------------------------------------------------
% Model evaluation for thesis - using fieldmean without 'area' spatialing
% --------------------------------------------------------------------


if flags.evalpriorfieldmean == 1   
   ms_eval_priorfieldmean;
end


% --------------------------------------------------------------------
% Model evaluation for thesis - using fieldmean without 'area' spatialing
% CA
% --------------------------------------------------------------------


if flags.evalpriorfieldmeanCA == 1   
   ms_eval_priorfieldmeanCA;
end


% --------------------------------------------------------------------
% Statistical significance
% --------------------------------------------------------------------


if flags.stat == 1   
   ms_statsign;
end



% --------------------------------------------------------------------
% Surface Energy Balance decomposition
% --------------------------------------------------------------------


if flags.STCD == 1
   ms_STCdecomp
end



% --------------------------------------------------------------------
% Percentile change
% --------------------------------------------------------------------


if flags.perc == 1
   ms_perc
end


% --------------------------------------------------------------------
% get values used in the paper
% --------------------------------------------------------------------


if flags.valp == 1
   ms_valp
end



% --------------------------------------------------------------------
% visualise output
% --------------------------------------------------------------------


if flags.plot == 1
   ms_plotscriptTHESIS
end


if flags.plotCA == 1
   ms_plotscriptTHESISCA
end




% --------------------------------------------------------------------
% local effects
% --------------------------------------------------------------------

if flags.local == 1
   ms_local
end


if flags.localthesis == 1
   ms_localthesis
end



toc
