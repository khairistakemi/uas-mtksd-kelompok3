clc;
clear;
close all;

%% Parameter Model SIR
beta = 0.25;
gamma = 0.10;

%% Menghitung Bilangan Reproduksi Dasar
R0 = beta/gamma;

fprintf('=========================================\n');
fprintf('ANALISIS BILANGAN REPRODUKSI DASAR\n');
fprintf('=========================================\n\n');

fprintf('Diketahui:\n');
fprintf('beta  = %.2f\n', beta);
fprintf('gamma = %.2f\n\n', gamma);

fprintf('Perhitungan:\n');
fprintf('R0 = beta/gamma\n');
fprintf('R0 = %.2f / %.2f\n', beta, gamma);
fprintf('R0 = %.2f\n\n', R0);

%% Analisis Berdasarkan Nilai R0

if R0 < 1

    fprintf('KASUS 1 : R0 < 1\n');
    fprintf('-----------------------------------------\n');
    fprintf('Karena beta < gamma,\n');
    fprintf('maka dI/dt < 0.\n');
    fprintf('Jumlah individu terinfeksi selalu menurun.\n\n');

    fprintf('lim I(t) saat t menuju tak hingga = 0\n');
    fprintf('Penyakit akan punah dari populasi.\n');

elseif R0 > 1

    fprintf('KASUS 2 : R0 > 1\n');
    fprintf('-----------------------------------------\n');
    fprintf('Karena beta > gamma,\n');
    fprintf('maka dI/dt > 0 pada fase awal epidemi.\n');
    fprintf('Jumlah individu terinfeksi meningkat.\n\n');

    fprintf('Terjadi epidemi.\n');

else

    fprintf('KASUS 3 : R0 = 1\n');
    fprintf('-----------------------------------------\n');
    fprintf('dI/dt = 0\n');
    fprintf('Jumlah penderita relatif tetap.\n');
    fprintf('Kondisi ini merupakan ambang epidemi.\n');

end

%% Kesimpulan

fprintf('\n=========================================\n');
fprintf('KESIMPULAN\n');
fprintf('=========================================\n');

fprintf('Nilai R0 = %.2f\n',R0);

if R0 > 1
    fprintf('Karena R0 > 1, maka terjadi epidemi.\n');
elseif R0 < 1
    fprintf('Karena R0 < 1, maka penyakit akan punah.\n');
else
    fprintf('Karena R0 = 1, maka sistem berada pada ambang epidemi.\n');
end

fprintf('=========================================\n');