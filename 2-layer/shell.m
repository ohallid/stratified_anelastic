function [ww] = shell ()

t       = 500;           %   s
T       = 2000;          %   Heating cut-off time
Nc      = 30;            %   Number of contours in display
Scalar  = 100;           %   Mode scaling with height : matches with single-layer calculation
sigma   = 1;

HL_bar   = 9.99;           %   relative lid height
HV_bar   = 3.0;            %   relative visualisation height
Ht_bar   = 1.071;          %   relative heating height
mmax     = Scalar * HL_bar;%   max number of modes scales with lid height
[ xx, zz, ww, bb] = series_half_sinusoid_plots_3_copy_no_checks2(HL_bar , HV_bar, Ht_bar, t, T, mmax, sigma );

figure ( 10 )
subplot(2,1,1)
contourf(xx,zz,ww,Nc);
colorbar
grid on
x = sprintf('w structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');
subplot(2,1,2)
contourf(xx,zz,bb,Nc);
colorbar
grid on
x = sprintf('w structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');
return 

