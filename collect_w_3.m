% sanity check code
function [ww] = collect_w_3()

t       = 500;          %   s
T       = 2000;         %   Heating cut-off time
Nc      = 30;           %   Number of contours in display
Scalar  = 128;          %   Mode scaling with height : matches with single-layer calculation

figure(1)
% lid height 10 x heating height
h(1)  =  subplot(3,1,1);
HL_bar   = 63.98;         %   relative lid height
HV_bar   =  3.0;          %   relative visualisation height
Ht_bar   =  1.0;          %   relative heating height
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scalar * HL_bar );
%[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy          (HL_bar , HV_bar, Ht_bar, t, T                  );
contourf(xx,zz,bb,Nc);
colorbar
grid on
axis equal
x = sprintf('w structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

% lid height 3 x heating height
h(2)  =  subplot(3,1,2) ;
HL_bar   = 9.99;
HV_bar   = 3.0;        
Ht_bar   = 1.0; 
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scalar * HL_bar );
%[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy          (HL_bar , HV_bar, Ht_bar, t, T                  );
contourf(xx,zz,bb,Nc);
colorbar
grid on
axis equal
x = sprintf('w structure t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

% lid height 2 x heating height
h(3)  =  subplot(3,1,3); 
HL_bar   = 2.0;
HV_bar   = 2.0;        
Ht_bar   = 1.0; 
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scalar * HL_bar );
%[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy          (HL_bar , HV_bar, Ht_bar, t, T                  );
contourf(xx,zz,bb,Nc);
colorbar
grid on
axis equal
x = sprintf('w structure t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

linkaxes(h)
xlim([0  10])
ylim([0  3])


figure(2)
% lid height 10 x heating height
h(1)  =  subplot(3,1,1);
HL_bar   = 63.98;         %   relative lid height
HV_bar   =  3.0;          %   relative visualisation height
Ht_bar   =  1.0;          %   relative heating height
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scalar * HL_bar );
%[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy          (HL_bar , HV_bar, Ht_bar, t, T                  );
contourf(xx,zz,ww,Nc);
colorbar
grid on
axis equal
x = sprintf('w structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

% lid height 3 x heating height
h(2)  =  subplot(3,1,2) ;
HL_bar   = 9.99;
HV_bar   = 3.0;        
Ht_bar   = 1.0; 
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scalar * HL_bar );
%[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy          (HL_bar , HV_bar, Ht_bar, t, T                  );
contourf(xx,zz,ww,Nc);
colorbar
grid on
axis equal
x = sprintf('w structure t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

% lid height 2 x heating height
h(3)  =  subplot(3,1,3); 
HL_bar   = 2.0;
HV_bar   = 2.0;        
Ht_bar   = 1.0; 
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scalar * HL_bar );
%[ xx, zz, ww ] = series_half_sinusoid_plots_3_copy          (HL_bar , HV_bar, Ht_bar, t, T                  );
contourf(xx,zz,ww,Nc);
colorbar
grid on
axis equal
x = sprintf('w structure t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / FWHM');
ylabel('z / H_t');

linkaxes(h)
xlim([0  10])
ylim([0  3])

return 

