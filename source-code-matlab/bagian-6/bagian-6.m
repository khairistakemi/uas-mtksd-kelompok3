clc;
clear;
close all;

%% Data

country = 'Japan';

N = 100000;
beta = 0.25;
gamma = 0.10;

S0 = 99990;
I0 = 10;
R0_pop = 0;

R0 = beta/gamma

%% Model SIR

SIR = @(t,y) [ ...
    -beta*y(1)*y(2)/N;
    beta*y(1)*y(2)/N - gamma*y(2);
    gamma*y(2)];

%% Simulasi

[t,y] = ode45(SIR,[0 200],[S0 I0 R0_pop]);

S = y(:,1);
I = y(:,2);
R = y(:,3);

%% Grafik SIR

figure
plot(t,S,'b','LineWidth',2)
hold on
plot(t,I,'r','LineWidth',2)
plot(t,R,'g','LineWidth',2)

xlabel('Waktu (hari)')
ylabel('Jumlah Individu')
title(['Model SIR - ' country])
legend('S(t)','I(t)','R(t)')
grid on

%% Bagian 6

% total infeksi kumulatif
total_infeksi = trapz(t,I)

% puncak epidemi
[I_peak,idx] = max(I);

t_peak = t(idx)

S_peak = S(idx);
R_peak = R(idx);

% verifikasi dI/dt = 0
dIdt = beta*S_peak*I_peak/N - gamma*I_peak

% verifikasi d2I/dt2 < 0
dSdt = -beta*S_peak*I_peak/N;

d2Idt2 = (beta/N)*dSdt*I_peak

%% Grafik puncak epidemi

figure
plot(t,I,'r','LineWidth',2)
hold on
plot(t_peak,I_peak,'ko','MarkerSize',8,'LineWidth',2)

xlabel('Waktu (hari)')
ylabel('I(t)')
title(['Puncak Epidemi - ' country])
grid on

%% Ringkasan hasil

hasil_R0 = R0
hari_puncak = t_peak
jumlah_infeksi_puncak = I_peak