function [mm] = M3(bm, HL_bar, c, A, m, s, x, x_0, z, t, T, Ht_bar, sigma )
                    
root2   = sqrt(2.0);
N1      = 0.01;             % Based on dry lapse rate of 10 deg per km (notes)
g       = 9.81;
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;
rho_s   = 1.0;              % Surface air density

x2      = sqrt(pi) / 2 / root2 / ( c * HL_bar ) * F3(x, x_0,  c*HL_bar, t, T, sigma);
x3      = sqrt(pi) / 2 / root2 / ( c * HL_bar ) * F3(x, x_0,- c*HL_bar, t, T, sigma);
x_var   = x2 - x3 ;

phi     = A * sin ( m * pi .* z / Ht_bar * ratio ) .* exp( 1 .* z / 2 / Ht_bar * ratiop );

z_var   = phi * bm;
z_var   = z_var';
mm      = z_var * x_var;

return 