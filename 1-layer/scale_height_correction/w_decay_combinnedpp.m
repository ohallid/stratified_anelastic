function [xx,zz] = w_decay_combinnedpp() 

fs1     = 18;
fs2     = 14;


sigma   = 1;     % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0
Scaler  = 128;
HL_bar  = 63.999;
HV_bar  = 1;
Ht_bar  = 1;
dx      = 0.1;
x1      = [-50:dx:50 ];
x2      = [-50:dx:50 ];

%
h(1)  =  subplot('Position',[0.3, 0.79, 0.4, 0.2]);
T     = 36000;
t     = 1800;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scaler * HL_bar , sigma);
bb = mean(bb);
ww = mean(ww);
[hAx,hLine1,hLine2] = plotyy(x1,bb,x2,ww);
grid on
%x = sprintf('Average Tropospheric Values of Temperature and Vertical Velocity for Steady and Transient Heating');
%title(x, 'FontSize', fs1);
set(hAx(1),'ylim', [-1 2]);
set(hAx(2),'ylim', [-0.25 0.5]);
set(hAx(1),'YTick', [ -1 0 1 2]);   
set(hAx(2),'YTick', [ -0.25 0 0.25 0.5 ]);
set(hAx(1),'ycolor','r')
set(hAx(2),'ycolor','b')
ylabel(hAx(1),{'Potential'; 'Temperature (K)'},'FontSize', fs2) % left y-axis
ylabel(hAx(2),{'Vertical'; 'Velocity (ms^{-1})'},'FontSize', fs2) % right y-axis
set(hLine1,'LineWidth',2);
set(hLine2,'LineWidth',2);
set(hLine1,'Color','r');
set(hLine2,'Color','b');
set(gca, 'xticklabel', [])
text(-45,1.5, '(a)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
text(30,1.5, 't = 30mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


h(2)  =  subplot('Position',[0.3, 0.55, 0.4, 0.2]);
T     = 36000;
t     = 3600;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scaler * HL_bar , sigma );
bb = mean(bb);
ww = mean(ww);
[hAx,hLine1,hLine2] = plotyy(x1,bb,x2,ww);
grid on
set(hAx(1),'ylim', [-1 2]);
set(hAx(2),'ylim', [-0.25 0.5]);
set(hAx(1),'YTick', [ -1 0 1 2]);   
set(hAx(2),'YTick', [ -0.25 0 0.25 0.5 ]);
set(hAx(1),'ycolor','r')
set(hAx(2),'ycolor','b')
set(hLine1,'LineWidth',2);
set(hLine2,'LineWidth',2);
set(hLine1,'Color','r');
set(hLine2,'Color','b');
text(-45,1.5, '(b)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
text(30,1.5, 't = 60mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
xlabel('x (km)','FontSize', fs2);
set(gca, 'XTick', [-40:10:40 ])
set(gca, 'xticklabel', [-400:100:400])

h(3)  =  subplot('Position', [0.05, 0.31, 0.4, 0.2]);
T     = 36000;
t     = 5400;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,Scaler * HL_bar , sigma );
bb = mean(bb);
ww = mean(ww);
[hAx,hLine1,hLine2] = plotyy(x1,bb,x2,ww);
grid on
x = sprintf('Steady Heating');
title(x,'FontSize', fs2);
set(hAx(1),'ylim', [-1 2]);
set(hAx(2),'ylim', [-0.25 0.5]);
set(hAx(1),'YTick', [ -1 0 1 2]);   
set(hAx(2),'YTick', [ -0.25 0 0.25 0.5 ]);
set(hAx(1),'ycolor','r')
set(hAx(2),'ycolor','b')
set(hLine1,'LineWidth',2);
set(hLine2,'LineWidth',2);
set(hLine1,'Color','r');
set(hLine2,'Color','b');
set(gca, 'xticklabel', [])
text(-45,1.5, '(c)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
text(30,1.5, 't = 90mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


h(4)  =  subplot('Position', [0.05, 0.07, 0.4, 0.2]);
T     = 36000;
t     = 7200;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scaler * HL_bar, sigma );
bb = mean(bb);
ww = mean(ww);
[hAx,hLine1,hLine2] = plotyy(x1,bb,x2,ww);
grid on
xlabel('x (km)','FontSize', fs2);
set(hAx(1),'ylim', [-1 2]);
set(hAx(2),'ylim', [-0.25 0.5]);
set(hAx(1),'YTick', [ -1 0 1 2]);   
set(hAx(2),'YTick', [ -0.25 0 0.25 0.5 ]);
set(hAx(1),'ycolor','r')
set(hAx(2),'ycolor','b')
set(hLine1,'LineWidth',2);
set(hLine2,'LineWidth',2);
set(hLine1,'Color','r');
set(hLine2,'Color','b');
text(-45,1.5, '(d)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
text(30,1.5, 't = 120mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
set(gca, 'XTick', [-40:10:40 ])
set(gca, 'xticklabel', [-400:100:400])

h(5)  =  subplot('Position', [0.55, 0.31, 0.4, 0.2]);
T     = 3600;
t     = 5400;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scaler * HL_bar , sigma );
bb = mean(bb);
ww = mean(ww);
[hAx,hLine1,hLine2] = plotyy(x1,bb,x2,ww);
grid on
x = sprintf('Transient Heating');
title(x,'FontSize', fs2);
set(hAx(1),'ylim', [-1 2]);
set(hAx(2),'ylim', [-0.25 0.5]);
set(hAx(1),'YTick', [ -1 0 1 2]);   
set(hAx(2),'YTick', [ -0.25 0 0.25 0.5 ]);
set(hAx(1),'ycolor','r')
set(hAx(2),'ycolor','b')
set(hLine1,'LineWidth',2);
set(hLine2,'LineWidth',2);
set(hLine1,'Color','r');
set(hLine2,'Color','b');
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', []);
text(-45,1.5, '(e)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
text(30,1.5, 't = 90mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


h(6)  =  subplot('Position', [0.55, 0.07, 0.4, 0.2]);
T     = 3600;
t     = 7200;
[ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, Scaler * HL_bar , sigma );
bb = mean(bb);
ww = mean(ww);
[hAx,hLine1,hLine2] = plotyy(x1,bb,x2,ww);
grid on
xlabel('x (km)','FontSize', fs2);
set(hAx(1),'ylim', [-1 2]);
set(hAx(2),'ylim', [-0.25 0.5]);
set(hAx(1),'YTick', [ -1 0 1 2]);   
set(hAx(2),'YTick', [ -0.25 0 0.25 0.5 ]);
set(hAx(1),'ycolor','r')
set(hAx(2),'ycolor','b')
set(hLine1,'LineWidth',2);
set(hLine2,'LineWidth',2);
set(hLine1,'Color','r');
set(hLine2,'Color','b');
set(gca, 'yticklabel', []);
text(-45,1.5, '(f)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
text(30,1.5, 't = 120mins', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
set(gca, 'XTick', [-40:10:40 ])
set(gca, 'xticklabel', [-400:100:400])

return
