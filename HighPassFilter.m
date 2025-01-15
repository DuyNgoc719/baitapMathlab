function [filtered_data, filter_SOS] = HighPassFilter(raw_data, filter_type, order, sample_freq, fc)
    Fn = sample_freq / 2;  % Tần số Nyquist
    
    switch filter_type
        case 1
            % Bộ lọc Butterworth
            [A, B, C, D] = butter(order, fc / Fn, 'high');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 2
            % Bộ lọc Chebyshev Type I
            [A, B, C, D] = cheby1(order, 0.1, fc / Fn, 'high');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 3
            % Bộ lọc Chebyshev Type II
            [A, B, C, D] = cheby2(order, 20, fc / Fn, 'high');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 4
            % Bộ lọc Elliptic
            [A, B, C, D] = ellip(order, 0.1, 30, fc / Fn, 'high');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 5
            % Bộ lọc FIR
            d = fir1(order, fc / Fn, 'high');
            filtered_data = filtfilt(d, 1, raw_data);
        case 6
            % Bộ lọc FIR với thiết kế đặc biệt
            d = designfilt('highpassfir', 'FilterOrder', order, ...
                           'StopbandFrequency', fc - 0.2, 'PassbandFrequency', fc, ...
                           'DesignMethod', 'ls', 'SampleRate', sample_freq);
            filtered_data = filtfilt(d, raw_data);
        case 7
            % Bộ lọc smoothing
            filtered_data = smooth(raw_data, order);
        case 8
            % Bộ lọc median
            filtered_data = medfilt1(raw_data, order);
        case 9
            % Bộ lọc Wavelet
            filtered_data = wden(raw_data, 'modwtsqtwolog', 's', 'mln', order, 'db2'); % Wavelet level: order
        otherwise
            error('Invalid filter type selected.');
    end
end
