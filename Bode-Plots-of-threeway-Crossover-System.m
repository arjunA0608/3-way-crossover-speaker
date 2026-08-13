clear; clc; close all;
syms s Vi

w_limits = {60, 600000}; 

% ==========================================
% 1. WOOFER (Low-Pass)
% ==========================================
L1 = 25.46e-3; C1 = 99.47e-6; R1 = 8;
sys_woof = tf([1/(L1*C1)], [1, 1/(R1*C1), 1/(L1*C1)]);
opts = bodeoptions;
opts.XLim = [60, 600000];
figure(1);
bode(sys_woof, opts);
grid on;
title('Woofer Section: Low-Pass Filter');
ax = findall(gcf, 'type', 'axes');

set(ax, 'XTick', [60, 100, 1000, 10000, 100000, 600000]);

set(ax, 'XTickLabel', {'60', '100', '1000', '10000', '100000', '600000'});
% ==========================================
% 2. MIDRANGE (Band-Pass)
% ==========================================
% High-Pass section (blocks < 100 Hz)
C2_val = 99.47e-6; L2_val = 25.46e-3; 
% Low-Pass section (blocks > 2500 Hz)
L3_val = 1.02e-3;  C3_val = 3.97e-6;  

Y_C2 = s * C2_val;       Y_L2 = 1 / (s * L2_val);
Y_L3 = 1 / (s * L3_val); Y_C3 = s * C3_val; 
Y_R2 = 1/8;

A = [ (Y_C2 + Y_L2 + Y_L3), -Y_L3; 
      -Y_L3,                (Y_L3 + Y_C3 + Y_R2) ];
B = [ Vi * Y_C2; 0 ];
X = A \ B; 

% Create Transfer Function
H_mid = simplify(X(2) / Vi);
[num_mid, den_mid] = numden(H_mid);
sys_mid = tf(sym2poly(num_mid), sym2poly(den_mid));

figure(2);
bode(sys_mid, opts);
grid on;
title('Midrange Section: Band-Pass Filter');
ax = findall(gcf, 'type', 'axes');

set(ax, 'XTick', [60, 100, 1000, 10000, 100000, 600000]);

set(ax, 'XTickLabel', {'60', '100', '1000', '10000', '100000', '600000'});
% ==========================================
% 3. TWEETER (High-Pass)
% ==========================================
L4 = 1.02e-3; C4 = 3.97e-6; R3 = 8;
sys_tweet = tf([1, 0, 0], [1, 1/(R3*C4), 1/(L4*C4)]);

figure(3);
bode(sys_tweet, opts);
grid on;
title('Tweeter Section: High-Pass Filter');
ax = findall(gcf, 'type', 'axes');

set(ax, 'XTick', [60, 100, 1000, 10000, 100000, 600000]);

set(ax, 'XTickLabel', {'60', '100', '1000', '10000', '100000', '600000'});