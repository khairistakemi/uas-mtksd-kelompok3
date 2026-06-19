clc;
clear;
close all;

% Parameter
N = 100000;
beta = 0.25;
gamma = 0.10;

S0 = 99990;
I0 = 10;
R0_pop = 0;

R0 = beta/gamma;

fprintf('Bilangan reproduksi dasar R0 = %.2f\n',R0);

% Model SIR
SIR = @(t,y) [ ...
    -beta*y(1)*y(2)/N;
     beta*y(1)*y(2)/N - gamma*y(2);
     gamma*y(2)];

[t,y] = ode45(SIR,[0 200],[S0 I0 R0_pop]);

S = y(:,1);
I = y(:,2);
R = y(:,3);

figure;
plot(t,S,'b','LineWidth',2);
hold on;
plot(t,I,'r','LineWidth',2);
plot(t,R,'g','LineWidth',2);

xlabel('Waktu (hari)');
ylabel('Jumlah Individu');
title('Simulasi Model SIR');
legend('Susceptible','Infected','Recovered');
grid on;

if R0 > 1
    disp('Kesimpulan: Terjadi epidemi.');
elseif R0 < 1
    disp('Kesimpulan: Penyakit akan punah.');
else
    disp('Kesimpulan: Kondisi ambang epidemi.');
end