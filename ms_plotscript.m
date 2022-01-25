
% --------------------------------------------------------------------
% visualisation subroutine
% note: preferably run "main"
% --------------------------------------------------------------------


% clean up
clc;
close all;


% flags for paper plots
flags.plot_fig1  = 0; % 0: do not plot figure 1 of paper
                      % 1: plot figure 1 of paper
flags.plot_fig2  = 0; % 0: do not plot figure 2 of paper
                      % 1: plot figure 2 of paper
flags.plot_fig3  = 0; % 0: do not plot figure 3 of paper
                      % 1: plot figure 3 of paper
flags.plot_fig4  = 0; % 0: do not plot figure 4 of paper
                      % 1: plot figure 4 of paper
flags.plot_fig5  = 0; % 0: do not plot figure 5 of paper
                      % 1: plot figure 5 of paper
flags.plot_fig6  = 0; % 0: do not plot figure 6 of paper
                      % 1: plot figure 6 of paper
flags.plot_fig7  = 1; % 0: do not plot TXx REGRESSIONS - INDIVIDUAL MEMBERS
                      % 1: plot TXx REGRESSIONS - INDIVIDUAL MEMBERS
flags.plot_fig8  = 1; % 0: do not plot T2M REGRESSIONS - INDIVIDUAL MEMBERS
                      % 1: plot figure T2M REGRESSIONS - INDIVIDUAL MEMBERS
flags.plot_fig9  = 0; % 0: do not plot TNn REGRESSIONS - INDIVIDUAL MEMBERS
                      % 1: plot figure TNn REGRESSIONS - INDIVIDUAL MEMBERS
flags.plot_fig10  = 0; % 0: do not plot REGRESSION MEANS
                      % 1: plot REGRESSION MEANS
flags.plot_fig11 = 0; % 0: do not plot REGRESSION RATIOS - CESM
                      % 1: plot REGRESSION RATIOS - CESM
flags.plot_fig12 = 0; % 0: do not plot OBSERVATIONS - INDIVIDUAL REGRESSIONS
                      % 1: plot OBSERVATIONS - INDIVIDUAL REGRESSIONS
flags.plot_fig13 = 0; % 0: do not plot OBSERVATIONS - MEANS AND RATIO
                      % 1: plot OBSERVATIONS - MEANS AND RATIO
                     
% flags for other plots               
flags.plot_ill01      = 0; % 0: do not plot illustration 1 of review
                           % 1: plot illustration 1 of review
flags.plot_ill04      = 0; % 0: do not plot illustration 4 of review
                           % 1: plot illustration 4 of review
flags.plot_eval       = 0; % 0: do not plot evaluation maps
                           % 1: plot evaluation maps
flags.plot_extr       = 0; % 0: do not plot extremes
                           % 1: plot extremes
flags.plot_bars       = 0; % 0: do not plot bar plots for srex regions
                           % 1: plot bar plots for srex regions
flags.plot_addv       = 0; % 0: do not plot bar plots for srex regions
                           % 1: plot bar plots for srex regions
flags.plot_STCD       = 0; % 0: do not plot Surface Temperature Change Decomposition
                           % 1: plot Surface Temperature Change Decomposition
flags.plot_STCD_local = 0; % 0: do not plot Surface Temperature Change Decomposition
                           % 1: plot Surface Temperature Change Decomposition
flags.plot_STCD_srex  = 0; % 0: do not plot Surface Temperature Change Decomposition per srex region
                           % 1: plot Surface Temperature Change Decomposition per srex region
flags.plot_perc       = 0; % 0: do not plot percentile changes
                           % 1: plot percentile changes
flags.plot_T2M_pe     = 0; % 0: do not plot T2M maps per ensemble member
                           % 1: plot T2M maps per ensemble member
        

                     
% --------------------------------------------------------------------
% initialisation
% --------------------------------------------------------------------


% set colorscale axes
caxes.T2M   = [-0.05       0.05 ];
caxes.PRECT = [  0       3000];
caxes.TXx   = [270       330 ];
caxes.TNn   = [240       300 ];
caxes.CDD   = [  0       365 ];
caxes.HWDI  = [  0       185 ];
caxes.WSDI  = [  0       34  ];
caxes.dT2M  = [ -.1       0.1   ];
caxes.dTS   = [ -2       2   ];
caxes.dPREC = [ -49      49  ];
caxes.dTXx  = [ -0.15   0.15 ];
caxes.dTNn  = [ -3       3   ];
caxes.dCDD  = [-10       10  ];
caxes.dHWDI = [-10       10  ];
caxes.dWSDI = [-10       10  ];
caxes.dflx  = [ -5       5   ];
caxes.dET   = [ -250     250 ];
caxes.Pirr  = [  0       50  ];
caxes.Qirr  = [  1       1000];
caxes.eTXx  = [ -10      10  ];
caxes.eflx  = [ -40      40  ];
caxes.epre  = [ -600     600 ];
caxes.ratio = [ -0.5        2.7 ];
caxes.TNnreg = [ -0.25        0.25 ];


% set colormaps
colormaps.T2M   =        mf_colormap_cpt('oc_sst'           , (caxes.T2M(2)  - caxes.T2M(1)) );
colormaps.PRECT =        mf_colormap_cpt('oc_sst'           , (caxes.T2M(2)  - caxes.T2M(1)) );
colormaps.TXx   =        mf_colormap_cpt('oc_sst'           , (caxes.TXx(2)  - caxes.TXx(1)) );
colormaps.TNn   =        mf_colormap_cpt('oc_sst'           , (caxes.TNn(2)  - caxes.TNn(1)) );
colormaps.CDD   =        mf_colormap_cpt('oc_sst'           , (caxes.CDD(2)  - caxes.CDD(1)) );
colormaps.HWDI  =        mf_colormap_cpt('oc_sst'           , (caxes.HWDI(2) - caxes.HWDI(1)));
colormaps.WSDI  =        mf_colormap_cpt('oc_sst'           , (caxes.WSDI(2) - caxes.WSDI(1)));
colormaps.dT2M  =        mf_colormap_cpt('dkbluered'        , 20);
colormaps.dTS   =        mf_colormap_cpt('dkbluered'        , 16);
colormaps.dPREC =        mf_colormap_cpt('precip_diff_12lev', 9);
colormaps.dTXx  =        mf_colormap_cpt('dkbluered'        , 24);
colormaps.dTNn  =        mf_colormap_cpt('dkbluered'        , 24);
colormaps.dCDD  = flipud(mf_colormap_cpt('precip_diff_12lev', 9));
colormaps.dHWDI =        mf_colormap_cpt('dkbluered'        , 20);
colormaps.dWSDI =        mf_colormap_cpt('dkbluered'        , 20);% colormaps.dflx  = flipud(mf_colormap_cpt('blue-tan'         , 20));
colormaps.dflx  =        mf_colormap_cpt('cbacPRGn10'       , 20);
colormaps.dET   =        mf_colormap_cpt('cbacPRGn10'       , 20);
colormaps.Pirr  =        mf_colormap_cpt('cbacYlGnBu09'     , 10);
colormaps.Qirr  =        mf_colormap_cpt('Blues_09'         , 9);
colormaps.eTXx  =        mf_colormap_cpt('dkbluered'        , 20);
colormaps.eflx  =        mf_colormap_cpt('dkbluered'        , 20);
colormaps.epre  =        mf_colormap_cpt('dkbluered'        , 20);
colormaps.ratio =        mf_colormap_cpt('dkbluered'      , 9);



% Set center of change to white
colormaps.dT2M(10:11,:)  = [1 1 1; 1 1 1];
colormaps.dTS(8:9,:)     = [1 1 1; 1 1 1];
colormaps.dTXx(12:13,:)  = [1 1 1; 1 1 1];
colormaps.dTNn(12:13,:)  = [1 1 1; 1 1 1];
colormaps.dPREC(6:10,:)  = colormaps.dPREC(5:9,:);
colormaps.dCDD(6:10,:)   = colormaps.dCDD(5:9,:);
colormaps.dHWDI(10:11,:) = [1 1 1; 1 1 1];
%colormaps.ratio(5:6,:)  = [1 1 1; 1 1 1];


% customize delfx & dET colormap
colormaps.dflx(1:9,:)   = colormaps.dflx(2:10,:);
colormaps.dflx(11:20,:) = colormaps.dflx(10:19,:);
colormaps.dflx(10:11,:) = [1 1 1; 1 1 1];
colormaps.dET(1:9,:)    = colormaps.dET(2:10,:);
colormaps.dET(11:20,:)  = colormaps.dET(10:19,:);
colormaps.dET(10:11,:)  = [1 1 1; 1 1 1];


% line colors
colors    = [0.20 0.73 0.03; ...   % 1.  grass 
             0.82 0.41 0.12; ...   % 2.  brown ('CHOCOLATE' in mf_rgb)
             0.80 0.73 0.03; ...   % 3.  sand
             1.00 0.00 0.00; ...   % 4.  red
             0.60 0.00 0.40; ...   % 5.  purple
             1.00 0.40 1.00; ...   % 6.  pink
             1.00 0.80 0.00; ...   % 7.  yellow
             0.50 0.50 0.50; ...   % 8.  grey
             0.00 0.00 1.00; ...   % 9.  blue
             0.30 0.00 0.00; ...   % 10. brown
             1.00 0.40 0.10; ...   % 11. orange
             0.75 0.75 1.00; ...   % 12. light blue
             1.00 0.75 0.75; ...   % 13. light red
             0.75 1.00 0.75; ...   % 14. light green
             0.90 0.83 0.13; ...   % 15. light sand
             0.89 0.10 0.11; ...   % 16. CB red
             0.21 0.49 0.72; ...   % 17. CB blue
             0.30 0.68 0.29; ...   % 18. CB green
             0.70 0.87 0.54; ...   % 19. CB lightgreen
                                   ]; 

                               
% define axes color                               
axcolor = [0.3 0.3 0.3]; % 70% contrast (so 0.3) is advised


% get alphabet                               
alphabet = char(repmat('a' + (1:26) - 1, [2 1]))';



% --------------------------------------------------------------------
% paper figure 1
% --------------------------------------------------------------------


if flags.plot_fig1 == 1

    
% percentage of pixel equipped for irrigation map
mf_plot_dom2(lon_mod, lat_mod, pct_irr, [], caxes.Pirr, colormaps.Pirr, 0, 2, 'a', 'area equipped for irrigation', 'equipped for irrigation [%]'); hold on;
for i=1:length(pol_lat) % plot srex polygons and their names (repeat first corner at the end to close box)
    m_line([pol_lon{i}; pol_lon{i}(1)], [pol_lat{i}; pol_lat{i}(1)],'linewi',1,'color','r');    % Area outline
