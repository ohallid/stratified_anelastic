function [bb] = vertical_cross_lid()

fs1   = 18;
fs2   = 14;

t       = 900;
T       = 1800;  % secs
sigma   = 1;     % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0
Ht_bar   = 1.0021;
Scaler   = 128;
sigma   = 1;     % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0

figure(2)

h(1)  =  subplot('Position', [0.03 0.74, 0.47, 0.2]);
HL_bar  = 63.999;
HV_bar  = 10.105513;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,ww,10);
colorbar('north')
caxis([-3 3]);
grid on
ylabel('z (km)','FontSize', fs2);
xlim([0 10])
ylim([0 5])
x = sprintf('Vertical Velocity (m/s)');
title(x,'FontSize', fs1);
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:1:5 ])
set(gca, 'yticklabel', [0, 10, 20, 30, 40, 50 ])
text(0.5,2, 'H_L = 640km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')

h(2)  =  subplot('Position', [0.03 0.52, 0.47, 0.2]);
HL_bar  = 9.999;
HV_bar  = 10.105513;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,ww,10);
colormap(jet(30))
caxis([-3 3]);
grid on
ylabel('z (km)','FontSize', fs2);
xlim([0 10])
ylim([0 5])
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:1:5 ])
set(gca, 'yticklabel', [0, 10, 20, 30 , 40, 50])
text(0.5,2, 'H_L = 100km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')


%
h(3)  =  subplot('Position', [0.03 0.3, 0.47, 0.2]);
HL_bar  = 3.01;
HV_bar  = 3.01;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,ww,10);
colormap(jet(30))
caxis([-3 3]);
grid on
ylabel('z (km)','FontSize', fs2);
xlim([0 10])
ylim([0 5])
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:1:5 ])
set(gca, 'yticklabel', [0, 10, 20, 30, 40, 50 ])
text(0.5,2, 'H_L = 30km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
%
h(4)  =  subplot('Position', [0.03 0.08, 0.47, 0.2]);
HL_bar  = 1.01;
HV_bar  = 1.01;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,ww,10);
colormap(jet(30))
caxis([-3 3]);
grid on
xlim([0 10])
ylim([0 5])
xlabel('x (km)','FontSize', fs2);
ylabel('z (km)','FontSize', fs2);
set(gca, 'YTick', [0:1:5 ])
set(gca, 'yticklabel', [0, 10, 20, 30, 40, 50 ])
text(0.5,2, 'H_L = 10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
set(gca, 'XTick', [0:1:9 ])
set(gca, 'xticklabel', [0:10:90])
%
h(5)  =  subplot('Position', [0.51 0.74, 0.47, 0.2]);
HL_bar  = 63.999;
HV_bar  = 10.105513;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,bb,10);
colormap(jet(30))
colorbar('north')
caxis([-3 3]);
grid on
xlim([0 10])
ylim([0 5])
x = sprintf('Potential Temperature (K)');
title(x,'FontSize', fs1);
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])
text(0.5,2, 'H_L = 640km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')

%
h(6)  =  subplot('Position', [0.51 0.52, 0.47, 0.2]);
HL_bar  = 9.999;
HV_bar  = 10.105513;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,bb,10);
colormap(jet(30))
caxis([-3 3]);
grid on
xlim([0 10])
ylim([0 5])
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])
text(0.5,2, 'H_L = 100km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')

%
h(7)  =  subplot('Position', [0.51 0.3, 0.47, 0.2]);
HV_bar  = 3.01;
HL_bar  = 3.01;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,bb,10);
colormap(jet(30))
caxis([-3 3]);
grid on
xlim([0 10])
ylim([0 5])
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])
text(0.5,2, 'H_L = 30km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
%
h(8)  =  subplot('Position', [0.51 0.08, 0.47, 0.2]);
HV_bar  = 1.01;
HL_bar  = 1.020999;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler, sigma);
contourf(xx,zz,bb,10);
colormap(jet(30))
caxis([-3 3]);
grid on
xlabel('x (km)','FontSize', fs2);
xlim([0 10])
ylim([0 5])
set(gca, 'yticklabel', [])
text(0.5,2, 'H_L = 10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
set(gca, 'XTick', [0:1:9 ])
set(gca, 'xticklabel', [0:10:90])

return 

