function [ c1, Nfound ] = NR31(HL_bar , Ht_bar)

% Case 3 roots of SE : addresses bounded region 
% 0.5 / N2 / ratio < x_n < 0.5 / N1 / ratio

pi      = 3.141592653589793;
g       = 9.81;                        % ms^{-2}        
N1      = 0.01;                        % Based on dry lapse rate of 10 deg per km (notes)
N2      = 0.0199;
ratio   = Ht_bar / HL_bar;
scaleht = g / N1 / N1 / 1e4;           % units of Ht_bar
ratiop  = Ht_bar  / scaleht;
ratiopp = scaleht / HL_bar;

xmin   = 0.5 / N2 / ratiopp;
xmax   = 0.5 / N1 / ratiopp;
dx     = ( xmax - xmin ) / 1e7; 
x      = [xmin:dx:xmax];
N      = round( 1e7 );

% Seeding using parity criterion
Hkn        = ( 0.25 / ratiopp / ratiopp - N1 * N1 .* x .* x ) .^ 0.5;
Hknp       = ( N2 * N2 .* x .* x - 0.25 / ratiopp / ratiopp ) .^ 0.5;
fx         = Hkn ./ Hknp - tanh ( Hkn * ratio ) .* cot( Hknp * (ratio - 1 ) );
index      = 0;
for n=1:N
    if ( fx(n)*fx(n+1) < 0 ) && ( abs(fx(n)) < 100 )
        index      = index + 1;
        Hx1(index) = x(n);
    end
end
index
pause

% figure(1)
% l  = length(Hx1);
% y1 = zeros(l);
% plot(x, fx );
% grid on
% xlabel('x H = H / c_n');
% ylabel('f( x H )');
% title('Secular equation case 3 for 2-layer problem with density variation with NR seeds.')
% ylim([-10 10]);
% xlim([xmin xmax])
% hold on
% plot(Hx1 ,y1,'c*');
% pause;

% Converge seeds
for n=1:10
    Hkn     = ( 0.25 / ratiopp / ratiopp - N1 * N1 .* Hx1 .* Hx1 ) .^ 0.5;
    Hknp    = ( N2 * N2 .* Hx1 .* Hx1 - 0.25 / ratiopp / ratiopp ) .^ 0.5;
    dHkndx  = - N1 * N1 .* Hx1 ./ Hkn; 
    dHknpdx =   N2 * N2 .* Hx1 ./ Hknp;    
    f       = Hkn ./ Hknp - tanh ( Hkn * ratio ) .* cot( Hknp * (ratio - 1 ) );
    
    dfdx    = - Hkn ./ ( Hknp .^ 2 ) .* dHknpdx + 1 ./ Hknp .* dHkndx...
              + tanh ( Hkn * ratio         ) .* ( ( sin ( Hknp * (ratio - 1 ) )   .^-2 ).* dHknpdx * (ratio - 1 ))...
              - cot ( Hknp * (ratio - 1 ) ) .* ( ( sech   ( Hkn  *  ratio       ) .^ 2 ).* dHkndx  *  ratio      );
    
    Hx1     = Hx1 - f ./ dfdx  ;
%     plot(Hx1 ,y1,'r*');
end

Nfound  = length(Hx1);
c1      = 1 ./ Hx1;

% Plot f and converged seeds
% figure(2)
% plot(x, fx );
% xlabel('x=1/cn');
% ylabel('f(x)');
% title('Secular equation for 2-layer problem with density variation with converged free mode speeds.')
% ylim([-10 10]);
% xlim([xmin xmax])
% hold on
% grid on
% plot(Hx1 ,y1,'c*');
% pause;

return
