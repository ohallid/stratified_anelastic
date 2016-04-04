function[f] = F3(x, x_0, c, t, T, sigma)

root2 = sqrt(2.0);
H = 0;
if ( t > T )
    H = 1;
end

f1     = erf( ( x-x_0 ) / root2 / sigma ) + erf ( ( c *   t      - x + x_0 ) / root2 / sigma );
f2     = erf( ( x-x_0 ) / root2 / sigma ) + erf ( ( c * ( t - T) - x + x_0 ) / root2 / sigma );
f      = f1 - H * f2 ;

return