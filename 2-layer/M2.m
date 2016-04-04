function [mm] = M2(bm,HL_bar,c,A,fac, s, x, x_0, z, t, T, Ht_bar, sigma )

pi      = 3.141592653589793;
g       = 9.81;                        % ms^{-2}        
N1      = 0.01;                        % Based on dry lapse rate of 10 deg per km (notes)
N2      = 0.0199;
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;           % units of Ht_bar
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;

H       = 0;                        % Heavyside for switch-off
if t > T
   H = 1;
end

x1           = c * c * F2(x, x_0, s * HL_bar, t  , sigma) / ( c*c - s * s / HL_bar / HL_bar) ;  
x2           = c * c * F2(x, x_0, c * HL_bar, t  , sigma) /  c / ( c - s / HL_bar );
x3           = c * c * F2(x, x_0,-c * HL_bar, t  , sigma) /  c / ( c + s / HL_bar );
x2p          = c * c * F2(x, x_0, c * HL_bar, t-T, sigma) /  c / ( c - s / HL_bar );
x3p          = c * c * F2(x, x_0,-c * HL_bar, t-T, sigma) /  c / ( c + s / HL_bar );
x_var        = x1 .* ( 1 - H ) - 0.5 .* x2 - 0.5 .* x3 + 0.5 .* x2p * H + 0.5 .* x3p * H;

Hkn1         = ( N1 * N1 / c / c - 0.25 / ratiopp / ratiopp ) .^ 0.5;
Hknp1        = ( N2 * N2 / c / c - 0.25 / ratiopp / ratiopp ) .^ 0.5;
region1      = z<=Ht_bar;              % Troposphere
region2      = z> Ht_bar;              % Stratosphere
phi(region1) = A / sigma       * sin ( Hkn1  .* z(region1) / HL_bar         ) .* exp( 1 .* z(region1) / 2 / Ht_bar * ratiop);
phi(region2) = A / sigma * fac * sin ( Hknp1 .* z(region2) / HL_bar - Hknp1 ) .* exp( 1 .* z(region2) / 2 / Ht_bar * ratiop);
% plot(z,phi);
% grid on;
% caption = sprintf('z-variation for b_m = %d',bm);
% title(caption);
% xlim([0 3])
% pause;

z_var        = bm * phi ;
z_var        = z_var';
mm           = z_var * x_var;

return 