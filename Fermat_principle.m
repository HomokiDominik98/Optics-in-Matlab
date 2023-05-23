%% 3.Problem: Fermat3s principle from wave propagation

% Implement the numerical solution problem we discussed in class, i. e. show that Fermat’s
% principle (principle of least time) comes out as a case of man light beams interfering with each
% other. Use the geometry from the figure below. Assume the light propagates with a 𝑘1 = 2𝜋/𝜆
% wavenumber in vacuum (top half plane) and with a 𝑘2 = 𝑛2𝑘1 in the bottom plane. The complex
% amplitude of a ray going from the source to the detector via two straight line segments is 𝐸 =
% e^(jk1s1)e^(jk2s2) (assuming a unit amplitude at the source). The beam can be traced by splitting the
% 𝑥 axis to 1 mm length segments and superposing a few thousand beams for each segment.

clear all;

% Define area
h1 = 10; %mm
h2 = 10;
d = 20;

% Set light properties
lambda = 630E-6;
n = 2;
k1 = 2*pi/lambda;
k2 = k1*n;

% Calculation of individual small area sum amplitudes
d_resolution = linspace(0,d,100);
amplitude = zeros(1,size(d_resolution,2));

j=0;
for i=1:size(d_resolution,2)-1
    j=j+1;
    x = linspace(d_resolution(i),d_resolution(i+1),1000);
    s_1 = sqrt(x.^2+h1^2);
    s_2 = sqrt((d-x).^2+h2^2);    
    area_ampl = exp(1i*k1*s_1).*exp(1i*k2*s_2);
    amplitude(j) = sum(area_ampl);
end

absolute_amplitude = abs(amplitude);

% Plotting the light intensity based on distance
f1 = figure(1)
set(f1, 'position', [100,80,1400,600])




%Color scaling
min_absolute_amplitude = min(absolute_amplitude,[],"all");
max_absolute_amplitude = max(absolute_amplitude,[],"all");
color = 1-(absolute_amplitude-min_absolute_amplitude)/(max_absolute_amplitude-min_absolute_amplitude);

% Plot for Path of light
subplot(1,2,1)
hold on
j=0;
for i=d_resolution
    j=j+1;    
    plot([0 i],[h1+h2 h1], 'Color', [color(j) color(j) color(j)])
    plot([i d],[h1 0], 'Color', [color(j) color(j) color(j)])
end
title("Path of light from the source to the target in different medium.")
subtitle(['(n_2/n_1=', num2str(n),')'])
xlabel("Distance on X [mm]")
ylabel("Distance on Y [mm]")
plot(0,h1+h2,'*', 'Color', [0.9290 0.5840 0.1450], 'MarkerSize',20, 'LineWidth', 1)
plot(d,0,'x', 'Color', [0 0.4470 0.7410], 'MarkerSize',10, 'LineWidth', 1)
plot(d,0,'o', 'Color', [0 0.4470 0.7410], 'MarkerSize',20, 'LineWidth', 1)
plot([0 d], [h1 h1], 'r--', 'LineWidth',1)

%Plot for Light Intensity
subplot(1,2,2)
plot(d_resolution,absolute_amplitude,'Color', [0 0.4470 0.7410], 'LineWidth', 1)
xlim([0, d])
xlabel("Distance [mm]")
ylabel("Light Intensity")
title("Light intensity at the border of the medium.")
subtitle(['(n_2/n_1=', num2str(n),')'])

% f2 = figure(2)
% set(f1, 'position', [100,80,1400,600])
% hold on
% j=0;
% for i=d_resolution
%     j=j+1;    
%     plot([0 i],[h1+h2 h1], 'Color', 'k')
%     plot([i d],[h1 0], 'Color', 'k')
% end
% title("Path of light from the source to the target in different medium.")
% subtitle(['(n_2/n_1=', num2str(n),')'])
% xlabel("Distance on X [mm]")
% ylabel("Distance on Y [mm]")
% plot(0,h1+h2,'*', 'Color', [0.9290 0.5840 0.1450], 'MarkerSize',20, 'LineWidth', 1)
% plot(d,0,'x', 'Color', [0 0.4470 0.7410], 'MarkerSize',10, 'LineWidth', 1)
% plot(d,0,'o', 'Color', [0 0.4470 0.7410], 'MarkerSize',20, 'LineWidth', 1)
% plot([0 d], [h1 h1], 'r--', 'Linewidth')