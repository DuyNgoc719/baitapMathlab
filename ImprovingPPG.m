% Định nghĩa tín hiệu mẫu và tín hiệu cần xử lý
f = template; % Mẫu PPG có chất lượng tốt (template)
g = signal; % Tín hiệu PPG (beat) cần được xử lý

% Resample tín hiệu g sao cho có độ dài giống tín hiệu f
% Đảm bảo rằng cả hai tín hiệu đều có độ dài giống nhau để có thể tính toán sự tương quan
g = resample(signal, length(f), length(g)); 

% Tính toán độ tương quan chéo (cross-correlation) giữa mẫu f và tín hiệu g
xcorr_f_g = xcorr(f, g); % Độ tương quan chéo giữa f và g
xcorr_g_f = xcorr(g, f); % Độ tương quan chéo giữa g và f

% Hiển thị các tín hiệu và kết quả của phép tương quan chéo
figure;

% Vẽ tín hiệu mẫu f
subplot(4,1,1); % Tạo subplot để vẽ nhiều đồ thị trên một cửa sổ
plot(f, 'k--'); % Vẽ tín hiệu mẫu f với màu đen và đường chấm đứt
title('f: Template'); % Tiêu đề cho tín hiệu mẫu

% Vẽ tín hiệu thô g
subplot(4,1,2); % Vẽ tín hiệu thô g trong subplot thứ 2
plot(g, 'r--'); % Vẽ tín hiệu g với màu đỏ và đường chấm đứt
title('g: Raw signal'); % Tiêu đề cho tín hiệu thô

% Vẽ kết quả của phép tương quan chéo f * g
subplot(4,1,3); % Vẽ kết quả tương quan chéo f * g
plot(xcorr_f_g); % Vẽ kết quả của phép tương quan chéo f * g
title('f * g'); % Tiêu đề cho phép tương quan chéo f * g

% Vẽ kết quả của phép tương quan chéo g * f
subplot(4,1,4); % Vẽ kết quả tương quan chéo g * f
plot(xcorr_g_f); % Vẽ kết quả của phép tương quan chéo g * f
title('g * f'); % Tiêu đề cho phép tương quan chéo g * f

% Thêm tiêu đề chung cho toàn bộ đồ thị
suptitle('Cross correlation'); % Tiêu đề chung cho toàn bộ các subplot
