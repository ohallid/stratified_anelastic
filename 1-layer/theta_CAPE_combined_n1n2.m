% plot showing differences between trapped and radiating for (n=1) and (n=1 +
% n=2)

function [bb1, bb2, delta_bb] = theta_CAPE_combined_n1n2()

sigma   = 1;     % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0
scalar  = 128;
HV_bar  = 1;
dx      = 0.1;
x1      = [-50:dx:50 ];
x2      = [-50:dx:50 ];
fs1     = 18;
fs2     = 14;
mz_max  = 1000;

% Top Panel
%h(1)  = subplot(3,1,1); - leave in code for reference
h(1)  = subplot('Position', [0.1, 0.7, 0.8, 0.26]);
T     = 1800;
t     = 1800;
% n=1 only
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb1  = bb;
bb11 = bb1 * 10 / 280 * 10000; % convert PT back to b, then multiply by depth of averaging domain (10)
bb1  = mean(bb1);
bb11 = mean(bb11);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb2  = bb;
bb22 = bb2 * 10 / 280 * 10000;
bb2  = mean(bb2);
bb22 = mean(bb22);

% n=1 + n=2
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb1p  = bb;
bb11p = bb1p * 10 / 280 * 10000;
bb1p  = mean(bb1p);
bb11p = mean(bb11p);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb2p  = bb;
bb22p = bb2p * 10 / 280 * 10000;
bb2p  = mean(bb2p);
bb22p = mean(bb22p);

% CAPE calcs
delta_bb  = bb22 - bb11;
delta_bbp = bb22p - bb11p;

[ax,h1,h2] = plotyy(x1, bb1, x1, delta_bb);
ylim(ax(1),[-1.0 2.5])
ylim(ax(2),[-100 250]);
set(ax(1),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);   
set(ax(2),'YTick', [ -100 -50 0 50 100 150 200 250 ]);
hold on
line(x1,bb2,'parent',ax(1),'Color','r','LineWidth',2)
line(x1,bb2p,'parent',ax(1),'Color','g','LineWidth',2)
line(x1,bb1p,'parent',ax(1),'Color','g','LineStyle','--','LineWidth',2)
line(x1,delta_bbp,'parent',ax(2),'Color','m','LineWidth',2)
grid on
set(ax(1),'xlim',[-20 20]);
set(ax(2),'xlim',[-20 20]);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
set(h1,'Color','r',  'linestyle','--');
set(h2,'Color','b');
set(ax(1),'ycolor','r')
set(ax(2),'ycolor','b')
set(gca, 'xticklabel', [])
title('Comparison of Mean Tropospheric Potential Temperature Response for Trapped and Radiating Solutions to 30min Heat Pulse With Low Level Cooling','FontSize',fs1)
h_legend = legend('(a)','(b)','(c)','(d)','(e)','(f)','Location','northeast');
set(h_legend,'FontSize',fs2);
text(-19,2, 't = 30mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')

% Middle Panel
%h(2)  = subplot(3,1,2);
h(2)  = subplot('Position', [0.1, 0.4, 0.8, 0.26]);
T     = 1800;
t     = 3600;
% n=1 only
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb1  = bb;
bb11 = bb1 * 10 / 280 * 10000;
bb1  = mean(bb1);
bb11 = mean(bb11);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb2  = bb;
bb22 = bb2 * 10 / 280 * 10000;
bb2  = mean(bb2);
bb22 = mean(bb22);


% n=1 + n=2
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb1p  = bb;
bb11p = bb1p * 10 / 280 * 10000;
bb1p  = mean(bb1p);
bb11p = mean(bb11p);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb2p  = bb;
bb22p = bb2p * 10 / 280 * 10000;
bb2p  = mean(bb2p);
bb22p = mean(bb22p);

%CAPE calcs
delta_bb  = bb22 - bb11;
delta_bbp = bb22p - bb11p;

[ax,h1,h2] = plotyy(x1, bb1, x1, delta_bb);
ylim(ax(1),[-1.0 2.5])
ylim(ax(2),[-100 250]);
set(ax(1),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);   
set(ax(2),'YTick', [ -100 -50 0 50 100 150 200 250 ]);
hold on
line(x1,bb2,'parent',ax(1),'Color','r','LineWidth',2)
line(x1,bb2p,'parent',ax(1),'Color','g','LineWidth',2)
line(x1,bb1p,'parent',ax(1),'Color','g','LineStyle','--','LineWidth',2)
line(x1,delta_bbp,'parent',ax(2),'Color','m','LineWidth',2)
grid on
set(ax(1),'xlim',[-20 20]);
set(ax(2),'xlim',[-20 20]);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
set(h1,'Color','r',  'linestyle','--');
set(h2,'Color','b');
set(gca, 'xticklabel', []);
set(ax(1),'ycolor','r');
set(ax(2),'ycolor','b');
ylabel(ax(1),'Potential Temperature (K)', 'FontSize', fs2)
ylabel(ax(2),'\Delta CAPE (J/kg)', 'FontSize', fs2)
text(-19,2, 't = 60mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


% Bottom Panel
%h(3)  = subplot(3,1,3);
h(3)  = subplot('Position', [0.1, 0.1, 0.8, 0.26]);
T     = 1800;
t     = 5400;
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb1  = bb;
bb11 = bb1 * 10 / 280 * 10000;
bb1  = mean(bb1);
bb11 = mean(bb11);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoid_n2(HL_bar, HV_bar, sigma, t, T, mz_max );
bb2  = bb;
bb22 = bb2 * 10 / 280 * 10000;
bb2  = mean(bb2);
bb22 = mean(bb22);


% n=1 + n=2
HL_bar  = 63.999;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb1p  = bb;
bb11p = bb1p * 10 / 280 * 10000;
bb1p  = mean(bb1p);
bb11p = mean(bb11p);

HL_bar  = 1.001;
[ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, scalar * HL_bar );
bb2p  = bb;
bb22p = bb2p * 10 / 280 * 10000;
bb2p  = mean(bb2p);
bb22p = mean(bb22p);

% CAPE calcs
delta_bb  = bb22 - bb11;
delta_bbp = bb22p - bb11p;

[ax,h1,h2] = plotyy(x1, bb1, x1, delta_bb);
ylim(ax(1),[-1.0 2.5])
ylim(ax(2),[-100 250]);
set(ax(1),'YTick', [ -1 -0.5 0 0.5 1 1.5 2 2.5 ]);   
set(ax(2),'YTick', [ -100 -50 0 50 100 150 200 250 ]);
hold on
line(x1,bb2,'parent',ax(1),'Color','r','LineWidth',2)
line(x1,bb2p,'parent',ax(1),'Color','g','LineWidth',2)
line(x1,bb1p,'parent',ax(1),'Color','g','LineStyle','--','LineWidth',2)
line(x1,delta_bbp,'parent',ax(2),'Color','m','LineWidth',2)
grid on
set(ax(1),'xlim',[-20 20]);
set(ax(2),'xlim',[-20 20]);
set(gca, 'xticklabel', [-200:50:200])
set(h1,'LineWidth',2);
set(h2,'LineWidth',2); 
set(h1,'Color','r',  'linestyle','--');
set(h2,'Color','b');
set(ax(1),'ycolor','r')
set(ax(2),'ycolor','b')
xlabel('x (km)', 'FontSize', fs2)
text(-19,2, 't = 90mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')



end