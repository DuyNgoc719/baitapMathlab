x = 0:pi/100:2*pi; % Tạo dãy giá trị từ 0 đến 2*pi với bước pi/100
wave_1 = cos(x * 2); % Tạo sóng cosin với tần số gấp đôi
figure; % Tạo một cửa sổ đồ thị mới
plot(wave_1); % Vẽ đồ thị của sóng
xlabel("Angle"); % Gắn nhãn trục x
ylabel("Amplitude"); % Gắn nhãn trục y
title("An example of generating a waveform using a sinusoid"); % Gắn tiêu đề cho đồ thị
