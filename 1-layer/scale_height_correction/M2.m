function [mm] = M2(bm, HL_bar, c, A, m, s, x, x_0, z, t, T, Ht_bar, sigma )

%   z is normalized to heating height i.e z = 1 is top of heating
%   range of z defines the interval of visualization
%   Ht_bar = ratio, top of heating to lid height
%   c = SL eigenvalue / H

pi      = 3.141592653589793;
N1      = 0.01;                     % Based on dry lapse rate of 10 deg per km (notes)
ratio   = Ht_bar / HL_bar;
g       = 9.81;
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;
rho_s   = 1.0;                      % Surface air density

H       = 0;                        % Heavyside for switch-off
if t > T
   H = 1;
end

x1           = c * c * F2(x, x_0, s * HL_bar, t  ) / ( c*c - s * s / HL_bar / HL_bar) ;  
x2           = c * c * F2(x, x_0, c * HL_bar, t  ) /  c / ( c - s / HL_bar );
x3           = c * c * F2(x, x_0,-c * HL_bar, t  ) /  c / ( c + s / HL_bar );
x2p          = c * c * F2(x, x_0, c * HL_bar, t-T) /  c / ( c - s / HL_bar );
x3p          = c * c * F2(x, x_0,-c * HL_bar, t-T) /  c / ( c + s / HL_bar );
x_var        = x1 .* ( 1 - H ) - 0.5 .* x2 - 0.5 .* x3 + 0.5 .* x2p * H + 0.5 .* x3p * H;

phi          = A / sigma * sin ( m * pi .* z / Ht_bar * ratio ) .* exp( 1 .* z / 2 / Ht_bar * ratiop );

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