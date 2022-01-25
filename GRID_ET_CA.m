%%%ET
[~, ~, TSA_ctl_ensmeanGRID, ET_ctl_ensmGRID] = mf_load('f.e122.F1850PDC5.f09_g16.control-io192.ensmean_lnd_h1_yearmean.nc'   , 'TSA', 'ET');
ET_ctl_ensmGRID=permute(ET_ctl_ensmGRID,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_ET_ctl_meanGRID = zeros(M, N);
intercept_ET_ctl_mean = zeros(M, N);
T = numel(time);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
        y = squeeze(ET_ctl_ensmGRID(i, j, :));
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
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_ET_ctl_meanGRID(i, j) = ss(ind(med_ind));
        intercept_ET_ctl_mean(i, j) = ints(ind(med_ind));
    end
end
slope_ET_ctl_meanGRID=permute(slope_ET_ctl_meanGRID,[2,1,3]);
slope_ET_ctl_meanGRID(~isca)=NaN;


%below uses yearmean eqiv of the h1 with timmean (fig 11, gridscale effect)
[~, ~, TSA_irr_ensmeanGRID, ET_irr_ensmGRID] = mf_load('f.e122.F1850PDC5.f09_g16.BASE-io192.ensmean_lnd_h1_yearmean.nc'   , 'TSA', 'ET');
ET_irr_ensmGRID=permute(ET_irr_ensmGRID,[2,1,3]);
M = numel(lon); % load slope / regress
N = numel(lat);
slope_ET_irr_meanGRID = zeros(M, N);
intercept_ET_irr_mean = zeros(M, N);
T = numel(time);
[p, q] = meshgrid(1 : T);
p = p(:);
q = q(:);
m = numel(p);
for i = 1 : M
    for j = 1 : N
        y = squeeze(ET_irr_ensmGRID(i, j, :));
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
        [~, ind] = sort(ss);
        med_ind = floor(m / 2) + 1;
        slope_ET_irr_meanGRID(i, j) = ss(ind(med_ind));
        intercept_ET_irr_mean(i, j) = ints(ind(med_ind));
    end
end
slope_ET_irr_meanGRID=permute(slope_ET_irr_meanGRID,[2,1,3]);
slope_ET_irr_meanGRID(~isca)=NaN;

for i=1:nlat
    for j=1:nlon 
GRIDaaaaa3(i,j) = 100*((slope_ET_ctl_meanGRID(i,j) - slope_ET_irr_meanGRID(i,j))./slope_ET_irr_meanGRID(i,j));
    end
end
GRIDaaaaa3(isnan(GRIDaaaaa3))=0;
GRIDaaaaa3(GRIDaaaaa3 < 10) = 0;
GRIDaaaaa3(GRIDaaaaa3 >= 10) = 1;
GRIDaaaaa3(~isca)=NaN;

%mf_plot_dom2(lon_mod, lat_mod, slope_ET_irr_meanGRID - slope_ET_ctl_meanGRID, GRIDaaaaa3, caxes.thiery, colormaps.dET, 0, 2, '(g)', 'Grid-scale effect, 1981-2010, IRR-CTL', '\delta ET /\delta t [K yr^-^1]'); hold on;
mf_plot_dom2(lon_mod, lat_mod, slope_ET_irr_meanGRID - slope_ET_ctl_meanGRID, GRIDaaaaa3, caxes.dEThes222, colormaps.dET2, 0, 2, '(j)', 'Grid-scale effect, 1981-2010, CA-CTL', '\delta ET /\delta t [mm yr^-^1]'); hold on;

[~, Lp_mean_et_ca_GRID, isir_mean_et_ca_GRID] = mf_fieldmean_modis2(slope_ET_irr_meanGRID,    island, isirr);
[~, Lp_mean_et_cm_GRID, isir_mean_et_cm_grid] = mf_fieldmean_modis2(slope_ET_ctl_meanGRID,    island, isirr);

%%
[~, ~,ET_CA_GRID_ip] = mf_fieldmean_MODIS(ET_irr_ensmGRID, island, isca); %note in this one island is ~ out does that make a difference
[~, islandET_CA_GRID, Ip_CAigated] = mf_fieldmean_MODIS(ET_irr_ensmGRID,    island, isca);

[~, ~, ET_CM_GRID_ip] = mf_fieldmean_MODIS(ET_ctl_ensmGRID, island, isca);
[~, islandET_CM_GRID, Ip_CM] = mf_fieldmean_MODIS(ET_ctl_ensmGRID,    island, isca);


%%
%all IP   this one
[AZA, QWQW] = tsreg(years,ET_CA_GRID_ip);
[ASA, EDED] = tsreg(years,ET_CM_GRID_ip);

s1=scatter(years,ET_CA_GRID_ip); hold on;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';
s2=scatter(years,ET_CM_GRID_ip); hold on;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';

set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); 
xlabel('Year');
ylabel('Mean ET [mm/yr]');
title('CAigated pixels, ET');
xlim([1980 2012]);
ylim([410 432]);
g(1) =plot(years,((AZA*years)+QWQW),'b','LineWidth',1.4); hold on; 
g(2)=plot(years,((ASA*years)+EDED),'r','LineWidth',1.4); hold on;
legend('CA','CTL','location', 'Southeast'); 
title('(l)                                                                             CA pixels, ET','Fontsize', 14)
hold off

%%
%all lp 
[nmn1, hbh1] = tsreg(years,islandET_CA_GRID);
[ooo2, fcf1] = tsreg(years,islandET_CM_GRID);

s1=scatter(years,islandET_CA_GRID); hold on;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';
s2=scatter(years,islandET_CM_GRID); hold on;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';

set(gca, 'Fontsize', 12, 'Fontweight', 'Bold'); 
xlabel('Year');
ylabel('Mean ET Temperature [K]');
title('All pixels, ET');
xlim([1980 2012]);
g(1) =plot(years,((nmn1*years)+hbh1),'b','LineWidth',1.4); hold on; 
g(2)=plot(years,((ooo2*years)+fcf1),'r','LineWidth',1.4); hold on;
legend('CAigated','CMfed','location', 'Southeast'); 
title('(a)                                                               GRID All pixels, ET','Fontsize', 14)
hold off
