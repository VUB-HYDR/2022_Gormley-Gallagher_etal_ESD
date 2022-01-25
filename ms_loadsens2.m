% --------------------------------------------------------------------
% subroutine to load the variables
% note: preferably run "main"
% --------------------------------------------------------------------


% --------------------------------------------------------------------
% Load observational data
% --------------------------------------------------------------------

% only needed if evaluation is performed
if flags.eval == 1

% load CRU data
[~, ~, T2M_cru   , PRECT_cru   ] = mf_load('CRU_1981-2010_timmean.nc' , 'T2M', 'Prec');
[~, ~, T2M_cru_mm, PRECT_cru_mm] = mf_load('CRU_1981-2010_ymonmean.nc', 'T2M', 'Prec');

% load ERA-interim/Land data
[~, ~, ET_eral   , QRUNOFF_eral   ] = mf_load('ERAL_1981-2010_timmean.nc' , 'ET', 'RUNOFF');
[~, ~, ET_eral_mm, QRUNOFF_eral_mm] = mf_load('ERAL_1981-2010_ymonmean.nc', 'ET', 'RUNOFF');

% load FLUXNET-MTE data
[~, ~, LHF_mte_8210   , SHF_mte_8210   ] = mf_load('MTE_1982-2010_timmean.nc' , 'LHF', 'SHF');
[~, ~, LHF_mte_8210_mm, SHF_mte_8210_mm] = mf_load('MTE_1982-2010_ymonmean.nc', 'LHF', 'SHF');

% load GHCNDEX data
[~, ~, TXx_ghcn   , TNn_ghcn   ] = mf_load('GHCNDEX_1981-2010_timmean.nc' , 'TXx', 'TNn');
[~, ~, TXx_ghcn_mm, TNn_ghcn_mm] = mf_load('GHCNDEX_1981-2010_ymonmean.nc', 'TXx', 'TNn');

% load GPCP data
[~, ~, PRECT_gpcp   ] = mf_load('GPCP_1981-2010_timmean.nc' , 'Prec');
[~, ~, PRECT_gpcp_mm] = mf_load('GPCP_1981-2010_ymonmean.nc', 'Prec');

% load HadEx2 data
[~, ~, TXx_had   , TNn_had   ] = mf_load('HadEX2_1981-2010_timmean.nc' , 'TXx', 'TNn');
[~, ~, TXx_had_mm, TNn_had_mm] = mf_load('HadEX2_1981-2010_ymonmean.nc', 'TXx', 'TNn');

% load irrigation amount data
[~, ~, QIRR_obs]       = mf_load('IRAM_2000.nc', 'QIRRIG');
QIRR_obs(QIRR_obs < 0) = 0; % remove unphysical values

% load LandFlux-EVAL data
[~, ~, ET_lfev_8905   ] = mf_load('LFEV_1989-2005_timmean.nc' , 'ET_mean');
[~, ~, ET_lfev_8905_mm] = mf_load('LFEV_1989-2005_ymonmean.nc', 'ET_mean');

% load GLEAM data
[~, ~, ET_glea   ] = mf_load('GLEAM_1981-2010_timmean.nc' , 'ET_mean');
[~, ~, ET_glea_mm] = mf_load('GLEAM_1981-2010_ymonmean.nc', 'ET_mean');

% load GEWEX-SRB data
[~, ~, SWnet_srb_8407   , LWnet_srb_8407   ] = mf_load('SRB_1984-2007_timmean.nc' , 'SWnet', 'LWnet');
[~, ~, SWnet_srb_8407_mm, LWnet_srb_8407_mm] = mf_load('SRB_1984-2007_ymonmean.nc', 'SWnet', 'LWnet');


end

% --------------------------------------------------------------------
% Load CESM model data
% --------------------------------------------------------------------
% load 2D model constants (pct_irr = percent of grid cell that is irrigated, see mksrfdat.F90)
[lat_mod, lon_mod, pct_irr, pct_land, area] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.001_constants.nc', 'PCT_IRRIG', 'landfrac', 'AREA');
% load 2D model atm variables
[~, ~, TS_ctl, TXx_ctl, TNn_ctl, PRECT_ctl, CDD_ctl, HWDI_ctl, WSDI_ctl, PSL_ctl] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_atm_h1_timmean.nc'   , 'TS', 'TXx', 'TNn', 'PRECT', 'CDD', 'HWDI', 'WSDI', 'PSL');
[~, ~, TS_irr, TXx_irr, TNn_irr, PRECT_irr, CDD_irr, HWDI_irr, WSDI_irr, PSL_irr] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_atm_h1_timmean.nc', 'TS', 'TXx', 'TNn', 'PRECT', 'CDD', 'HWDI', 'WSDI', 'PSL');
% load 2D model lnd variables
[~, ~, Rx1day_ctl, Rx5day_ctl, QIRR_ctl, QRUNOFF_ctl, ET_ctl, T2M_ctl, TV_ctl, LHF_ctl, SHF_ctl] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_timmean.nc'   , 'Rx1day', 'Rx5day', 'QIRRIG', 'QRUNOFF', 'ET', 'TSA', 'TV', 'Qle', 'FSH');
[~, ~, Rx1day_irr, Rx5day_irr, QIRR_irr, QRUNOFF_irr, ET_irr, T2M_irr, TV_irr, LHF_irr, SHF_irr] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_timmean.nc', 'Rx1day', 'Rx5day', 'QIRRIG', 'QRUNOFF', 'ET', 'TSA', 'TV', 'Qle', 'FSH');
% load 2D model lnd variables
[~, ~, Rx1day_ctl, Rx5day_ctl, QIRR_ctl, QRUNOFF_ctl, ET_ctl, T2M_ctl, TV_ctl, LHF_ctl, SHF_ctl] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_timmean.nc'   , 'Rx1day', 'Rx5day', 'QIRRIG', 'QRUNOFF', 'ET', 'TSA', 'TV', 'Qle', 'FSH');
[~, ~, Rx1day_irr, Rx5day_irr, QIRR_irr, QRUNOFF_irr, ET_irr, T2M_irr, TV_irr, LHF_irr, SHF_irr] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_timmean.nc', 'Rx1day', 'Rx5day', 'QIRRIG', 'QRUNOFF', 'ET', 'TSA', 'TV', 'Qle', 'FSH');


% --------------------------------------------------------------------
% LOAD REGRESSION DATA - CONTROL - TXx
% --------------------------------------------------------------------

% load 2D model atm variables - CONTROL  
    % load member 1_control
