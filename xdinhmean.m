A = [0.57 0.59 0.60 0.1 0.59 0.58 0.57 0.58 0.3 0.61 0.62 0.60 0.62 0.58 0.57];
% Xác định các giá trị ngoại lai trong từng cột bằng phương pháp 'mean'
TF = isoutlier(A, 'mean');
