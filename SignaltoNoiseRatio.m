signal = signal - mean(signal); % Loại bỏ giá trị trung bình của tín hiệu

NFFT = max(256, 2^nextpow2(length(signal))); % Độ dài FFT, đảm bảo là lũy thừa của 2

Fs = 125; % Tần số lấy mẫu (Sampling frequency)

% Phương pháp Welch để tính phổ công suất
[pxx, f] = pwelch(signal, length(signal), length(signal)/2, (NFFT*2)-1, Fs);

% Các dải tần số cần tính toán
F1 = [1 2.25]; % Dải tần số F1
F2 = [0 8];    % Dải tần số F2

% Tính tổng công suất trong các dải tần số F1 và F2
powerF1 = trapz(f(f >= F1(1) & f <= F1(2)), pxx(f >= F1(1) & f <= F1(2))); % Công suất trong dải F1
powerF2 = trapz(f(f >= F2(1) & f <= F2(2)), pxx(f >= F2(1) & f <= F2(2))); % Công suất trong dải F2

% Tính chỉ số chất lượng tín hiệu (R_SQI)
R_SQI = powerF1 / powerF2;
