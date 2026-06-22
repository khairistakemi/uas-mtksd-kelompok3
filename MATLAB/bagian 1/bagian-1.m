function sir_simulation()
% Parameter
N = 100000;
beta = 0.25;
gamma = 0.1;

% Kondisi Awal: S=99990, I=10, R=0
y0 = [99990; 10; 0];
tspan = [0 200]; % Simulasi selama 200 hari

% Definisi sistem ODE
ode_system = @(t, y) [
    -beta * y(1) * y(2) / N;                 % dS/dt
    beta * y(1) * y(2) / N - gamma * y(2);  % dI/dt
    gamma * y(2)                            % dR/dt
    ];

% Menjalankan solver ODE
[t, y] = ode45(ode_system, tspan, y0);

% Verifikasi: Hitung jumlah total S + I + R
total_pop = y(:,1) + y(:,2) + y(:,3);

% Plot Hasil
figure;
plot(t, y(:,1), 'b', t, y(:,2), 'r', t, y(:,3), 'g', 'LineWidth', 2);
hold on;
plot(t, total_pop, 'k--', 'LineWidth', 1.5);
legend('Susceptible', 'Infected', 'Recovered', 'Total (N)');
xlabel('Waktu (hari)');
ylabel('Populasi');
title('Simulasi Model SIR');
grid on;

% Menampilkan hasil verifikasi
fprintf('Nilai awal N: %d\n', sum(y0));
fprintf('Nilai akhir N: %.2f\n', total_pop(end));
fprintf('Perubahan maksimum (N - total_pop): %e\n', max(abs(N - total_pop)));
end