function [bb] = vertical_cross()

T       = 1800;  % secs
sigma   = 1;     % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0
scalar  = 128;
HL_bar   = 63.999;
HV_bar   = 6;
Ht_bar   = 1;
Scaler   = 128;

figure (1)

h(1)  =  subplot(4,2,2);
t     = 900;;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler );
contourf(xx,zz,bb,10);
colorbar
caxis([-3 3]);
grid on
axis equal
x = sprintf('Potential Temperature (K)');
title(x);
ylabel('z / Ht');

h(2)  =  subplot(4,2,4);
t     = 1800;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,HL_bar * Scaler  );
contourf(xx,zz,bb,10);
colorbar
caxis([-3 3]);
grid on
axis equal
ylabel('z / Ht');

h(3)  =  subplot(4,2,6) ;
t     = 2700;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler);
contourf(xx,zz,bb,10);
colorbar
caxis([-3 3]);
grid on
axis equal
ylabel('z / Ht');

h(4)  =  subplot(4,2,8); 
t     = 3600;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler);
contourf(xx,zz,bb,10);
colorbar
caxis([-3 3]);
grid on
axis equal
xlabel('x / \sigma_0');
ylabel('z / Ht');
set(gca, 'XTick', [0:1:9 ])
set(gca, 'xticklabel', [0:10:90])

h(5)  =  subplot(4,2,1);
t     = 900;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler);
contourf(xx,zz,ww,10);
colorbar
caxis([-3 3]);
grid on
axis equal
x = sprintf('Vertical Velocity (m/s)');
title(x);
ylabel('z / Ht');

h(6)  =  subplot(4,2,3);
t     = 1800;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler);
contourf(xx,zz,ww,10);
colorbar
caxis([-3 3]);
grid on
axis equal
ylabel('z / Ht');

h(7)  =  subplot(4,2,5) ;
t     = 2700;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler );
contourf(xx,zz,ww,10);
colorbar
caxis([-3 3]);
grid on
axis equal
ylabel('z / Ht');

h(8)  =  subplot(4,2,7);
t     = 3600;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,  HL_bar * Scaler);
contourf(xx,zz,ww,10);
colorbar
caxis([-3 3]);
grid on
axis equal
xlabel('x / \sigma_0');
ylabel('z / Ht');
set(gca, 'XTick', [0:1:9 ])
set(gca, 'xticklabel', [0:10:90])

linkaxes(h)
xlim([0  10])
ylim([0  6])


return 

