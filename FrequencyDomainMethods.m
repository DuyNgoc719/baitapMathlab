% Phần 1: Nội suy chuỗi thời gian và tính toán phổ công suất
f_interplotion = 4; % Tần số nội suy (Hz)

% 3. Tạo một vector thời gian từ các khoảng cách thời gian (intervals)
t = zeros(1, length(intervals)); % Khởi tạo vector thời gian
for j = 1:1:length(intervals)
    t(j) = sum(intervals(1:j)); % Tính thời gian tích lũy tại mỗi điểm
end

% 7. Tạo vector thời gian t2 với tần số nội suy
t2 = t(1):1/f_interplotion:t(length(t)); % Tạo vector thời gian với tần số nội suy

% 8. Nội suy các giá trị khoảng thời gian (intervals) thành giá trị tại thời gian t2 sử dụng phương pháp spline (nội suy bậc ba)
y = interp1(t, intervals, t2', 'spline')'; % Sử dụng nội suy spline (cubic spline)

% Phần 2: Tính toán phổ công suất
% 11. Loại bỏ giá trị trung bình của chuỗi tín hiệu y
y1 = y - mean(y); % Loại bỏ giá trị trung bình của tín hiệu

% 12. Số điểm FFT (Số điểm của FFT cần phải là bội số của 2, tìm số gần nhất)
NFFT = max(256, 2^nextpow2(length(y1))); % Chọn NFFT là bội số của 2 lớn nhất lớn hơn chiều dài tín hiệu

% 13. Tính toán phổ công suất bằng phương pháp Welch
[pxx, f] = pwelch(y1, length(t2), length(t2)/2, (NFFT*2)-1, f_interplotion); % Sử dụng phương pháp Welch để tính phổ công suất

% Phần 3: Tính toán HRV (Biến động nhịp tim)
% 16. Xác định dải tần số VLF (Very Low Frequency)
f_VLF = [0 0.04]; % Dải tần số VLF

% 17. Xác định dải tần số LF (Low Frequency)
f_LF = [0.04 0.15]; % Dải tần số LF

% 18. Xác định dải tần số HF (High Frequency)
f_HF = [0.15 0.4]; % Dải tần số HF

% 19. Tính tổng phổ trong dải tần số VLF
VLF = trapz(f(f >= f_VLF(1) & f <= f_VLF(2)), pxx(f >= f_VLF(1) & f <= f_VLF(2))) * 1e6; % Đơn vị VLF là ms^2

% 20. Tính tổng phổ trong dải tần số LF
LF = trapz(f(f >= f_LF(1) & f <= f_LF(2)), pxx(f >= f_LF(1) & f <= f_LF(2))) * 1e6; % Đơn vị LF là ms^2

% 21. Tính tổng phổ trong dải tần số HF
HF = trapz(f(f >= f_HF(1) & f <= f_HF(2)), pxx(f >= f_HF(1) & f <= f_HF(2))) * 1e6; % Đơn vị HF là ms^2

% 22. Tính tỷ lệ LF/HF
ratio_LF_HF = LF / HF;

% Phần 4: Vẽ đồ thị
% 24. Vẽ đồ thị phổ công suất
figure;

% 25. Vẽ đồ thị phổ VLF (màu đen)
plot(f(f >= f_VLF(1) & f <= f_VLF(2)), pxx(f >= f_VLF(1) & f <= f_VLF(2)), 'color', 'k');

% 26. Giữ lại đồ thị hiện tại để vẽ các đồ thị tiếp theo
hold on;

% 27. Vẽ đồ thị phổ LF (màu đỏ)
plot(f(f >= f_LF(1) & f <= f_LF(2)), pxx(f >= f_LF(1) & f <= f_LF(2)), 'color', 'r');

% 28. Vẽ đồ thị phổ HF (màu xanh)
plot(f(f >= f_HF(1) & f <= f_HF(2)), pxx(f >= f_HF(1) & f <= f_HF(2)), 'color', 'b');

% 29. Thiết lập các điểm tick trên trục X
set(gca, 'XTick', [0, 0.04, 0.15, 0.4]);

% 30. Thiết lập nhãn cho các điểm tick trên trục X
set(gca, 'XTickLabel', {'0', '0.04', '0.15', '0.4'});
