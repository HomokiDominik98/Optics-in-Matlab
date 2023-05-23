%This returns a matrix with the wave amplitudes


function [Mech_F] = waveamp(Xdim,Ydim,isrc,jsrc,ampsrc,dx,dy,lambda)

[X,Y] = meshgrid((1:Xdim)*dx, (1:Ydim)*dy);

r = sqrt( (jsrc*dy-Y).^2 + (isrc*dx-X).^2 );

    k = 2*pi/lambda;
    
    ampsrc; 
    Mech_F = ampsrc*1./sqrt(r).*exp(-1i*k*r);
    
   %Mech_F(isrc,jsrc) = 1.0/dx;
    
end 