end
m_text(pol_lon{1}(2)   ,pol_lat{1}(2),srex_reg(1),'ver','top','hor','left','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
m_text(pol_lon{2}(2)   ,pol_lat{2}(2),srex_reg(2),'ver','top','hor','right','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
m_text(pol_lon{3}(1)   ,pol_lat{3}(1),srex_reg(3),'ver','top','hor','left','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
m_text(pol_lon{4}(2)+15,pol_lat{4}(2),srex_reg(4),'ver','bottom','hor','left','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
m_text(pol_lon{5}(1)   ,pol_lat{5}(1),srex_reg(5),'ver','top','hor','left','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
m_text(pol_lon{6}(1)   ,pol_lat{6}(1),srex_reg(6),'ver','top','hor','left','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
m_text(pol_lon{7}(3)-10,pol_lat{7}(3),srex_reg(7),'ver','bottom','hor','right','color','r', 'Fontweight', 'Bold', 'Fontsize', 10); hold on;
%export_fig figures/used/pct_irr_lowres -transparent -png % save figure
% export_fig figures/used/pct_irr -m10 -transparent -png % save figure


% water added through irrigation - logarythmic scale !!
mf_plot_dom2_log(lon_mod, lat_mod, QIRR_obs, caxes.Qirr, colormaps.Qirr, 0, 2, 'b', 'water added through irrigation - observed', 'Q_i_r_r [mm yr^-^1]'); hold on;
%export_fig figures/used/QIRR_obs_lowres -transparent -png % save figure
% export_fig figures/used/QIRR_obs -m10 -transparent -png % save figure


% water added through irrigation - logarythmic scale !!
mf_plot_dom2_log(lon_mod, lat_mod, QIRR_irr, caxes.Qirr, colormaps.Qirr, 0, 2, 'c', 'water added through irrigation - CESM', 'Q_i_r_r [mm yr^-^1]'); hold on;
%export_fig figures/used/QIRR_irr_lowres -transparent -png % save figure
% export_fig figures/used/QIRR_irr -m10 -transparent -png % save figure


end



% --------------------------------------------------------------------
% paper figure 2
% --------------------------------------------------------------------


if flags.plot_fig2 == 1

    
% QIRR
figure;
h = bar(1:7,QIRR_srex,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 160]);
% mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold','color', axcolor); %#ok<NBRAK>
ylabel('Q_i_r_r [mm yr^-^1]', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'OBS', 'IRR', 2);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11,'textcolor', axcolor);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold','Xcolor', axcolor,'Ycolor', axcolor);
export_fig text/figures_paper/figure_02 -transparent;


end



% --------------------------------------------------------------------
% paper figure 3
% --------------------------------------------------------------------


if flags.plot_fig3 == 1


% workaround to get white spaces
RMSE_change_perc_plot_mm   = NaN(nprod,(nreg+2)*4+1);
for i=1:nreg+2
    RMSE_change_perc_plot_mm(:,i*4-2:i*4) = [RMSE_change_perc_mm(:,i), RMSE_change_perc_mm(:,i), RMSE_change_perc_mm(:,i)];
end

    
% generate plot
figure;
h = imagesc(1:length(RMSE_change_perc_plot_mm(1,:)),1:nprod,RMSE_change_perc_plot_mm(1:nprod,:));
set(h,'alphadata',~isnan(RMSE_change_perc_plot_mm(1:nprod,:)))
% alternative to the above two lines using pcolor instead of imagesc:
% h = pcolor(1:length(RMSE_change_perc_plot_mm(1,:)), 0.5:nprod+0.5, [RMSE_change_perc_plot_mm(1:nprod,:); NaN(1,(nreg+2)*4+1)]);
% set(h, 'edgecolor', 'none');                                                                                       % remove black grid around pixels 
% set(gca, 'ydir', 'reverse');
set(gca, 'Fontsize', 13, 'Fontweight', 'Bold','TickLength', [0 0],'Xcolor', axcolor,'Ycolor', axcolor);
set(gca,'Ytick',1:1:nprod,'YTickLabel',prod_names, 'Fontsize', 10);
mf_tightfig; 
mf_xticklabel_rotate([3:4:(nreg+2)*4],45,[srex_reg, 'all land', 'irrigated'],'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold', 'color', axcolor); %#ok<NBRAK>
cbh = colorbar('Fontsize', 14, 'Fontweight', 'Bold', 'YColor', axcolor);
colormap(flipud(mf_colormap_cpt('cbcRdYlGn',10)));
caxis([-5 5])
text((nreg+5.5)*4,nprod/2+0.5,'% RMSE change','ver','bottom','hor','center', 'Fontweight', 'Bold', 'Fontsize', 12,'rotation',-90, 'color', axcolor); hold off;
box off
% export_fig text/figures_paper/figure_03 -transparent;


end



% --------------------------------------------------------------------
% paper figure 4
% --------------------------------------------------------------------


if flags.plot_fig4 == 1

    
% T2M diff map
mf_plot_dom2(lon_mod, lat_mod, T2M_irr-T2M_ctl, statsign_dT2M_h, caxes.dT2M, colormaps.dT2M, 0, 2, 'a', '1981-2010, IRR - CTL', '\Delta T_2_m [K]'); hold on;
export_fig figures/used/impact_av_T2M_irr-ctl_lowres -transparent -png % save figure
% export_fig figures/used/impact_av_T2M_irr-ctl -m10 -transparent -png % save figure

          
% PRECT diff map
mf_plot_dom2(lon_mod, lat_mod, PRECT_irr-PRECT_ctl, statsign_dPRECT_h, caxes.dPREC, colormaps.dPREC, 0, 2, 'b', '1981-2010, IRR - CTL', '\Delta Precipitation [mm yr^-^1]'); hold on;
export_fig figures/used/impact_av_PRECT_irr-ctl_lowres -transparent -png % save figure
% export_fig figures/used/impact_av_PRECT_irr-ctl -m10 -transparent -png % save figure


% LHF diff map
mf_plot_dom2(lon_mod, lat_mod, LHF_irr-LHF_ctl, statsign_dLHF_h, caxes.dflx, colormaps.dflx, 0, 2, 'c', '1981-2010, IRR-CTL', '\Delta LHF [W m^-^2]'); hold on;
export_fig figures/used/impact_av_LHF_irr-ctl_lowres -transparent -png % save figure
% export_fig figures/used/impact_av_LHF_irr-ctl -m10 -transparent -png % save figure


% SHF diff map
mf_plot_dom2(lon_mod, lat_mod, SHF_irr-SHF_ctl, statsign_dSHF_h, caxes.dflx, colormaps.dflx, 0, 2, 'd', '1981-2010, IRR-CTL', '\Delta SHF [W m^-^2]'); hold on;
export_fig figures/used/impact_av_SHF_irr-ctl_lowres -transparent -png % save figure
% export_fig figures/used/impact_av_SHF_irr-ctl -m10 -transparent -png % save figure


end



% --------------------------------------------------------------------
% paper figure 5
% --------------------------------------------------------------------


if flags.plot_fig5 == 1

    
% make sure you bin according to TSA (temperature) in ms_perc!!!
    
% initialisation - y-axis limits (see srex_vars)
ylims = [  0       0.90  ; ...  % QIRRIG
          -0.9     0.35  ; ...  % TSA
          -0.5    12.0   ; ...  % Qle
         -9.5      4.5   ; ...  % FSH
          -4       4     ; ...  % FSA
          -5       2     ; ...  % FIRA
           0      10     ; ...  % PRECT
          -0.301   0.20] ;      % QRUNOFF         
      

% prepare for loop
k = 1;


% bin other variables to TSA
for i=1:4                        %  QIRRIG, TSA, Qle and FSH only

    for j=3                      % MED only
        
        % get differences per bin    
        bindiff              = binmedian_binT_irr{i,j} - binmedian_binT_ctl{i,j};
        bindiff_Q25          = binQ25_binT_irr{i,j}    - binQ25_binT_ctl{i,j};
        bindiff_Q75          = binQ75_binT_irr{i,j}    - binQ75_binT_ctl{i,j};
        ind_pos              = find(bindiff > 0);
        ind_neg              = find(bindiff < 0);
        bindiff_pos          = zeros(size(bindiff));
        bindiff_neg          = zeros(size(bindiff));
        bindiff_pos(ind_pos) = bindiff(ind_pos);
        bindiff_neg(ind_neg) = bindiff(ind_neg);

        % quantile change of a given variable between CTL and IRR
        figure('OuterPosition',[100 200 950 410]);
        set(gcf, 'color', 'w');
        h(1) = bar(1:nbins,bindiff_pos,'histc'); hold on;
        h(2) = bar(1:nbins,bindiff_neg,'histc'); hold on;
        set(h(1),'facecolor',colors(16,:),'edgecolor','none');
        set(h(2),'facecolor',colors(17,:),'edgecolor','none');
        e = errorbar(1.5:nbins+0.5, bindiff, bindiff_Q25, bindiff_Q75,'k.','linewidth',1.5); hold on
        set(get(e,'children'),'clipping','off')
        axis([1 nbins+1 ylims(i,1) ylims(i,2)]);
        set(gca, 'Fontsize', 15, 'Fontweight', 'Bold');
        set(gca,'XTickLabel',{' ','P10',' ','P30',' ','P50',' ','P70', ' ','P90'}, 'Xtick', 1:nbins/10:nbins,'fontsize',15)
        xlabel('T_2_m percentiles', 'Fontsize', 18, 'Fontweight', 'Bold'); 
        ylabel(['\Delta ' srex_ylabels{i} ' [' srex_units{i} ']'], 'Fontsize', 18, 'Fontweight', 'Bold'); 
       
        text(1.15,ylims(i,2),alphabet(k),'ver','bottom','hor','center','Fontsize', 18)
        %text(nbins+1,ylims(i,2),[srex_vars{i} ', ' srex_reg{j}],'ver','bottom','hor','right','Fontsize', 11, 'Fontweight', 'Bold')
        text(nbins+1,ylims(i,2),srex_reg{j},'ver','bottom','hor','right','Fontsize', 18, 'Fontweight', 'Bold')

        % save figure
        export_fig(sprintf('figures/used/perc_change_%s.png',[num2str(k) '_' srex_vars{i} '_' srex_reg{j}]), '-transparent');
        %export_fig(sprintf('figures/used/perc_change_%s.pdf',[num2str(k) '_' srex_vars{i} '_' srex_reg{j}]), '-transparent');
                
        % for panel letters
        k = k + 1;
        
    end
    
end


end



% --------------------------------------------------------------------
% paper figure 6
% --------------------------------------------------------------------


if flags.plot_fig6 == 1

    
% initialisation - y-axis limits (see srex_vars)
ylims = [  0        1.51 ; ...  % QIRRIG
          -0.75     0.55 ; ...  % TSA
          -2.5     10.0  ; ...  % Qle
          -4        4.5  ; ...  % FSH
          -4        4    ; ...  % FSA
          -5        2    ; ...  % FIRA
           0       10    ; ...  % PRECT
          -0.55     0.35];      % QRUNOFF         
          
       
% prepare for loop
k = 1;


% bin other variables to TSA
for i=1:4                        %  QIRRIG, TSA, Qle and FSH only

    for j=5                  % MED only
        
        % get differences per bin    
        bindiff              = binmedian_binP_irr{i,j} - binmedian_binP_ctl{i,j};
        bindiff_Q25          = binQ25_binP_irr{i,j}    - binQ25_binP_ctl{i,j};
        bindiff_Q75          = binQ75_binP_irr{i,j}    - binQ75_binP_ctl{i,j};
        ind_pos              = find(bindiff > 0);
        ind_neg              = find(bindiff < 0);
        bindiff_pos          = zeros(size(bindiff));
        bindiff_neg          = zeros(size(bindiff));
        bindiff_pos(ind_pos) = bindiff(ind_pos);
        bindiff_neg(ind_neg) = bindiff(ind_neg);

        % quantile change of a given variable between CTL and IRR
        figure('OuterPosition',[100 200 950 410]);
        set(gcf, 'color', 'w');
        h(1) = bar(1:nbins,bindiff_pos,'histc'); hold on;
        h(2) = bar(1:nbins,bindiff_neg,'histc'); hold on;
        set(h(1),'facecolor',colors(16,:),'edgecolor','none');
        set(h(2),'facecolor',colors(17,:),'edgecolor','none');
        e = errorbar(1.5:nbins+0.5, bindiff, bindiff_Q25, bindiff_Q75,'k.','linewidth',1.5); hold on
        set(get(e,'children'),'clipping','off')
        axis([1 nbins+1 ylims(i,1) ylims(i,2)]);
        set(gca,'XTickLabel',{' ','P10',' ','P30',' ','P50',' ','P70', ' ','P90'}, 'Xtick', 1:nbins/10:nbins,'fontsize',18)
        xlabel('Precipitation percentiles', 'Fontsize', 18, 'Fontweight', 'Bold'); 
        ylabel(['\Delta ' srex_ylabels{i} ' [' srex_units{i} ']'], 'Fontsize', 18, 'Fontweight', 'Bold'); 
        set(gca, 'Fontsize', 18, 'Fontweight', 'Bold');
        text(1.15,ylims(i,2),alphabet(k),'ver','bottom','hor','center','Fontsize', 18)
        %text(nbins+1,ylims(i,2),[srex_vars{i} ', ' srex_reg{j}],'ver','bottom','hor','right','Fontsize', 11, 'Fontweight', 'Bold')
        text(nbins+1,ylims(i,2),srex_reg{j},'ver','bottom','hor','right','Fontsize', 18, 'Fontweight', 'Bold')

        % save figure
        export_fig(sprintf('figures/used/perc_change_%s.png',[num2str(k) '_' srex_vars{i} '_' srex_reg{j}]), '-transparent');
        %export_fig(sprintf('figures/used/perc_change_%s.pdf',[num2str(k) '_' srex_vars{i} '_' srex_reg{j}]), '-transparent');
                
        % for panel letters
        k = k + 1;
        
    end
    
end


end



% --------------------------------------------------------------------
% TXx REGRESSIONS - INDIVIDUAL MEMBERS
% --------------------------------------------------------------------

if flags.plot_fig7 == 1

%TXX REGRESSIONS
%TXx ctl_members
% M1
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m1ctl', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 1', '\Delta TXx [K]'); hold on;
% M2
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m2ctl', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 2', '\Delta TXx [K]'); hold on;
% M3
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m3ctl', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 3', '\Delta TXx [K]'); hold on;
% M4
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m4ctl', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 4', '\Delta TXx [K]'); hold on;
% M5
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m5ctl', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 5', '\Delta TXx [K]'); hold on;

