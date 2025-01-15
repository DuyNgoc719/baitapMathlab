a = 1; % Biên độ
mu = 50; % Giá trị trung bình của Gaussian
sigma = 10; % Độ lệch chuẩn của Gaussian
x = 1:1:100; % Tạo các điểm mẫu từ 1 đến 100
y = a * exp(-(((x - mu) / sigma).^2) / 2); % Tính giá trị Gaussian

figure; % Tạo cửa sổ đồ thị mới
plot(x, y); % Vẽ đồ thị
xlabel("Sampling points"); % Gắn nhãn trục x
ylabel("Amplitude"); % Gắn nhãn trục y
title("An example of generating a waveform using one Gaussian function"); % Gắn tiêu đề
