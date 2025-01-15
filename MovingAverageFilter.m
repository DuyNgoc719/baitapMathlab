windowSize = 4; % Kích thước cửa sổ
Raw_Sig = rand(1, 100); % Thay "your PPG signal" bằng tín hiệu PPG thực hoặc tín hiệu giả lập
figure;
plot(Raw_Sig); % Hiển thị tín hiệu gốc
xlabel('Samples');
ylabel('Amplitude');
title('Raw PPG Signal');

% Áp dụng bộ lọc trung bình di động
Filtered_Sig = zeros(1, length(Raw_Sig) - windowSize + 1); % Khởi tạo mảng cho tín hiệu lọc
for i = 1:length(Raw_Sig) - windowSize + 1
    Filtered_Sig(i) = mean(Raw_Sig(i:i+windowSize-1)); % Tính trung bình
end

% Hiển thị tín hiệu đã lọc
figure;
plot(Filtered_Sig);
xlabel('Samples');
ylabel('Amplitude');
title('Moving Average');
