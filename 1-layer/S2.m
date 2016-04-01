function [Sz] = M2(bm, HL_bar, c, A, m, s, x, x_0, z, t, T, Ht_bar )

pi      = 3.141592653589793;
N1      = 0.01;                        % Based on dry lapse rate of 10 deg per km (notes)

phi     = A * sin ( m * pi .* z / HL_bar ) .* exp( 1 .* z / 2 / Ht_bar );
Sz      = bm * phi;

% Inspect the contribution to the variation
% plot(z,Sz);
% grid on;
% caption = sprintf('z-variation of N^2 phi_m for b_m = %d',bm);
% title(caption);
% xlim([0 10])
% pause;

return 