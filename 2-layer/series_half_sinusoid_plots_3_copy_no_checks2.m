function [ xx, zz, ww, bb ] = series_half_sinusoid_plots_3_copy_no_checks2(HL_bar , HV_bar, Ht_bar, t, T, mmax, sigma )

pi      = 3.141592653589793;
N1      = 0.01;              % Based on dry lapse rate of 10 deg per km (notes)
N2      = 0.0199;
g       = 9.81;              % ms^{-2}
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4; % units of Ht_bar
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;
rhos    = 1.0;               % Surface air density

i       = complex(0,1);
x_0     = 0;                 % initial position of heating function, middle of box
s       = 0;             

dx      = 0.1;             % x-step
dz      = 0.1;             % z-step
x       = [0:dx:20 ];        % x = 10 equivalent to 10 * \sigma (FWHM, PB F(x) )
z       = [0:dz:HV_bar ];
[xx,zz] = meshgrid( x, z);

% Case 1
% precise number of these close to but not necessarily equal to mmax
[c1, Nroots1 ] = NR3(HL_bar,Ht_bar,mmax);
m1            = [1:1:Nroots1];
% Normalization coefficients
Hkn1    = ( N1 * N1 ./ c1 ./ c1 - 0.25 / ratiopp / ratiopp ) .^ 0.5;
Hknp1   = ( N2 * N2 ./ c1 ./ c1 - 0.25 / ratiopp / ratiopp ) .^ 0.5;
fac1    = sin ( Hkn1 * ratio ) ./ sin ( Hknp1 * ( ratio - 1) );
A1      = 0.5 * N1 * N1 .* (     ratio - 0.5 * sin ( 2 * Hkn1  *  ratio      ) ./ Hkn1  )...
        + 0.5 * N2 * N2 .* ( 1 - ratio + 0.5 * sin ( 2 * Hknp1 * (ratio - 1) ) ./ Hknp1 ) .* fac1 .* fac1;
A1      = ( A1 .^ -0.5 ) / sqrt(HL_bar * rhos ); 
A1(1)   = 0;  % Fixed wave speed c1(1) gives Hkn1 = 0 hence A1(1) value will be NaN 
% Heating coefficients
t1      =   1 ./ (   i * pi / ratio + i * Hkn1 - 0.5 / ratiopp ) .* ( exp (   i * Hkn1 * ratio - 0.5 * ratiop ) + 1 );
t2      = - 1 ./ (   i * pi / ratio - i * Hkn1 - 0.5 / ratiopp ) .* ( exp ( - i * Hkn1 * ratio - 0.5 * ratiop ) + 1 );
t3      = - 1 ./ ( - i * pi / ratio + i * Hkn1 - 0.5 / ratiopp ) .* ( exp (   i * Hkn1 * ratio - 0.5 * ratiop ) + 1 );
t4      =   1 ./ ( - i * pi / ratio - i * Hkn1 - 0.5 / ratiopp ) .* ( exp ( - i * Hkn1 * ratio - 0.5 * ratiop ) + 1 );
s1      =   real( rhos * HL_bar * A1 / 4 .* ( t1 + t2 + t3 + t4 ) );

% Case 3
% [c3, Nroots3 ] = NR31(HL_bar,Ht_bar);
% m3            = [1:1:Nroots3];
% Hkn3    = ( 0.25 / ratiopp / ratiopp - N1 * N1 ./ c3 ./ c3 ) .^ 0.5;
% Hknp3   = ( N2 * N2 ./ c3 ./ c3 - 0.25 / ratiopp / ratiopp ) .^ 0.5;
% fac3    = sinh ( Hkn3 * ratio ) ./ sin ( Hknp3 * ( ratio - 1) );
% A3      = 0.5 * N1 * N1 .* (   - ratio + 0.5 * sinh ( 2 * Hkn3  *  ratio      ) ./ Hkn3  )...
%         + 0.5 * N2 * N2 .* ( 1 - ratio + 0.5 * sin  ( 2 * Hknp3 * (ratio - 1) ) ./ Hknp3 ) .* fac3 .* fac3;
% A3      = ( A3 .^ -0.5 ) / sqrt( HL_bar * rhos ); 
% Heating coefficients
% t1      =   1 ./ (   i * pi / ratio + Hkn3 - 0.5 / ratiopp ) .* ( exp (   Hkn3 * ratio - 0.5 * ratiop ) + 1 );
% t2      = - 1 ./ (   i * pi / ratio - Hkn3 - 0.5 / ratiopp ) .* ( exp ( - Hkn3 * ratio - 0.5 * ratiop ) + 1 );
% t3      = - 1 ./ ( - i * pi / ratio + Hkn3 - 0.5 / ratiopp ) .* ( exp (   Hkn3 * ratio - 0.5 * ratiop ) + 1 );
% t4      =   1 ./ ( - i * pi / ratio - Hkn3 - 0.5 / ratiopp ) .* ( exp ( - Hkn3 * ratio - 0.5 * ratiop ) + 1 );
% s3      =   real( i * rhos * HL_bar * A3 / 4 .* ( t1 + t2 + t3 + t4 ) ); 

% figure(1)
% subplot(2,3,1)
% scatter(m1,c1,'c');
% grid on
% title('Case 1 wave speeds')
% subplot(2,3,2)
% scatter(m1,A1,'c');
% grid on
% title('Case 1 normalization')
% subplot(2,3,3)
% scatter(m1,real(s1),'c');
% grid on
% title('Case 1 heating coeffs')
% subplot(2,3,4)
% scatter(m3,c3,'r');
% grid on
% title('Case 3 wave speeds')
% subplot(2,3,5)
% scatter(m3,A3,'r');
% grid on
% title('Case 3 normalization')
% subplot(2,3,6)
% scatter(m3,real(s3),'r');
% grid on
% title('Case 3 heating coeffs')

% Case 1 wave speeds
ww = M2(s1(1), HL_bar, c1(1), A1(1), fac1(1), s, x, x_0, z, t, T, Ht_bar, sigma );
bb = M3(s1(1), HL_bar, c1(1), A1(1), fac1(1), s, x, x_0, z, t, T, Ht_bar, sigma );
Sz = S2(s1(1), HL_bar, c1(1), A1(1), fac1(1), s, x, x_0, z, t, T, Ht_bar);
for mz = 2: Nroots1
   ww = ww + M2(s1(mz), HL_bar, c1(mz), A1(mz), fac1(mz), s, x, x_0, z, t, T, Ht_bar, sigma );
   bb = bb + M3(s1(mz), HL_bar, c1(mz), A1(mz), fac1(mz), s, x, x_0, z, t, T, Ht_bar, sigma );
   Sz = Sz + S2(s1(mz), HL_bar, c1(mz), A1(mz), fac1(mz), s, x, x_0, z, t, T, Ht_bar);
end
% Case 3 wave speeds
% for mz = 1: Nroots3
%    ww = ww + M2p(s3(mz), HL_bar, c3(mz), A3(mz), fac3(mz), s, x, x_0, z, t, T, Ht_bar, sigma );
%    bb = bb + M3p(s3(mz), HL_bar, c3(mz), A3(mz), fac3(mz), s, x, x_0, z, t, T, Ht_bar, sigma );
%    Sz = Sz + S2p(s3(mz), HL_bar, c3(mz), A3(mz), fac3(mz), s, x, x_0, z, t, T, Ht_bar);
% end 

% Reconstruct heating profile as check of closure of set of wave speeds
% figure(2)
% plot(z,Sz);
% xlim([0 HV_bar]);
% grid on;
% title('Reconstructed heating function');

return 