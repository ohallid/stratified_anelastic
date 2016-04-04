function [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks(HL_bar , HV_bar, Ht_bar, t, T, mmax, sigma )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   z is normalized to top of heating i.e. z = 1 correponds to top of heating

%   HL_bar ratio,  lid height as a multiple of heating height
%   HV_bar ratio,  visualisation height as a multiple of heating height

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pi      = 3.141592653589793;
dx      = 0.1;            % x-step
dz      = 0.1;            % z-step
x       = [-50:dx:50 ];       % x = 10 equivalent to 10 * \sigma (FWHM, PB F(x) )
z       = [0:dz:HV_bar ];
x_0     = 0;                % initial position of heating function, middle of box
s       = 0;             
N1      = 0.01;             % Based on dry lapse rate of 10 deg per km (notes)
g       = 9.81;
rho_s   = 1.0;              % Surface air density
i       = complex(0,1);
scaleht = g / N1 / N1 / 1e4;

ratio   = Ht_bar / HL_bar;
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;

[xx,zz] = meshgrid( x, z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Compute the vertical velocity field w(x,z,t)
%   ww(1,:) corresponds to x = 0 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of modes
m       = [1:1:mmax]; 

% Wave speeds "non-dimensionalized" by HL_bar
c1      = 2 * ratiopp * N1 ./ ( ( 1 + 4 .* m .* m * pi * pi * ratiopp * ratiopp ) .^ 0.5 ) ;

% Mode normalization constants
A1      = ( 2 / HL_bar / rho_s ) ^ 0.5;

% Half-sinusoid heating for density Variation model with adapted PB heating
% Scale height = tropopause height
% fac1    =   1 ./ (   i * pi / ratio + i * pi .* m - 1 / ratio / 2 ) .* ( exp (   i .* m * pi * ratio - 0.5 ) + 1 );
% fac2    = - 1 ./ (   i * pi / ratio - i * pi .* m - 1 / ratio / 2 ) .* ( exp ( - i .* m * pi * ratio - 0.5 ) + 1 );
% fac3    = - 1 ./ ( - i * pi / ratio + i * pi .* m - 1 / ratio / 2 ) .* ( exp (   i .* m * pi * ratio - 0.5 ) + 1 );
% fac4    =   1 ./ ( - i * pi / ratio - i * pi .* m - 1 / ratio / 2 ) .* ( exp ( - i .* m * pi * ratio - 0.5 ) + 1 );
% s1      =   A1 * rho_s * HL_bar / 4 .* ( fac1 + fac2 + fac3 + fac4 );

% Scale height = non-dimensionalised g / N^2 
fac1    =   1 ./ (   i * pi / ratio + i * pi .* m - 1 / ratiopp / 2 ) .* ( exp (   i .* m * pi * ratio - 0.5 * ratiop ) + 1 );
fac2    = - 1 ./ (   i * pi / ratio - i * pi .* m - 1 / ratiopp / 2 ) .* ( exp ( - i .* m * pi * ratio - 0.5 * ratiop ) + 1 );
fac3    = - 1 ./ ( - i * pi / ratio + i * pi .* m - 1 / ratiopp / 2 ) .* ( exp (   i .* m * pi * ratio - 0.5 * ratiop ) + 1 );
fac4    =   1 ./ ( - i * pi / ratio - i * pi .* m - 1 / ratiopp / 2 ) .* ( exp ( - i .* m * pi * ratio - 0.5 * ratiop ) + 1 );
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

ww = M2(real(s1(1)), HL_bar, c1(1), A1, 1, s, x, x_0, z, t, T, Ht_bar, sigma );
bb = M3(real(s1(1)), HL_bar, c1(1), A1, 1, s, x, x_0, z, t, T, Ht_bar, sigma );
Sz = S2(real(s1(1)), HL_bar, c1(1), A1, 1, s, x, x_0, z, t, T, Ht_bar        ); 
for mz = 2: mmax
   ww = ww + M2(real(s1(mz)), HL_bar, c1(mz), A1, mz, s, x, x_0, z, t, T, Ht_bar, sigma );
   bb = bb + M3(real(s1(mz)), HL_bar, c1(mz), A1, mz, s, x, x_0, z, t, T, Ht_bar, sigma );
   Sz = Sz + S2(real(s1(mz)), HL_bar, c1(mz), A1, mz, s, x, x_0, z, t, T, Ht_bar        );
end 

% Check heating profile developed by eigenfunction expansion
% figure(2)
% plot(z,Sz);
% grid on;
% title('Reconstructed Heating Profile')
% pause;

% scalings
ww      = 10000 * ww;           % converting units (ww in 10s of kms, convert m)
bb      = 280 * bb / 10;        % bb --> theta, see PB 
Q       = 1 / 2500;             % scaling coeficient on all cals, determind empirically through heating rate arguments
ww      = Q * ww;
bb      = Q * bb;


return 