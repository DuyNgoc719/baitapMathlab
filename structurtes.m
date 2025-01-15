Participant.FirstName = 'Kirk';           % Gán giá trị
Participant.LastName = 'Shelley';         % Gán giá trị 
Participant.Age = 45;                     % Gán giá trị tuổi

Participant.BloodPressure = [110, 140, 113]; % Gán mảng áp suất máu
Participant.Hypertension = logical([0, 1, 0]); % Gán mảng logic cho bệnh cao huyết áp
Participant                              % Hiển thị cấu trúc Participant
Participant.BloodPressure(2) %Hiển thị phần tử thứ 2 trong array blood pressure