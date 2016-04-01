function [ww] = collect_w_5()

figure ( 1 )

t       = 2500;
Nc      = 20;           %   Number of contours

% lid height 10 x heating height
HL_bar   = 19.993;       %   relative lid height
HV_bar   = 20.005;       %   relative visualisation height
Ht_bar   = 1.000000091;  %   relative heating height
[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t);
contourf(xx,zz,ww,Nc);
colorbar
caxis([-1 1])
grid on
axis equal
x = sprintf('w structure at  t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

xlim([0  20])
ylim([0  20])

return 

