function [bb1, bb2, delta_bb] = theta_CAPE_w_fixedt()

sigma   = 1;     % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0
scalar  = 128;
HV_bar  = 1;
dx      = 0.1;
x1      = [-50:dx:50 ];
x2      = [-50:dx:50 ];
t       = 7200;
T       = 1800;
mz_max  = 1000;

fs1     = 18;
fs2     = 14;

% Top Panel - w
%h(1)  = subplot(3,1,1);
h(1)  = subplot('Position', [0.1, 0.7, 0.8, 0.26]);
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
ww1  = ww;
ww1  = mean(ww1);
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
ww11 = ww;
ww11 = mean(ww11);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
ww2  = ww;
ww2  = mean(ww2);
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
ww22 = ww;
ww22 = mean(ww22);

plot(x1, ww1, 'Color', 'r','LineWidth',2);
%ylim(ax(1),[-1.0 2.5])
%ylim(ax(2),[-1 2.5]);
%set(ax(1),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);   
%set(ax(2),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);
hold on
line(x1,ww2,'Color','b','LineWidth',3)
line(x1,ww11,'Color','k','LineWidth',3)
% line(x1,ww2,'Color','b','LineWidth',2, 'LineStyle', '--')
% line(x1,ww11,'Color','g','LineWidth',2, 'LineStyle', ':')
% line(x1,ww22,'Color','k','LineWidth',2, 'LineStyle', '-.')
grid on
%set(ax(1),'xlim',[-20 20]);
%set(ax(2),'xlim',[-20 20]);
set(gca,'ycolor','r')
set(gca, 'xticklabel', [])
%title('Comparison in Mean Tropospheric Potential Temperature Response for Trapped and Radiating Solutions to Steady Heating','FontSize',fs1)
%h_legend = legend('PT Radiating','PT Trapped','\Delta CAPE','Location','northeast');
%set(h_legend,'FontSize',fs2);
%text(-19,1, 't = 30mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')

% Middle Panel - b
%h(2)  = subplot(3,1,2);
h(2)  = subplot('Position', [0.1, 0.4, 0.8, 0.26]);

HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb1  = bb;
bb1  = mean(bb1);
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb11 = bb;
bb11 = mean(bb11);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb2  = bb;
bb2  = mean(bb2);
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb22 = bb;
bb22 = mean(bb22);

plot(x1, bb1, 'Color','r','LineWidth',2);
%ylim(ax(1),[-1.0 2.5])
%ylim(ax(2),[-1 2.5]);
%set(ax(1),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);   
%set(ax(2),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);
hold on
line(x1,bb2,'Color','b','LineWidth',3)
line(x1,bb11,'Color','k','LineWidth',3)
% line(x1,bb2,'Color','b','LineWidth',2,'LineStyle', '--')
% line(x1,bb11,'Color','k','LineWidth',2, 'LineStyle', ':')
% %line(x1,bb22,'Color','k','LineWidth',2, 'LineStyle', '-.')
grid on
%set(ax(1),'xlim',[-20 20]);
%set(ax(2),'xlim',[-20 20]);
set(gca, 'xticklabel', []);
set(gca,'ycolor','b');
%ylabel(ax(1),'Potential Temperature (K)', 'FontSize', fs2)
text(-19,1, 't = 60mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


% Bottom Panel - CAPE
%h(3)  = subplot(3,1,3); 
h(3)  = subplot('Position', [0.1, 0.1, 0.8, 0.26]);
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
cc1  = bb;  % cc = CAPE
cc11 = cc1 * 10 / 280* 10000;
cc11 = mean(cc11);
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
cc1p = bb;
cc11p = cc1p * 10 / 280* 10000;
cc11p = mean(cc11p);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
cc2  = bb;
cc22 = cc2 * 10 / 280* 10000;
cc22 = mean(cc22);
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
cc2p = bb;
cc22p = cc2p * 10 / 280* 10000;
cc22p = mean(cc22p);

% llc   = low-level cooling, radiating
% rad   = radiating single half sine
% trap  = trapped single half sine
% trapl = trapped llc

llc_rad_diff    = cc11p - cc11;
llc_trap_diff   = cc11p - cc22;
llc_trapl_diff  = cc11p - cc22p;
rad_trap_diff   = cc11  - cc22;
rad_trapl_diff  = cc11  - cc22p;
trap_trapl_diff = cc22  - cc22p; 

plot(x1, llc_rad_diff, 'Color', 'g', 'LineWidth',2);
%ylim(ax(1),[-1.0 2.5])
%ylim(ax(2),[-1 2.5]);
%set(ax(1),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);   
%set(ax(2),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);
hold on
line(x1,rad_trap_diff,'Color','g','LineWidth',2, 'LineStyle','--')
line(x1,rad_trapl_diff,'Color','g','LineWidth',2, 'LineStyle', ':')
line(x1,trap_trapl_diff,'Color','g','LineWidth',2, 'LineStyle', '-.')
grid on
%set(ax(1),'xlim',[-20 20]);
%set(ax(2),'xlim',[-20 20]);
set(gca, 'xticklabel', [-200:50:200])
set(gca,'ycolor','g')
xlabel('x (km)', 'FontSize', fs2)
text(-19,1, 't = 90mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')

end