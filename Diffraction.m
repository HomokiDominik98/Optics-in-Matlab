%% 1.Problem: Diffraction of a slit

% Use the waveamp.m matlab script (uploaded on the web site) to study the diffraction of slit
% that has the width of 𝑤. You can start with w = 10 𝜇𝑚 and 𝜆 = 630 nm and you can let the
% light propagate to a d = 200 𝜇𝑚 distance.
% a) Show that approximately, the image (diffraction pattern) of the slit is a Fourier transform, i.e.
% the 𝑈(𝑥0) diffraction pattern is a Fourier transform of the 𝑈(𝑥) aperture function with 𝑓x = x0/𝜆*d.
% Spatial frequency components (there is a 1/𝜆*d scale factor between the spatial and frequency
% domain). Show how the validity of the approximation changes as we go farther from the slit or
% change the wavelength. See the figure below for some hint.
% b) show that you can actually generate Fourier transform of different 𝑈(𝑥) aperture functions,
% check how accurate this hardware Fourier transform is.

clear all;

ampsrc = 1;
lambda = 630.0E-9;

% Distance from the slit
d = 780;

% Resolution
dx = 400E-9;          
dy = 400E-9;

% Dimensions
Xdim = 800;             
Ydim = 800;
% Area calculation: Xdim*dx, Ydim*dy -> unit -> in this case X, Y = 400E-9*800 = 320 um

% Defining the source area
slit_width = 8;    % the number of FFT sidebands depends on the slot width: wider -> more sidebands
isrc = (Xdim-slit_width)/2:(Xdim+slit_width)/2;       
jsrc = 0;

Mech_F(1:Xdim,1:Ydim) = 0.0;

for i_plane = isrc       
    Mech_F = Mech_F + waveamp(Xdim,Ydim,i_plane,jsrc,ampsrc,dx,dy,lambda);
end
absoluteMech_F = abs(Mech_F);


% Plotting of hardware Fourier transform - the absolute value from the source
s = d;
index_in_s = 1:Xdim;
value_in_s = 1:Xdim;
for i=1:Xdim
    index_in_s(i) = round(real(sqrt(s^2-(i-Xdim/2).^2)));
    value_in_s(i) = absoluteMech_F(round(real(sqrt(s^2-(i-Xdim/2).^2))),i);
end

f = figure(1); 
set(f, 'position', [100,50,1200,800])
clf()
subplot(2,2,3)
hold all;
plot(absoluteMech_F(d,:),'r', 'LineWidth', 2);
plot(value_in_s,'Color', [0.4660 0.6740 0.380], 'LineWidth', 2);
shading interp;
title(['Mechanical Fourier transform']);
xlabel('x [unit]');
ylabel('Mech_F');
l=legend(['line, d: ', num2str(d), ' unit'],['circle, s: ', num2str(s), ' unit']);
set(l, 'position', [0.15,0.418,0.3007,0.03379]);
set(l, 'Orientation','horizontal');

% Creating the Fourier transformation of the slit function
X = [zeros(1,isrc(1)), ones(1,isrc(end)-isrc(1)), zeros(1,Xdim-isrc(end))]*(lambda/dy*d);
fs = [1:Xdim]*(isrc(end)-isrc(1))/(lambda/dy*d);
L = Xdim;
Y = fft(X);
Y_shift = fftshift(Y);

% Plotting the Fourier of the slit function
subplot(2,2,4)
plot(abs(Y_shift), 'LineWidth', 2) 
title('Fourier transform of the slit function')
xlabel('f [Hz]')
ylabel('U(f)')

% Plotting the visible image (absolute value of diffraction)
subplot(2,2,[1,2])
hold on
pcolor(absoluteMech_F);
plot([0,Xdim],[d,d],'r-', 'LineWidth',2)
plot(1:Xdim,index_in_s,'Color', [0.4660 0.6740 0.380], 'LineWidth', 2);
shading interp; axis equal;
colorbar
caxis([min(absoluteMech_F,[],'all') max(absoluteMech_F,[],'all')])
xlabel("Xdim [unit]")
ylabel("Ydim [unit]")
xlim([0 Xdim])
ylim([0 Ydim])
title('Absolute value of diffraction (visible image)');

%Another visualization of diffraction
% figure(2);
% pcolor(real(MechF));
% shading interp; axis equal;
% xlabel("Xdim [um]")
% ylabel("Ydim [um]")
% title('Real value of diffraction');
% caxis([-150 150])

