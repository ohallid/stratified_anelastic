function [ww] = shell ()

t       = 900;              %   s
T       = 2000;             %   Heating cut-off time
Nc      = 30;               %   Number of contours in display
Scalar  = 100;              %   Mode scaling with height : matches with single-layer calculation
sigma   = 1;
N1      = 0.01;             % Based on dry lapse rate of 10 deg per km (notes)
N2      = 0.023 ;
HL_bar  = 9.99;             %   relative lid height
HV_bar  = 3.0;              %   relative visualisation height
Ht_bar  = 1.001;            %   relative heating height
mmax    = Scalar * HL_bar;  %   max number of modes scales with lid height

[ xx, zz, ww, bb, uu, e, ke_t] = series_half_sinusoid_plots_3_copy_no_checks2(HL_bar , HV_bar, Ht_bar, t, T, mmax, sigma, N1, N2 );

% Response fields
figure ( 10 )
subplot(4,1,1)
contourf(xx,zz,ww ,Nc);
colorbar
grid on
x = sprintf('w / ms^{-1} structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
ylabel('z / H_t');
set(gca,'xticklabel', [ ]);
set(gca,'yticklabel', [0 10 20 30 ]);
%
subplot(4,1,2)
contourf(xx,zz,( bb * 273 / 9.81 / 10^7),Nc);
colorbar
grid on
x = sprintf('PT / K structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
ylabel('z / H_t');
set(gca,'xticklabel', [ ]);
set(gca,'yticklabel', [0 10 20 30 ]);
%
subplot(4,1,3)
contourf(xx,zz,uu,Nc);
colorbar
grid on
x = sprintf('u / ms^{-1} structure at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
ylabel('z / H_t');
set(gca,'xticklabel', [ ]);
set(gca,'yticklabel', [0 10 20 30 ]);
%
subplot(4,1,4)
contourf(xx,zz,e,Nc);
colorbar
grid on
x = sprintf('Vertical component of energy density flux at t = %6.1fs, H_L=%6.1f*H_t',t,HL_bar);
title(x);
xlabel('x / \sigma');
ylabel('z / H_t');
set(gca,'xticklabel', [0 20 40 60 80 100 120 140 160 180]);  
set(gca,'yticklabel', [0 10 20 30 ]);

return 