% TXx irr_members
% M1
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m1irr', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 1', '\Delta TXx [K]'); hold on;
% M2
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m2irr', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 2', '\Delta TXx [K]'); hold on;
% M3
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m3irr', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 3', '\Delta TXx [K]'); hold on;
% M4
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m4irr', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 4', '\Delta TXx [K]'); hold on;
% M5
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_m5irr', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 5', '\Delta TXx [K]'); hold on;

end

% --------------------------------------------------------------------
% T2M REGRESSIONS - INDIVIDUAL MEMBERS
% --------------------------------------------------------------------

if flags.plot_fig72 == 1

% T2M CTL
% M1
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m1ctl', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 1', '\Delta T2M [K]'); hold on;
% M2
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m2ctl', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 2', '\Delta T2M [K]'); hold on;
% M3
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m3ctl', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 3', '\Delta T2M [K]'); hold on;
% M4
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m4ctl', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 4', '\Delta T2M [K]'); hold on;
% M5
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m5ctl', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 5', '\Delta T2M [K]'); hold on; 

% T2M IRR
% M1
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m1irr', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 1', '\Delta T2M [K]'); hold on;
% M2
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m2irr', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 2', '\Delta T2M [K]'); hold on;
% M3
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m3irr', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 3', '\Delta T2M [K]'); hold on;
% M4
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m4irr', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 4', '\Delta T2M [K]'); hold on;
% M5
mf_plot_dom2(lon_mod, lat_mod, slope_T2M_m5irr', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 5', '\Delta T2M [K]'); hold on;

end

% --------------------------------------------------------------------
% TNn REGRESSIONS - INDIVIDUAL MEMBERS
% --------------------------------------------------------------------

if flags.plot_fig73 == 1

% TNn regression CTL_members
% M1
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m1ctl', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 1', '\Delta TNn [K]'); hold on;
% M2
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m2ctl', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 2', '\Delta TNn [K]'); hold on;
% M3
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m3ctl', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Member 3', '\Delta TNn [K]'); hold on;
% M4
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m4ctl', [], caxes.TNnreg, colormaps.dTXx, 0, 2, 'a', '1981-2010, CTL Member 4', '\Delta TNn [K]'); hold on;
% M5
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m5ctl', [], caxes.TNnreg, colormaps.dTXx, 0, 2, 'a', '1981-2010, CTL Member 5', '\Delta TNn [K]'); hold on;
%statsign_dTXx_h this is for TXx (and also seems work with TSA) but should it be island? %also replace caxes.dTXx bk to -0.125 to 0.125 match donat

% TNn regression irr_members
% M1
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m1irr', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 1', '\Delta TNn [K]'); hold on;
% M2
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m2irr', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 2', '\Delta TNn [K]'); hold on;
% M3
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m3irr', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 3', '\Delta TNn [K]'); hold on;
% M4
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m4irr', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 4', '\Delta TNn [K]'); hold on;
% M5
mf_plot_dom2(lon_mod,lat_mod,slope_TNn_m5irr', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Member 5', '\Delta TNn [K]'); hold on;
%statsign_dTXx_h this is for TXx (and also seems work with TSA) but should it be island? %also replace caxes.dTXx bk to -0.125 to 0.125 match donat

end

% --------------------------------------------------------------------
% REGRESSION MEANS
% --------------------------------------------------------------------

if flags.plot_fig74 == 1

    % TXx regression ctl_mean
