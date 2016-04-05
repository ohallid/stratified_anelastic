function[f] = F2(x,x_0,s,t, sigma)

% sigma = FWHM 
f     = exp(- ( x - x_0 - s * t) .* ( x - x_0 - s * t) / sigma / sigma );

return