function [criteria_array_0, delta_w0, xx1, tt] = triggering_criteria()
% 289 X 1001

fs1     = 18;
fs2     = 12;

HL_bar       = 63.993 ;
HV_bar       = 1.50;
Ht_bar       = 1.01;
x_0          = 0;
dx           = 0.01;
x1           = [-50:dx:50];
t1           = [0:450:14400];
[xx1, tt]    = meshgrid(x1,  t1);
N            = 0.01;
mmax         = 500;

%Compute first heating
t = 0;
for i = 1:1:32
    sigma       = 1;
    T           = 3600;
    alpha       = 1;
    [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, mmax );
    % w
    w_ext0               = ww(20,:);
    w_trop0(i,:)         = w_ext0(:);
    w_ext1               = ww(50,:);
    w_trop1(i,:)         = w_ext1(:);
%     w_ext2               = ww(50,:);
%     w_trop2(i,:)         = w_ext2(:);
%     w_ext3               = ww(74,:);
%     w_trop3(i,:)         = w_ext3(:);
    
    % PT
    b_ext0               = bb(20,:);
    b_trop0(i,:)         = b_ext0(:);
    b_ext1               = bb(50,:);
    b_trop1(i,:)         = b_ext1(:);
%     b_ext2               = bb(50,:);
%     b_trop2(i,:)         = b_ext2(:);
%     b_ext3               = bb(74,:);
%     b_trop3(i,:)         = b_ext3(:);
    t = t + 450;
end

%Compute second heating
t = 0;
for k = 1:1:32
   HL_bar = HL_bar ;
   sigma       = 1;
   T           = 900;
   alpha       = 1; % scaling factor to conserve heating
   [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, mmax ); 
   % w
   w = alpha * ww;
   w_ext0p               = ww(20,:);
   w_trop0p(k,:)         = w_ext0p(:);
   w_ext1p               = ww(50,:);
   w_trop1p(k,:)         = w_ext1p(:);
%    w_ext2p               = ww(50,:);
%    w_trop2p(k,:)         = w_ext2p(:);
%    w_ext3p               = ww(74,:);
%    w_trop3p(k,:)         = w_ext3p(:);
   
   % PT
   bb          = alpha * bb;
   b_ext0p               = bb(20,:);
   b_trop0p(k,:)         = b_ext0p(:);
   b_ext1p               = bb(50,:);
   b_trop1p(k,:)         = b_ext1p(:);
%    b_ext2p               = bb(50,:);
%    b_trop2p(k,:)         = b_ext2p(:);
%    b_ext3p               = bb(74,:);
%    b_trop3p(k,:)         = b_ext3p(:);
   
   t = t + 450;
end


%Centre heating about 'timestep'
% c            = zeros(27, 1001);          % specify magnitude of shift
% %
% w_trop0p     = [c;w_trop0p];            % add in zeros at start to delay 'on' time 
% w_trop0p     = w_trop0p([1:289], : );         % trim to fit simulation time
% w_trop1p     = [c;w_trop1p];            % add in zeros at start to delay 'on' time 
% w_trop1p     = w_trop1p([1:289], : );
% 
% 
% b_trop0p     = [c;b_trop0p];            % add in zeros at start to delay 'on' time 
% b_trop0p     = b_trop0p([1:289], : );         % trim to fit simulation time
% b_trop1p     = [c;b_trop1p];            % add in zeros at start to delay 'on' time 
% b_trop1p     = b_trop1p([1:289], : );

%diffs
delta_w0          = w_trop0p - w_trop0;
w_trop0_diff      = delta_w0 .* delta_w0;
w_trop0_diff      = sqrt(w_trop0_diff);
delta_w1          = w_trop1p - w_trop1;
w_trop1_diff      = delta_w1 .* delta_w1;
w_trop1_diff      = sqrt(w_trop1_diff);    

%
delta_b0          = b_trop0p - b_trop0;
b_trop0_diff      = delta_b0 .* delta_b0;
b_trop0_diff      = sqrt(b_trop0_diff);
delta_b1          = b_trop1p - b_trop1;
b_trop1_diff      = delta_b1 .* delta_b1;
b_trop1_diff      = sqrt(b_trop1_diff);    


criteria_array_0    = zeros(33,101);
criteria_array_1    = zeros(33,101);
a    = 1 / 3;
b    = 2 / 3;
c    = 3 / 3;

for k = 1:32
    for l = 1:101
        if delta_w0(k,l) > 0 && delta_b0(k,l) < 0
            criteria_array_0(k,l) = a;
        end
        if delta_w0(k,l) < 0 && delta_b0(k,l) > 0
            criteria_array_0(k,l) = b; 
        end
        if delta_w0(k,l) > 0 && delta_b0(k,l) > 0
            criteria_array_0(k,l) = c;
        end
        %
        %
         if delta_w1(k,l) > 0.01 && delta_b1(k,l) < 0.01
            criteria_array_1(k,l) = a;
        end
        if delta_w1(k,l) < 0.01 && delta_b1(k,l) > 0.01
            criteria_array_1(k,l) = b; 
        end
        if delta_w1(k,l) > 0.01 && delta_b1(k,l) > 0.01
            criteria_array_1(k,l) = c;
        end
    end
end

% figure(1)
% h(1) = subplot('Position', [0.1, 0.1, 0.35, 0.8]);
% surf(xx1,tt,criteria_array_0);
% xlim([-50 50])
% ylim([0 14400])
% text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
% colormap(jet)
% 
% h(2) = subplot('Position', [0.6, 0.1, 0.35, 0.8]);
% surf(xx1,tt,criteria_array_1);
% xlim([-50 50])
% ylim([0 14400])
% text(-45,4000, '5km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
% colormap(jet)



figure(2)
h(1) = subplot('Position', [0.1, 0.1, 0.35, 0.8]);
criteria_array_0 = flipud(criteria_array_0);
imagesc(criteria_array_0);
xlim([0 100])
ylim([0 32])
text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')


h(2) = subplot('Position', [0.5, 0.1, 0.35, 0.8]);
criteria_array_1 = flipud(criteria_array_1);
imagesc(criteria_array_1);
xlim([0 100])
ylim([0 32])
text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
s2Pos = get(h(2),'position');
hb = colorbar('location','eastoutside');
caxis([0 1])
%set(hb, 'YTick', []);
set(h(2),'position',s2Pos);



% figure(3)
% delta_w0 = delta_w0 + 3;
% delta_b0 = delta_b0 + 6;
% surf(delta_w0);
% colormap(jet)
% hold on
% surf(delta_b0);
% colormap(jet)
% imagesc(criteria_array_0);
% colormap(jet)
% %xlim([-50 50])
% %ylim([0 14400])
% text(-45,4000, '2km', 'FontSize',fs2, 'EdgeColor', 'k','BackgroundColor' , 'y')
% colormap(jet)



end
