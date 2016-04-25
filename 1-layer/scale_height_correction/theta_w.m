function [bb1, bb2, delta_bb] = theta_w()

Scaler  = 128;
HV_bar  = 1;
Ht_bar  = 1;
dx      = 0.1;
x1      = [-50:dx:50 ];
x2      = [-50:dx:50 ];
fs1     = 18;
fs2     = 14;
sigma   = 1;

% Top Panel
%h(1)  = subplot(3,1,1);
h(1)  = subplot('Position', [0.1, 0.7, 0.8, 0.26]);

T     = 1800;
t     = 1800;


HL_bar  = 63.999;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
bb1  = bb;
bb11 = bb1 * 10 / 280 * 10; % convert PT back to b, then multiply by depth of averaging domain (10)
bb1  = mean(bb1);
bb11 = mean(bb11);
ww1  = ww;
ww1  = mean(ww1);

HL_bar  = 1.001;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
bb2  = bb;
bb22 = bb2 * 10 / 280 * 10;
bb2  = mean(bb2);
bb22 = mean(bb22);
ww2  = ww;
ww2  = mean(ww2);

delta_bb = bb22 - bb11;

% HL_bar  = 63.999;
% [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
% bb1p  = bb;
% bb11p = bb1p * 10 / 280 * 10; % convert PT back to b, then multiply by depth of averaging domain (10)
% bb1p  = mean(bb1p);
% bb11p = mean(bb11p);
% ww1p  = ww;
% ww1p  = mean(ww1p);
% 
% HL_bar  = 1.001;
% [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
% bb2p  = bb;
% bb22p = bb2p * 10 / 280 * 10;
% bb2p  = mean(bb2p);
% bb22p = mean(bb22p);
% ww2p  = ww;
% ww2p  = mean(ww2p);

%
%[ax,h1,h2] = plotyy(x1, bb1, x1, delta_bb);
[ax,h1,h2] = plotyy(x1, bb1, x1, ww1);
ylim(ax(1),[-1.5 3])
ylim(ax(2),[-1.5 3]);
set(ax(1),'YTick', [-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3]);   
set(ax(2),'YTick', [-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3]);
hold on
line(x1,bb2,'parent',ax(1),'Color','r','LineWidth',2)
line(x1,ww2,'parent',ax(2),'Color','b','LineWidth',2)
%line(x1,bb2p,'parent',ax(1),'Color','r','LineWidth',2)
%line(x1,ww2p,'parent',ax(2),'Color','b','LineWidth',2)
grid on
set(ax(1),'xlim',[-20 20]);
set(ax(2),'xlim',[-20 20]);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
set(h1,'Color','r',  'linestyle','--');
set(h2,'Color','b','linestyle','--');
set(ax(1),'ycolor','r')
set(ax(2),'ycolor','b')
set(gca, 'xticklabel', [])
title('Comparison in Mean Tropospheric Potential Temperature Response for Trapped and Radiating Solutions to a 30min Heat Pulse','FontSize',fs1)
h_legend = legend('PT Radiating','PT Trapped','w Radiating','w Trapped','Location','northeast');
set(h_legend,'FontSize',fs2);
text(-19,1, 't = 30mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')

% Middle Panel
%h(2)  = subplot(3,1,2);
h(2)  = subplot('Position', [0.1, 0.4, 0.8, 0.26]);
T     = 1800;
t     = 3600;
HL_bar  = 63.999;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
bb1  = bb;
bb11 = bb1 * 10 / 280 * 10;
bb1  = mean(bb1);
bb11 = mean(bb11);
ww1  = ww;
ww1  = mean(ww1);

HL_bar  = 1.001;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
bb2  = bb;
bb22 = bb2 * 10 / 280 * 10;
bb2  = mean(bb2);
bb22 = mean(bb22);
ww2  = ww;
ww2  = mean(ww2);

delta_bb = bb22 - bb11;

%[ax,h1,h2] = plotyy(x1, bb1, x1, delta_bb);
[ax,h1,h2] = plotyy(x1, bb1, x1, ww1);
ylim(ax(1),[-1.5 3])
ylim(ax(2),[-1.5 3]);
set(ax(1),'YTick', [-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3]);   
set(ax(2),'YTick', [-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3]);
hold on
line(x1,bb2,'parent',ax(1),'Color','r','LineWidth',2)
line(x1,ww2,'parent',ax(2),'Color','b','LineWidth',2)
grid on
set(ax(1),'xlim',[-20 20]);
set(ax(2),'xlim',[-20 20]);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
set(h1,'Color','r',  'linestyle','--');
set(h2,'Color','b','linestyle','--');
set(gca, 'xticklabel', []);
set(ax(1),'ycolor','r');
set(ax(2),'ycolor','b');
ylabel(ax(1),'Potential Temperature (K)', 'FontSize', fs2)
ylabel(ax(2),'w (m/s)', 'FontSize', fs2)
text(-19,1, 't = 60mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


% Bottom Panel
%h(3)  = subplot(3,1,3);
h(3)  = subplot('Position', [0.1, 0.1, 0.8, 0.26]);
T     = 1800;
t     = 5400;
HL_bar  = 63.999;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
bb1  = bb;
bb11 = bb1 * 10 / 280 * 10;
bb1  = mean(bb1);
bb11 = mean(bb11);
ww1  = ww;
ww1  = mean(ww1);

HL_bar  = 1.001;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
bb2  = bb;
bb22 = bb2 * 10 / 280 * 10;
bb2  = mean(bb2);
bb22 = mean(bb22);
ww2  = ww;
ww2  = mean(ww2);

delta_bb = bb22 - bb11;

%[ax,h1,h2] = plotyy(x1, bb1, x1, delta_bb);
[ax,h1,h2] = plotyy(x1, bb1, x1, ww1);
ylim(ax(1),[-1.5 3])
ylim(ax(2),[-1.5 3]);
set(ax(1),'YTick', [-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3]);   
set(ax(2),'YTick', [-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3]);
hold on
line(x1,bb2,'parent',ax(1),'Color','r','LineWidth',2)
line(x1,ww2,'parent',ax(2),'Color','b','LineWidth',2)
grid on
set(ax(1),'xlim',[-20 20]);
set(ax(2),'xlim',[-20 20]);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
set(h1,'Color','r',  'linestyle','--');
set(h2,'Color','b','linestyle','--');
set(gca, 'xticklabel', [-200:50:200])
%set(gca, 'xticklabel', [])
set(ax(1),'ycolor','r')
set(ax(2),'ycolor','b')
xlabel('x (km)', 'FontSize', fs2)
text(-19,1, 't = 90mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')

end