function [Sz] = S2(bm, HL_bar, c, A, fac, s, x, x_0, z, t, T, Ht_bar, N1, N2 )
 
pi      = 3.141592653589793;
g       = 9.81;                              % ms^{-2}        
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;               % units of Ht_bar
% scaleht = 4 * g / ( N1+N2) / (N1+N2) / 1e4;  % units of Ht_bar
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;

Hkn1         = ( N1 * N1 / c / c - 0.25 / ratiopp / ratiopp ) .^ 0.5;
Hknp1        = ( N2 * N2 / c / c - 0.25 / ratiopp / ratiopp ) .^ 0.5;
region1      = z<=Ht_bar;              % Troposphere
region2      = z> Ht_bar;              % Stratosphere
phi(region1) = N1 * N1 *  A        * sin ( Hkn1  .* z(region1) / HL_bar         ) .* exp( 1 .* z(region1) / 2 / Ht_bar * ratiop );
phi(region2) = N2 * N2 *  A *  fac * sin ( Hknp1 .* z(region2) / HL_bar - Hknp1 ) .* exp( 1 .* z(region2) / 2 / Ht_bar * ratiop );
Sz           = bm * phi;
% Inspect the contribution to the variation
% figure(20)
% plot(z,real(Sz),'b-' );
% grid on;
% hold on
% plot(z,imag(Sz),'r-' );
% caption = sprintf('N^2 phi_m for x_m = %f, s_m = %f, A_m = %f',1/c,bm,A);
% title(caption);
% xlim([0 10])
% pause;

return 