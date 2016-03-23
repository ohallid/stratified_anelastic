function [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, mmax )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   z is normalized to top of heating i.e. z = 1 correponds to top of heating

%   HL_bar ratio,  lid height as a multiple of heating height
%   HV_bar ratio,  visualisation height as a multiple of heating height

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pi      = 3.141592653589793;
dx      = 0.01;         % x-step
dz      = 0.01;         % z-step
x       = [0:dx:20 ];    % x = 10 equivalent to 10 * \sigma (FWHM, PB F(x) )
z       = [0:dz:HV_bar ];
x_0     = 0;             % initial position of heating function, middle of box
s       = 0;             
N1      = 0.01;          % Based on dry lapse rate of 10 deg per km (notes)
ratio   = Ht_bar / HL_bar;
rho_s   = 1.0;           % Surface air density
i       = complex(0,1);
[xx,zz] = meshgrid( x, z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Compute the vertical velocity field w(x,z,t)
%   ww(1,:) corresponds to x = 0 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m       = [1:1:mmax]; 
c1      = 2 * ratio * N1 * HL_bar ./ ( ( 1 + 4 .* m .* m * pi * pi * ratio * ratio ) .^ 0.5 ) ;
c1      = c1 / HL_bar;                  % Non-dimensionalisation
A1      = ( 2 / HL_bar / rho_s ) ^ 0.5;


% Half-sinusoid heating for density Variation model with adapted PB heating
fac1    =   1 ./ (   i * pi / ratio + i * pi .* m - 1 / ratio ) .* ( exp (   i .* m * pi * ratio - 1 ) + 1 );
fac2    = - 1 ./ (   i * pi / ratio - i * pi .* m - 1 / ratio ) .* ( exp ( - i .* m * pi * ratio - 1 ) + 1 );
fac3    = - 1 ./ ( - i * pi / ratio + i * pi .* m - 1 / ratio ) .* ( exp (   i .* m * pi * ratio - 1 ) + 1 );
fac4    =   1 ./ ( - i * pi / ratio - i * pi .* m - 1 / ratio ) .* ( exp ( - i .* m * pi * ratio - 1 ) + 1 );
s1      =   A1 * rho_s * HL_bar / 4 .* ( fac1 + fac2 + fac3 + fac4 );

% figure(1)
% subplot(3,1,1)
% plot(m,c1);
% title('Wave speeds')
% grid on
% subplot(3,1,2)
% plot(m,A1 );
% title('Normalization constants')
% grid on
% subplot(3,1,3)
% plot(m,real(s1));
% title('Heating expansion coefficients')
% grid on;
% pause;

ww = M2(real(s1(1)), HL_bar, c1(1), A1, 1, s, x, x_0, z, t, T, Ht_bar );
bb = M3(real(s1(1)), HL_bar, c1(1), A1, 1, s, x, x_0, z, t, T, Ht_bar );
Sz = S2(real(s1(1)), HL_bar, c1(1), A1, 1, s, x, x_0, z, t, T, Ht_bar ); 
for mz = 2: mmax
   ww = ww + M2(real(s1(mz)), HL_bar, c1(mz), A1, mz, s, x, x_0, z, t, T, Ht_bar );
   bb = bb + M3(real(s1(mz)), HL_bar, c1(mz), A1, mz, s, x, x_0, z, t, T, Ht_bar );
   Sz = Sz + S2(real(s1(mz)), HL_bar, c1(mz), A1, mz, s, x, x_0, z, t, T, Ht_bar );
end 

% Check heating profile developed by eigenfunciton expension
% figure(2)
% plot(z,Sz);
% grid on;
% pause;

bb   = 280 * bb / 10;
Q    = 1;
ww   = Q * ww;
bb   = Q * bb;

return 