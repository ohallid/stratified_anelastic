function [criteria_array_0, delta_w_CAPE] = triggering_criteria_CAPE()
% 289 X 1001

fs1     = 20;
fs2     = 20;

HL_bar       = 63.993 ;
HV_bar       = 1.0;
Ht_bar       = 1.0;
x_0          = 0;
dx           = 1;
x1           = [-50:dx:50];
t1           = [0:225:14400];
[xx1, tt]    = meshgrid(x1,  t1);
N            = 0.01;
scalar       = 250;

%Compute first heating
t = 0;
for i = 1:1:64
    sigma       = 1;
    T           = 3600;
    alpha       = 1;
    [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, scalar * HL_bar );
    % w, PT at top of CIN
    w_ext0               = ww(2,:);
    w_CIN0(i,:)          = w_ext0(:);
    b_ext0               = bb(2,:);
    b_CIN0(i,:)          = b_ext0(:);
    % averaged values for CAPE considerations
    w_mean_0(i,:)        = mean(ww);
    b_mean_0(i,:)        = mean(bb);

    t = t + 225;
end

%Compute second heating
t = 0;
for k = 1:1:64
   HL_bar = HL_bar ;
   sigma       = 1;
   T           = 900;
   alpha       = 4; % scaling factor to conserve heating
   [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, scalar * HL_bar ); 
   % Scaling
   ww          = alpha * ww;
   bb          = alpha * bb;
   % CIN
   w_ext0p               = ww(2,:);
   w_CIN1(k,:)           = w_ext0p(:);
   b_ext0p               = bb(2,:);
   b_CIN1(k,:)           = b_ext0p(:);
   % averaged values for CAPE considerations
   w_mean_1(k,:)         = mean(ww);
   b_mean_1(k,:)         = mean(bb);
   
   t = t + 225;
end


%Centre heating about 'timestep'
% Comment out 0 or 1 blocks where relvent (see config at start of time
% loop)
c            = zeros(6, 101);          % specify magnitude of shift
% %
% w_CIN0       = [c;w_CIN0];            % add in zeros at start to delay 'on' time 
% w_CIN0       = w_CIN0([1:64], : );         % trim to fit simulation time
w_CIN1       = [c;w_CIN1];            % add in zeros at start to delay 'on' time 
w_CIN1       = w_CIN1([1:64], : );
% 
% b_CIN0       = [c;b_CIN0];            % add in zeros at start to delay 'on' time 
% b_CIN0       = b_CIN0([1:64], : );         % trim to fit simulation time
b_CIN1       = [c;b_CIN1];            % add in zeros at start to delay 'on' time 
b_CIN1       = b_CIN1([1:64], : );
% 
% w_mean_0     = [c;w_mean_0];            % add in zeros at start to delay 'on' time 
% w_mean_0     = w_mean_0([1:64], : );         % trim to fit simulation time
w_mean_1     = [c;w_mean_1];            % add in zeros at start to delay 'on' time 
w_mean_1     = w_mean_1([1:64], : );
%
% b_mean_0     = [c;b_mean_0];            % add in zeros at start to delay 'on' time 
% b_mean_0     = b_mean_0([1:64], : );         % trim to fit simulation time
b_mean_1     = [c;b_mean_1];            % add in zeros at start to delay 'on' time 
b_mean_1     = b_mean_1([1:64], : );
%

%
%diffs
delta_w_CIN        = w_CIN1 - w_CIN0;
delta_b_CIN        = b_CIN1 - b_CIN0;
%
delta_w_CAPE       = w_mean_1 - w_mean_0;
delta_b_CAPE       = b_mean_1 - b_mean_0;
%
   
% Fill arrays with arbitrary numbers to store info on up/down, warm/cold
criteria_array_0    = zeros(64,101);
criteria_array_1    = zeros(64,101);
a    = 1 / 3;
b    = 2 / 3;
c    = 3 / 3;
%

% Bin array index according to up/down, warm/cold
for k = 1:64
    % CIN
    for l = 1:101
        if delta_w_CIN(k,l) > 0 && delta_b_CIN(k,l) < 0
            criteria_array_0(k,l) = a;
        end
        if delta_w_CIN(k,l) < 0 && delta_b_CIN(k,l) > 0
            criteria_array_0(k,l) = b; 
        end
        if delta_w_CIN(k,l) > 0 && delta_b_CIN(k,l) > 0
            criteria_array_0(k,l) = c;
        end
        %
        %
         if delta_w_CAPE(k,l) > 0.0 && delta_b_CAPE(k,l) < 0.0
            criteria_array_1(k,l) = a;
        end
        if delta_w_CAPE(k,l) < 0.0 && delta_b_CAPE(k,l) > 0.0
            criteria_array_1(k,l) = b; 
        end
        if delta_w_CAPE(k,l) > 0.0 && delta_b_CAPE(k,l) > 0.0
            criteria_array_1(k,l) = c;
        end
    end
end
% 
% flip arrays up to down
criteria_array_0 = flipud(criteria_array_0);
criteria_array_1 = flipud(criteria_array_1);

% plot 2 - both CIN and CAPE plots in same figure (different colormap)
% figure(2)
% h(1) = subplot('Position', [0.1, 0.1, 0.35, 0.8]);
% imagesc(criteria_array_0);
% xlim([0 100])
% ylim([0 64])
% colormap(winter(4))
% %hb1 = colorbar('location','southoutside');
% %text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
% text(-40,30, '(a)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
% freezeColors
% 
% h(2) = subplot('Position', [0.6, 0.1, 0.35, 0.8]);
% imagesc(criteria_array_1);
% xlim([0 100])
% ylim([0 64])
% %s2Pos = get(h(2),'position');
% colormap(autumn(4))
% %hb2 = colorbar('location','southoutside');
% caxis([0 1])
% %set(hb, 'YTick', []);
% %set(h(2),'position',s2Pos);
% text(-40,15, '(b)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')

% % plot 3 - both CIN and CAPE plots in same figure (same colormap)
% figure(3)
% h(1) = subplot('Position', [0.1, 0.1, 0.35, 0.8]);
% imagesc(criteria_array_0);
% xlim([0 100])
% ylim([0 64])
% %text(-45,30, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
% text(-45,15, '(a)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
% 
% h(2) = subplot('Position', [0.6, 0.1, 0.35, 0.8]);
% imagesc(criteria_array_1);
% xlim([0 100])
% ylim([0 64])
% %text(-45,30, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
% caxis([0 1])
% text(-45,15, '(b)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
% colormap(jet(4))

% plot 4 - CIN only
figure(4)
imagesc(criteria_array_0);
xlim([0 100])
ylim([0 64])
text(-45,15, '(a)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
colormap(jet(4))
set(gca, 'XTick', [0:10:100], 'xticklabel',[-500:100:500],'YTick', [0:8:64], 'yticklabel',[0:8]) 
xlabel('x(km)', 'FontSize', fs2)
ylabel('time(hours)', 'FontSize', fs2)

% plot 5 - CAPE only
figure(5)
imagesc(criteria_array_1);
xlim([0 100])
ylim([0 64])
%text(-45,30, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
caxis([0 1])
text(-45,15, '(b)', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'w')
colormap(jet(4))
set(gca, 'XTick', [0:10:100], 'xticklabel',[-500:100:500],'YTick', [0:8:64], 'yticklabel',[0:8]) 
xlabel('x(km)', 'FontSize', fs2)
ylabel('time(hours)', 'FontSize', fs2)

end
