function [mm] = M3p(bm, HL_bar, c, A, fac, s, x, x_0, z, t, T, Ht_bar, sigma )
                    
root2   = sqrt(2.0);
pi      = 3.141592653589793;
g       = 9.81;                        % ms^{-2}        
N1      = 0.01;                        % Based on dry lapse rate of 10 deg per km (notes)
N2      = 0.0199;
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;           % units of Ht_bar
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;

x2      = sqrt(pi) / 2 / root2 / ( c * HL_bar ) * F3(x, x_0,  c*HL_bar, t, T, sigma);
x3      = sqrt(pi) / 2 / root2 / ( c * HL_bar ) * F3(x, x_0,- c*HL_bar, t, T, sigma);
x_var   = x2 - x3 ;

Hkn1         = ( 0.25 / ratiopp / ratiopp - N1 * N1 / c / c ) .^ 0.5;
Hknp1        = ( N2 * N2 / c / c - 0.25 / ratiopp / ratiopp ) .^ 0.5;
region1      = z<=Ht_bar;              % Troposphere
region2      = z> Ht_bar;              % Stratosphere
phi(region1) = A        * sinh ( Hkn1  .* z(region1) / HL_bar         ) .* exp( 1 .* z(region1) / 2 / Ht_bar * ratiop );
phi(region2) = A *  fac * sin  ( Hknp1 .* z(region2) / HL_bar - Hknp1 ) .* exp( 1 .* z(region2) / 2 / Ht_bar * ratiop );
z_var   = phi * bm;
z_var   = z_var';

mm      =  z_var * x_var;

return 