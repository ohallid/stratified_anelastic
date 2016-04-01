function[f] = F2(x,x_0,s,t)

% sigma = FWHM 

sigma = 1;

f     = exp(- ( x - x_0 - s * t) .* ( x - x_0 - s * t) / sigma / sigma );

return