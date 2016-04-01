function [Sz] = M2(bm, HL_bar, c, A, m, s, x, x_0, z, t, T, Ht_bar )

pi      = 3.141592653589793;
N1      = 0.01;                        % Based on dry lapse rate of 10 deg per km (notes)
g       = 9.81;                        % ms^{-2}
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;           % Atmospheric scale heigh in units of Ht_bar
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;
rho_s   = 1.0;                         % Surface air density

phi     = A * sin ( m * pi .* z / Ht_bar * ratio ) .* exp( 1 .* z / 2 / Ht_bar * ratiop );
Sz      = bm * phi;

% Inspect the contribution to the variation
% plot(z,Sz);
% grid on;
% caption = sprintf('z-variation of N^2 phi_m for b_m = %d',bm);
% title(caption);
% xlim([0 10])
% pause;

return 