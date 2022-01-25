
% --------------------------------------------------------------------
% evaluation subroutine
% note: preferably run "main"
% --------------------------------------------------------------------



% --------------------------------------------------------------------
% manipulations: general
% --------------------------------------------------------------------


% get number of observational products
nprod = length(prod_names);



% --------------------------------------------------------------------
% manipulations: CESM data
% --------------------------------------------------------------------


% --------------------------------------------------------------------
% manipulations: spatial averaging over srex regions
% --------------------------------------------------------------------


% irrigation amounts
%QIRR_srex(:,1) = mf_srex_prior(lat_mod, lon_mod, QIRR_obs, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
%QIRR_srex(:,2) = mf_srex_prior(lat_mod, lon_mod, QIRR_irr, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
%QIRR_srex(:,3) = mf_srex_prior(lat_mod, lon_mod, QIRR_ctl, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');


% irrigation amounts
if flags.offli == 1
QIRR_srex_offline(:,1) = mf_srex_prior(lat_mod, lon_mod, QIRR_obs            , island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline(:,2) = mf_srex_prior(lat_mod, lon_mod, QIRR_irr_offline_w00, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline(:,3) = mf_srex_prior(lat_mod, lon_mod, QIRR_irr_offline_w03, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline(:,4) = mf_srex_prior(lat_mod, lon_mod, QIRR_irr_offline_w07, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline(:,5) = mf_srex_prior(lat_mod, lon_mod, QIRR_irr_offline_w10, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline(:,6) = mf_srex_prior(lat_mod, lon_mod, QIRR_ctl_offline    , island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');


% get land pixel indices - excluding Antarctica
island_2deg                     = pct_land_2deg > 50; 
island_2deg(lat_mod_2deg < -60) = 0;             % remove antarctica

QIRR_srex_offline_2deg(:,1) = mf_srex_prior(lat_mod     , lon_mod     , QIRR_obs                 , island     , [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline_2deg(:,2) = mf_srex_prior(lat_mod_2deg, lon_mod_2deg, QIRR_irr_offline_2deg_w00, island_2deg, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline_2deg(:,3) = mf_srex_prior(lat_mod_2deg, lon_mod_2deg, QIRR_irr_offline_2deg_w03, island_2deg, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline_2deg(:,4) = mf_srex_prior(lat_mod_2deg, lon_mod_2deg, QIRR_irr_offline_2deg_w07, island_2deg, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline_2deg(:,5) = mf_srex_prior(lat_mod_2deg, lon_mod_2deg, QIRR_irr_offline_2deg_w10, island_2deg, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
QIRR_srex_offline_2deg(:,6) = mf_srex_prior(lat_mod_2deg, lon_mod_2deg, QIRR_ctl_offline_2deg    , island_2deg, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
end



% loop over years
for i=1:30

% T2M - CRU
T2M_srex(:,1,i) = mf_srex_prior(lat_mod, lon_mod, T2m_cru_ensmean4(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS'); %122x288x12
T2M_srex(:,2,i) = mf_srex_prior(lat_mod, lon_mod, T2m_irr_ensmean4(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
T2M_srex(:,3,i) = mf_srex_prior(lat_mod, lon_mod, T2m_ctl_ensmean4(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');


% spatial averaging - SREX regions
% !!! this is odd here since GHCNDEX has very few data in these regions !!!
TXx_srex_ghcn_mm(:,1,i) = mf_srex_prior(lat_mod, lon_mod, TXx_ghc_ensmean3(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
TXx_srex_ghcn_mm(:,2,i) = mf_srex_prior(lat_mod, lon_mod, TXx_irr_ensmean3(:,:,i) , island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
TXx_srex_ghcn_mm(:,3,i) = mf_srex_prior(lat_mod, lon_mod, TXx_ctl_ensmean3(:,:,i) , island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');


% spatial averaging - SREX regions
% !!! this is odd here since Hadex2 has very few data in these regions !!!
TXx_srex_had_mm(:,1,i) = mf_srex_prior(lat_mod, lon_mod, TXx_had_ensmean3(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
TXx_srex_had_mm(:,2,i) = mf_srex_prior(lat_mod, lon_mod, TXx_irr_ensmean3(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
TXx_srex_had_mm(:,3,i) = mf_srex_prior(lat_mod, lon_mod, TXx_ctl_ensmean3(:,:,i), island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');

end


% --------------------------------------------------------------------
% manipulations: generate added value matrix
% --------------------------------------------------------------------


% change in spatial MSE - SREX regions, global land, global irrigated land
%[RMSE_irr( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_irr       - QIRR_obs      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS'); %122x288
[RMSE_irr( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_had       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
%[~, RMSE_irr( 1,nreg+1), RMSE_irr( 1,nreg+2)] = mf_fieldmean_previous((QIRR_irr       - QIRR_obs      ).^2, island, isirr);
[~, RMSE_irr( 1,nreg+1), RMSE_irr( 1,nreg+2)] = mf_fieldmean_previous((mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, island, isirr);
[~, RMSE_irr( 2,nreg+1), RMSE_irr( 2,nreg+2)] = mf_fieldmean_previous((mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, island, isirr);
[~, RMSE_irr(3,nreg+1), RMSE_irr(3,nreg+2)] = mf_fieldmean_previous((mean_slope_txx_irr        - slope_TXx_had       ).^2, island, isirr);


% change in spatial MSE - SREX regions, global land, global irrigated land
%[RMSE_ctl( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_ctl       - QIRR_obs      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_had       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
%[~, RMSE_ctl( 1,nreg+1), RMSE_ctl( 1,nreg+2)] = mf_fieldmean_previous((QIRR_ctl       - QIRR_obs      ).^2, island, isirr);
[~, RMSE_ctl( 1,nreg+1), RMSE_ctl( 1,nreg+2)] = mf_fieldmean_previous((mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, island, isirr);
[~, RMSE_ctl( 2,nreg+1), RMSE_ctl( 2,nreg+2)] = mf_fieldmean_previous((mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, island, isirr);
[~, RMSE_ctl(3,nreg+1), RMSE_ctl(3,nreg+2)] = mf_fieldmean_previous((mean_slope_txx_ctl        - slope_TXx_had       ).^2, island, isirr);


% go from MSE to RMSE
RMSE_irr = sqrt(RMSE_irr);
RMSE_ctl = sqrt(RMSE_ctl);


% get the percentage change in RMSE
RMSE_change_perc = (RMSE_irr - RMSE_ctl);



% --------------------------------------------------------------------
% manipulations: generate added value matrix - SLOPES
% --------------------------------------------------------------------


% initialise matrix
RMSE_irr_mm = NaN(nprod,nreg+2);
RMSE_ctl_mm = NaN(nprod,nreg+2);



% change in spatial MSE - SREX regions, global land, global irrigated land
% % % [RMSE_irr( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_irr_mm       - QIRR_obs_mm      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_mm( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_mm(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_had       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
% [~, RMSE_irr_mm( 1,nreg+1), RMSE_irr_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((QIRR_irr_mm       - QIRR_obs_mm      ).^2, 3), island, isirr);
[~, RMSE_irr_mm( 1,nreg+1), RMSE_irr_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, 3), island, isirr); %3?
[~, RMSE_irr_mm( 2,nreg+1), RMSE_irr_mm( 2,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, 3), island, isirr);
[~, RMSE_irr_mm(3,nreg+1), RMSE_irr_mm(3,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_irr        - slope_TXx_had       ).^2, 3), island, isirr);

%number is the prod name number 10 etc, nreg plus 2 covers all land and irr
% change in spatial MSE - SREX regions, global land, global irrigated land
% [RMSE_ctl_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_ctl_mm       - QIRR_obs_mm      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS'); %122x288x12
[RMSE_ctl_mm( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl_mm(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_had       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
% [~, RMSE_ctl_mm( 1,nreg+1), RMSE_ctl_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((QIRR_ctl_mm       - QIRR_obs_mm      ).^2, 3), island, isirr);
[~, RMSE_ctl_mm( 1,nreg+1), RMSE_ctl_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, 3), island, isirr);
[~, RMSE_ctl_mm( 2,nreg+1), RMSE_ctl_mm( 2,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, 3), island, isirr);
[~, RMSE_ctl_mm(3,nreg+1), RMSE_ctl_mm(3,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_ctl        - slope_TXx_had       ).^2, 3), island, isirr);


% go from MSE to RMSE
RMSE_irr_mm = sqrt(RMSE_irr_mm);
RMSE_ctl_mm = sqrt(RMSE_ctl_mm);


% get the percentage change in RMSE
%RMSE_change_perc_mm = (RMSE_irr_mm - RMSE_ctl_mm) ./RMSE_ctl_mm .* 100;
%CHANGED TO ABSOLUTE BELOW

RMSE_change_perc_mm = (RMSE_irr_mm - RMSE_ctl_mm);


    
% since Qirr does not exist for monthly means, put annual means instead
RMSE_change_perc_mm(1,:) = RMSE_change_perc(1,:);

%%
% --------------------------------------------------------------------
% manipulations: generate added value matrix - subgrid SLOPES
% --------------------------------------------------------------------

RMSE_irr_mm = NaN(nprod,nreg+2);
RMSE_ctl_mm = NaN(nprod,nreg+2);



% change in spatial MSE - SREX regions, global land, global irrigated land
% % % [RMSE_irr( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_irr_mm       - QIRR_obs_mm      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_mm( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_mm(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_irr        - slope_eobsub       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
% [~, RMSE_irr_mm( 1,nreg+1), RMSE_irr_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((QIRR_irr_mm       - QIRR_obs_mm      ).^2, 3), island, isirr);
[~, RMSE_irr_mm( 1,nreg+1), RMSE_irr_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, 3), island, isirr); %3?
[~, RMSE_irr_mm( 2,nreg+1), RMSE_irr_mm( 2,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, 3), island, isirr);
[~, RMSE_irr_mm(3,nreg+1), RMSE_irr_mm(3,nreg+2)] = mf_fieldmean_MODIS(nanmean((slope_TS_pft_SD_irr        - slope_eobsub       ).^2, 3), island, issrex(:,:,3)&isirr);

%number is the prod name number 10 etc, nreg plus 2 covers all land and irr
% change in spatial MSE - SREX regions, global land, global irrigated land
% [RMSE_ctl_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_ctl_mm       - QIRR_obs_mm      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS'); %122x288x12
[RMSE_ctl_mm( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_ctl_mm(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_rain        - slope_eobsub       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
% [~, RMSE_ctl_mm( 1,nreg+1), RMSE_ctl_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((QIRR_ctl_mm       - QIRR_obs_mm      ).^2, 3), island, isirr);
[~, RMSE_ctl_mm( 1,nreg+1), RMSE_ctl_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, 3), island, isirr);
[~, RMSE_ctl_mm( 2,nreg+1), RMSE_ctl_mm( 2,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, 3), island, isirr);
[~, RMSE_ctl_mm(3,nreg+1), RMSE_ctl_mm(3,nreg+2)] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rain        - slope_eobsub       ).^2, 3), island, issrex(:,:,3)&isirr);

%% same results - MAKE SURE TO START WITH ISLAND SLOPE (NOT ISIRR)
[~, ~,~, RMSE_irr_mm, RMSE_irr_mm2] = mf_fieldmean_MODIS(nanmean((slope_TS_pft_SD_irr        - slope_eobsub       ).^2, 3), island,isca,issrex(:,:,3), issrex(:,:,3)&isca);
[~, ~,~, RMSE_ctl_mm, RMSE_ctl_mm2] = mf_fieldmean_MODIS(nanmean((slope_TS_pft_SD_rain        - slope_eobsub       ).^2, 3), island,isca,issrex(:,:,3), issrex(:,:,3)&isca);

%0.0313 for IP and all pix MED for irrigation
%0.0402 for al pix on med CTL - but IP is 0.0279

% go from MSE to RMSE
RMSE_irr_mm = sqrt(RMSE_irr_mm);
RMSE_ctl_mm = sqrt(RMSE_ctl_mm);

RMSE_irr_mm2 = sqrt(RMSE_irr_mm2);
RMSE_ctl_mm2 = sqrt(RMSE_ctl_mm2);

RMSE_change_perc_mm = (RMSE_irr_mm - RMSE_ctl_mm); %=0.0034 absolute









%%
% initialise matrix
RMSE_irr_sub = NaN(nprod,nreg+2);
RMSE_rain_sub = NaN(nprod,nreg+2);



% change in spatial MSE - SREX regions, global land, global irrigated land
% % % [RMSE_irr( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_irr_mm       - QIRR_obs_mm      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_sub( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_irrmed        - slope_eobsub       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_sub( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_irr_sub(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_irr        - slope_TXx_had       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
% [~, RMSE_irr_mm( 1,nreg+1), RMSE_irr_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((QIRR_irr_mm       - QIRR_obs_mm      ).^2, 3), island, isirr);
[~, RMSE_irr_sub( 1,nreg+1), RMSE_irr_sub( 1,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_t2m_irr        - slope_T2M_CRU       ).^2, 3), island, isirr); %3?
[~, RMSE_irr_sub( 2,nreg+1), RMSE_irr_sub( 2,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_irr        - slope_TXx_GHCNDX      ).^2, 3), island, isirr);
[~, RMSE_ctl_mm(3,nreg+1), RMSE_ctl_mm(3,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_ctl        - slope_TXx_had       ).^2, 3), island, isirr);
%%
slope_TS_pft_SD_irrmed=slope_TS_pft_SD_irr;
slope_TS_pft_SD_irrmed(~issrex(:,:,3))=NaN;
[~, RMSE_irr_sub(3,nreg+1), RMSE_irr_sub(3,nreg+2)] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irrmed        - slope_eobsub       ).^2, 3), island, isirr);
[~, ~,~, RMSE_irr_sub] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irrmed        - slope_eobsub       ).^2, 3), island,isirr,issrex(:,:,3));

%number is the prod name number 10 etc, nreg plus 2 covers all land and irr
%all land and irrigated land of the med square, need irrigated for med square 
% change in spatial MSE - SREX regions, global land, global irrigated land
% [RMSE_ctl_mm( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (QIRR_ctl_mm       - QIRR_obs_mm      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_rain_sub( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_rain        - slope_T2M_CRU       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS'); %122x288x12
[RMSE_rain_sub( 2,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
[RMSE_rain_sub(3,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (mean_slope_txx_ctl        - slope_TXx_had       ).^2, island, [], 'WNA', 'CNA', 'MED', 'WAS', 'SAS', 'SEA', 'EAS');
% [~, RMSE_ctl_mm( 1,nreg+1), RMSE_ctl_mm( 1,nreg+2)] = mf_fieldmean_previous(nanmean((QIRR_ctl_mm       - QIRR_obs_mm      ).^2, 3), island, isirr);
[~, RMSE_rain_sub( 1,nreg+1), RMSE_rain_sub( 1,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_t2m_ctl        - slope_T2M_CRU       ).^2, 3), island, isirr);
[~, RMSE_rain_sub( 2,nreg+1), RMSE_rain_sub( 2,nreg+2)] = mf_fieldmean_previous(nanmean((mean_slope_txx_ctl        - slope_TXx_GHCNDX      ).^2, 3), island, isirr);
slope_TS_pft_SD_rainmed=slope_TS_pft_SD_rain;
slope_TS_pft_SD_rainmed(~issrex(:,:,3))=NaN;
[~, RMSE_rain_sub(3,nreg+1), RMSE_rain_sub(3,nreg+2)] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rainmed        - slope_eobsub       ).^2, 3), island, isirr);
[~, ~,~, RMSE_rain_sub] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rainmed        - slope_eobsub       ).^2, 3), island,isirr,issrex(:,:,3));


% go from MSE to RMSE
RMSE_irr_sub = sqrt(RMSE_irr_sub);
RMSE_rain_sub = sqrt(RMSE_rain_sub);

%according to these, all pixels MED irrigation is better, but IP med it is
%not BUT FOR irr it is the same IP or not - prob becuase if irrigaed in
%model only going to be irrigated pixels for subg. so dont include in fulll
%table??
slope_TS_pft_SD_rain(~issrex(:,:,3))=NaN;
slope_TS_pft_SD_irr(~issrex(:,:,3))=NaN;
slope_TS_pft_SD_rain(~isirr)=NaN;
slope_TS_pft_SD_irr(~isirr)=NaN;

[~, ~,~, ~, RMSE_rain_sub] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rain        - slope_eobsub       ).^2, 3), island,isirr,issrex(:,:,3),issrex(:,:,3)&isirr);
[~, ~,~,~,  RMSE_irr_sub] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irr        - slope_eobsub       ).^2, 3), island,isirr,issrex(:,:,3),issrex(:,:,3)&isirr);
RMSE_irr_sub = sqrt(RMSE_irr_sub); %0.0313
RMSE_rain_sub = sqrt(RMSE_rain_sub); %0.0279

slope_TS_pft_SD_rain(~issrex(:,:,3))=NaN;
slope_TS_pft_SD_irr(~issrex(:,:,3))=NaN;
slope_eobsub(~issrex(:,:,3))=NaN;
[~, RMSE_irr_sub( 2,nreg+1), RMSE_irr_sub( 2,nreg+2)] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rain        - slope_eobsub      ).^2, 3), island, isirr);
[~, RMSE_rain_sub( 2,nreg+1), RMSE_rain_sub( 2,nreg+2)] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irr        - slope_eobsub      ).^2, 3), island, isirr);
RMSE_irr_sub = sqrt(RMSE_irr_sub); %0.18
RMSE_rain_sub = sqrt(RMSE_rain_sub); %0.17

slope_TS_pft_SD_rain(~issrex(:,:,3))=NaN;
slope_TS_pft_SD_irr(~issrex(:,:,3))=NaN;
slope_eobsub(~issrex(:,:,3))=NaN;
[RMSE_rain_sub( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_rain        - slope_eobsub       ).^2, island, [], 'MED'); %122x288x12
[RMSE_irr_sub( 1,1:nreg)] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_irr        - slope_eobsub       ).^2, island, [],  'MED');
RMSE_irr_sub = sqrt(RMSE_irr_sub); 
RMSE_rain_sub = sqrt(RMSE_rain_sub);




slope_eobsub2=slope_eobsub;
slope_eobsub2(~isirr)=NaN;
slope_TS_pft_SD_rain2=slope_TS_pft_SD_rain;
slope_TS_pft_SD_rain2(~isirr)=NaN;
slope_TS_pft_SD_irr2=slope_TS_pft_SD_irr;
slope_TS_pft_SD_irr2(~isirr)=NaN;
[~, ~,~, RMSE_rain_subirr2] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rain2        - slope_eobsub2       ).^2, 3), island,isirr,issrex(:,:,3),issrex(:,:,3) &isirr);
[~, ~,~, RMSE_irr_subirr2] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irr2        - slope_eobsub2       ).^2, 3), island,isirr,issrex(:,:,3),issrex(:,:,3) &isirr);
RMSE_irr_subirr2 = sqrt(RMSE_irr_subirr2); 
RMSE_rain_subirr2 = sqrt(RMSE_rain_subirr2);


[RMSE_irr_subirr2] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_irr        - slope_eobsub       ).^2, island, [], 'MED'); %122x288x12
[ RMSE_rain_subirr2] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_rain        - slope_eobsub       ).^2, island, [], 'MED'); %122x288x12
RMSE_irr_subirr2 = sqrt(RMSE_irr_subirr2); 
RMSE_rain_subirr2 = sqrt(RMSE_rain_subirr2);

[RMSE_irr_subirr3] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_irr2        - slope_eobsub2       ).^2, island, [], 'MED'); %122x288x12
[ RMSE_rain_subirr3] = mf_srex_prior(lat_mod, lon_mod, (slope_TS_pft_SD_rain2        - slope_eobsub2       ).^2, island, [], 'MED'); %122x288x12
RMSE_irr_subirr3 = sqrt(RMSE_irr_subirr3); 
RMSE_rain_subirr3 = sqrt(RMSE_rain_subirr3); %irrigation med all pixels = 0.031, control = 0.040


% get the percentage change in RMSE
%according to these, all pixels MED irrigation is better, but IP med it is
%not BUT FOR irr it is the same IP or not
[~, ~,RMSE_rain_subMED, RMSE_rain_subMEDisirr] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rain        - slope_eobsub       ).^2, 3), island,isirr,issrex(:,:,3),issrex(:,:,3)&isirr);
[~, ~,RMSE_irr_subMED, RMSE_irr_subMEDisrr] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irr        - slope_eobsub       ).^2, 3), island,isirr,issrex(:,:,3),issrex(:,:,3)&isirr);
RMSE_rain_subMED = sqrt(RMSE_rain_subMED); 
RMSE_rain_subMEDisirr = sqrt(RMSE_rain_subMEDisirr);
RMSE_irr_subMED = sqrt(RMSE_irr_subMED); 
RMSE_irr_subMEDisrr = sqrt(RMSE_irr_subMEDisrr);


slope_eobsub2=slope_eobsub;
slope_eobsub2(~isirr)=NaN;
slope_TS_pft_SD_rain2=slope_TS_pft_SD_rain;
slope_TS_pft_SD_rain2(~isirr)=NaN;
slope_TS_pft_SD_irr2=slope_TS_pft_SD_irr;
slope_TS_pft_SD_irr2(~isirr)=NaN;
[~, ~,~, RMSE_rain_subirr2] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_rain2        - slope_eobsub2       ).^2, 3), island,isirr,issrex(:,:,3));
[~, ~,~, RMSE_irr_subirr2] = mf_fieldmean_previous(nanmean((slope_TS_pft_SD_irr2        - slope_eobsub2       ).^2, 3), island,isirr,issrex(:,:,3));
RMSE_irr_subirr2 = sqrt(RMSE_irr_subirr2); 
RMSE_rain_subirr2 = sqrt(RMSE_rain_subirr2);



%RMSE_change_perc_mm = (RMSE_irr_mm - RMSE_ctl_mm) ./RMSE_ctl_mm .* 100;
%CHANGED TO ABSOLUTE BELOW

RMSE_change_perc_sub = (RMSE_irr_sub - RMSE_rain_sub);


    
% since Qirr does not exist for monthly means, put annual means instead
RMSE_change_perc_sub(1,:) = RMSE_change_perc_sub(1,:);






