% Hovmollers of different sigma. Steady. b repsonse. 
% Config list: 2 x HL_bar, t, data height, time step, sigma, T, N. 

%function [x1, t1, xx1, tt, ww, w_trop        ]  = Hovmoller()        % surf
%function [ w_trop0_diff, w_trop1_diff, w_trop2_diff , w_trop3_diff] = Hovmoller_diff()       % contour
function [b_trop1p ] = Hovmoller_transient_centered_bp()

% font size
fs1     = 18;
fs2     = 12;

HL_bar       = 63.993 ;
HV_bar       = 1.50;
Ht_bar       = 1.0;
x_0          = 0;
dx           = 0.1;
x1           = [-50:dx:50];
t1           = [0:50:14400];
[xx1, tt]    = meshgrid(x1,  t1);
N            = 0.01;
Scaler       = 128;

%Compute first heating
t = 0;
for i = 1:1:289
    sigma       = 1;
    T           = 3600;
    alpha       = 1;
    [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
    b_ext0               = bb(2,:);
    b_trop0(i,:)         = b_ext0(:);
    b_ext1               = bb(5,:);
    b_trop1(i,:)         = b_ext1(:);
    b_ext2               = bb(10,:);
    b_trop2(i,:)         = b_ext2(:);
    b_ext3               = bb(14,:);
    b_trop3(i,:)         = b_ext3(:);
    t = t + 50;
end


%Compute second heating
t = 0;
for k = 1:1:289
   HL_bar = HL_bar ;
   sigma       = 1;
   T           = 900;
   alpha       = 4; % scaling factor to conserve heating
   [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, HL_bar * Scaler, sigma );
   bb          = alpha * bb;
   b_ext0p               = bb(2,:);
   b_trop0p(k,:)         = b_ext0p(:);
   b_ext1p               = bb(5,:);
   b_trop1p(k,:)         = b_ext1p(:);
   b_ext2p               = bb(10,:);
   b_trop2p(k,:)         = b_ext2p(:);
   b_ext3p               = bb(14,:);
   b_trop3p(k,:)         = b_ext3p(:);
   
   t = t + 50;
end

%Centre heating about 'timestep'
c            = zeros(27, 1001);          % specify magnitude of shift
%
b_trop0p     = [c;b_trop0p];            % add in zeros at start to delay 'on' time 
b_trop0p     = b_trop0p([1:289], : );         % trim to fit simulation time

b_trop1p     = [c;b_trop1p];            % add in zeros at start to delay 'on' time 
b_trop1p     = b_trop1p([1:289], : );

b_trop2p     = [c;b_trop2p];            % add in zeros at start to delay 'on' time 
b_trop2p     = b_trop2p([1:289], : );

b_trop3p     = [c;b_trop3p];            % add in zeros at start to delay 'on' time 
b_trop3p     = b_trop3p([1:289], : );


%diffs
delta_b0          = b_trop0p - b_trop0;
b_trop0_diff      = delta_b0 .* delta_b0;
b_trop0_diff      = sqrt(b_trop0_diff);

delta_b1          = b_trop1p - b_trop1;
b_trop1_diff      = delta_b1 .* delta_b1;
b_trop1_diff      = sqrt(b_trop1_diff);
    
delta_b2          = b_trop2p - b_trop2;
b_trop2_diff      = delta_b2 .* delta_b2;
b_trop2_diff      = sqrt(b_trop2_diff);
    
delta_b3          = b_trop3p - b_trop3;
b_trop3_diff      = delta_b3 .* delta_b3;
b_trop3_diff      = sqrt(b_trop3_diff);


% Set contour levels for plots
v  = [-3:0.4:3];
v2 = [-5:0.4:5];


%Hovmoller 1    
figure(4)
%h(1) = subplot(4,3,1) ;
h(1) = subplot('Position', [0.06, 0.74, 0.3, 0.2]);
contourf(xx1 , tt, b_trop3,v2);
colormap(jet(30))
colorbar('north')
caxis([-5 5])
ylabel('Time (hours)','FontSize', fs2)
xlim([-50 50])
text(-45,2000, '(a)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '15km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'YTick', [0:3600:14400 ])
set(gca, 'yticklabel', [0, 1, 2, 3, 4 ])
title('PT response with forcing for 1hour', 'FontSize', fs1)

%h(2) = subplot(4,3,4) ;
h(2) = subplot('Position', [0.06, 0.52 , 0.3, 0.2]);
contourf(xx1 , tt, b_trop2,v2);
colormap(jet(30))
caxis([-5 5])
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
contourf(xx1 , tt, b_trop1,v2);
colormap(jet(30))
caxis([-5 5])
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
contourf(xx1 , tt, b_trop0,v2);
colormap(jet(30))
caxis([-5 5])
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
contourf(xx1 , tt, b_trop3p,v2);
colormap(jet(30))
colorbar('north')
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(e)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '15km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])
title('PT response with forcing for 15mins', 'FontSize', fs1)

%h(6) = subplot(4,3,5) ;
h(6) = subplot('Position', [0.365, 0.52, 0.3, 0.2]);
contourf(xx1 , tt, b_trop2p,v2);
colormap(jet(30))
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(f)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(7) = subplot(4,3,8) ;
h(7) = subplot('Position', [0.365, 0.30, 0.3, 0.2]);
contourf(xx1 , tt, b_trop1p,v2);
colormap(jet(30))
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(g)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '5km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(8) = subplot(4,3,11) ;
h(8) = subplot('Position', [0.365, 0.08, 0.3, 0.2]);
contourf(xx1 , tt, b_trop0p,v2);
colormap(jet(30))
caxis([-5 5])
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
contourf(xx1 , tt, delta_b3,v2);
colormap(jet(50))
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
contourf(xx1 , tt, delta_b2,v2);
colormap(jet(50))
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(j)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '10km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(11) = subplot(4,3,9) ;
h(11) = subplot('Position', [0.69, 0.30, 0.3, 0.2]);
contourf(xx1 , tt, delta_b1 ,v2);
colormap(jet(50))
caxis([-5 5])
xlim([-50 50])
text(-45,2000, '(k)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
text(-45,4000, '5km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
grid on
set(gca, 'xticklabel', [])
set(gca, 'yticklabel', [])

%h(12) = subplot(4,3,12) ;
h(12) = subplot('Position', [0.69, 0.08, 0.3, 0.2]);
contourf(xx1 , tt, delta_b0,v2);
colormap(jet(50))
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