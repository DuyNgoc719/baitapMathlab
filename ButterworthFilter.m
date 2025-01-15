Fs = 200; % Tần số lấy mẫu
Fc = 6 / (Fs / 2); % Tần số cắt (chuẩn hóa theo Nyquist)
m = 6; % Bậc của bộ lọc

% Bộ lọc Butterworth
[num, dend] = butter(m, Fc);

% Thang đo logarit
L = logspace(0, 2); % Tạo mảng tần số trên thang logarit

% Gọi hàm đáp ứng tần số
Z = freqz(num, dend, L, Fs);

% Tính toán và hiển thị độ lớn của đáp ứng
figure;
semilogx(L, abs(Z), 'k'); % Hiển thị trên thang logarit
grid on;
xlabel('Hz'); % Nhãn trục x
ylabel('Gain'); % Nhãn trục y
title('Butterworth Filter Magnitude Response'); % Tiêu đề
