%
%--------
%-------- same as previous
%----for gridscale (see localprogress file)
%below uses yearmean eqiv of the h1 with timmean (fig 11, gridscale effect)
%---m1 ctl

[~, ~, shf_grid_ctl, LHF_grid_ctl] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_atm_h1_yearmean.nc'   , 'SHFLX', 'LHFLX');
shf_grid_ctl=permute(shf_grid_ctl,[2,1,3]);
LHF_grid_ctl=permute(LHF_grid_ctl,[2,1,3]);
%%
[~, ~, shf_grid_ctl_vector] = mf_fieldmean_previous(shf_grid_ctl, island, isirr);
[~, ~, lhf_grid_ctl_vector] = mf_fieldmean_previous(LHF_grid_ctl, island, isirr);
%%
[~, ~, shf_grid_irr, LHF_grid_irr] = mf_load('f.e122.F1850PDC5.f09_g16.irrigation-io192.ensmean_atm_h1_yearmean.nc'   , 'SHFLX','LHFLX');
shf_grid_irr=permute(shf_grid_irr,[2,1,3]);
LHF_grid_irr=permute(LHF_grid_irr,[2,1,3]);
[~, ~, shf_grid_irr_vector] = mf_fieldmean_previous(shf_grid_irr, island, isirr);
[~, ~, lhf_grid_irr_vector] = mf_fieldmean_previous(LHF_grid_irr, island, isirr);

%%
[~, ~, shf_grid_CA, LHF_grid_CA] = mf_load('f.e122.F1850PDC5.f09_g16.BASE-io192.ensmean_atm_h1_yearmean.nc'   , 'SHFLX','LHFLX');
shf_grid_CA=permute(shf_grid_CA,[2,1,3]);
LHF_grid_CA=permute(LHF_grid_CA,[2,1,3]);
[~, ~, shf_grid_CA_vector] = mf_fieldmean_previous(shf_grid_CA, island, isca);
[~, ~, lhf_grid_CA_vector] = mf_fieldmean_previous(LHF_grid_CA, island, isca);
[~, ~, shf_grid_ctl_vector2] = mf_fieldmean_previous(shf_grid_ctl, island, isca);
[~, ~, lhf_grid_ctl_vector2] = mf_fieldmean_previous(LHF_grid_ctl, island, isca);


%%
%irrigagtion grid SHF
[st2mirrip34, b91234] = tsreg(years,shf_grid_irr_vector);
[st2mctlip34, b691234] = tsreg(years,shf_grid_ctl_vector);
%[st2mcruip, b7912] = tsreg(years3,ts_obs_ip2);

s1=scatter(years,shf_grid_irr_vector); hold on;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';
s2=scatter(years,shf_grid_ctl_vector); hold on;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';

set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); 
xlabel('Year');
ylabel('Mean SHF [W/m2/year]');
title('Irrigated pixels, SHF');
xlim([1980 2012]);
%ylim([288.2 290.2]);
g(1) =plot(years,((st2mirrip34*years)+b91234),'b','LineWidth',1.4); hold on; 
g(2)=plot(years,((st2mctlip34*years)+b691234),'r','LineWidth',1.4); hold on;
legend('IRR','CTL','location', 'Southeast'); 
%title('(d)                                                                     Gridscale, SHF','Fontsize', 14)
title('(g)                                                                     Irrigated pixels, SHF','Fontsize', 14)
hold off

%%
%irrigagtion grid SHF
[st2mirrip34, b91234] = tsreg(years,lhf_grid_irr_vector);
[st2mctlip34, b691234] = tsreg(years,lhf_grid_ctl_vector);

s1=scatter(years,lhf_grid_irr_vector); hold on;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';
s2=scatter(years,lhf_grid_ctl_vector); hold on;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';

set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); 
xlabel('Year');
ylabel('Mean LHF [W/m2/year]');
title('Irrigated pixels, LHF');
xlim([1980 2012]);
%ylim([288.2 290.2]);
g(1) =plot(years,((st2mirrip34*years)+b91234),'b','LineWidth',1.4); hold on; 
g(2)=plot(years,((st2mctlip34*years)+b691234),'r','LineWidth',1.4); hold on;
legend('IRR','CTL','location', 'Southeast'); 
%title('(d)                                                                     Gridscale, LHF','Fontsize', 14)
title('(i)                                                                 Irrigated pixels, LHF','Fontsize', 14)
hold off


%%
%irrigagtion grid SHF
[st2mirrip34, b91234] = tsreg(years,shf_grid_CA_vector);
[st2mctlip34, b691234] = tsreg(years,shf_grid_ctl_vector2);
%[st2mcruip, b7912] = tsreg(years3,ts_obs_ip2);

s1=scatter(years,shf_grid_CA_vector); hold on;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';
s2=scatter(years,shf_grid_ctl_vector2); hold on;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';

set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); 
xlabel('Year');
ylabel('Mean SHF [W/m2/year]');
title('CAigated pixels, SHF');
xlim([1980 2012]);
%ylim([288.2 290.2]);
g(1) =plot(years,((st2mirrip34*years)+b91234),'b','LineWidth',1.4); hold on; 
g(2)=plot(years,((st2mctlip34*years)+b691234),'r','LineWidth',1.4); hold on;
legend('CA','CTL','location', 'Southeast'); 
title('(h)                                                                          CA pixels, SHF','Fontsize', 14)
hold off

%%
%CAigagtion grid SHF
[st2mirrip34, b91234] = tsreg(years,lhf_grid_CA_vector);
[st2mctlip34, b691234] = tsreg(years,lhf_grid_ctl_vector2);

s1=scatter(years,lhf_grid_CA_vector); hold on;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';
s2=scatter(years,lhf_grid_ctl_vector2); hold on;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';

set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); 
xlabel('Year');
ylabel('Mean LHF [W/m2/year]');
title('CAigated pixels, LHF');
xlim([1980 2012]);
%ylim([288.2 290.2]);
g(1) =plot(years,((st2mirrip34*years)+b91234),'b','LineWidth',1.4); hold on; 
g(2)=plot(years,((st2mctlip34*years)+b691234),'r','LineWidth',1.4); hold on;
legend('CA','CTL','location', 'Southeast'); 
title('(j)                                                                        CA pixels, LHF','Fontsize', 14)
hold off
