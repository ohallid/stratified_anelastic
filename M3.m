function [mm] = M3(bm, HL_bar, c, A, m, s, x, x_0, z, t, T, Ht_bar )
                    
root2   = sqrt(2.0);
sigma   = 1.0;

x2      = sigma * sigma * sqrt(pi) / 2 / root2 / ( c * HL_bar ) * F3(x, x_0,  c*HL_bar, t, T, sigma);
x3      = sigma * sigma * sqrt(pi) / 2 / root2 / ( c * HL_bar ) * F3(x, x_0,- c*HL_bar, t, T, sigma);
x_var   = x2 - x3 ;

phi     = A * sin ( m * pi .* z / HL_bar ) .* exp( 1 .* z / 2 / Ht_bar );
z_var   = phi * bm;
z_var   = z_var';

mm      =  z_var * x_var;

return 