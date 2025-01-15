function [filtered_data] = PPG_Bandstop(raw_data, filter_type, order, Fs, fL, fH)
    Fn = Fs / 2;  % Tần số Nyquist
    
    switch filter_type
        case 1
            % Bộ lọc Butterworth
            [A, B, C, D] = butter(order, [fL fH] / Fn, 'stop');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 2
            % Bộ lọc Chebyshev Type I
            [A, B, C, D] = cheby1(order, 0.1, [fL fH] / Fn, 'stop');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 3
            % Bộ lọc Chebyshev Type II
            [A, B, C, D] = cheby2(order, 20, [fL fH] / Fn, 'stop');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 4
            % Bộ lọc Elliptic
            [A, B, C, D] = ellip(order, 0.1, 30, [fL fH] / Fn, 'stop');
            [filter_SOS, g] = ss2sos(A, B, C, D);
            filtered_data = filtfilt(filter_SOS, g, raw_data);
        case 5
            % Bộ lọc FIR
            d = fir1(order, [fL fH] / Fn, 'stop');
            filtered_data = filtfilt(d, 1, raw_data);
        case 6
            % Bộ lọc FIR với thiết kế đặc biệt
            d = designfilt('bandstopfir', 'FilterOrder', order, ...
                           'StopbandFrequency1', fL - 0.2, 'PassbandFrequency1', fL, ...
                           'PassbandFrequency2', fH, 'StopbandFrequency2', fH + 2, ...
                           'DesignMethod', 'ls', 'SampleRate', Fs);
            filtered_data = filtfilt(d, raw_data);
        otherwise
            error('Invalid filter type selected.');
    end
end
