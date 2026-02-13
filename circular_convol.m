clear all;
close all;
clc;

% input
x1_raw = input('Enter the first sequence x1[n] = ');
x2_raw = input('Enter the second sequence x2[n] = ');

if iscell(x1_raw), x1 = cell2mat(x1_raw); else, x1 = x1_raw; end
if iscell(x2_raw), x2 = cell2mat(x2_raw); else, x2 = x2_raw; end

N1 = length(x1);
N2 = length(x2);
N = max(N1, N2);

% Zero padding
x1 = [x1 zeros(1, N-N1)];
x2 = [x2 zeros(1, N-N2)];

y = zeros(1, N);

% Circular Convolution Calculation (Manual 2 loops r there)
for n = 0:N-1
    for k = 0:N-1
        index = mod(n-k, N) + 1;
        % Line 22: Now works because x1 and x2 are numeric
        y(n+1) = y(n+1) + x1(k+1) * x2(index);
    end
end

disp('Circular Convolution Result y[n]:');
disp(y);

% Concentric Circle Visualization
theta = linspace(pi/2, pi/2 - 2*pi, N+1); 
theta = theta(1:end-1);

r_inner = 1;
xi = r_inner * cos(theta);
yi = r_inner * sin(theta);

r_outer = 2;
xo = r_outer * cos(theta);
yo = r_outer * sin(theta);

figure;
hold on;
viscircles([0,0], r_inner, 'EdgeColor', 'b', 'LineStyle', '--');
viscircles([0,0], r_outer, 'EdgeColor', 'r', 'LineStyle', '--');

for i = 1:N
    plot(xi(i), yi(i), 'bo', 'MarkerFaceColor', 'b');
    text(xi(i)*0.7, yi(i)*0.7, num2str(x1(i)), 'Color', 'blue', 'FontWeight', 'bold');
    
    plot(xo(i), yo(i), 'ro', 'MarkerFaceColor', 'r');
    text(xo(i)*1.3, yo(i)*1.3, num2str(x2(i)), 'Color', 'red', 'FontWeight', 'bold');
end

axis equal; axis([-3 3 -3 3]);
title('Concentric Circle Representation');
grid on;
hold off;