mf_plot_dom2(lon_mod,lat_mod,mean_slope_txx_ctl', [], caxes.dTXx, colormaps.dT2M, 0, 2, ' ', '1981-2010, CTL Mean', '\Delta TXx [K]'); hold on;
%statsign_dTXx_h this is for TXx (and also seems work with TSA) but should it be island? %also replace caxes.dTXx bk to -0.125 to 0.125 match donat

    % TXx regression irr_mean
mf_plot_dom2(lon_mod,lat_mod,mean_slope_txx_irr', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Mean', '\Delta TXx [K]'); hold on;
%statsign_dTXx_h this is for TXx (and also seems work with TSA) but should it be island? %also replace caxes.dTXx bk to -0.125 to 0.125 match donat

    % T2M regression ctl_mean
mf_plot_dom2(lon_mod, lat_mod, mean_slope_t2m_ctl', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Mean', '\Delta T2M [K]'); hold on;
%should it be island???

    % T2M regression irr_mean
mf_plot_dom2(lon_mod, lat_mod, mean_slope_t2m_irr', [], caxes.dT2M, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Mean', '\Delta T2M [K]'); hold on;
%should it be island???

    % TNn regression ctl_mean
mf_plot_dom2(lon_mod,lat_mod,mean_slope_tnn_ctl', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, CTL Mean', '\Delta TNn [K]'); hold on;
%statsign_dTXx_h this is for TXx (and also seems work with TSA) but should it be island? %also replace caxes.dTXx bk to -0.125 to 0.125 match donat

    % TNn regression irr_mean
mf_plot_dom2(lon_mod,lat_mod,mean_slope_tnn_irr', [], caxes.TNnreg, colormaps.dTXx, 0, 2, ' ', '1981-2010, IRR Mean', '\Delta TNn [K]'); hold on;
%statsign_dTXx_h this is for TXx (and also seems work with TSA) but should it be island? %also replace caxes.dTXx bk to -0.125 to 0.125 match donat

end

% --------------------------------------------------------------------
% REGRESSION RATIOS - CESM
% --------------------------------------------------------------------

if flags.plot_fig76 == 1

% TXx T2M ratio_CTL
slope3=mean_slope_txx_ctl'./mean_slope_t2m_ctl';
mf_plot_dom2(lon_mod, lat_mod, slope3, [], caxes.ratio, colormaps.ratio, 0, 2, 'Ratio', '1981-2010, CTL TXx:T2M', '\Delta TXx:T2M [K]'); hold on;

% TXx T2M ratio_IRR
slope4=mean_slope_txx_irr'./mean_slope_t2m_irr';
mf_plot_dom2(lon_mod, lat_mod, slope4, [], caxes.ratio, colormaps.ratio, 0, 2, 'Ratio', '1981-2010, IRR TXx:T2M', '\Delta TXx:T2M [K]'); hold on;

end

% --------------------------------------------------------------------
%  OBSERVATIONS - INDIVIDUAL REGRESSIONS
% --------------------------------------------------------------------

if flags.plot_fig75 == 1

%  TXx_HadEX2
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_had', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, HadEX2', '\Delta TXx [K]'); hold on;
%  TXx_GHCNDX
mf_plot_dom2(lon_mod,lat_mod,slope_TXx_GHCNDX', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, GHCNDEX', '\Delta TXx [K]'); hold on;
%  T2M_CRU
mf_plot_dom2(lon_mod,lat_mod,slope_T2M_CRU', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, CRU', '\Delta T2M [K]'); hold on;
%  TNn_HadEX2
mf_plot_dom2(lon_mod, lat_mod, slope_TNn_had', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, HadEX2 TNn', '\Delta TNn [K]'); hold on;
%  TNn_GHCNDX
mf_plot_dom2(lon_mod, lat_mod, slope_TNn_GHCNDX', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, GHCNDEX TNn', '\Delta TNn [K]'); hold on;

end

% --------------------------------------------------------------------
%  OBSERVATIONS - MEANS AND RATIO
% --------------------------------------------------------------------

if flags.plot_fig75 == 1

%  Mean observations
%  Mean TXx_HadEX2 & GHC observations
mf_plot_dom2(lon_mod, lat_mod, mean_slope_txx_obs', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, Mean observations', '\Delta TXx [K]'); hold on;
%  Mean TNn_HadEX2 & GHC observations
mf_plot_dom2(lon_mod, lat_mod, mean_slope_tnn_obs', [], caxes.dTXx, colormaps.dTXx, 0, 2, ' ', '1981-2010, Mean observations', '\Delta TNn [K]'); hold on;

%  Ratio mean TXx obs : T2M obs
obs_ratio=mean_slope_txx_obs'./slope_T2M_CRU';
mf_plot_dom2(lon_mod, lat_mod, obs_ratio, [], caxes.ratio, colormaps.ratio, 0, 2, 'Ratio Obs', '1981-2010, Obs TXx:T2M', '\Delta TXx:T2M [K]'); hold on;

end


% --------------------------------------------------------------------
% STATISTICS
% --------------------------------------------------------------------

if flags.plot_fig70 == 1

% TXx CTL
    % Unroll into a single vector and remove NaN values
meanslopes_TXx_ctl = mean_slope_txx_ctl(:);
meanslopes_TXx_ctl(isnan(meanslopes_TXx_ctl)) = [];
figure; %histogram
figure('OuterPosition',[100 200 950 410]); %try line
set(gcf, 'color', 'w'); %try line
h=histogram(meanslopes_TXx_ctl(meanslopes_TXx_ctl>0),'BinWidth',0.005);
h.FaceColor='red';
hold on
h1=histogram(meanslopes_TXx_ctl(meanslopes_TXx_ctl<0),'BinWidth',0.005);
h1.FaceColor='blue';
ylim([0 3500]);
xlim([-0.12 0.12]);
set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); %added
title('Distribution of mean ensemble member slopes - CTL TXx');
xlabel('Rate of change');
ylabel('Rate of change frequency');
        %stats for txx ctl ensemble mean 
nn = numel(meanslopes_TXx_ctl);
n2 = numel(meanslopes_TXx_ctl(meanslopes_TXx_ctl<0));
n3 = numel(meanslopes_TXx_ctl(meanslopes_TXx_ctl>0));
n4 = numel(meanslopes_TXx_ctl(meanslopes_TXx_ctl==0));
prcentTXless0_TXx_ctl = (n2 / nn) * 100;
prcentTXmore0_TXx_ctl = (n3 / nn) * 100;
prcentTXequal0_TXx_ctl = (n4 / nn) * 100;
mean_meanslopes_TXx_ctl = nanmean(meanslopes_TXx_ctl);
std_slope = std(meanslopes_TXx_ctl);
fprintf('The confidence interval for mean CTL TXx is: %f to %f\n\n', mean_meanslopes_TXx_ctl - 2.576*std_slope/sqrt(nn), mean_meanslopes_TXx_ctl + 2.576*std_slope/sqrt(nn));
fprintf('Mean slope CTL TXx is: %f\n', mean_meanslopes_TXx_ctl);


 % TXx IRR
meanslopes_TXx_irr = mean_slope_txx_irr(:);
meanslopes_TXx_irr(isnan(meanslopes_TXx_irr)) = [];
figure; %histogram
figure('OuterPosition',[100 200 950 410]); %try line
set(gcf, 'color', 'w'); %try line
h=histogram(meanslopes_TXx_irr(meanslopes_TXx_irr>0),'BinWidth',0.005);
h.FaceColor='red';
hold on
h1=histogram(meanslopes_TXx_irr(meanslopes_TXx_irr<0),'BinWidth',0.005);
h1.FaceColor='blue';
ylim([0 3500]);
xlim([-0.12 0.12]);
set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); %added
title('Distribution of mean ensemble member slopes - irr TXx');
xlabel('Rate of change');
ylabel('Rate of change frequency');
        %stats for txx ctl ensemble mean 
nn_irr = numel(meanslopes_TXx_irr);
n2_irr = numel(meanslopes_TXx_irr(meanslopes_TXx_irr<0));
n3_irr = numel(meanslopes_TXx_irr(meanslopes_TXx_irr>0));
n4_irr = numel(meanslopes_TXx_irr(meanslopes_TXx_irr==0));
prcentTXless0_TXx_IRR = (n2_irr / nn_irr) * 100;
prcentTXmore0_TXx_IRR = (n3_irr / nn_irr) * 100;
prcentTXequal0_TXx_IRR = (n4_irr / nn_irr) * 100;
mean_meanslopes_TXx_irr = nanmean(meanslopes_TXx_irr);
std_slopeTXx = std(meanslopes_TXx_irr);
fprintf('The confidence interval for mean irr TXx is: %f to %f\n\n', mean_meanslopes_TXx_irr - 2.576*std_slopeTXx/sqrt(nn_irr), mean_meanslopes_TXx_irr + 2.576*std_slopeTXx/sqrt(nn_irr));
fprintf('Mean slope irr TXx is: %f\n', mean_meanslopes_TXx_irr);


% t2m ctl
        % Unroll into a single vector and remove NaN values
meanslopes_T2M_ctl = mean_slope_t2m_ctl(:);
meanslopes_T2M_ctl(isnan(meanslopes_T2M_ctl)) = [];
figure; %histogram
figure('OuterPosition',[100 200 950 410]); %try line
set(gcf, 'color', 'w'); %try line
h=histogram(meanslopes_T2M_ctl(meanslopes_T2M_ctl>0),'BinWidth',0.005);
h.FaceColor='red';
hold on
h1=histogram(meanslopes_T2M_ctl(meanslopes_T2M_ctl<0),'BinWidth',0.005);
h1.FaceColor='blue';
ylim([0 2000]);
xlim([-0.08 0.08]);
set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); %added
title('Distribution of mean ensemble slopes - CTL T2M');
xlabel('Rate of change');
ylabel('Rate of change frequency');
        %stats for txx ctl ensemble mean 
nnT2M_ctl = numel(meanslopes_T2M_ctl);
n2T2M_ctl = numel(meanslopes_T2M_ctl(meanslopes_T2M_ctl<0));
n3T2M_ctl = numel(meanslopes_T2M_ctl(meanslopes_T2M_ctl>0));
n4T2M_ctl = numel(meanslopes_T2M_ctl(meanslopes_T2M_ctl==0));
prcentT2Mless0_T2M_ctl = (n2T2M_ctl / nnT2M_ctl) * 100;
prcentT2Mmore0_T2M_ctl = (n3T2M_ctl / nnT2M_ctl) * 100;
prcentT2Mequal0_T2M_ctl = (n4T2M_ctl / nnT2M_ctl) * 100;
mean_meanslopes_T2M_ctl = nanmean(meanslopes_T2M_ctl);
std_slopeT2M_ctl = std(meanslopes_T2M_ctl);
fprintf('The confidence interval for mean CTL T2M is: %f to %f\n\n', mean_meanslopes_T2M_ctl - 2.576*std_slopeT2M_ctl/sqrt(nnT2M_ctl), mean_meanslopes_T2M_ctl + 2.576*std_slope/sqrt(nnT2M_ctl));
fprintf('Mean slope for CTL T2M is: %f\n', mean_meanslopes_T2M_ctl);

% t2M irr
    % Unroll into a single vector and remove NaN values
meanslopes_T2M_irr = mean_slope_t2m_irr(:);
meanslopes_T2M_irr(isnan(meanslopes_T2M_irr)) = [];
figure; %histogram
figure('OuterPosition',[100 200 950 410]); %try line
set(gcf, 'color', 'w'); %try line
h=histogram(meanslopes_T2M_irr(meanslopes_T2M_irr>0),'BinWidth',0.005);
h.FaceColor='red';
hold on
h1=histogram(meanslopes_T2M_irr(meanslopes_T2M_irr<0),'BinWidth',0.005);
h1.FaceColor='blue';
ylim([0 2000]);
xlim([-0.08 0.08]);
set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); %added
title('Distribution of mean ensemble member slopes - irr T2M');
xlabel('Rate of change');
ylabel('Rate of change frequency');
        %stats for txx ctl ensemble mean 
nn_irrT2M = numel(meanslopes_T2M_irr);
n2_irrT2M = numel(meanslopes_T2M_irr(meanslopes_T2M_irr<0));
n3_irrT2M = numel(meanslopes_T2M_irr(meanslopes_T2M_irr>0));
n4_irrT2M = numel(meanslopes_T2M_irr(meanslopes_T2M_irr==0));
prcentT2Mless0_T2M_IRR = (n2_irrT2M / nn_irrT2M) * 100;
prcentT2Mmore0_T2M_IRR = (n3_irrT2M / nn_irrT2M) * 100;
prcentT2Mequal0_T2M_IRR = (n4_irrT2M / nn_irrT2M) * 100;
mean_meanslopes_T2M_irr = nanmean(meanslopes_T2M_irr);
std_slopeT2M = std(meanslopes_T2M_irr);
fprintf('The confidence interval for mean irr T2M is: %f to %f\n\n', mean_meanslopes_T2M_irr - 2.576*std_slopeT2M/sqrt(nn_irrT2M), mean_meanslopes_T2M_irr + 2.576*std_slopeT2M/sqrt(nn_irrT2M));
fprintf('Mean slope irr T2M is: %f\n', mean_meanslopes_T2M_irr);

% tnn ctl
        % Unroll into a single vector and remove NaN values
meanslopes_TNn_ctl = mean_slope_tnn_ctl(:);
meanslopes_TNn_ctl(isnan(meanslopes_TNn_ctl)) = [];
figure; %histogram
figure('OuterPosition',[100 200 950 410]); %try line
set(gcf, 'color', 'w'); %try line
h=histogram(meanslopes_TNn_ctl(meanslopes_TNn_ctl>0),'BinWidth',0.005);
h.FaceColor='red';
hold on
h1=histogram(meanslopes_TNn_ctl(meanslopes_TNn_ctl<0),'BinWidth',0.005);
h1.FaceColor='blue';
ylim([0 4200]);
xlim([-0.17 0.17]);
set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); %added
title('Distribution of mean ensemble slopes - CTL TNn');
xlabel('Rate of change');
ylabel('Rate of change frequency');
        %stats for tnn ctl ensemble mean 
