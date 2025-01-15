windowSize = 4; % Kích thước cửa sổ
Raw_Sig = rand(1, 100); % Thay bằng tín hiệu PPG thực hoặc tín hiệu giả lập
figure;
plot(Raw_Sig);
xlabel('Samples');
ylabel('Amplitude');
title('Raw PPG Signal');

% Áp dụng bộ lọc trung bình di động
kernel = [0, 0, 1/4, 1/4, 1/4, 1/4, 0, 0]; % Bộ lọc trung bình
Filtered_Sig = conv(Raw_Sig, kernel, 'same'); % Lọc tín hiệu bằng hàm conv

% Hiển thị tín hiệu đã lọc
figure;
plot(Filtered_Sig);
xlabel('Samples');
ylabel('Amplitude');
title('Moving Average');
