Fs = 200; % Tần số lấy mẫu
windowSize = 5; % Kích thước cửa sổ
num = (1/windowSize) * ones(1, windowSize); % Bộ lọc trung bình
dend = 1; % Mẫu số của hàm truyền

% Thang đo logarit
L = logspace(0, 2); % Các tần số trên thang logarit

% Gọi hàm đáp ứng tần số
Z = freqz(num, dend, L, Fs); % Hàm đáp ứng tần số của bộ lọc

% Tính toán và hiển thị độ lớn của đáp ứng
figure;
semilogx(L, abs(Z), 'k'); % Hiển thị trên thang logarit
grid on;
xlabel('Hz'); % Nhãn trục x
ylabel('Gain'); % Nhãn trục y
title('Moving Average'); % Tiêu đề