nnTNn_ctl = numel(meanslopes_TNn_ctl);
n2TNn_ctl = numel(meanslopes_TNn_ctl(meanslopes_TNn_ctl<0));
n3TNn_ctl = numel(meanslopes_TNn_ctl(meanslopes_TNn_ctl>0));
n4TNn_ctl = numel(meanslopes_TNn_ctl(meanslopes_TNn_ctl==0));
prcentTNnless0_TNn_ctl = (n2TNn_ctl / nnTNn_ctl) * 100;
prcentTNnmore0_TNn_ctl = (n3TNn_ctl / nnTNn_ctl) * 100;
prcentTNnequal0_TNn_ctl = (n4TNn_ctl / nnTNn_ctl) * 100;
mean_meanslopes_TNn_ctl = nanmean(meanslopes_TNn_ctl);
std_slopeTNn_ctl = std(meanslopes_TNn_ctl);
fprintf('The confidence interval for mean CTL TNn is: %f to %f\n\n', mean_meanslopes_TNn_ctl - 2.576*std_slopeTNn_ctl/sqrt(nnTNn_ctl), mean_meanslopes_TNn_ctl + 2.576*std_slope/sqrt(nnTNn_ctl));
fprintf('Mean slope for CTL TNn is: %f\n', mean_meanslopes_TNn_ctl);

% tnn irr
        % Unroll into a single vector and remove NaN values
meanslopes_TNn_irr = mean_slope_tnn_irr(:);
meanslopes_TNn_irr(isnan(meanslopes_TNn_irr)) = [];
figure; %histogram
figure('OuterPosition',[100 200 950 410]); %try line
set(gcf, 'color', 'w'); %try line
h=histogram(meanslopes_TNn_irr(meanslopes_TNn_irr>0),'BinWidth',0.005);
h.FaceColor='red';
hold on
h1=histogram(meanslopes_TNn_irr(meanslopes_TNn_irr<0),'BinWidth',0.005);
h1.FaceColor='blue';
ylim([0 4200]);
xlim([-0.17 0.17]);
set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); %added
title('Distribution of mean ensemble slopes - irr TNn');
xlabel('Rate of change');
ylabel('Rate of change frequency');
        %stats for tnn irr ensemble mean 
nnTNn_irr = numel(meanslopes_TNn_irr);
n2TNn_irr = numel(meanslopes_TNn_irr(meanslopes_TNn_irr<0));
n3TNn_irr = numel(meanslopes_TNn_irr(meanslopes_TNn_irr>0));
n4TNn_irr = numel(meanslopes_TNn_irr(meanslopes_TNn_irr==0));
prcentTNnless0_TNn_irr = (n2TNn_irr / nnTNn_irr) * 100;
prcentTNnmore0_TNn_irr = (n3TNn_irr / nnTNn_irr) * 100;
prcentTNnequal0_TNn_irr = (n4TNn_irr / nnTNn_irr) * 100;
mean_meanslopes_TNn_irr = nanmean(meanslopes_TNn_irr);
std_slopeTNn_irr = std(meanslopes_TNn_irr);
fprintf('The confidence interval for mean irr TNn is: %f to %f\n\n', mean_meanslopes_TNn_irr - 2.576*std_slopeTNn_irr/sqrt(nnTNn_irr), mean_meanslopes_TNn_irr + 2.576*std_slope/sqrt(nnTNn_irr));
fprintf('Mean slope for irr TNn is: %f\n', mean_meanslopes_TNn_irr);

end


% --------------------------------------------------------------------
% paper figure 8
% --------------------------------------------------------------------


if flags.plot_fig8 == 1


% create figure
figure('OuterPosition',[10 100 1700 350]);
set(gcf, 'color', 'w');
set(gca,'color','w');


% plot the contribution to temperature change - all pixels
subplot(1,3,1)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_lp(1); 0       ; 0       ; dT_lp(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; dT_lp(2); dT_lp(3); 0       ; dT_lp(5); dT_lp(6); 0     ; 0          ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; 0       ; 0       ; 0       ; dTs_lp; dT2m_tot_lp], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; dT_lp(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-0.2 0.2]);
plot([6.5 6.5], [-0.2 0.2], '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\DeltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
legend('Direct forcings on \DeltaT_s', 'Indirect forcings on \DeltaT_s', 'Net signal', 2);
set(legend, 'Box', 'off', 'color', 'none', 'Fontweight', 'Bold', 'Fontsize', 8);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-0.201 -0.201 -0.201 -0.201 -0.201 -0.201 -0.201 -0.201],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'R', '\DeltaT_s', '\DeltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,0.2,{'a'},'ver','bottom','hor','left','Fontsize', 13)
text(9,0.2,{'all land'},'ver','bottom','hor','right','Fontsize', 13)


% plot the contribution to temperature change - irrigated pixels
subplot(1,3,2)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_ip(1); 0       ; 0       ; dT_ip(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; dT_ip(2); dT_ip(3); 0       ; dT_ip(5); dT_ip(6); 0     ; 0          ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; 0       ; 0       ; 0       ; dTs_ip; dT2m_tot_ip], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; dT_ip(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-1 1]);
plot([6.5 6.5], [-1 1], '--', 'color', [0.7 0.7 0.7]); hold off; 
ylabel('\DeltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-1.02 -1.02 -1.02 -1.02 -1.02 -1.02 -1.02 -1.02],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'R', '\DeltaT_s', '\DeltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,1,{'b'},'ver','bottom','hor','left','Fontsize', 13)
text(9,1,{'irrigated land'},'ver','bottom','hor','right','Fontsize', 13)


% plot the contribution to temperature change - irrigated pixels (local)
subplot(1,3,3)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_local_ip(1); 0             ; 0             ; dT_local_ip(4); 0             ; 0             ; 0           ; 0                ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0             ; dT_local_ip(2); dT_local_ip(3); 0             ; dT_local_ip(5); dT_local_ip(6); 0           ; 0                ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0             ; 0             ; 0             ; 0             ; 0             ; 0             ; dTs_local_ip; dT2m_tot_local_ip], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0             ; 0             ; 0             ; dT_local_ip(4); 0             ; 0             ; 0           ; 0                ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-3 3]);
plot([6.5 6.5], [-3 3], '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\DeltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-3.02 -3.02 -3.02 -3.02 -3.02 -3.02 -3.02 -3.02],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'R', '\DeltaT_s', '\DeltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,3,{'c'},'ver','bottom','hor','left','Fontsize', 13)
text(9,3,{'irrigated land - subgrid effect'},'ver','bottom','hor','right','Fontsize', 13)


% save figure
export_fig text/figures_paper/figure_08 -transparent;
% export_fig text/figures_paper/figure_08.pdf;
    

end



% --------------------------------------------------------------------
% paper figure 9
% --------------------------------------------------------------------


if flags.plot_fig9 == 1


% set bar width
barwidth = 0.6;
% ylims    = [-3 3];
ylims    = [-3.5 3.5];
xlims    = [0.5 13.5];


for i=1:nreg
% i=5    
    
ind = i; % for alphabet
if i > 4
  ind = ind - 4;
end

% create figure
figure('OuterPosition',[200 100 1000 370]);
set(gcf, 'color', 'w');
set(gca,'color','w', 'XColor', 'r');