[~, ~, TXx_ctl_m1, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.001_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_ctl_m1=permute(TXx_ctl_m1,[2,1,3]); %288x192
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m1ctl = zeros(M, N);
intercept_TXx_m1ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N   
        % Get all time instances of each lat/lon location
        y = squeeze(TXx_ctl_m1(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m1ctl(i, j) = ss(ind(med_ind));
        intercept_TXx_m1ctl(i, j) = ints(ind(med_ind));
    end
end
slope_TXx_m1ctl=permute(slope_TXx_m1ctl,[2,1,3]);
slope_TXx_m1ctl(~island)=NaN;



    % load member 2_control
[~, ~, TXx_ctl_m2, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.002_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_ctl_m2=permute(TXx_ctl_m2,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m2ctl = zeros(M, N);
intercept_TXx_m2ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
                % Get all time instances of each lat/lon location
        y = squeeze(TXx_ctl_m2(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m2ctl(i, j) = ss(ind(med_ind));
        intercept_TXx_m2ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m2ctl(~island')=NaN;
slope_TXx_m2ctl=permute(slope_TXx_m2ctl,[2,1,3]);
slope_TXx_m2ctl(~island)=NaN;

    % load member 3_control
[~, ~, TXx_ctl_m3, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.003_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_ctl_m3=permute(TXx_ctl_m3,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m3ctl = zeros(M, N);
intercept_TXx_m3ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
                        % Get all time instances of each lat/lon location
        y = squeeze(TXx_ctl_m3(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m3ctl(i, j) = ss(ind(med_ind));
        intercept_TXx_m3ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m3ctl(~island')=NaN;
slope_TXx_m3ctl=permute(slope_TXx_m3ctl,[2,1,3]);
slope_TXx_m3ctl(~island)=NaN;


    % load member 4_control
[~, ~, TXx_ctl_m4, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.004_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_ctl_m4=permute(TXx_ctl_m4,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m4ctl = zeros(M, N);
intercept_TXx_m4ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
                            % Get all time instances of each lat/lon location
        y = squeeze(TXx_ctl_m4(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m4ctl(i, j) = ss(ind(med_ind));
        intercept_TXx_m4ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m4ctl(~island')=NaN;
slope_TXx_m4ctl=permute(slope_TXx_m4ctl,[2,1,3]);
slope_TXx_m4ctl(~island)=NaN;

    % load member 5_control
[~, ~, TXx_ctl_m5, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.005_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_ctl_m5=permute(TXx_ctl_m5,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m5ctl = zeros(M, N);
intercept_TXx_m5ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TXx_ctl_m5(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m5ctl(i, j) = ss(ind(med_ind));
        intercept_TXx_m5ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m5ctl(~island')=NaN;
slope_TXx_m5ctl=permute(slope_TXx_m5ctl,[2,1,3]);
slope_TXx_m5ctl(~island)=NaN;

% load 2D model mean ensemble atm CONTROL for regression
sum_txx_ctl_slope=(slope_TXx_m1ctl + slope_TXx_m2ctl + slope_TXx_m3ctl + slope_TXx_m4ctl + slope_TXx_m5ctl); 
%mean_slope_txx_ctl=(sum_txx_ctl_slope/5);

%using ensemble file -same trend as mean above
[~, ~, TXx_ctl_ensmean, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_atm_h1_yearmean.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_ctl_ensmean=permute(TXx_ctl_ensmean,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_txx_ctl = zeros(M, N);
mean_intercept_txx_ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_txx_ctl = zeros(M, N);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TXx_ctl_ensmean(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_txx_ctl(i, j) = ss(ind(med_ind));
        mean_intercept_txx_ctl(i, j) = ints(ind(med_ind));
        
  
    end
end
%mean_slope_txx_ctl(~island')=NaN;
mean_slope_txx_ctl=permute(mean_slope_txx_ctl,[2,1,3]);
mean_slope_txx_ctl(~island)=NaN;
p_values_txx_ctl=permute(p_values_txx_ctl,[2,1,3]);
p_values_txx_ctl(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_txx_ctl, p_values_txx_ctl, caxes.ddTXx, colormaps.ddTXx, 0, 2, '', '1981-2010, CTL Mean', '\delta TXx /\delta t [K yr^-^1]'); hold on;
%need stat test for comparing 2 variables rather than this for absolute
%values 
%H=permute(H,[2,1,3]);
%H(~island)=NaN;
%mf_plot_dom2(lon_mod, lat_mod, mean_slope_txx_ctl, H, caxes.ddTXx, colormaps.ddTXx, 0, 2, '', '1981-2010, CTL Mean', '\delta TXx /\delta t [K yr^-^1]'); hold on;



% --------------------------------------------------------------------
% LOAD REGRESSION DATA - IRRIGATION - TXx
% --------------------------------------------------------------------

    % load member 1_irrigation
[~, ~, TXx_irr_m1, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.001_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_irr_m1=permute(TXx_irr_m1,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m1irr = zeros(M, N);
intercept_TXx_m1irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TXx_irr_m1(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m1irr(i, j) = ss(ind(med_ind));
        intercept_TXx_m1irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m1irr(~island')=NaN;
slope_TXx_m1irr=permute(slope_TXx_m1irr,[2,1,3]);
slope_TXx_m1irr(~island)=NaN;

    % load member 2_irrigation
[~, ~, TXx_irr_m2, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.002_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_irr_m2=permute(TXx_irr_m2,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m2irr = zeros(M, N);
intercept_TXx_m2irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
       % Get all time instances of each lat/lon location
        y = squeeze(TXx_irr_m2(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m2irr(i, j) = ss(ind(med_ind));
        intercept_TXx_m2irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m2irr(~island')=NaN;
slope_TXx_m2irr=permute(slope_TXx_m2irr,[2,1,3]);
slope_TXx_m2irr(~island)=NaN;

    % load member 3_irr
[~, ~, TXx_irr_m3, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.003_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_irr_m3=permute(TXx_irr_m3,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m3irr = zeros(M, N);
intercept_TXx_m3irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TXx_irr_m3(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m3irr(i, j) = ss(ind(med_ind));
        intercept_TXx_m3irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m3irr(~island')=NaN;
slope_TXx_m3irr=permute(slope_TXx_m3irr,[2,1,3]);
slope_TXx_m3irr(~island)=NaN;

    % load member 4_irr
[~, ~, TXx_irr_m4, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.004_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_irr_m4=permute(TXx_irr_m4,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m4irr = zeros(M, N);
intercept_TXx_m4irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TXx_irr_m4(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m4irr(i, j) = ss(ind(med_ind));
        intercept_TXx_m4irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m4irr(~island')=NaN;
slope_TXx_m4irr=permute(slope_TXx_m4irr,[2,1,3]);
slope_TXx_m4irr(~island)=NaN;

    % load member 5_irr
[~, ~, TXx_irr_m5, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.005_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_irr_m5=permute(TXx_irr_m5,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_m5irr = zeros(M, N);
intercept_TXx_m5irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TXx_irr_m5(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_m5irr(i, j) = ss(ind(med_ind));
        intercept_TXx_m5irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TXx_m5irr(~island')=NaN;
slope_TXx_m5irr=permute(slope_TXx_m5irr,[2,1,3]);
slope_TXx_m5irr(~island)=NaN;

% load 2D model mean ensemble atm IRRIGATION for regression
sum_txx_irr_slope=(slope_TXx_m1irr + slope_TXx_m2irr + slope_TXx_m3irr + slope_TXx_m4irr + slope_TXx_m5irr); 
%mean_slope_txx_irr=(sum_txx_irr_slope/5);

%using ensemble file -same trend as mean above
[~, ~, TXx_irr_ensmean, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_atm_h1_yearmean.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
TXx_irr_ensmean=permute(TXx_irr_ensmean,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_txx_irr = zeros(M, N);
mean_intercept_txx_irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_txxirr = zeros(M, N);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TXx_irr_ensmean(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_txx_irr(i, j) = ss(ind(med_ind));
        mean_intercept_txx_irr(i, j) = ints(ind(med_ind));
   
    end
end
%mean_slope_txx_irr(~island')=NaN;
mean_slope_txx_irr=permute(mean_slope_txx_irr,[2,1,3]);
mean_slope_txx_irr(~island)=NaN;
mean_slope_txx_irr(isempty(mean_slope_txx_irr)) = NaN;
p_values_txxirr=permute(p_values_txxirr,[2,1,3]);
p_values_txxirr(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_txx_irr, p_values_txxirr, caxes.ddTXx, colormaps.ddTXx, 0, 2, '', '1981-2010, IRR Mean', '\delta TXx /\delta t [K yr^-^1]'); hold on;




% --------------------------------------------------------------------
% LOAD REGRESSION DATA - CONTROL - T2m
% --------------------------------------------------------------------

% load 2D model atm variables for regression
    % load member 1_control
[~, ~, T2M_ctl_m1, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.001_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_ctl_m1=permute(T2M_ctl_m1,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m1ctl = zeros(M, N);
intercept_T2M_m1ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_ctl_m1(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m1ctl(i, j) = ss(ind(med_ind));
        intercept_T2M_m1ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m1ctl(~island')=NaN;
slope_T2M_m1ctl=permute(slope_T2M_m1ctl,[2,1,3]);
slope_T2M_m1ctl(~island)=NaN;

    % load member 2_control
[~, ~, T2M_ctl_m2, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.002_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_ctl_m2=permute(T2M_ctl_m2,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m2ctl = zeros(M, N);
intercept_T2M_m2ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(T2M_ctl_m2(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m2ctl(i, j) = ss(ind(med_ind));
        intercept_T2M_m2ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m2ctl(~island')=NaN;
slope_T2M_m2ctl=permute(slope_T2M_m2ctl,[2,1,3]);
slope_T2M_m2ctl(~island)=NaN;

    % load member 3_control
[~, ~, T2M_ctl_m3, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.003_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_ctl_m3=permute(T2M_ctl_m3,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m3ctl = zeros(M, N);
intercept_T2M_m3ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_ctl_m3(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m3ctl(i, j) = ss(ind(med_ind));
        intercept_T2M_m3ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m3ctl(~island')=NaN;
slope_T2M_m3ctl=permute(slope_T2M_m3ctl,[2,1,3]);
slope_T2M_m3ctl(~island)=NaN;

    % load member 4_control
[~, ~, T2M_ctl_m4, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.004_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_ctl_m4=permute(T2M_ctl_m4,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m4ctl = zeros(M, N);
intercept_T2M_m4ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_ctl_m4(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m4ctl(i, j) = ss(ind(med_ind));
        intercept_T2M_m4ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m4ctl(~island')=NaN;
slope_T2M_m4ctl=permute(slope_T2M_m4ctl,[2,1,3]);
slope_T2M_m4ctl(~island)=NaN;

    % load member 5_control
[~, ~, T2M_ctl_m5, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.005_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_ctl_m5=permute(T2M_ctl_m5,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m5ctl = zeros(M, N);
intercept_T2M_m5ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
        % Get all time instances of each lat/lon location
        y = squeeze(T2M_ctl_m5(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m5ctl(i, j) = ss(ind(med_ind));
        intercept_T2M_m5ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m5ctl(~island')=NaN;
slope_T2M_m5ctl=permute(slope_T2M_m5ctl,[2,1,3]);
slope_T2M_m5ctl(~island)=NaN;

% load 2D model mean ensemble lnd CONTROL for regression
sum_t2m_ctl_slope=(slope_T2M_m1ctl + slope_T2M_m2ctl + slope_T2M_m3ctl + slope_T2M_m4ctl + slope_T2M_m5ctl); 
%mean_slope_t2m_ctl=(sum_t2m_ctl_slope/5);



%using ensemble file -same trend as mean above
[~, ~, T2M_ctl_ensmean, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_yearmean.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_ctl_ensmean(isempty(T2M_ctl_ensmean)) = NaN;
T2M_ctl_ensmean=permute(T2M_ctl_ensmean,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_t2m_ctl = zeros(M, N);
mean_intercept_t2m_ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.01; % Level of significance
alpha = alpha0/2; %
p_values_t2mctl = zeros(M, N);
for i = 1 : M
    for j = 1 : N
        % Get all time instances of each lat/lon location
        y = squeeze(T2M_ctl_ensmean(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_t2m_ctl(i, j) = ss(ind(med_ind));
        mean_intercept_t2m_ctl(i, j) = ints(ind(med_ind));        

    end
end
%mean_slope_t2m_ctl(~island')=NaN;
mean_slope_t2m_ctl=permute(mean_slope_t2m_ctl,[2,1,3]);
mean_slope_t2m_ctl(~island)=NaN;
mean_slope_t2m_ctl(isempty(mean_slope_t2m_ctl)) = NaN;
p_values_t2mctl=permute(p_values_t2mctl,[2,1,3]);
p_values_t2mctl(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_t2m_ctl, p_values_t2mctl,caxes.ddT2M, colormaps.ddT2M, 0, 2, '', '1981-2010, CTL Mean', '\delta T_2_m /\delta t [K yr^-^1]'); hold on;


%H=permute(H,[2,1,3]);

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_t2m_ctl, H,caxes.ddT2M, colormaps.ddT2M, 0, 2, '', '1981-2010, CTL Mean', '\delta T_2_m /\delta t [K yr^-^1]'); hold on;

%H = 0 indicates insignificant, 1 is signif
%%% a failure to reject the null hypothesis at the alpha significance level.
%then do statsign on differences with wilcox, using sums not ensmean 

% --------------------------------------------------------------------
% LOAD REGRESSION DATA - IRRIGATION - T2m
% --------------------------------------------------------------------

% load member 1_irr
[~, ~, T2M_irr_m1, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.001_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_irr_m1=permute(T2M_irr_m1,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m1irr = zeros(M, N);
intercept_T2M_m1irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(T2M_irr_m1(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m1irr(i, j) = ss(ind(med_ind));
        intercept_T2M_m1irr(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m1irr(~island')=NaN;
slope_T2M_m1irr=permute(slope_T2M_m1irr,[2,1,3]);
slope_T2M_m1irr(~island)=NaN;

    % load member 2_irr
[~, ~, T2M_irr_m2, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.002_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_irr_m2=permute(T2M_irr_m2,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m2irr = zeros(M, N);
intercept_T2M_m2irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_irr_m2(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m2irr(i, j) = ss(ind(med_ind));
        intercept_T2M_m2irr(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m2irr(~island')=NaN;
slope_T2M_m2irr=permute(slope_T2M_m2irr,[2,1,3]);
slope_T2M_m2irr(~island)=NaN;

    % load member 3_irr
[~, ~, T2M_irr_m3, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.003_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_irr_m3=permute(T2M_irr_m3,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m3irr = zeros(M, N);
intercept_T2M_m3irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
        % Get all time instances of each lat/lon location
        y = squeeze(T2M_irr_m3(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m3irr(i, j) = ss(ind(med_ind));
        intercept_T2M_m3irr(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m3irr(~island')=NaN;
slope_T2M_m3irr=permute(slope_T2M_m3irr,[2,1,3]);
slope_T2M_m3irr(~island)=NaN;

    % load member 4_irr
[~, ~, T2M_irr_m4, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.004_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_irr_m4=permute(T2M_irr_m4,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m4irr = zeros(M, N);
intercept_T2M_m4irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_irr_m4(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m4irr(i, j) = ss(ind(med_ind));
        intercept_T2M_m4irr(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m4irr(~island')=NaN;
slope_T2M_m4irr=permute(slope_T2M_m4irr,[2,1,3]);
slope_T2M_m4irr(~island)=NaN;

    % load member 5_control
[~, ~, T2M_irr_m5, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.005_lnd_h1_yearmean_selname.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_irr_m5=permute(T2M_irr_m5,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_m5irr = zeros(M, N);
intercept_T2M_m5irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
        % Get all time instances of each lat/lon location
        y = squeeze(T2M_irr_m5(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_m5irr(i, j) = ss(ind(med_ind));
        intercept_T2M_m5irr(i, j) = ints(ind(med_ind));
    end
end
%slope_T2M_m5irr(~island')=NaN;
slope_T2M_m5irr=permute(slope_T2M_m5irr,[2,1,3]);
slope_T2M_m5irr(~island)=NaN;

% load 2D model mean ensemble lnd IRRIGATION for regression
sum_t2m_irr_slope=(slope_T2M_m1irr + slope_T2M_m2irr + slope_T2M_m3irr + slope_T2M_m4irr + slope_T2M_m5irr); 
%mean_slope_t2m_irr=(sum_t2m_irr_slope/5);

%using ensemble file -same trend as mean above
[~, ~, T2M_irr_ensmean, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_yearmean.nc', 'TSA', 'lat', 'lon', 'time'); % load member 1_control 
T2M_irr_ensmean=permute(T2M_irr_ensmean,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_t2m_irr = zeros(M, N);
mean_intercept_t2m_irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_t2mirr = zeros(M, N);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_irr_ensmean(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_t2m_irr(i, j) = ss(ind(med_ind));
        mean_intercept_t2m_irr(i, j) = ints(ind(med_ind));
        
    end
end
mean_slope_t2m_irr=permute(mean_slope_t2m_irr,[2,1,3]);
mean_slope_t2m_irr(~island)=NaN;
mean_slope_t2m_irr(isempty(mean_slope_t2m_irr)) = NaN;
p_values_t2mirr=permute(p_values_t2mirr,[2,1,3]);
p_values_t2mirr(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_t2m_irr, p_values_t2mirr, caxes.ddT2M, colormaps.ddT2M, 0, 2, '', '1981-2010, IRR Mean', '\delta T_2_m /\delta t [K yr^-^1]'); hold on;




% --------------------------------------------------------------------
% LOAD REGRESSION DATA - CONTROL - TNn
% --------------------------------------------------------------------
    
% load 2D model atm variables - CONTROL
    % load member 1_control
[~, ~, TNn_ctl_m1, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.001_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_ctl_m1=permute(TNn_ctl_m1,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m1ctl = zeros(M, N);
intercept_TNn_m1ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TNn_ctl_m1(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m1ctl(i, j) = ss(ind(med_ind));
        intercept_TNn_m1ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m1ctl(~island')=NaN;
slope_TNn_m1ctl=permute(slope_TNn_m1ctl,[2,1,3]);
slope_TNn_m1ctl(~island)=NaN;

    % load member 2_control
[~, ~, TNn_ctl_m2, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.002_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_ctl_m2=permute(TNn_ctl_m2,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m2ctl = zeros(M, N);
intercept_TNn_m2ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_ctl_m2(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m2ctl(i, j) = ss(ind(med_ind));
        intercept_TNn_m2ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m2ctl(~island')=NaN;
slope_TNn_m2ctl=permute(slope_TNn_m2ctl,[2,1,3]);
slope_TNn_m2ctl(~island)=NaN;


    % load member 3_control
[~, ~, TNn_ctl_m3, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.003_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
    %TNn_atm_control_m3
TNn_ctl_m3=permute(TNn_ctl_m3,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m3ctl = zeros(M, N);
intercept_TNn_m3ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TNn_ctl_m3(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m3ctl(i, j) = ss(ind(med_ind));
        intercept_TNn_m3ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m3ctl(~island')=NaN;
slope_TNn_m3ctl=permute(slope_TNn_m3ctl,[2,1,3]);
slope_TNn_m3ctl(~island)=NaN;


    % load member 4_control
[~, ~, TNn_ctl_m4, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.004_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
    %TNn_atm_control_m3
TNn_ctl_m4=permute(TNn_ctl_m4,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m4ctl = zeros(M, N);
intercept_TNn_m4ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_ctl_m4(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m4ctl(i, j) = ss(ind(med_ind));
        intercept_TNn_m4ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m4ctl(~island')=NaN;
slope_TNn_m4ctl=permute(slope_TNn_m4ctl,[2,1,3]);
slope_TNn_m4ctl(~island)=NaN;


    % load member 5_control
[~, ~, TNn_ctl_m5, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.005_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
    %TNn_atm_control_m3
TNn_ctl_m5=permute(TNn_ctl_m5,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m5ctl = zeros(M, N);
intercept_TNn_m5ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_ctl_m5(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m5ctl(i, j) = ss(ind(med_ind));
        intercept_TNn_m5ctl(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m5ctl(~island')=NaN;
slope_TNn_m5ctl=permute(slope_TNn_m5ctl,[2,1,3]);
slope_TNn_m5ctl(~island)=NaN;

% load 2D model mean ensemble atm CONTROL for regression
sum_tnn_ctl_slope=(slope_TNn_m1ctl + slope_TNn_m2ctl + slope_TNn_m3ctl + slope_TNn_m4ctl + slope_TNn_m5ctl); 
%mean_slope_tnn_ctl=(sum_tnn_ctl_slope/5);

%using ensemble file -same trend as mean above
[~, ~, TNn_ctl_ensmean, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_atm_h1_yearmean.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
    %TNn_atm_control_m3
TNn_ctl_ensmean=permute(TNn_ctl_ensmean,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_tnn_ctl = zeros(M, N);
mean_intercept_tnn_ctl = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_tnnctl = zeros(M, N);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_ctl_ensmean(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_tnn_ctl(i, j) = ss(ind(med_ind));
        mean_intercept_tnn_ctl(i, j) = ints(ind(med_ind));
 
    end
end
%mean_slope_tnn_ctl(~island')=NaN;
mean_slope_tnn_ctl=permute(mean_slope_tnn_ctl,[2,1,3]);
mean_slope_tnn_ctl(~island)=NaN;
p_values_tnnctl=permute(p_values_tnnctl,[2,1,3]);
p_values_tnnctl(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_tnn_ctl, p_values_tnnctl, caxes.ddTNn, colormaps.ddTNn, 0, 2, '', '1981-2010, CTL Mean', '\delta TNn /\delta t [K yr^-^1]'); hold on;




% --------------------------------------------------------------------
% LOAD REGRESSION DATA - IRRIGATION - TNn
% --------------------------------------------------------------------
    % load member 1_irrigation
[~, ~, TNn_irr_m1, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.001_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_irr_m1=permute(TNn_irr_m1,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m1irr = zeros(M, N);
intercept_TNn_m1irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_irr_m1(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m1irr(i, j) = ss(ind(med_ind));
        intercept_TNn_m1irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m1irr(~island')=NaN;
slope_TNn_m1irr=permute(slope_TNn_m1irr,[2,1,3]);
slope_TNn_m1irr(~island)=NaN;

    % load member 2_irrigation
[~, ~, TNn_irr_m2, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.002_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_irr_m2=permute(TNn_irr_m2,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m2irr = zeros(M, N);
intercept_TNn_m2irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_irr_m2(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m2irr(i, j) = ss(ind(med_ind));
        intercept_TNn_m2irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m2irr(~island')=NaN;
slope_TNn_m2irr=permute(slope_TNn_m2irr,[2,1,3]);
slope_TNn_m2irr(~island)=NaN;

    % load member 3_irr
[~, ~, TNn_irr_m3, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.003_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_irr_m3=permute(TNn_irr_m3,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m3irr = zeros(M, N);
intercept_TNn_m3irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_irr_m3(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m3irr(i, j) = ss(ind(med_ind));
        intercept_TNn_m3irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m3irr(~island')=NaN;
slope_TNn_m3irr=permute(slope_TNn_m3irr,[2,1,3]);
slope_TNn_m3irr(~island)=NaN;

    % load member 4_irr
[~, ~, TNn_irr_m4, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.004_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_irr_m4=permute(TNn_irr_m4,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m4irr = zeros(M, N);
intercept_TNn_m4irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_irr_m4(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m4irr(i, j) = ss(ind(med_ind));
        intercept_TNn_m4irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m4irr(~island')=NaN;
slope_TNn_m4irr=permute(slope_TNn_m4irr,[2,1,3]);
slope_TNn_m4irr(~island)=NaN;

    % load member 5_irr
[~, ~, TNn_irr_m5, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.005_atm_h1_yearmean_selname.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_irr_m5=permute(TNn_irr_m5,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_m5irr = zeros(M, N);
intercept_TNn_m5irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_irr_m5(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_m5irr(i, j) = ss(ind(med_ind));
        intercept_TNn_m5irr(i, j) = ints(ind(med_ind));
    end
end
%slope_TNn_m5irr(~island')=NaN;
slope_TNn_m5irr=permute(slope_TNn_m5irr,[2,1,3]);
slope_TNn_m5irr(~island)=NaN;

% load 2D model mean ensemble IRRIGATION for regression
sum_tnn_irr_slope=(slope_TNn_m1irr + slope_TNn_m2irr + slope_TNn_m3irr + slope_TNn_m4irr + slope_TNn_m5irr); 
%mean_slope_tnn_irr=(sum_tnn_irr_slope/5);

%using ensemble file -same trend as mean above
[~, ~, TNn_irr_ensmean, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_atm_h1_yearmean.nc', 'TNn', 'lat', 'lon', 'time'); % load member 1_control 
TNn_irr_ensmean=permute(TNn_irr_ensmean,[2,1,3]); %288x192
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_tnn_irr = zeros(M, N);
mean_intercept_tnn_irr = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_tnnirr = zeros(M, N);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_irr_ensmean(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_tnn_irr(i, j) = ss(ind(med_ind));
        mean_intercept_tnn_irr(i, j) = ints(ind(med_ind));
    end
end
%mean_slope_tnn_irr(~island')=NaN;
mean_slope_tnn_irr=permute(mean_slope_tnn_irr,[2,1,3]);
mean_slope_tnn_irr(~island)=NaN;
p_values_tnnirr=permute(p_values_tnnirr,[2,1,3]);
p_values_tnnirr(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, mean_slope_tnn_irr, p_values_tnnirr, caxes.ddTNn, colormaps.ddTNn, 0, 2, '', '1981-2010, IRR Mean', '\delta TNn /\delta t [K yr^-^1]'); hold on;



%288x192
%island = 192x288

% --------------------------------------------------------------------
% LOAD REGRESSION DATA - OBSERVATIONS
% --------------------------------------------------------------------
%put TXx temp file below, check statsign 
    % Hadex txx   
[~, ~, TXx_had_obv, lat, lon, time] = mf_load('HadEX2_1981-2010_yearmax.nc', 'TXx', 'lat', 'lon', 'time'); % load obv
TXx_had_obv(isempty(TXx_had_obv)) = NaN;
TXx_had_obv=permute(TXx_had_obv,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_had = zeros(M, N);
intercept_TXx_had = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_had_txx = zeros(M, N);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TXx_had_obv(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_had(i, j) = ss(ind(med_ind));
        intercept_TXx_had(i, j) = ints(ind(med_ind));
                % If slope is NaN skip Mann-Kendall
    end
end
%slope_TXx_had(~island')=NaN; %288 x192
slope_TXx_had=permute(slope_TXx_had,[2,1,3]);
slope_TXx_had(~island)=NaN;
p_values_had_txx=permute(p_values_had_txx,[2,1,3]);
p_values_had_txx(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, slope_TXx_had, p_values_had_txx, caxes.ddTXx, colormaps.ddTXx, 0, 2, '', '1981-2010, TXx HadEX', '\delta TXx /\delta t [K yr^-^1]'); hold on;
%lines are significant


    % cru t2m   
[~, ~, T2M_CRU_obv, lat, lon, time] = mf_load('CRU_1981-2010_yearmean.nc', 'T2M', 'lat', 'lon', 'time'); % load obv
T2M_CRU_obv(isempty(T2M_CRU_obv)) = NaN;
T2M_CRU_obv=permute(T2M_CRU_obv,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_CRU = zeros(M, N);
intercept_T2M_CRU_obv = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_obst2m = zeros(M, N);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_CRU_obv(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_CRU(i, j) = ss(ind(med_ind));
        intercept_T2M_CRU_obv(i, j) = ints(ind(med_ind));
 
    end
end
%slope_T2M_CRU(~island')=NaN;
%slope_T2M_CRU(~isirr')=NaN;
slope_T2M_CRU=permute(slope_T2M_CRU,[2,1,3]);
slope_T2M_CRU(~island)=NaN;
slope_T2M_CRU(isempty(slope_T2M_CRU)) = NaN;
p_values_obst2m=permute(p_values_obst2m,[2,1,3]);
p_values_obst2m(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, slope_T2M_CRU, p_values_obst2m, caxes.ddT2M, colormaps.ddT2M, 0, 2, '', '1981-2010, OBS HadCRUT', '\delta T_2_m /\delta t [K yr^-^1]'); hold on;
%lines sig



    % GHCNDEX txx   
[~, ~, TXx_GHCNDX, lat, lon, time] = mf_load('GHCNDEX_1981-2010_yearmax.nc', 'TXx', 'lat', 'lon', 'time'); % load obv
TXx_GHCNDX=permute(TXx_GHCNDX,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_GHCNDX = zeros(M, N);
intercept_TXx_GHCNDX = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_ghc_txx = zeros(M, N);
for i = 1 : M
    for j = 1 : N
         % Get all time instances of each lat/lon location
        y = squeeze(TXx_GHCNDX(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_GHCNDX(i, j) = ss(ind(med_ind));
        intercept_TXx_GHCNDX(i, j) = ints(ind(med_ind));
 
    end
end
%slope_TXx_GHCNDX(~island')=NaN;
slope_TXx_GHCNDX=permute(slope_TXx_GHCNDX,[2,1,3]);
slope_TXx_GHCNDX(~island)=NaN;
p_values_ghc_txx=permute(p_values_ghc_txx,[2,1,3]);
p_values_ghc_txx(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, slope_TXx_GHCNDX, p_values_ghc_txx, caxes.ddTXx, colormaps.ddTXx, 0, 2, '', '1981-2010, TXx GHCNDEX', '\delta TXx /\delta t [K yr^-^1]'); hold on;



    % load observation regressions TNn
    % Hadex tnn   
[~, ~, TNn_had_obv, lat, lon, time] = mf_load('HadEX2_1981-2010_yearmax.nc', 'TNn', 'lat', 'lon', 'time'); % load obv
TNn_had_obv=permute(TNn_had_obv,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_had = zeros(M, N);
intercept_TNn_had = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_had_tnn = zeros(M, N);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_had_obv(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_had(i, j) = ss(ind(med_ind));
        intercept_TNn_had(i, j) = ints(ind(med_ind));

    end
end
slope_TNn_had=permute(slope_TNn_had,[2,1,3]);
slope_TNn_had(~island)=NaN;
p_values_had_tnn=permute(p_values_had_tnn,[2,1,3]);
p_values_had_tnn(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, slope_TNn_had, p_values_had_tnn, caxes.ddTXx, colormaps.ddTXx, 0, 2, '', '1981-2010, TNn HadEX', '\delta TNn /\delta t [K yr^-^1]'); hold on;




    % GHCNDEX tnn   
[~, ~, TNn_GHCNDX, lat, lon, time] = mf_load('GHCNDEX_1981-2010_yearmax.nc', 'TNn', 'lat', 'lon', 'time'); % load obv
TNn_GHCNDX=permute(TNn_GHCNDX,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TNn_GHCNDX = zeros(M, N);
intercept_TNn_GHCNDX = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
alpha0 = 0.05; % Level of significance
alpha = alpha0/2; %
p_values_ghc_tnn = zeros(M, N);
for i = 1 : M
    for j = 1 : N
  % Get all time instances of each lat/lon location
        y = squeeze(TNn_GHCNDX(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TNn_GHCNDX(i, j) = ss(ind(med_ind));
        intercept_TNn_GHCNDX(i, j) = ints(ind(med_ind));

    end
end
slope_TNn_GHCNDX=permute(slope_TNn_GHCNDX,[2,1,3]);
slope_TNn_GHCNDX(~island)=NaN;
p_values_ghc_tnn=permute(p_values_ghc_tnn,[2,1,3]);
p_values_ghc_tnn(~island)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, slope_TNn_GHCNDX, p_values_ghc_tnn, caxes.ddTNn, colormaps.ddTNn, 0, 2, '', '1981-2010, TNn GHCNDEX', '\delta TNn /\delta t [K yr^-^1]'); hold on;




% load observation regressions TXX   
% MEAN txx   
[~, ~, TXx_ensmean_obs, lat, lon, time] = mf_load('TXx_1981-2010_yearmax.nc', 'TXx', 'lat', 'lon', 'time'); % load obv
TXx_ensmean_obs=permute(TXx_ensmean_obs,[2,1,3]); %288x192
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_txx_obs = zeros(M, N);
intercept_TXx_ensmean = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TXx_ensmean_obs(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_txx_obs(i, j) = ss(ind(med_ind));
        intercept_TXx_ensmean(i, j) = ints(ind(med_ind));
    end
end
%mean_slope_txx_obs(~island')=NaN;    
mean_slope_txx_obs=permute(mean_slope_txx_obs,[2,1,3]);
mean_slope_txx_obs(~island)=NaN;

% load observation regressions TNn
    % MEAN tnn   
[~, ~, TNn_ensmean_obs, lat, lon, time] = mf_load('TXx_1981-2010_yearmax.nc', 'TNn', 'lat', 'lon', 'time'); % load obv
TNn_ensmean_obs=permute(TNn_ensmean_obs,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
mean_slope_tnn_obs = zeros(M, N);
intercept_TNn_ensmean = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TNn_ensmean_obs(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        mean_slope_tnn_obs(i, j) = ss(ind(med_ind));
        intercept_TNn_ensmean(i, j) = ints(ind(med_ind));
    end
end
%mean_slope_tnn_obs(~island')=NaN;
mean_slope_tnn_obs=permute(mean_slope_tnn_obs,[2,1,3]);
mean_slope_tnn_obs(~island)=NaN;



% --------------------------------------------------------------------
% LOAD REGRESSION DATA - OBSERVATIONS ANALYSIS BASED ON DONAT 1951-2010  
% --------------------------------------------------------------------
%TXx 1951-2010 GHCNDX
[~, ~, TXx_GHCNDX_51, lat, lon, time] = mf_load('GHCNDEX_1951-2010_yearmax.nc', 'TXx', 'lat', 'lon', 'time'); % load obv
TXx_GHCNDX_51=permute(TXx_GHCNDX_51,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_GHCNDX_51 = zeros(M, N);
intercept_TXx_GHCNDX_51 = zeros(M, N);
T = numel(years2);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TXx_GHCNDX_51(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years2(p(k));
            y1 = y(p(k));
            x2 = years2(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_GHCNDX_51(i, j) = ss(ind(med_ind));
        intercept_TXx_GHCNDX_51(i, j) = ints(ind(med_ind));
    end
end
slope_TXx_GHCNDX_51(~island')=NaN;

    % Hadex txx 1951-2010  
[~, ~, TXx_had_obv_51, lat, lon, time] = mf_load('HadEX2_1951-2010_yearmax.nc', 'TXx', 'lat', 'lon', 'time'); % load obv
TXx_had_obv_51=permute(TXx_had_obv_51,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_TXx_had_51 = zeros(M, N);
intercept_TXx_had_51 = zeros(M, N);
T = numel(years2);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(TXx_had_obv_51(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years2(p(k));
            y1 = y(p(k));
            x2 = years2(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_TXx_had_51(i, j) = ss(ind(med_ind));
        intercept_TXx_had_51(i, j) = ints(ind(med_ind));
    end
end
slope_TXx_had_51(~island')=NaN;

    % cru t2m   1951
[~, ~, T2M_CRU_obv_51, lat, lon, time] = mf_load('CRU_1951-2010_yearmean.nc', 'T2M', 'lat', 'lon', 'time'); % load obv
T2M_CRU_obv_51=permute(T2M_CRU_obv_51,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_T2M_CRU_51 = zeros(M, N);
intercept_T2M_CRU_obv_51 = zeros(M, N);
T = numel(years2);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(T2M_CRU_obv_51(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years2(p(k));
            y1 = y(p(k));
            x2 = years2(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_T2M_CRU_51(i, j) = ss(ind(med_ind));
        intercept_T2M_CRU_obv_51(i, j) = ints(ind(med_ind));
    end
end    
slope_T2M_CRU_51(~island')=NaN;
   
% load mean txx observaations 1951-2010
sum_txx_obs_51=(slope_TXx_GHCNDX_51 + slope_TXx_had_51); 
mean_slope_txx_obs_51=(sum_txx_obs_51/2);




% load data for check to find Theiry Fig 7 patterns, using Thesis data and
% integrated model
% members CTL 
[~, ~, TXx_ctl_m1_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.001_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_ctl_m2_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.002_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_ctl_m3_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.003_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_ctl_m4_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.004_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_ctl_m5_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.005_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
% members IRR 
[~, ~, TXx_irr_m1_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.001_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_irr_m2_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.002_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_irr_m3_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.003_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_irr_m4_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.004_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 
[~, ~, TXx_irr_m5_theiry, lat, lon, ~] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.005_atm_h1_yearmean_selname.nc', 'TXx', 'lat', 'lon', 'time'); % load member 1_control 

sum_txx_ctl_thiery=(TXx_ctl_m1_theiry + TXx_ctl_m2_theiry + TXx_ctl_m3_theiry + TXx_ctl_m4_theiry + TXx_ctl_m5_theiry); 
mean_sum_txx_ctl_thiery=(sum_txx_ctl_thiery/5);

sum_txx_irr_thiery=(TXx_irr_m1_theiry + TXx_irr_m2_theiry + TXx_irr_m3_theiry + TXx_irr_m4_theiry + TXx_irr_m5_theiry); 
mean_sum_txx_irr_thiery=(sum_txx_irr_thiery/5);

deltatxx_theiry=mean(mean_sum_txx_irr_thiery,3)-mean(mean_sum_txx_ctl_thiery,3);
%deltatxx_theiry=permute(deltatxx_theiry,[2,1,3]);
deltatxx_theiry(~island)=NaN;
 %also try mean(yxxxx(1:5)) - yxxxx(end) later QC

 
 
%third method of calc mean, same trend 
%txx
[~, ~, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.001_atm_h1_yearmean_selname.nc', 'lat', 'lon', 'time'); % load member 1_control 
sum_txx_ctl2thesis=(TXx_ctl_m1+TXx_ctl_m2+TXx_ctl_m3+TXx_ctl_m4+TXx_ctl_m5); 
mean_txx_ctl2thesis=(sum_txx_ctl2thesis/5);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_txx_ctl2thesis = zeros(M, N);
intercept_txx_ctl2thesis = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(mean_txx_ctl2thesis(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_txx_ctl2thesis(i, j) = ss(ind(med_ind));
        intercept_txx_ctl2thesis(i, j) = ints(ind(med_ind));
    end
end 
%slope_txx_ctl2thesis(~island')=NaN; 
slope_txx_ctl2thesis=permute(slope_txx_ctl2thesis,[2,1,3]);
slope_txx_ctl2thesis(~island)=NaN;

sum_txx_irr2thesis=(TXx_irr_m1+TXx_irr_m2+TXx_irr_m3+TXx_irr_m4+TXx_irr_m5); 
mean_txx_irr2thesis=(sum_txx_irr2thesis/5);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_txx_irr2thesis = zeros(M, N);
intercept_txx_irr2thesis = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(mean_txx_irr2thesis(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_txx_irr2thesis(i, j) = ss(ind(med_ind));
        intercept_txx_irr2thesis(i, j) = ints(ind(med_ind));
    end
end 
%slope_txx_irr2thesis(~island')=NaN;
slope_txx_irr2thesis=permute(slope_txx_irr2thesis,[2,1,3]);
slope_txx_irr2thesis(~island)=NaN;

%t2m
[~, ~, lat, lon, time] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.001_lnd_h1_yearmean_selname.nc', 'lat', 'lon', 'time'); % load member 1_control 
sum_t2m_ctl2thesis=(T2M_ctl_m1+T2M_ctl_m2+T2M_ctl_m3+T2M_ctl_m4+T2M_ctl_m5); 
mean_t2m_ctl2thesis=(sum_t2m_ctl2thesis/5);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_t2m_ctl2thesis = zeros(M, N);
intercept_t2m_ctl2thesis = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(mean_t2m_ctl2thesis(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_t2m_ctl2thesis(i, j) = ss(ind(med_ind));
        intercept_t2m_ctl2thesis(i, j) = ints(ind(med_ind));
    end
end 
%slope_t2m_ctl2thesis(~island')=NaN; 
slope_t2m_ctl2thesis=permute(slope_t2m_ctl2thesis,[2,1,3]);
slope_t2m_ctl2thesis(~island)=NaN;

sum_t2m_irr2thesis=(T2M_irr_m1+T2M_irr_m2+T2M_irr_m3+T2M_irr_m4+T2M_irr_m5); 
mean_t2m_irr2thesis=(sum_t2m_irr2thesis/5);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_t2m_irr2thesis = zeros(M, N);
intercept_t2m_irr2thesis = zeros(M, N);
T = numel(years);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
 % Get all time instances of each lat/lon location
        y = squeeze(mean_t2m_irr2thesis(i, j, :));
        % Find all possible pairs of slopes and intercepts
        ss = zeros(m, 1);
        ints = zeros(m, 1);
        for k = 1 : m
            x1 = years(p(k));
            y1 = y(p(k));
            x2 = years(q(k));
            y2 = y(q(k));
            s = (y2 - y1) / (x2 - x1);
            in = y1 - s*x1;
            ss(k) = s;
            ints(k) = in;
        end 
          % Find the median slope
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_t2m_irr2thesis(i, j) = ss(ind(med_ind));
        intercept_t2m_irr2thesis(i, j) = ints(ind(med_ind));
    end
end 
%slope_t2m_irr2thesis(~island')=NaN;
slope_t2m_irr2thesis=permute(slope_t2m_irr2thesis,[2,1,3]);
slope_t2m_irr2thesis(~island)=NaN;


% --------------------------------------------------------------------
% LOAD INDIVIDUAL LAT LON 
% --------------------------------------------------------------------
%LOAD INDIVIDUAL LAT LON 

%Below Tehran, Iran, betw. Caspian and saudi (lat 35.17, lon: 51.14)
%E.G. cdo remapnn,lon=108/lat=12 vietnamctl2.nc vietnamctl2processed.nc
%TXX TNN
%m4 ATM iran IRR
TXx_IRR_Iran_M4(:,1)=ncread('42irriranprocessed.nc','TXx');
TNn_IRR_Iran_M4(:,1)=ncread('42irriranprocessed.nc','TNn');
%m4 iran atm CTL
TXx_CTL_Iran_M4(:,1)=ncread('ctlm4atmprocessed.nc','TXx');
TNn_CTL_Iran_M4(:,1)=ncread('ctlm4atmprocessed.nc','TNn');
%iran txx tnn OBS
%HadEX
TXx_Had_Iran_OBS(:,1)=ncread('iranobstxxtnn.nc','TXx');
TNn_Had_Iran_OBS(:,1)=ncread('iranobstxxtnn.nc','TNn');
%GHC
TXx_GHCNDEX_Iran_OBS(:,1)=ncread('iranobstxxtnnghcnd.nc','TXx');
TNn_GHCNDEX_Iran_OBS(:,1)=ncread('iranobstxxtnnghcnd.nc','TNn');
%T2M
%iran observations t2m
T2M_CRU_Iran_OBS(:,1)=ncread('iranobst2m.nc','T2M');
%m1 LND iran irrigation
T2M_IRR_Iran_M1(:,1)=ncread('irrlandm1processed.nc','TSA');
%m1 LND iran control
T2M_CTL_Iran_M1(:,1)=ncread('m1ctl_lnd_iran.nc','TSA');




% load 2D model lnd variables for evaluation (subsetting for observational periods)
if flags.eval == 1   
[~, ~, SWnet_ctl_ym   , LWnet_ctl_ym   , SHF_ctl_ym   , LHF_ctl_ym   ] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_yearmean.nc'           , 'FSA', 'FIRA', 'FSH', 'Qle');
[~, ~, SWnet_irr_ym   , LWnet_irr_ym   , SHF_irr_ym   , LHF_irr_ym   ] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_yearmean.nc'        , 'FSA', 'FIRA', 'FSH', 'Qle');

[~, ~, SWnet_ctl_mm_py, LWnet_ctl_mm_py, SHF_ctl_mm_py, LHF_ctl_mm_py] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_monmean_selname.nc'   , 'FSA', 'FIRA', 'FSH', 'Qle');
[~, ~, SWnet_irr_mm_py, LWnet_irr_mm_py, SHF_irr_mm_py, LHF_irr_mm_py] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_monmean_selname.nc', 'FSA', 'FIRA', 'FSH', 'Qle');

[~, ~, QIRR_ctl_mm, QRUNOFF_ctl_mm, ET_ctl_mm, T2M_ctl_mm] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_ymonmean.nc'   , 'QIRRIG', 'QRUNOFF', 'ET', 'TSA');
[~, ~, QIRR_irr_mm, QRUNOFF_irr_mm, ET_irr_mm, T2M_irr_mm] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_ymonmean.nc', 'QIRRIG', 'QRUNOFF', 'ET', 'TSA');

[~, ~, TXx_ctl_mm, TNn_ctl_mm, PRECT_ctl_mm] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_atm_h1_ymonmean.nc'   , 'TXx', 'TNn', 'PRECT');
[~, ~, TXx_irr_mm, TNn_irr_mm, PRECT_irr_mm] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_atm_h1_ymonmean.nc', 'TXx', 'TNn', 'PRECT');
end


% load 2D model lnd variables for STC decomposition
if flags.perc == 1  
for i=1:length(srex_vars)    
    for j=1:length(srex_reg)
        for k=1:nens
            srex_ctl{i,j,k} = squeeze(ncread(['f.e122.F1850PDC5.f09_g16.control-io192.00'    num2str(k) '_' srex_block{i} '_h1_srex.nc'], [srex_vars{i} '_' srex_reg{j}])); %#ok<*SAGROW>
            srex_irr{i,j,k} = squeeze(ncread(['f.e122.F1850PDC5.f09_g16.irrigation-io192.00' num2str(k) '_' srex_block{i} '_h1_srex.nc'], [srex_vars{i} '_' srex_reg{j}]));
        end
    end
end
end


% load 2D model lnd variables for STC decomposition - total, local and monthly effect
if flags.STCD == 1 || flags.eval == 1
[~, ~, SWnet_ctl    , LWnet_ctl    , SWin_ctl   , SWout_ctl    , LWin_ctl   , LWout_ctl    , G_ctl    , WHF_ctl    , AHF_ctl                ] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_timmean.nc'    , 'FSA'    , 'FIRA'    , 'SWdown', 'SWup'    , 'LWdown', 'LWup'    , 'FGR'    , 'WASTEHEAT'    , 'HEAT_FROM_AC'        );
[~, ~, SWnet_irr    , LWnet_irr    , SWin_irr   , SWout_irr    , LWin_irr   , LWout_irr    , G_irr    , WHF_irr    , AHF_irr                ] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_timmean.nc' , 'FSA'    , 'FIRA'    , 'SWdown', 'SWup'    , 'LWdown', 'LWup'    , 'FGR'    , 'WASTEHEAT'    , 'HEAT_FROM_AC'        );

[~, ~, SWnet_pft_irr, LWnet_pft_irr,              SWout_pft_irr,              LWout_pft_irr, SHF_pft_irr, LHF_pft_irr, G_pft_irr, WHF_pft_irr, AHF_pft_irr            ] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h2_timmean.nc' , 'FSA_pft', 'FIRA_pft',           'SWup_pft',           'LWup_pft', 'FSH_pft', 'Qle_pft', 'FGR_pft', 'WASTEHEAT_pft', 'HEAT_FROM_AC_pft'    );

[~, ~, SWnet_ctl_mm , LWnet_ctl_mm , SWin_ctl_mm, SWout_ctl_mm , LWin_ctl_mm, LWout_ctl_mm , SHF_ctl_mm , LHF_ctl_mm , G_ctl_mm , WHF_ctl_mm , AHF_ctl_mm , T2M_ctl_mm] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_ymonmean.nc'   , 'FSA'    , 'FIRA'    , 'SWdown', 'SWup'    , 'LWdown', 'LWup'    , 'FSH'    , 'Qle'    , 'FGR'    , 'WASTEHEAT'    , 'HEAT_FROM_AC', 'TSA' );
[~, ~, SWnet_irr_mm , LWnet_irr_mm , SWin_irr_mm, SWout_irr_mm , LWin_irr_mm, LWout_irr_mm , SHF_irr_mm , LHF_irr_mm , G_irr_mm , WHF_irr_mm , AHF_irr_mm , T2M_irr_mm] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h1_ymonmean.nc', 'FSA'    , 'FIRA'    , 'SWdown', 'SWup'    , 'LWdown', 'LWup'    , 'FSH'    , 'Qle'    , 'FGR'    , 'WASTEHEAT'    , 'HEAT_FROM_AC', 'TSA' );
end


% load 2D model lnd variables per pft (!) for local effects
if flags.local == 1 || flags.STCD == 1
[~, ~, T2M_pft_ctl, TV_pft_ctl, ET_pft_ctl, TS_pft_ctl] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h2_timmean.nc'   , 'TSA_pft', 'TV_pft', 'ET_pft', 'TS_pft');
[~, ~, T2M_pft_irr, TV_pft_irr, ET_pft_irr, TS_pft_irr] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_lnd_h2_timmean.nc', 'TSA_pft', 'TV_pft', 'ET_pft', 'TS_pft');
end

%%%STATS THESIS
%below channge 
% load 2D model variables per year and member (!) for statsign computation
%same nc files
if flags.stat == 1  
for i=1:nens
    ind                             = (1:nyears) + (i-1)*nyears;
    [~, ~, SHF_ctl_ym_pe(:,:,ind), LHF_ctl_ym_pe(:,:,ind), T2M_ctl_ym_pe(:,:,ind), ET_ctl_ym_pe(:,:,ind)] = mf_load(['f.e122.F1850PDC5.f09_g16.control-io192.00'    num2str(i) '_lnd_h1_yearmean_selname.nc'], 'FSH', 'Qle', 'TSA', 'ET'); %#ok<SAGROW>
    [~, ~, SHF_irr_ym_pe(:,:,ind), LHF_irr_ym_pe(:,:,ind), T2M_irr_ym_pe(:,:,ind), ET_irr_ym_pe(:,:,ind)] = mf_load(['f.e122.F1850PDC5.f09_g16.irrigation-io192.00' num2str(i) '_lnd_h1_yearmean_selname.nc'], 'FSH', 'Qle', 'TSA', 'ET'); %#ok<SAGROW>
    [~, ~, CDD_ctl_ym_pe(:,:,ind), HWDI_ctl_ym_pe(:,:,ind), PRECT_ctl_ym_pe(:,:,ind), TNn_ctl_ym_pe(:,:,ind), TXx_ctl_ym_pe(:,:,ind), TS_ctl_ym_pe(:,:,ind)] = mf_load(['f.e122.F1850PDC5.f09_g16.control-io192.00'    num2str(i) '_atm_h1_yearmean_selname.nc'], 'CDD', 'HWDI', 'PRECT', 'TNn', 'TXx', 'TS'); %#ok<SAGROW>
    [~, ~, CDD_irr_ym_pe(:,:,ind), HWDI_irr_ym_pe(:,:,ind), PRECT_irr_ym_pe(:,:,ind), TNn_irr_ym_pe(:,:,ind), TXx_irr_ym_pe(:,:,ind), TS_irr_ym_pe(:,:,ind)] = mf_load(['f.e122.F1850PDC5.f09_g16.irrigation-io192.00' num2str(i) '_atm_h1_yearmean_selname.nc'], 'CDD', 'HWDI', 'PRECT', 'TNn', 'TXx', 'TS'); %#ok<SAGROW>
    [~, ~, ET_pft_irr_ym_pe(:,:,:,ind), TS_pft_irr_ym_pe(:,:,:,ind)] = mf_load(['f.e122.F1850PDC5.f09_g16.irrigation-io192.00'    num2str(i) '_lnd_h2_yearmean_selname.nc'], 'ET_pft', 'TS_pft'); %irrigated pixels
end
end
%SHF_ctl = 192x288, SHF_ctl_tm_pe = 192x288x150 (so 150 from 5 members over



% load irrigation amounts from offline simulations
if flags.offli == 1
[~, ~, QIRR_ctl_offline    ]      = mf_load('i.e122.I_2000.f09_g16.control-io48.001_lnd_h1_timmean.nc'   , 'QIRRIG');
[~, ~, QIRR_irr_offline_w00]      = mf_load('i.e122.I_2000.f09_g16.irrigation-io48.001_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_irr_offline_w03]      = mf_load('i.e122.I_2000.f09_g16.irrigation-io48.002_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_irr_offline_w07]      = mf_load('i.e122.I_2000.f09_g16.irrigation-io48.003_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_irr_offline_w10]      = mf_load('i.e122.I_2000.f09_g16.irrigation-io48.004_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_ctl_offline_2deg    ] = mf_load('i.e122.I_2000.f19_g16.control-io48.001_lnd_h1_timmean.nc'   , 'QIRRIG');
[~, ~, QIRR_irr_offline_2deg_w00] = mf_load('i.e122.I_2000.f19_g16.irrigation-io48.001_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_irr_offline_2deg_w03] = mf_load('i.e122.I_2000.f19_g16.irrigation-io48.002_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_irr_offline_2deg_w07] = mf_load('i.e122.I_2000.f19_g16.irrigation-io48.003_lnd_h1_timmean.nc', 'QIRRIG');
[~, ~, QIRR_irr_offline_2deg_w10] = mf_load('i.e122.I_2000.f19_g16.irrigation-io48.004_lnd_h1_timmean.nc', 'QIRRIG');

% load 2D model constants from offline simulations (pct_irr = percent of grid cell that is irrigated, see mksrfdat.F90)
[lat_mod_2deg, lon_mod_2deg pct_irr_2deg, pct_land_2deg, area_2deg] = mf_load('i.e122.I_2000.f19_g16.irrigation-io48.002_constants.nc', 'PCT_IRRIG', 'landfrac', 'AREA');
pct_land_2deg                                                       = pct_land_2deg .* 100; % [] to [%]
end

% load 2D model lnd variables per year and member (!) for std computation
if flags.valp == 1  
for i=1:nens
    ind                             = (1:nyears) + (i-1)*nyears;
    [~, ~, QIRR_irr_ym_pe(:,:,ind)] = mf_load(['f.e122.F1850PDC5.f09_g16.irrigation-io192.00' num2str(i) '_lnd_h1_yearmean_QIRRIG.nc'], 'QIRRIG'); %#ok<SAGROW>
end
end

% --------------------------------------------------------------------
% unit conversions
% --------------------------------------------------------------------


% pct_land
pct_land = pct_land .* 100; % [] to [%]


% Mean Sea Level Pressure
PSL_ctl = PSL_ctl ./ 100; % [Pa] to [hPa]
PSL_irr = PSL_irr ./ 100; % [Pa] to [hPa]


% convert LandFlux-EVAL and GLEAM evapotranspiration fluxes
if flags.eval == 1   
LHF_lfev_8905    = ET_lfev_8905    ./ 1E3 ./ 365.25 ./ 86400 .* Lvap .* rhow; % from [mm yr^-1] to [W m^-2]
LHF_glea         = ET_glea         ./ 1E3 ./ 365.25 ./ 86400 .* Lvap .* rhow; % from [mm yr^-1] to [W m^-2]
LHF_lfev_8905_mm = ET_lfev_8905_mm ./ 1E3           ./ 86400 .* Lvap .* rhow; % from [mm d^-1] to [W m^-2]
LHF_glea_mm      = ET_glea_mm      ./ 1E3           ./ 86400 .* Lvap .* rhow; % from [mm d^-1] to [W m^-2]
end

