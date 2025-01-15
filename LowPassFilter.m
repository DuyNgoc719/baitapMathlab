function [filtered_data] = LowPassFilter(raw_data, filter_type, order, Fs, fc)
    Fn = Fs / 2; % Tần số Nyquist

    % Kiểm tra loại bộ lọc
    switch filter_type
        case 1 % Butterworth filter
            [A, B, C, D] = butter(order, fc / Fn, 'low');
            [filter_SOS, g] = ss2sos(A, B, C, D); % Chuyển đổi bộ lọc thành SOS (Second-Order Sections)
            filtered_data = filtfilt(filter_SOS, g, raw_data); % Áp dụng bộ lọc qua hàm filtfilt

        case 2 % Chebyshev Type I filter
            [A, B, C, D] = cheby1(order, 0.1, fc / Fn, 'low');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);

        case 3 % Chebyshev Type II filter
            [A, B, C, D] = cheby2(order, 20, fc / Fn, 'low');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);

        case 4 % Elliptic filter
            [A, B, C, D] = ellip(order, 0.1, 30, fc / Fn, 'low');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);

        case 5 % FIR filter (FIR1)
            d = fir1(order, fc / Fn, 'low');
            filtered_data = filtfilt(d, 1, raw_data); % Áp dụng bộ lọc FIR

        case 6 % FIR filter (designfilt)
            d = designfilt('lowpassfir', 'FilterOrder', order, 'PassbandFrequency', fc, 'StopbandFrequency', fc + 0.2, 'DesignMethod', 'ls', 'SampleRate', Fs);
            filtered_data = filtfilt(d, raw_data); % Áp dụng bộ lọc FIR thiết kế

        case 7 % Smoothing filter
            filtered_data = smooth(raw_data, order); % Bộ lọc làm mịn

        case 8 % Median filter
            filtered_data = medfilt1(raw_data, order); % Bộ lọc trung vị

        case 9 % Wavelet denoising
            filtered_data = wden(raw_data, 'modwtsqtwolog', 's', 'mln', order, 'db2'); % Bộ lọc sóng con

        otherwise
            error('Invalid filter type.'); % Nếu không hợp lệ, báo lỗi
    end
end