% plot the contribution to temperature change - land pixels
subplot(1,2,1)
dT_plot = [squeeze(dT_srex_lp_mm(1:5,i,:))'; dT_srex_lp(1:5,i)'];
dT_plot_pos = dT_plot;
dT_plot_neg = dT_plot;
dT_plot_pos(dT_plot_pos < 0) = 0;
dT_plot_neg(dT_plot_neg > 0) = 0;
bar(dT_plot_neg, barwidth, 'stack', 'EdgeColor', 'none'); hold on;
bar(dT_plot_pos, barwidth, 'stack', 'EdgeColor', 'none'); hold on;
colormap(flipud(mf_colormap_cpt('Paired_05')));
plot(1:12,dTs_srex_lp_mm(i,:), '-s','Color',colors(10,:),'MarkerFaceColor', colors(10,:), 'MarkerSize',3, 'LineWidth',1); hold on;
plot(13,dTs_srex_lp(i), 's','Color',colors(10,:),'MarkerFaceColor', colors(10,:), 'MarkerSize',3, 'LineWidth',1); hold on;
ylim(ylims);
plot([12.5 12.5], ylims, '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\DeltaT_s  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
if ind==1
legend('\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 2);
set(legend, 'Box', 'off', 'color', 'none', 'Fontweight', 'Bold', 'Fontsize', 8);
end
set(gca,'xlim',xlims,'XTickLabel',{'J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D', ' '}, 'Xtick', 1:13)
text(xlims(1)+(xlims(2)-xlims(1))/50, ylims(2)+ylims(2)/100, alphabet(2*ind - 1),'ver','bottom','hor','left','Fontsize', 13, 'color', axcolor)
text(xlims(2)-(xlims(2)-xlims(1))/50, ylims(2)+ylims(2)/100, [srex_reg{i} ' - all land'],'ver','bottom','hor','right','Fontsize', 13, 'color', axcolor)
set(gca,'Xcolor', axcolor,'Ycolor', axcolor, 'Fontsize', 11, 'Fontweight', 'Bold')


% plot the contribution to temperature change - irrigated pixels
subplot(1,2,2)
dT_plot = [squeeze(dT_srex_ip_mm(1:5,i,:))'; dT_srex_ip(1:5,i)'];
dT_plot_pos = dT_plot;
dT_plot_neg = dT_plot;
dT_plot_pos(dT_plot_pos < 0) = 0;
dT_plot_neg(dT_plot_neg > 0) = 0;
bar(dT_plot_neg, barwidth, 'stack', 'EdgeColor', 'none'); hold on;
bar(dT_plot_pos, barwidth, 'stack', 'EdgeColor', 'none'); hold on;
colormap(flipud(mf_colormap_cpt('Paired_05')));
plot(1:12,dTs_srex_ip_mm(i,:), '-s','Color',colors(10,:),'MarkerFaceColor', colors(10,:), 'MarkerSize',3, 'LineWidth',1); hold on;
plot(13,dTs_srex_ip(i), 's','Color',colors(10,:),'MarkerFaceColor', colors(10,:), 'MarkerSize',3, 'LineWidth',1); hold on;
ylim(ylims);
plot([12.5 12.5], ylims, '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\DeltaT_s  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',xlims,'XTickLabel',{'J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D', ' '}, 'Xtick', 1:13)
text(xlims(1)+(xlims(2)-xlims(1))/50, ylims(2)+ylims(2)/100, alphabet(2*ind),'ver','bottom','hor','left','Fontsize', 13, 'color', axcolor)
text(xlims(2)-(xlims(2)-xlims(1))/50, ylims(2)+ylims(2)/100, [srex_reg{i} ' - irrigated land'],'ver','bottom','hor','right','Fontsize', 13, 'color', axcolor)
set(gca,'Xcolor', axcolor,'Ycolor', axcolor, 'Fontsize', 11, 'Fontweight', 'Bold')


% save figure
export_fig(sprintf('figures/used/STCdecomp_mm_%s.png',[num2str(i) '_' srex_reg{i}]), '-transparent');
% export_fig(sprintf('figures/used/STCdecomp_mm_%s.pdf',[num2str(i) '_' srex_reg{i}]), '-transparent');


end
    


end



% --------------------------------------------------------------------
% paper figure 10
% --------------------------------------------------------------------


if flags.plot_fig10 == 1

    
% is produced under plot_fig09...

end



% --------------------------------------------------------------------
% paper figure 11 - local effects
% --------------------------------------------------------------------


if flags.plot_fig11 == 1

    
% TS diff map - grid-scale
mf_plot_dom2(lon_mod, lat_mod, TS_irr - TS_ctl, statsign_dTS_h, caxes.dTS, colormaps.dTS, 0, 2, 'a', 'Grid-scale effect, 1981-2010, IRR-CTL', '\Delta T_s [K]'); hold on;
export_fig figures/used/dTS_total_lowres -transparent -png % save figure
% export_fig figures/used/dTS_total -m10 -transparent -png % save figure

    
% ET diff map - grid-scale
mf_plot_dom2(lon_mod, lat_mod, ET_irr - ET_ctl, statsign_dET_h, caxes.dET, colormaps.dET, 0, 2, 'b', 'Grid-scale effect, 1981-2010, IRR-CTL', '\Delta ET [mm yr^-^1]'); hold on;
export_fig figures/used/dET_total_lowres -transparent -png % save figure
% export_fig figures/used/dET_total -m10 -transparent -png % save figure

% TS irr map - subgrid-scale
mf_plot_dom2(lon_mod, lat_mod, TS_pft_irr(:,:,17) - TS_pft_irr(:,:,16), statsign_dTS_pft_h, caxes.dTS, colormaps.dTS, 0, 2, 'c', 'Subgrid-scale effect, 1981-2010, IRR', '\Delta T_s [K]'); hold on;
export_fig figures/used/dTS_subgrid_lowres -transparent -png % save figure
% export_fig figures/used/dTS_subgrid -m10 -transparent -png % save figure

    
% ET irr map - subgrid-scale
mf_plot_dom2(lon_mod, lat_mod, ET_pft_irr(:,:,17) - ET_pft_irr(:,:,16), statsign_dET_pft_h, caxes.dET, colormaps.dET, 0, 2, 'd', 'Subgrid-scale effect, 1981-2010, IRR', '\Delta ET [mm yr^-^1]'); hold on;
export_fig figures/used/dET_subgrid_lowres -transparent -png % save figure
% export_fig figures/used/dET_subgrid -m10 -transparent -png % save figure


% % % TS irr map - local scaled
% % mf_plot_dom2(lon_mod, lat_mod, dTS_local_scaled, [], caxes.dTS, colormaps.dTS, 0, 2, 'b', 'Local effect (scaled), 1981-2010, IRR', '\Delta T_s [K]'); hold on;
% % export_fig figures/used/dTS_local_scaled -transparent -png % save figure
% % 
% % % TS irr map - non-local scaled
% % mf_plot_dom2(lon_mod, lat_mod, dTS_nonlocal, [], caxes.dTS, colormaps.dTS, 0, 2, 'c', 'non-local effect, 1981-2010, IRR', '\Delta T_s [K]'); hold on;
% % export_fig figures/used/dTS_nonlocal -transparent -png % save figure


% % % ET irr map - local scaled
% % mf_plot_dom2(lon_mod, lat_mod, dET_local_scaled, [], caxes.dET, colormaps.dET, 0, 2, 'b', 'Local effect (scaled), 1981-2010, IRR', 'T_v_e_g [K]'); hold on;
% % export_fig figures/used/dET_local_scaled -transparent -png % save figure
% % 
% % % ET irr map - non-local scaled
% % mf_plot_dom2(lon_mod, lat_mod, dET_nonlocal, [], caxes.dET, colormaps.dET, 0, 2, 'c', 'non-local effect, 1981-2010, IRR', 'T_v_e_g [K]'); hold on;
% % export_fig figures/used/dET_nonlocal -transparent -png % save figure


end



% --------------------------------------------------------------------
% Review illustration 2 - bar plots of qirr
% --------------------------------------------------------------------


if flags.plot_ill01 == 1


% create figure
figure('OuterPosition',[100 100 1400 450]);
set(gcf, 'color', 'w');
set(gca,'color','w', 'XColor', 'r');

% QIRR
subplot(1,2,1)
h = bar(1:7,QIRR_srex_offline,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 250]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold','color', axcolor); %#ok<NBRAK>
ylabel('Q_i_r_r [mm yr^-^1]', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(h(1:5), 'OBS', 'IRR_{offline} (irr_{factor} = 0.0)', 'IRR_{offline} (irr_{factor} = 0.3)', 'IRR_{offline} (irr_{factor} = 0.7)', 'IRR_{offline} (irr_{factor} = 1.0)', 2);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 10,'textcolor', axcolor);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold','Xcolor', axcolor,'Ycolor', axcolor);
text(0.1,250,{'a'},'ver','bottom','hor','left','Fontsize', 12)
text(8,250,{'irrigation amounts - 1° offline'},'ver','bottom','hor','right','Fontsize', 12)


% QIRR
subplot(1,2,2)
h = bar(1:7,QIRR_srex_offline_2deg,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 250]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold','color', axcolor); %#ok<NBRAK>
ylabel('Q_i_r_r [mm yr^-^1]', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(h(1:5), 'OBS', 'IRR_{offline} (irr_{factor} = 0.0)', 'IRR_{offline} (irr_{factor} = 0.3)', 'IRR_{offline} (irr_{factor} = 0.7)', 'IRR_{offline} (irr_{factor} = 1.0)', 2);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 10,'textcolor', axcolor);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold','Xcolor', axcolor,'Ycolor', axcolor);
text(0.1,250,{'b'},'ver','bottom','hor','left','Fontsize', 12)
text(8,250,{'irrigation amounts - 2° offline'},'ver','bottom','hor','right','Fontsize', 12)


% save figure
export_fig text/review/illustrations/illustration_01 -transparent;


end



% --------------------------------------------------------------------
% Review illustration 4 - ecdf of irrigated pixels
% --------------------------------------------------------------------


if flags.plot_ill04 == 1


AAA   = pct_irr(island);
AAB   = AAA(AAA > 0);
[f,x] = ecdf(AAB);

figure;
set(gcf, 'color', 'w');
set(gca,'color','w');
z(3,1) = plot(x, f, 'linewidth', 2, 'color', colors(17,:)); hold on;
xlabel('Area equipped for irrigation (%)'     , 'Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor); 
ylabel(['Fraction of land pixels with non-zero' 10 'area equipped for irrigation'], 'Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor);
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,'Ycolor', axcolor, 'xtick', [1 10:10:100]);
export_fig text/review/illustrations/illustration_04 -pdf;


end



% --------------------------------------------------------------------
% maps of evaluation
% --------------------------------------------------------------------


if flags.plot_eval == 1


% LHF irr eval map - LandFlux-EVAL
mf_plot_dom2(lon_mod, lat_mod, LHF_irr_8905-nanmean(LHF_lfev_8905,3), [], caxes.eflx, colormaps.eflx, 0, 1, 'a', '1989-2005, IRR-LandFlux-EVAL', 'LHF (W m^-^2)'); hold on;
export_fig figures/eval_LHF_irr-lfev -transparent -png % save figure


% LHF irr eval map - GLEAM
mf_plot_dom2(lon_mod, lat_mod, LHF_irr-nanmean(LHF_glea,3), [], caxes.eflx, colormaps.eflx, 0, 1, 'b', '1981-2010, IRR-Fluxnet-mte', 'LHF (W m^-^2)'); hold on;
export_fig figures/eval_LHF_irr-glea -transparent -png % save figure


% LHF irr eval map - Fluxnet-mte
mf_plot_dom2(lon_mod, lat_mod, LHF_irr_8210-nanmean(LHF_mte_8210,3), [], caxes.eflx, colormaps.eflx, 0, 1, 'b', '1982-2010, IRR-Fluxnet-mte', 'LHF (W m^-^2)'); hold on;
export_fig figures/eval_LHF_irr-mte -transparent -png % save figure


% SHF irr eval map - Fluxnet-mte
mf_plot_dom2(lon_mod, lat_mod, SHF_irr_8210-nanmean(SHF_mte_8210,3), [], caxes.eflx, colormaps.eflx, 0, 1, 'c', '1982-2010, IRR-Fluxnet-mte', 'SHF (W m^-^2)'); hold on;
export_fig figures/eval_SHF_irr-mte -transparent -png % save figure


% SWnet irr eval map - Fluxnet-mte
mf_plot_dom2(lon_mod, lat_mod, SWnet_irr_8407-nanmean(SWnet_srb_8407,3), [], caxes.eflx, colormaps.eflx, 0, 1, 'd', '1984-2007, IRR-SRB', 'SWnet (W m^-^2)'); hold on;
export_fig figures/eval_SWnet_irr-srb -transparent -png % save figure


% LWnet irr eval map - Fluxnet-mte
mf_plot_dom2(lon_mod, lat_mod, LWnet_irr_8407-nanmean(LWnet_srb_8407,3), [], caxes.eflx, colormaps.eflx, 0, 1, 'e', '1984-2007, IRR-SRB', 'LWnet (W m^-^2)'); hold on;
export_fig figures/eval_LWnet_irr-srb -transparent -png % save figure


% PRECT irr eval map - GPCP
mf_plot_dom2(lon_mod, lat_mod, PRECT_irr-nanmean(PRECT_gpcp,3), [], caxes.epre, colormaps.epre, 0, 1, 'f', '1981-2010, IRR-GPCP', 'PREC (mm yr^-^1)'); hold on;
export_fig figures/eval_PRECT_irr-gpcp -transparent -png % save figure


% PRECT irr eval map - CRU
mf_plot_dom2(lon_mod, lat_mod, PRECT_irr-nanmean(PRECT_cru,3), [], caxes.epre, colormaps.epre, 0, 1, 'g', '1981-2010, IRR-CRU', 'PREC (mm yr^-^1)'); hold on;
export_fig figures/eval_PRECT_irr-cru -transparent -png % save figure


% T2M irr eval map - CRU
mf_plot_dom2(lon_mod, lat_mod, T2M_irr-nanmean(T2M_cru,3), [], caxes.eTXx, colormaps.eTXx, 0, 1, 'h', '1981-2010, IRR-CRU', 'T (K)'); hold on;
export_fig figures/eval_T2M_irr-cru -transparent -png % save figure


% TXx irr eval map - HadEX2
mf_plot_dom2(lon_mod, lat_mod, TXx_irr-nanmean(TXx_had,3), [], caxes.eTXx, colormaps.eTXx, 0, 1, 'i', '1981-2010, IRR-HadEX2', 'TXx (K)'); hold on;
export_fig figures/eval_TXx_irr-had -transparent -png % save figure


% TXx irr eval map - GHCNDEX
mf_plot_dom2(lon_mod, lat_mod, TXx_irr-nanmean(TXx_ghcn,3), [], caxes.eTXx, colormaps.eTXx, 0, 1, 'j', '1981-2010, IRR-GHCNDEX', 'TXx (K)'); hold on;
export_fig figures/eval_TXx_irr-ghcn -transparent -png % save figure


% TNn irr eval map - HadEX2
mf_plot_dom2(lon_mod, lat_mod, TNn_irr-nanmean(TNn_had,3), [], caxes.eTXx, colormaps.eTXx, 0, 1, 'k', '1981-2010, IRR-HadEX2', 'TNn (K)'); hold on;
export_fig figures/eval_TNn_irr-had -transparent -png % save figure


% TNn irr eval map - GHCNDEX
mf_plot_dom2(lon_mod, lat_mod, TNn_irr-nanmean(TNn_ghcn,3), [], caxes.eTXx, colormaps.eTXx, 0, 1, 'l', '1981-2010, IRR-GHCNDEX', 'TNn (K)'); hold on;
export_fig figures/eval_TNn_irr-ghcn -transparent -png % save figure



end




% --------------------------------------------------------------------
% maps of extremes
% --------------------------------------------------------------------


if flags.plot_extr == 1


% WSDI ctl map
mf_plot_dom2(lon_mod, lat_mod, WSDI_ctl, [], caxes.WSDI, colormaps.WSDI, 0, 1, 'a', '1981-2010, CTL', 'Warm Spell Duration Index'); hold on;
export_fig figures/WSDI_ctl -transparent -png % save figure
% WSDI irr map
mf_plot_dom2(lon_mod, lat_mod, WSDI_irr, [], caxes.WSDI, colormaps.WSDI, 0, 1, 'b', '1981-2010, IRR', 'Warm Spell Duration Index'); hold on;
export_fig figures/WSDI_irr -transparent -png % save figure
% WSDI diff map
mf_plot_dom2(lon_mod, lat_mod, WSDI_irr-WSDI_ctl, [], caxes.dWSDI, colormaps.dWSDI, 0, 1, 'c', '1981-2010, IRR - CTL', 'Warm Spell Duration Index'); hold on;
export_fig figures/WSDI_irr-ctl -transparent -png % save figure


end



% --------------------------------------------------------------------
% bar plots
% --------------------------------------------------------------------


if flags.plot_bars == 1


% QRUN
figure;
h = bar(1:7,QRUNOFF_srex,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 1200]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('Q_r_u_n (mm yr^-^1)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'ERA-Interm Land', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_QRUN -transparent -png % save figure


% LHF LandFLux-EVAL
figure;
h = bar(1:7,LHF_srex_lfev,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 100]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('LHF (W m^-^2)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'LandFlux Eval', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_LHF_lfev -transparent -png % save figure


% LHF FLUXNET-MTE
figure;
h = bar(1:7,LHF_srex_mte,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 100]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('LHF (W m^-^2)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'Fluxnet-MTE', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_LHF_mte -transparent -png % save figure


% SHF
figure;
h = bar(1:7,SHF_srex,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 80]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('SHF (W m^-^2)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'Fluxnet-MTE', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_SHF -transparent -png % save figure


% SWnet
figure;
h = bar(1:7,SWnet_srex,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 100 200]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('SW_n_e_t (W m^-^2)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'GEWEX-SRB', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_SWnet -transparent -png % save figure


% LWnet
figure;
h = bar(1:7,LWnet_srex,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
% axis([0 8 0 80]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('LW_n_e_t (W m^-^2)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'GEWEX-SRB', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_LWnet -transparent -png % save figure


% T2M
figure;
h = bar(1:7,T2M_srex,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 275 305]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('T_2_m (K)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'CRU', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_T2M -transparent -png % save figure


% PRECT - CRU
figure;
h = bar(1:7,PRECT_srex_cru,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 2600]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('PRECT (mm yr^-^1)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'CRU', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_PRECT_cru -transparent -png % save figure


% PRECT - GPCP
figure;
h = bar(1:7,PRECT_srex_gpcp,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 0 2600]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('PRECT (mm yr^-^1)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'GPCP', 'IRR', 'CTL', 2);
set(legend, 'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_PRECT_gpcp -transparent -png % save figure


% TXx - GHCNDEX
figure;
h = bar(1:7,TXx_srex_ghcn,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 300 320]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('TXx (K)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'GHCNDEX', 'IRR', 'CTL', 1);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_TXx_ghcn -transparent -png % save figure


% TXx - HadEX2
figure;
h = bar(1:7,TXx_srex_had,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 300 320]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('TXx (K)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'HadEX2', 'IRR', 'CTL', 1);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_TXx_had -transparent -png % save figure


% TNn - GHCNDEX
figure;
h = bar(1:7,TNn_srex_ghcn,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 240 290]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('TNn (K)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'GHCNDEX', 'IRR', 'CTL', 1);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_TNn_ghcn -transparent -png % save figure


% TNn - HadEX2
figure;
h = bar(1:7,TNn_srex_had,'hist'); hold on;
g(1) = plot(1,1, 'b', 'LineWidth',2.5); hold on;
g(2) = plot(1,1, 'g', 'LineWidth',2.5); hold on;
g(3) = plot(1,1, 'r', 'LineWidth',2.5); hold off;
set(h(1),'facecolor',[0.5 0.5 1]) 
set(h(2),'facecolor',[0.5 1 0.5]) 
set(h(3),'facecolor',[1 0.5 0.5])
set(h,'edgecolor','none')
axis([0 8 240 290]);
mf_xticklabel_rotate([1:7],45,srex_reg,'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
ylabel('TNn (K)', 'Fontsize', 14, 'Fontweight', 'Bold'); 
legend(g, 'HadEX2', 'IRR', 'CTL', 1);
set(legend,'YColor','w','XColor','w', 'Fontweight', 'Bold', 'Fontsize', 11);
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
export_fig figures/Bars_TNn_had -transparent -png % save figure


end



% --------------------------------------------------------------------
% added value matrix
% --------------------------------------------------------------------


if flags.plot_addv == 1


% workaround to get white spaces
RMSE_change_perc_plot   = nan(nprod,(nreg+2)*4+1);
for i=1:nreg+2
    RMSE_change_perc_plot(:,i*4-2:i*4) = [RMSE_change_perc(:,i), RMSE_change_perc(:,i), RMSE_change_perc(:,i)];
end

    
% generate plot
figure;
h = imagesc(1:length(RMSE_change_perc_plot(1,:)),1:nprod,RMSE_change_perc_plot(1:nprod,:));
set(h,'alphadata',~isnan(RMSE_change_perc_plot(1:nprod,:)))
set(gca, 'Fontsize', 13, 'Fontweight', 'Bold','TickLength', [0 0]);
set(gca,'Ytick',1:1:nprod,'YTickLabel',prod_names, 'Fontsize', 10);
mf_tightfig; 
mf_xticklabel_rotate([3:4:(nreg+2)*4],45,[srex_reg, 'all land', 'irrigated'],'interpreter','none','Fontsize', 11, 'Fontweight', 'Bold'); %#ok<NBRAK>
cbh = colorbar('Fontsize', 14, 'Fontweight', 'Bold');
colormap(flipud(mf_colormap_cpt('cbcRdYlGn',10)));
caxis([-5 5])
text((nreg+5.5)*4,nprod/2+0.5,'% RMSE change','ver','bottom','hor','center', 'Fontweight', 'Bold', 'Fontsize', 12,'rotation',-90); hold off;
box off
export_fig figures/added_value -transparent -png % save figure


end



% --------------------------------------------------------------------
% Surface temperature change decomposition - total effect
% --------------------------------------------------------------------


if flags.plot_STCD == 1

    
% create figure
figure('OuterPosition',[200 10 1000 750]);
set(gcf, 'color', 'w');
set(gca,'color','w');


% plot the net radiative forcing - all pixels
subplot(2,2,1)
bar    ([1; 2; 3; 4; 5], dR_lp(1:5), 'FaceColor',[0.7 0.7 0.7]); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5])
ylim([-2 2]);
ylabel('Irrigation impact  [W m^-^2]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 6],'XTickLabel',{' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5])
text(1:5,[-2.02 -2.02 -2.02 -2.02 -2.02],{'SW_{net}', 'LW_{net}', 'LHF', 'SHF', 'G'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
text(0.1,2,{'a'},'ver','bottom','hor','left','Fontsize', 13)
text(6,2,{'all land'},'ver','bottom','hor','right','Fontsize', 13)
 

% plot the net radiative forcing - lake pixels
subplot(2,2,2)
bar    ([1; 2; 3; 4; 5], dR_ip(1:5), 'FaceColor',[0.7 0.7 0.7]); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5])
ylim([-5 5]);
ylabel('Irrigation impact  [W m^-^2]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 6],'XTickLabel',{' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5])
text(1:5,[-5.02 -5.02 -5.02 -5.02 -5.02],{'SW_{net}', 'LW_{net}', 'LHF', 'SHF', 'G'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
text(0.1,5,{'b'},'ver','bottom','hor','left','Fontsize', 13)
text(6,5,{'irrigated land'},'ver','bottom','hor','right','Fontsize', 13)


% plot the contribution to temperature change - all pixels
subplot(2,2,3)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_lp(1); 0       ; 0       ; dT_lp(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; dT_lp(2); dT_lp(3); 0       ; dT_lp(5); dT_lp(6); 0     ; 0          ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; 0       ; 0       ; 0       ; dTs_lp; dT2m_tot_lp], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; dT_lp(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-0.2 0.2]);
plot([6.5 6.5], [-0.2 0.2], '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\deltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
legend('Direct forcings on \deltaT_s', 'Indirect forcings on \deltaT_s', 'Net signal', 2);
set(legend, 'Box', 'off', 'color', 'none', 'Fontweight', 'Bold', 'Fontsize', 8);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-0.201 -0.201 -0.201 -0.201 -0.201 -0.201 -0.201 -0.201],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'res', '\deltaT_s', '\deltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,0.2,{'c'},'ver','bottom','hor','left','Fontsize', 13)
text(9,0.2,{'all land'},'ver','bottom','hor','right','Fontsize', 13)


% plot the contribution to temperature change - lake pixels
subplot(2,2,4)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_ip(1); 0       ; 0       ; dT_ip(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; dT_ip(2); dT_ip(3); 0       ; dT_ip(5); dT_ip(6); 0     ; 0          ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; 0       ; 0       ; 0       ; dTs_ip; dT2m_tot_ip], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0       ; 0       ; 0       ; dT_ip(4); 0       ; 0       ; 0     ; 0          ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-1 1]);
plot([6.5 6.5], [-1 1], '--', 'color', [0.7 0.7 0.7]); hold off; 
ylabel('\deltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-1.02 -1.02 -1.02 -1.02 -1.02 -1.02 -1.02 -1.02],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'res', '\deltaT_s', '\deltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,1,{'d'},'ver','bottom','hor','left','Fontsize', 13)
text(9,1,{'irrigated land'},'ver','bottom','hor','right','Fontsize', 13)


% save figure
export_fig figures/STCdecomp/STCdecomp_total.png;
export_fig figures/STCdecomp/STCdecomp_total.pdf;
    

end



% --------------------------------------------------------------------
% Surface temperature change decomposition - local effect
% --------------------------------------------------------------------


if flags.plot_STCD_local == 1

    
% create figure
figure('OuterPosition',[200 10 1000 750]);
set(gcf, 'color', 'w');
set(gca,'color','w');
 

% plot the net radiative forcing - lake pixels
subplot(2,2,2)
bar    ([1; 2; 3; 4; 5], dR_local_ip(1:5), 'FaceColor',[0.7 0.7 0.7]); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5])
ylim([-16 16]);
ylabel('Irrigation impact  [W m^-^2]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 6],'XTickLabel',{' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5])
text(1:5,[-16.02 -16.02 -16.02 -16.02 -16.02],{'SW_{net}', 'LW_{net}', 'LHF', 'SHF', 'G'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
text(0.1,16,{'a'},'ver','bottom','hor','left','Fontsize', 13)
text(6,16,{'irrigated land - local effect'},'ver','bottom','hor','right','Fontsize', 13)


% plot the contribution to temperature change - lake pixels
subplot(2,2,4)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_local_ip(1); 0             ; 0             ; dT_local_ip(4); 0             ; 0             ; 0           ; 0                ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0             ; dT_local_ip(2); dT_local_ip(3); 0             ; dT_local_ip(5); dT_local_ip(6); 0           ; 0                ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0             ; 0             ; 0             ; 0             ; 0             ; 0             ; dTs_local_ip; dT2m_tot_local_ip], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0             ; 0             ; 0             ; dT_local_ip(4); 0             ; 0             ; 0           ; 0                ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-3 3]);
plot([6.5 6.5], [-3 3], '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\deltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-3.02 -3.02 -3.02 -3.02 -3.02 -3.02 -3.02 -3.02],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'res', '\deltaT_s', '\deltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,3,{'b'},'ver','bottom','hor','left','Fontsize', 13)
text(9,3,{'irrigated land - local effect'},'ver','bottom','hor','right','Fontsize', 13)


% save figure
export_fig figures/STCdecomp/STCdecomp_local.png;
export_fig figures/STCdecomp/STCdecomp_local.pdf;
    

end



% --------------------------------------------------------------------
% Surface temperature change decomposition - srex regions
% --------------------------------------------------------------------


if flags.plot_STCD_srex == 1

    
for i=1:nreg
     
    
% create figure
figure('OuterPosition',[200 100 1000 370]);
set(gcf, 'color', 'w');
set(gca,'color','w');

    
% plot the contribution to temperature change - all pixels
subplot(1,2,1)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_srex_lp(1,i); 0              ; 0              ; dT_srex_lp(4,i); 0              ; 0              ; 0             ; 0                  ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0              ; dT_srex_lp(2,i); dT_srex_lp(3,i); 0              ; dT_srex_lp(5,i); dT_srex_lp(6,i); 0             ; 0                  ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0              ; 0              ; 0              ; 0              ; 0              ; 0              ; dTs_srex_lp(i); dT2m_tot_srex_lp(i)], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0              ; 0              ; 0              ; dT_srex_lp(4,i); 0              ; 0              ; 0             ; 0                  ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-0.2 0.2]);
plot([6.5 6.5], [-0.2 0.2], '--', 'color', [0.7 0.7 0.7]); hold off;
ylabel('\deltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
if i==1
legend('Direct forcings on \deltaT_s', 'Indirect forcings on \deltaT_s', 'Net signal', 2);
set(legend, 'Box', 'off', 'color', 'none', 'Fontweight', 'Bold', 'Fontsize', 8);
end
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-0.201 -0.201 -0.201 -0.201 -0.201 -0.201 -0.201 -0.201],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'res', '\deltaT_s', '\deltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,0.2,alphabet(2*i-1),'ver','bottom','hor','left','Fontsize', 13)
text(9,0.2,[srex_reg{i} ' - all land'],'ver','bottom','hor','right','Fontsize', 13)


% plot the contribution to temperature change - lake pixels
subplot(1,2,2)
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [dT_srex_ip(1,i); 0              ; 0              ; dT_srex_ip(4,i); 0              ; 0              ; 0             ; 0                  ], 'FaceColor', colors(1,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0              ; dT_srex_ip(2,i); dT_srex_ip(3,i); 0              ; dT_srex_ip(5,i); dT_srex_ip(6,i); 0             ; 0                  ], 'FaceColor', colors(5,:)); hold on;
bar    ([1; 2; 3; 4; 5; 6; 7; 8], [0              ; 0              ; 0              ; 0              ; 0              ; 0              ; dTs_srex_ip(i); dT2m_tot_srex_ip(i)], 'FaceColor', 'k'); hold on;
h = bar([1; 2; 3; 4; 5; 6; 7; 8], [0              ; 0              ; 0              ; dT_srex_ip(4,i); 0              ; 0              ; 0             ; 0                  ], 'FaceColor', 'k'); hold on;
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold');
set(gca, 'XTick', [1, 2, 3, 4, 5, 6, 7, 8])
ylim([-1 1]);
plot([6.5 6.5], [-1 1], '--', 'color', [0.7 0.7 0.7]); hold off; 
ylabel('\deltaT_s forcing  [K]', 'Fontweight', 'Bold', 'Fontsize', 13);
set(gca,'xlim',[0 9],'XTickLabel',{' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},'xtick',[1 2 3 4 5 6 7 8])
text(1:8,[-1.02 -1.02 -1.02 -1.02 -1.02 -1.02 -1.02 -1.02],{'\alpha', 'SW_i', 'LW_i', 'LHF', 'SHF', 'res', '\deltaT_s', '\deltaT_2_m'},'ver','top','hor','center','Fontsize', 11, 'Fontweight', 'Bold')
hPatch1 = findobj(h, 'Type', 'patch');                    % Apply Hatch Fill(1)
h1 = mf_hatchfill(hPatch1, 'single', 45, 3, colors(1,:)); % Apply Hatch Fill(2)
set(h1, 'Color', colors(5,:));                            % Apply Hatch Fill(3)
text(0.1,1,alphabet(2*i),'ver','bottom','hor','left','Fontsize', 13)
text(9,1,[srex_reg{i} ' - irrigated land'],'ver','bottom','hor','right','Fontsize', 13)


% save figure
export_fig(sprintf('figures/STCdecomp/STCdecomp_%s.png',[num2str(i) '_' srex_reg{i}]), '-transparent');
export_fig(sprintf('figures/STCdecomp/STCdecomp_%s.pdf',[num2str(i) '_' srex_reg{i}]), '-transparent');


end


end



% --------------------------------------------------------------------
% percentile changes
% --------------------------------------------------------------------


if flags.plot_perc == 1

    
% initialisation - y-axis limits (see srex_vars)
ylims = [ -1     1  ; ...  % TSA
          -0.2   0.2; ...  % QRUNOFF         
          -1    10  ; ...  % Qle
         -10     2  ; ...  % FSH
          -4     4  ; ...  % FSA
          -5     2      ]; % FIRA
        

 
% prepare for loop
k = 1;


% bin other variables to OT
for i=1:length(srex_vars)    

    for j=1:length(srex_reg)
        
        % get differences per bin    
        bindiff              = binmedian_irr{i,j} - binmedian_ctl{i,j};
        bindiff_Q25          = binQ25_irr{i,j}    - binQ25_ctl{i,j};
        bindiff_Q75          = binQ75_irr{i,j}    - binQ75_ctl{i,j};
        ind_pos              = find(bindiff > 0);
        ind_neg              = find(bindiff < 0);
        bindiff_pos          = zeros(size(bindiff));
        bindiff_neg          = zeros(size(bindiff));
        bindiff_pos(ind_pos) = bindiff(ind_pos);
        bindiff_neg(ind_neg) = bindiff(ind_neg);

        % quantile change of TOT_PREC RCP-HIS - CCLM²
        figure('OuterPosition',[100 200 950 410]);
        set(gcf, 'color', 'w');
        h(1) = bar(1:nbins,bindiff_pos,'histc'); hold on;
        h(2) = bar(1:nbins,bindiff_neg,'histc'); hold on;
        set(h(1),'facecolor',colors(16,:),'edgecolor','none');
        set(h(2),'facecolor',colors(17,:),'edgecolor','none');
        errorbar(1.5:nbins+0.5, bindiff, bindiff_Q25, bindiff_Q75,'k.','linewidth',1.5); hold on
        axis([1 nbins+1 ylims(i,1) ylims(i,2)]);
        set(gca,'XTickLabel',{' ','P10',' ','P30',' ','P50',' ','P70', ' ','P90'}, 'Xtick', 1:nbins/10:nbins,'fontsize',14)
        ylabel(['\Delta ' srex_ylabels{i} ' [' srex_units{i} ']'], 'Fontsize', 14, 'Fontweight', 'Bold'); 
        set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');
        text(1.15,ylims(i,2),alphabet(k),'ver','bottom','hor','center','Fontsize', 14)
        text(nbins+1,ylims(i,2),[srex_ylabels{i} ', ' srex_reg{j}],'ver','bottom','hor','right','Fontsize', 11, 'Fontweight', 'Bold')

        % save figure
        export_fig(sprintf('figures/perc_change/perc_change_%s.png',[num2str(k) '_' srex_vars{i} '_' srex_reg{j}]), '-transparent');
        export_fig(sprintf('figures/perc_change/perc_change_%s.pdf',[num2str(k) '_' srex_vars{i} '_' srex_reg{j}]), '-transparent');
                
        % for panel letters
        k = k + 1;
        
    end
    
end
    
end




% --------------------------------------------------------------------
% T2M maps per ensemble members
% --------------------------------------------------------------------

if flags.plot_T2M_pe == 1

for i=1:5
    % get indices
    ind = (i-1)*30+1: i*30;
    
    % T2M ctl map
    mf_plot_dom2(lon_mod, lat_mod, nanmean(T2M_ctl_ym_pe(:,:,ind),3), [], caxes.T2M, colormaps.T2M, 0, 2, ' ', '1981-2010, CTL', 'T_2_m [K]'); hold on;
    export_fig(sprintf('figures/for_Daniela_T2M_ctl_em%s.png',num2str(i)), '-transparent');
    
    % T2M irr map
    mf_plot_dom2(lon_mod, lat_mod, nanmean(T2M_irr_ym_pe(:,:,ind),3), [], caxes.T2M, colormaps.T2M, 0, 2, ' ', '1981-2010, IRR', 'T_2_m [K]'); hold on;
    export_fig(sprintf('figures/for_Daniela_T2M_irr_em%s.png',num2str(i)), '-transparent');
end


end
