% Hovmollers of different sigma. Steady. b repsonse. 
% Config list: 2 x HL_bar, t, data height, time step, sigma, T, N. 

%function [x1, t1, xx1, tt, ww, w_trop        ]  = Hovmoller()        % surf
%function [ w_trop0_diff, w_trop1_diff, w_trop2_diff , w_trop3_diff] = Hovmoller_diff()       % contour
function [w_trop1p ] = Hovmoller_steady_centered_wp()

% font size
fs1     = 18;
fs2     = 12;

HL_bar       = 63.993 ;
HV_bar       = 20.00;
x_0          = 0;
x1           = [-50:0.05:50];
t1           = [0:50:14400];
[xx1, tt]    = meshgrid(x1,  t1);
N            = 0.01;
mz_max       = 1000;

%Compute first heating
t = 0;
for i = 1:1:289
    sigma       = 4;
    T           = 14400;
    alpha       = 1;
    [ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, mz_max );
    w_ext0               = ww(2,:);
    w_trop0(i,:)         = w_ext0(:);
    w_ext1               = ww(5,:);
    w_trop1(i,:)         = w_ext1(:);
    w_ext2               = ww(10,:);
    w_trop2(i,:)         = w_ext2(:);
    w_ext3               = ww(15,:);
    w_trop3(i,:)         = w_ext3(:);
    t = t + 50;
end


%Compute second heating
t = 0;
for k = 1:1:289
   HL_bar = HL_bar ;
   sigma       = 1;  % heating conservation done elsewhere in code
   T           = 14400;
   alpha       = 1; % scaling factor to conserve heating
   [ ww, bb, FS, b, m, xx, zz, z ] = series_half_sinusoidp_w_b(HL_bar, HV_bar, sigma, t, T, mz_max );
   w_ext0p               = ww(2,:);
   w_trop0p(k,:)         = w_ext0p(:);
   w_ext1p               = ww(5,:);
   w_trop1p(k,:)         = w_ext1p(:);
   w_ext2p               = ww(10,:);
   w_trop2p(k,:)         = w_ext2p(:);
   w_ext3p               = ww(15,:);
   w_trop3p(k,:)         = w_ext3p(:);
   
   t = t + 50;
end


%diffs
delta_w0          = w_trop0p - w_trop0;
w_trop0_diff      = delta_w0 .* delta_w0;
w_trop0_diff      = sqrt(w_trop0_diff);

delta_w1          = w_trop1p - w_trop1;
w_trop1_diff      = delta_w1 .* delta_w1;
w_trop1_diff      = sqrt(w_trop1_diff);
    
delta_w2          = w_trop2p - w_trop2;
w_trop2_diff      = delta_w2 .* delta_w2;
w_trop2_diff      = sqrt(w_trop2_diff);
    
delta_w3          = w_trop3p - w_trop3;
w_trop3_diff      = delta_w3 .* delta_w3;
w_trop3_diff      = sqrt(w_trop3_diff);


% Set contour levels for plots
v  = [-3:0.1:3];
v2 = [-5:0.1:5];


%Hovmoller 1    
figure(4)
%h(1) = subplot(4,3,1) ;
h(1) = subplot('Position', [0.06, 0.74, 0.3, 0.2]);
contourf(xx1 , tt, w_trop3,v);
colormap(jet(60))
colorbar('north')
caxis([-3 3])
ylabel('Time (hours)','FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(a)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '15km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:3600:14400 ])
set(gca, 'yticklabel', [0, 1, 2, 3, 4 ])
title('w response \sigma = 4', 'FontSize', fs1)

%h(2) = subplot(4,3,4) ;
h(2) = subplot('Position', [0.06, 0.52 , 0.3, 0.2]);
contourf(xx1 , tt, w_trop2,v);
colormap(jet(60))
caxis([-3 3])
ylabel('Time (hours)', 'FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(b)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:3600:14400 ])
set(gca, 'yticklabel', [0, 1, 2, 3, 4 ])

%h(3) = subplot(4,3,7) ;
h(3) = subplot('Position', [0.06, 0.30, 0.3, 0.2]);
contourf(xx1 , tt, w_trop1,v);
colormap(jet(60))
caxis([-3 3])
ylabel('Time (hours)','FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(c)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '5km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:3600:14400 ])
set(gca, 'yticklabel', [0, 1, 2, 3, 4 ])

%h(4) = subplot(4,3,10) ;
h(4) = subplot('Position', [0.06, 0.08, 0.3, 0.2]);
contourf(xx1 , tt, w_trop0,v);
colormap(jet(60))
caxis([-3 3])
xlabel('x (km)','FontSize', fs2)
ylabel('Time (hours)','FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(d)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'YTick', [0:3600:14400 ])
set(gca, 'yticklabel', [0, 1, 2, 3, 4 ])
set(gca, 'XTick', [-40:10:40 ])
set(gca, 'xticklabel', [-400:100:400])

%h(5) = subplot(4,3,2) ;
h(5) = subplot('Position', [0.365, 0.74, 0.3, 0.2]);
contourf(xx1 , tt, w_trop3p,v);
colormap(jet(60))
colorbar('north')
caxis([-3 3])
xlim([-50 50])
text(-45,2000, '(e)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '15km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])
title('w response \sigma = 1', 'FontSize', fs1)

%h(6) = subplot(4,3,5) ;
h(6) = subplot('Position', [0.365, 0.52, 0.3, 0.2]);
contourf(xx1 , tt, w_trop2p,v);
colormap(jet(60))
caxis([-3 3])
xlim([-50 50])
text(-45,2000, '(f)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(7) = subplot(4,3,8) ;
h(7) = subplot('Position', [0.365, 0.30, 0.3, 0.2]);
contourf(xx1 , tt, w_trop1p,v);
colormap(jet(60))
caxis([-3 3])
xlim([-50 50])
text(-45,2000, '(g)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '5km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(8) = subplot(4,3,11) ;
h(8) = subplot('Position', [0.365, 0.08, 0.3, 0.2]);
contourf(xx1 , tt, w_trop0p,v);
colormap(jet(60))
caxis([-3 3])
xlabel('x (km)', 'FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(h)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'yticklabel', [])
set(gca, 'XTick', [-40:10:40 ])
set(gca, 'xticklabel', [-400:100:400])

%h(9) = subplot(4,3,3) ;
h(9) = subplot('Position', [0.69, 0.74, 0.3, 0.2]);
contourf(xx1 , tt, delta_w3,v2);
colormap(jet(100))
colorbar('north')
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(i)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '15km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])
title('Difference', 'FontSize', fs1)

%h(10) = subplot(4,3,6) ;
h(10) = subplot('Position', [0.69, 0.52, 0.3, 0.2]);
contourf(xx1 , tt, delta_w2,v2);
colormap(jet(100))
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(j)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(11) = subplot(4,3,9) ;
h(11) = subplot('Position', [0.69, 0.30, 0.3, 0.2]);
contourf(xx1 , tt, delta_w1 ,v2);
colormap(jet(100))
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(k)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '5km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(12) = subplot(4,3,12) ;
h(12) = subplot('Position', [0.69, 0.08, 0.3, 0.2]);
contourf(xx1 , tt, delta_w0,v2);
colormap(jet(100))
caxis([-5 5])
xlabel('x (km)', 'FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(l)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'yticklabel', [])
set(gca, 'XTick', [-40:10:40 ])
set(gca, 'xticklabel', [-400:100:400])
% 


 return