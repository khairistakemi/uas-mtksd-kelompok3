clear; clc;

% λ = α ± βi = -0.05 + 0.1i 
lambda = -0.05 + 0.1i; 

% 1. Menghitung Modulus (r)
% r = sqrt(alpha^2 + beta^2)
alpha = real(lambda);
beta_im = imag(lambda);
r = sqrt(alpha^2 + beta_im^2);

% 2. Menghitung Argumen (θ)
% θ = atan2(beta, alpha)
theta_rad = atan2(beta_im, alpha);
theta_deg = rad2deg(theta_rad);

% 3. Menampilkan Hasil
fprintf('--- Hasil Perhitungan Bagian 3 ---\n');
fprintf('Eigenvalue (λ)    : %.2f + %.2fi\n', alpha, beta_im);
fprintf('Modulus (r)       : %.4f\n', r); % Target: 0.1118 
fprintf('Argumen (θ) (rad) : %.4f radian\n', theta_rad); % Target: 2.034 
fprintf('Argumen (θ) (deg) : %.2f derajat\n', theta_deg); % Target: 116.57 

% Penjelasan Stabilita
if alpha < 0
    fprintf('\nInterpretasi: Karena Re(λ) < 0, sistem bersifat stabil.\n');
else
    fprintf('\nInterpretasi: Karena Re(λ) > 0, sistem tidak stabil.\n');
end