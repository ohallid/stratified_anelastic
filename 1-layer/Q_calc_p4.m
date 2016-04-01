% Tool to calculate Q (to tune heating rate)
% Plots max(max(bb)) against time. Grad of grap will give rate of heating
% per unit time.
function [ww ,bb , b1, b2, delta_b, pp21, pp22, pp31, pp32] = Q_calc_p3();


T       = 10000000;  % secs
sigma   = 5;      % multiplies reference value \sigma_0 i.e. sigma = 3 means sigma = 3 \sigma_0
scalar  = 128;
HL_bar  = 64.0001;
HV_bar  = 1;
Ht_bar  = 1;
s       = ' ';

Q = 0.002;
for j = 1:4   
    
    t = 100;
    for i = 1:200
        [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, scalar * HL_bar )
        bb = Q * bb;
        bb = mean(mean(bb));
        b1(i) = bb;   % records mean bb for different times in array
        t = t + 100;
    end
    
    t = 2;
    for l = 1:75
        [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, scalar * HL_bar )
        bb = Q * bb;
        bb = mean(mean(bb));
        b2(l) = bb;   % records mean bb for different times in array
        t = t + 2;
    end
    
    t = 2;
    for l = 1:150
        [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T,scalar * HL_bar )
        bb = Q * bb;
        bb = mean(mean(bb));
        b3(l) = bb;   % records maximum bb for different times in array
        t = t + 2;
    end
    
    for k = 2:length(b1)
        delta_b(k-1) = b1(k) - b1(k-1);
        delta_t      = 100;
        grad_b_t     = delta_b ./ delta_t;
    end
        
    
    t1 = [100:100:20000];
    t2 = [2:2:150];
    t3 = [2:2:300];
     
    figure(1) % Full set
    scatter(t1 , b1, 'x')
    grid on
    hold on
    x = sprintf('Temporal Variation of Mean Potential Temperature, H = 1* H_t',t,HL_bar);
    title(x);
    xlabel('time (s)');
    ylabel('Mean Potential Temperature');
    legend('Q = 16','Q = 8','Q = 4', 'Q = 2')
%    ylim([0 25])
    
    figure(2) % First subset, extracted by eye (when temp is still changing)
    scatter(t2 , b2 , 'o')
    grid on
    hold on
    x = sprintf('Temporal Variation of Maximum Potential Temperature, H = 1* H_t',t,HL_bar);
    title(x);
    xlabel('time (s)');
    ylabel('Mean Potential Temperature');
    ylim([0 0.02])
    p2      = polyfit(t2,b2,1)    % use the raw data to get the intercept and slope
    pp21(j) = p2(1);              % write grad and intercept into array to use in graph legend
    pp22(j) = p2(2);
    x2 = 0:1:150;
    y2 = p2(1) * x2 + p2(2);
    plot(x2,y2)                  % plot line of best fit
    if j == 1
        str1 = sprintf('Q = %f : b(t) = %f t + %f \n',Q,pp21(j),pp22(j) );
    end
    if j == 2
        str2 = sprintf('Q = %f : b(t) = %f t + %f \n',Q,pp21(j),pp22(j) );
    end
    if j == 3
        str3 = sprintf('Q = %f : b(t) = %f t + %f \n',Q,pp21(j),pp22(j) );
    end
    if j == 4
        str4 = sprintf('Q = %f : b(t) = %ft + %f \n.',Q,pp21(j),pp22(j) );
        legend('Q = 2.0',str1,'Q = 1.0',str2,'Q = 0.5',str3,'Q = 0.25',str4 );
    end
    
    
    figure(3)                    % Test with larger subset to see variation in line of best fit
    scatter(t3 , b3 , 'o') 
    grid on
    x = sprintf('Temporal Variation of Maximum Potential Temperature, H = 1* H_t',t,HL_bar);
    title(x);
    xlabel('time (s)');
    ylabel('Mean Potential Temperature');
    ylim([0 0.02])
    p3      = polyfit(t3,b3,1);  % use the raw data to get the intercept and slope
    pp31(j) = p3(1);             % write grad and intercept into array to use in graph legend
    pp32(j) = p3(2);
    x3 = 0:1:300;
    y3 = p3(1) * x3 + p3(2);
    hold on
    plot(x3,y3)
    if j == 1
        str1 = sprintf('Q = %f : b(t) = %ft + %f \n.',Q,pp31(j),pp32(j));
    end
    if j == 2
        str2 = sprintf('Q = %f : b(t) = %ft + %f \n.',Q,pp31(j),pp32(j) );
    end
    if j == 3
        str3 = sprintf('Q = %f : b(t) = %ft + %f \n.',Q,pp31(j),pp32(j));
    end
    if j == 4
        str4 = sprintf('Q = %f : b(t) = %ft + %f \n.',Q,pp31(j),pp32(j) );
        legend('Q = 2.0',str1,'Q = 1.0',str2,'Q = 0.5',str3,'Q = 0.25',str4 );
    end
    
    Q = Q / 2;
    
end

return