% Tính toán các chỉ số HRV (Heart Rate Variability) từ các khoảng thời gian của các nhịp tim

% 1. SDNN: Độ lệch chuẩn của các khoảng thời gian
% SDNN đo độ biến thiên tổng thể của các khoảng RR (hoặc các khoảng thời gian giữa các nhịp tim).
SDNN = std(intervals) * 1000; % Đơn vị của SDNN là mili giây (ms)

% 2. diffNN: Tính sự khác biệt giữa các khoảng thời gian liên tiếp
% diffNN là sự khác biệt giữa các khoảng RR liên tiếp và được tính bằng mili giây.
diffNN = diff(intervals) * 1000; % Đơn vị của diffNN là mili giây (ms)

% 3. RMSSD: Độ lệch chuẩn của sự khác biệt các khoảng RR liên tiếp
% RMSSD đo độ lớn của sự thay đổi trong các khoảng RR liên tiếp, phản ánh sự biến động ngắn hạn.
RMSSD = rms(diffNN); % Tính RMSSD (độ lệch chuẩn của sự khác biệt)

% 4. SDSD: Độ lệch chuẩn của sự khác biệt giữa các khoảng RR liên tiếp
% SDSD là một đặc trưng khác đo sự biến thiên ngắn hạn giữa các nhịp tim.
SDSD = std(diffNN); % Tính SDSD (độ lệch chuẩn của diffNN)

% 5. NN50: Số lượng các cặp khoảng RR có sự khác biệt lớn hơn 50 ms
% NN50 đo số lượng các sự thay đổi giữa các khoảng RR vượt quá 50 ms.
NN50 = length(find(abs(diffNN) > 50)); % Đếm số lượng các sự thay đổi > 50 ms

% 6. pNN50: Tỷ lệ phần trăm các cặp khoảng RR có sự khác biệt lớn hơn 50 ms
% pNN50 là tỷ lệ phần trăm các sự thay đổi giữa các khoảng RR vượt quá 50 ms.
pNN50 = NN50 / length(intervals); % Tính tỷ lệ NN50

% 7. NN20: Số lượng các cặp khoảng RR có sự khác biệt lớn hơn 20 ms
% NN20 đo số lượng các sự thay đổi giữa các khoảng RR vượt quá 20 ms.
NN20 = length(find(abs(diffNN) > 20)); % Đếm số lượng các sự thay đổi > 20 ms

% 8. pNN20: Tỷ lệ phần trăm các cặp khoảng RR có sự khác biệt lớn hơn 20 ms
% pNN20 là tỷ lệ phần trăm các sự thay đổi giữa các khoảng RR vượt quá 20 ms.
pNN20 = NN20 / length(intervals); % Tính tỷ lệ NN20
