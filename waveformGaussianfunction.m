Duration = 1; % Thời gian tín hiệu
Fs = 125; % Tần số lấy mẫu

a = [0.82, 0.4]; % Biên độ của 2 Gaussian
mu = [-pi/2, 0]; % Trung tâm của 2 Gaussian
sigma = [0.6, 1.2]; % Độ lệch chuẩn của 2 Gaussian

Samples = Fs / Duration; % Số mẫu
V_angle = 2 * pi / Samples; % Khoảng cách giữa các góc mẫu
angle = -pi + V_angle : V_angle : pi; % Các góc mẫu từ -pi đến pi

% Tạo các hàm Gaussian
y1 = a(1) * exp(-(((angle - mu(1)) / sigma(1)).^2) / 2);
y2 = a(2) * exp(-(((angle - mu(2)) / sigma(2)).^2) / 2);
y = y1 + y2; % Tổng của 2 Gaussian

% Vẽ đồ thị
figure;
plot(angle, y, 'b'); % Tín hiệu tổng hợp
hold on;
plot(angle, y1, 'k--'); % Gaussian thứ nhất
plot(angle, y2, 'r--'); % Gaussian thứ hai
hold off;

% Gắn nhãn và định dạng
xlabel("Angle");
ylabel("Amplitude");
xlim([-pi, pi]); % Giới hạn trục x từ -pi đến pi
set(gca, 'xtick', [-pi, 0, pi], 'xticklabel', {'-\pi', '0', '\pi'}); % Định dạng nhãn trục x
legend("Synthetic PPG", "1^{st} Gaussian", "2^{nd} Gaussian");
title("An example of generating a waveform using angle model");
