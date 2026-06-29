% =========================================================================
% TUGAS BESAR KELOMPOK 3 - EKSPANSI DERET TAYLOR VS NUMERIK
% =========================================================================
clear; clc; close all;

% 1. PARAMETER DATASET (Japan, N = 100.000)
N     = 100000;
beta  = 0.25;
gamma = 0.10;
I0    = 10;
R_init = 0;
S0    = N - I0 - R_init; % 99990

tspan = [0, 10]; % Jangkauan waktu pendek agar Taylor masih akurat
h     = 0.1;     % Step size
t     = (tspan(1):h:tspan(2))';
n     = length(t);

% 2. HITUNG TURUNAN MANUAL DI t=0 UNTUK DERET TAYLOR
% S'(0) dan I'(0)
dS0 = -beta * S0 * I0 / N;
dI0 = (beta * S0 * I0 / N) - (gamma * I0);

% Turunan kedua (Orde 2)
% d2I/dt2 = (beta/N)*(dS/dt*I + S*dI/dt) - gamma*dI/dt
d2I0 = (beta/N)*(dS0*I0 + S0*dI0) - gamma*dI0;

% Turunan ketiga (Orde 3)
% d2S/dt2 = -(beta/N)*(dS/dt*I + S*dI/dt)
d2S0 = -(beta/N)*(dS0*I0 + S0*dI0);
% d3I/dt3 = (beta/N)*(d2S/dt2*I + 2*dS/dt*dI/dt + S*d2I/dt2) - gamma*d2I/dt2
d3I0 = (beta/N)*(d2S0*I0 + 2*dS0*dI0 + S0*d2I0) - gamma*d2I0;

% Turunan keempat (Orde 4)
d3S0 = -(beta/N)*(d2S0*I0 + 2*dS0*dI0 + S0*d2I0);
d4I0 = (beta/N)*(d3S0*I0 + 3*d2S0*dI0 + 3*dS0*d2I0 + S0*d3I0) - gamma*d3I0;


% 3. HITUNG SOLUSI ANALITIK DERET TAYLOR (Orde 1 sampai 4)
I_taylor1 = I0 + dI0*t;
I_taylor2 = I0 + dI0*t + (d2I0/2)*t.^2;
I_taylor3 = I0 + dI0*t + (d2I0/2)*t.^2 + (d3I0/6)*t.^3;
I_taylor4 = I0 + dI0*t + (d2I0/2)*t.^2 + (d3I0/6)*t.^3 + (d4I0/24)*t.^4;


% 4. METODE EULER
y_euler = zeros(n, 2); % Kolom 1: S, Kolom 2: I
y_euler(1, :) = [S0, I0];
for i = 1:(n-1)
    S_skrg = y_euler(i, 1);
    I_skrg = y_euler(i, 2);
    
    y_euler(i+1, 1) = S_skrg + h * (-beta * S_skrg * I_skrg / N);
    y_euler(i+1, 2) = I_skrg + h * (beta * S_skrg * I_skrg / N - gamma * I_skrg);
end


% 5. RUNGE-KUTTA ORDE 4
y_rk4 = zeros(n, 2);
y_rk4(1, :) = [S0, I0];
for i = 1:(n-1)
    S_i = y_rk4(i, 1);
    I_i = y_rk4(i, 2);
    
    % k1
    k1_S = -beta * S_i * I_i / N;
    k1_I = beta * S_i * I_i / N - gamma * I_i;
    
    % k2
    S_k2 = S_i + (h/2)*k1_S; I_k2 = I_i + (h/2)*k1_I;
    k2_S = -beta * S_k2 * I_k2 / N;
    k2_I = beta * S_k2 * I_k2 / N - gamma * I_k2;
    
    % k3
    S_k3 = S_i + (h/2)*k2_S; I_k3 = I_i + (h/2)*k2_I;
    k3_S = -beta * S_k3 * I_k3 / N;
    k3_I = beta * S_k3 * I_k3 / N - gamma * I_k3;
    
    % k4
    S_k4 = S_i + h*k3_S; I_k4 = I_i + h*k3_I;
    k4_S = -beta * S_k4 * I_k4 / N;
    k4_I = beta * S_k4 * I_k4 / N - gamma * I_k4;
    
    y_rk4(i+1, 1) = S_i + (h/6)*(k1_S + 2*k2_S + 2*k3_S + k4_S);
    y_rk4(i+1, 2) = I_i + (h/6)*(k1_I + 2*k2_I + 2*k3_I + k4_I);
end


% 6. HITUNG GALAT RELATIF
I_sebenarnya = y_rk4(:, 2);

% Ambil sampel galat di akhir waktu (t = 10) untuk perbandingan tabel
err_t1 = abs(I_taylor1(end) - I_sebenarnya(end)) / I_sebenarnya(end) * 100;
err_t2 = abs(I_taylor2(end) - I_sebenarnya(end)) / I_sebenarnya(end) * 100;
err_t3 = abs(I_taylor3(end) - I_sebenarnya(end)) / I_sebenarnya(end) * 100;
err_t4 = abs(I_taylor4(end) - I_sebenarnya(end)) / I_sebenarnya(end) * 100;
err_euler = abs(y_euler(end, 2) - I_sebenarnya(end)) / I_sebenarnya(end) * 100;


% 7. TAMPILKAN TABEL GALAT
disp('==================================================');
disp('   PERBANDINGAN GALAT RELATIF PADA t = 10 HARI   ');
disp('==================================================');
fprintf('Deret Taylor Orde 1 : Galat = %.4f %%\n', err_t1);
fprintf('Deret Taylor Orde 2 : Galat = %.4f %%\n', err_t2);
fprintf('Deret Taylor Orde 3 : Galat = %.4f %%\n', err_t3);
fprintf('Deret Taylor Orde 4 : Galat = %.4f %%\n', err_t4);
fprintf('Metode Euler        : Galat = %.4f %%\n', err_euler);
fprintf('Runge-Kutta Orde 4  : Galat = 0.0000 %% (Acuan)\n');
disp('--------------------------------------------------');
fprintf('Jumlah Terinfeksi RK4 (t=10): %.4f jiwa\n', I_sebenarnya(end));
disp('==================================================');


% 8. PLOT GRAFIK PERBANDINGAN
figure(1);
plot(t, I_sebenarnya, 'k-', 'LineWidth', 2.5); hold on;
plot(t, y_euler(:, 2), 'cx-', 'LineWidth', 1.5);
plot(t, I_taylor1, 'r--', t, I_taylor2, 'g--', t, I_taylor3, 'b--', t, I_taylor4, 'm--', 'LineWidth', 1.2);

xlabel('Waktu (Hari)');
ylabel('Jumlah Terinfeksi I(t)');
title('Perbandingan Deret Taylor vs Euler vs RK4');
legend('Solusi Acuan (RK4)', 'Metode Euler', 'Taylor Orde 1', 'Taylor Orde 2', 'Taylor Orde 3', 'Taylor Orde 4', 'Location', 'NorthWest');
grid on;
