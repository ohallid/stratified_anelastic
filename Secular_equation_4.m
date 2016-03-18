
function [ Hx1, Hx2 ] = Secular_equation_4(HL_bar , Ht_bar)

pi      = 3.141592653589793;
N1      = 0.01;
N2      = 0.0199 ;
ratio   = Ht_bar / HL_bar;
m       = [1:1:30];

% Seeds
Hx1      = sqrt( ( m          .* m           * pi * pi + 0.25                       ) / (     N1 * N1 * ratio     * ratio       ));
Hx2      = sqrt( ((2 * m + 1) .* (2 * m + 1) * pi * pi + 0.25 * ( 1 - 1 / ratio )^2 ) / ( 4 * N2 * N2 * (ratio-1) * (ratio - 1) ));
Hx2(1)   = 0.5 / N1 / ratio;
Hx2(2)   = 0.5 * (Hx2(1) + Hx2(3) );

l       = length(Hx1);
y1      = zeros(l);
l       = length(Hx2);
y2      = zeros(l);
 
xmin   = 0.5 / N1 / ratio;
xmax   = xmin * 40;
dx     = ( xmax - xmin ) / 1e7; 
x      = [xmin:dx:xmax];

% Plot f and unconverged seeds
figure(1)
Hkn     = ( N1 * N1 .* x .* x - 0.25 / ratio / ratio ) .^ 0.5;
Hknp    = ( N2 * N2 .* x .* x - 0.25 / ratio / ratio ) .^ 0.5;
dHkndx  = N1 * N1 .* x ./ ( Hkn  ); 
dHknpdx = N2 * N2 .* x ./ ( Hknp );    
fx      = Hkn ./ Hknp - tan ( Hkn * ratio ) .* cot( Hknp * (ratio - 1 ) );
plot(x, fx );
xlabel('x=1/cn');
ylabel('f(x)');
title('Secular equation for 2-layer problem with density variation with NR seeds.')
ylim([-100 100]);
xlim([0 xmax/4])
hold on
plot(Hx1 ,y1,'c*');
plot(Hx2 ,y2,'r*');
grid on
pause;

% Converge both sets of seeds
for n=1:60
    Hkn     = ( N1 * N1 .* Hx1 .* Hx1 - 0.25 / ratio / ratio ) .^ 0.5;
    Hknp    = ( N2 * N2 .* Hx1 .* Hx1 - 0.25 / ratio / ratio ) .^ 0.5;
    dHkndx  = N1 * N1 .* Hx1 ./ Hkn; 
    dHknpdx = N2 * N2 .* Hx1 ./ Hknp;    
    f       = Hkn ./ Hknp - tan ( Hkn * ratio ) .* cot( Hknp * (ratio - 1 ) );
    dfdx    = - Hkn ./ ( Hknp .^ 2 ) .* dHknpdx + 1 ./ Hknp .* dHkndx...
              + tan ( Hkn * ratio         ) .* ( ( sin ( Hknp * (ratio - 1 ) )   .^-2 ).* dHknpdx * (ratio - 1 ))...
              - cot ( Hknp * (ratio - 1 ) ) .* ( ( sec   ( Hkn  *  ratio       ) .^ 2 ).* dHkndx  *  ratio      );
    Hx1     = Hx1 - f ./ dfdx / 40  ;

    Hkn     = ( N1 * N1 .* Hx2 .* Hx2 - 0.25 / ratio / ratio ) .^ 0.5;
    Hknp    = ( N2 * N2 .* Hx2 .* Hx2 - 0.25 / ratio / ratio ) .^ 0.5;
    dHkndx  = N1 * N1 .* Hx2 ./ Hkn ; 
    dHknpdx = N2 * N2 .* Hx2 ./ Hknp;
    f       = Hkn ./ Hknp - tan ( Hkn * ratio ) .* cot( Hknp * (ratio - 1 ) );
    dfdx    = - Hkn ./ ( Hknp .^ 2 ) .* dHknpdx + 1 ./ Hknp .* dHkndx...
              + tan ( Hkn * ratio         ) .* ( ( sin ( Hknp * (ratio - 1 ) ) .^-2 ).* dHknpdx * (ratio - 1 ))...
              - cot ( Hknp * (ratio - 1 ) ) .* ( ( sec ( Hkn  *  ratio       ) .^ 2 ).* dHkndx  *  ratio      );          
    Hx2     = Hx2 - f ./ dfdx / 40  ;
    
    plot(Hx1 ,y1,'c*');
    plot(Hx2 ,y2,'r*');
end

% Plot f and converged seeds
figure(2)
plot(x, fx );
xlabel('x=1/cn');
ylabel('f(x)');
title('Secular equation for 2-layer problem with density variation with converged free mode speeds.')
ylim([-100 100]);
xlim([0 xmax/4])
hold on
grid on
plot(Hx1 ,y1,'c*');
plot(Hx2 ,y2,'r*');

return
