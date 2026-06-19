clc;
clear;

% Parameter
beta = 0.25;
gamma = 0.10;

% Hitung R0
R0 = beta/gamma;

fprintf('Nilai R0 = %.2f\n',R0);

if R0 < 1
    fprintf('Penyakit akan punah.\n');
elseif R0 > 1
    fprintf('Terjadi epidemi.\n');
else
    fprintf('Kondisi ambang epidemi.\n');
end