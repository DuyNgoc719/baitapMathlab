% Bước 1: Tính tổng các phần tử của ma trận x
n = sum(x(:)); % Sum of Matrix elements, cộng tất cả các phần tử trong ma trận x

% Bước 2: Chuẩn hóa ma trận x theo tổng n
x = x ./ n; % Chia mỗi phần tử trong x cho tổng n, tạo thành tỷ lệ

% Bước 3: Tính tổng theo hàng
r = sum(x, 2); % Tính tổng các phần tử theo từng hàng của ma trận x

% Bước 4: Tính tổng theo cột
s = sum(x); % Tính tổng các phần tử theo từng cột của ma trận x

% Bước 5: Tính tỷ lệ kỳ vọng cho sự đồng thuận ngẫu nhiên
Ex = r * s; % Tỷ lệ kỳ vọng cho sự đồng thuận ngẫu nhiên, nhân tổng theo hàng với tổng theo cột

% Bước 6: Tính tỷ lệ tối đa có thể quan sát được
pom = sum(min([r'; s])); % Tính tổng giá trị nhỏ nhất giữa tổng theo hàng và tổng theo cột (có thể đại diện cho tỷ lệ tối đa quan sát được)

% Bước 7: Tính tỷ lệ quan sát được
po = sum(sum(x .* f)); % Tính tỷ lệ quan sát được bằng cách nhân ma trận x với ma trận f và cộng tất cả các phần tử

% Bước 8: Tính tỷ lệ kỳ vọng
pe = sum(sum(Ex .* f)); % Tính tỷ lệ kỳ vọng bằng cách nhân ma trận Ex với ma trận f và cộng tất cả các phần tử

% Bước 9: Tính chỉ số Kappa của Cohen
k = (po - pe) / (1 - pe); % Tính chỉ số Kappa của Cohen, đánh giá mức độ đồng thuận giữa hai đánh giá
