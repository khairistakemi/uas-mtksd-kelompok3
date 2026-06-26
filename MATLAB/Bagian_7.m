% Bagian 7 

% data awal
N     = 100000;
beta  = 0.25;
gamma = 0.10;
I0    = 10;
R_init = 0;
S0    = N - I0 - R_init;

tspan = [0, 200];
h     = 0.5;

% skenario 1: vaksinasi 50%
% 50% populasi udah divaksin jadi langsung kebal, S0 berkurang setengahnya
S_vak = S0 - 0.50 * N;
b_vak = beta;
g_vak = gamma;
label1 = 'Vaksinasi 50%';

% skenario 2: karantina, beta dikurangi 50%
% orang2 dibatasi kontaknya jadi penularan melambat
S_kar = S0;
b_kar = beta * 0.50;
g_kar = gamma;
label2 = 'Karantina (beta -50%)';

% skenario 3: pengobatan, gamma dinaikkan 50%
% obat lebih bagus jadi orang lebih cepet sembuh
S_peng = S0;
b_peng = beta;
g_peng = gamma * 1.50;
label3 = 'Pengobatan (gamma +50%)';

% jalanin simulasi buat ketiga skenario
f_vak  = @(t,y) SIR_ode(t, y, b_vak,  g_vak);
f_kar  = @(t,y) SIR_ode(t, y, b_kar,  g_kar);
f_peng = @(t,y) SIR_ode(t, y, b_peng, g_peng);

[t1, y1] = rk4_solver(f_vak,  tspan, [S_vak;  I0; R_init], h);
[t2, y2] = rk4_solver(f_kar,  tspan, [S_kar;  I0; R_init], h);
[t3, y3] = rk4_solver(f_peng, tspan, [S_peng; I0; R_init], h);

% hitung R0 dan Reff tiap skenario
% Reff = R0 * (S0/N), kalau Reff < 1 berarti wabah bisa mereda
R0_vak  = b_vak  / g_vak;   Reff_vak  = R0_vak  * (S_vak  / N);
R0_kar  = b_kar  / g_kar;   Reff_kar  = R0_kar  * (S_kar  / N);
R0_peng = b_peng / g_peng;  Reff_peng = R0_peng * (S_peng / N);

% hitung integral I(t)dt pakai trapesium
int1 = integral_trapesium(t1, y1(:,2));
int2 = integral_trapesium(t2, y2(:,2));
int3 = integral_trapesium(t3, y3(:,2));

[~, idx1] = max(y1(:,2));  tpeak1 = t1(idx1);
[~, idx2] = max(y2(:,2));  tpeak2 = t2(idx2);
[~, idx3] = max(y3(:,2));  tpeak3 = t3(idx3);

% tampilin tabel hasil
fprintf('   PERBANDINGAN SKENARIO INTERVENSI - R0 & INTEGRAL I(t)dt\n');
fprintf('%-26s | %5s | %6s | %8s | %14s\n', ...
    'Skenario', 'R0', 'Reff', 't_peak', 'Int I(t)dt');
fprintf('%-26s | %5s | %6s | %8s | %14s\n', ...
    '--------------------------','-----','------','--------','--------------');
fprintf('%-26s | %5.4f | %6.4f | %8.1f | %14.0f\n', label1, R0_vak,  Reff_vak,  tpeak1, int1);
fprintf('%-26s | %5.4f | %6.4f | %8.1f | %14.0f\n', label2, R0_kar,  Reff_kar,  tpeak2, int2);
fprintf('%-26s | %5.4f | %6.4f | %8.1f | %14.0f\n', label3, R0_peng, Reff_peng, tpeak3, int3);

fprintf('\n--- cek apakah epidemi terkendali (Reff < 1) ---\n');
Reff_list = {label1, Reff_vak; label2, Reff_kar; label3, Reff_peng};
for k = 1:3
    if Reff_list{k,2} < 1
        ket = 'TERKENDALI';
    else
        ket = 'BELUM TERKENDALI';
    end
    fprintf('  %-26s -> Reff = %.4f -> %s\n', Reff_list{k,1}, Reff_list{k,2}, ket);
end

% figure: bandingin R0 dan integral I(t)dt antar skenario
figure('Name','Perbandingan R0 dan Integral','NumberTitle','off','Position',[100 100 800 420]);

xlabels = {'Vaksinasi 50%', 'Karantina -50%', 'Pengobatan +50%'};
warna   = [0 0.7 0.3; 0.85 0.2 0.2; 0.7 0.2 0.8];

subplot(1, 2, 1);
bh1 = bar([R0_vak, R0_kar, R0_peng], 'FaceColor', 'flat');
bh1.CData = warna;
set(gca, 'XTickLabel', xlabels, 'FontSize', 10);
ylabel('R_0', 'FontSize', 11);
title('Bilangan Reproduksi Dasar (R_0)', 'FontSize', 11, 'FontWeight', 'bold');
grid on;

subplot(1, 2, 2);
bh2 = bar([int1, int2, int3]/1e6, 'FaceColor', 'flat');
bh2.CData = warna;
set(gca, 'XTickLabel', xlabels, 'FontSize', 10);
ylabel('Juta hari-orang', 'FontSize', 11);
title('Total Beban Infeksi \int I(t)dt', 'FontSize', 11, 'FontWeight', 'bold');
grid on;

sgtitle('Perbandingan R_0 dan \int I(t)dt Antar Skenario Intervensi', ...
    'FontSize', 12, 'FontWeight', 'bold');

% fungsi lokal
function [t_out, y_out] = rk4_solver(ode_func, tspan, y0, h)
    t0 = tspan(1);
    tf = tspan(2);
    t_out  = (t0:h:tf)';
    n      = length(t_out);
    y_out  = zeros(n, length(y0));
    y_out(1,:) = y0';
    for i = 1:(n-1)
        ti = t_out(i);
        yi = y_out(i,:)';
        k1 = ode_func(ti,       yi);
        k2 = ode_func(ti + h/2, yi + h/2 * k1);
        k3 = ode_func(ti + h/2, yi + h/2 * k2);
        k4 = ode_func(ti + h,   yi + h   * k3);
        y_out(i+1,:) = (yi + (h/6)*(k1 + 2*k2 + 2*k3 + k4))';
    end
end

function dydt = SIR_ode(~, y, b, g)
    N = 100000;
    dydt = [ -b*y(1)*y(2)/N;
              b*y(1)*y(2)/N - g*y(2);
              g*y(2) ];
end

function total = integral_trapesium(t_vec, I_vec)
    total = 0;
    for i = 1:(length(t_vec)-1)
        dt    = t_vec(i+1) - t_vec(i);
        total = total + dt * (I_vec(i) + I_vec(i+1)) / 2;
    end
end