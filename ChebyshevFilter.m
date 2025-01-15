Fs = 200; % Tần số lấy mẫu
Fc = 6 / (Fs / 2); % Tần số cắt (chuẩn hóa theo Nyquist)
m = 6; % Bậc bộ lọc
Rs = 18; % Dải tần số ngừng

% Bộ lọc Chebyshev Type I
[num, dend] = cheby1(m, Rs, Fc);

% Thang đo logarit
L = logspace(0, 2); % Tạo dải tần số trên thang logarit

% Gọi hàm đáp ứng tần số
Z = freqz(num, dend, L, Fs);

% Tính toán và hiển thị độ lớn của đáp ứng
figure;
semilogx(L, abs(Z), 'k'); % Hiển thị trên thang logarit
grid on;
xlabel('Hz'); % Nhãn trục x
ylabel('Gain'); % Nhãn trục y
title('Chebyshev Type I Filter Magnitude Response'); % Tiêu đề

% Bộ lọc Chebyshev Type II (cheby2)
[num2, dend2] = cheby2(m, Rs, Fc);

% Gọi lại hàm đáp ứng tần số cho bộ lọc Chebyshev Type II
Z2 = freqz(num2, dend2, L, Fs);

% Hiển thị độ lớn của đáp ứng cho bộ lọc Chebyshev Type II
figure;
semilogx(L, abs(Z2), 'r'); % Hiển thị trên thang logarit
grid on;
xlabel('Hz'); % Nhãn trục x
ylabel('Gain'); % Nhãn trục y
title('Chebyshev Type II Filter Magnitude Response'); % Tiêu đề
