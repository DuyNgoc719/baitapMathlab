function [error_code, ppg_feature] = FeatureCalculation(error_code, sample_time, PPG_Loc, VPG_Loc, APG_Loc, ppg, vpg, apg)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ppg_feature_calculation.m
    % Xác định và tính toán các đặc trưng PPG
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% Input:
    % error_code — Mã lỗi: 0 nếu tính toán thành công, 1 nếu có lỗi
    % sample_time — Thời gian mẫu của tín hiệu PPG
    % PPG_Loc — Vị trí các điểm đặc trưng của PPG
    % VPG_Loc — Vị trí các điểm đặc trưng của VPG
    % APG_Loc — Vị trí các điểm đặc trưng của APG
    % ppg — Tín hiệu PPG của hai chu kỳ nhịp tim liên tiếp
    % vpg — Tín hiệu VPG của hai chu kỳ nhịp tim liên tiếp
    % apg — Tín hiệu APG của hai chu kỳ nhịp tim liên tiếp

    %% Output:
    % error_code — Cập nhật mã lỗi sau khi tính toán (0: thành công, 1: lỗi)
    % ppg_feature — Cấu trúc chứa các đặc trưng PPG đã tính toán

    %% Phân tách các vị trí đặc trưng của PPG, VPG và APG
    num_O = PPG_Loc(1);
    num_S = PPG_Loc(2);
    num_N = PPG_Loc(3);
    num_D = PPG_Loc(4);
    num_O_next = PPG_Loc(5);

    num_w = VPG_Loc(1);
    num_y = VPG_Loc(2);
    num_z = VPG_Loc(3);
    num_w_next = VPG_Loc(4);

    num_a = APG_Loc(1);
    num_b = APG_Loc(2);
    num_c = APG_Loc(3);
    num_d = APG_Loc(4);
    num_e = APG_Loc(5);
    num_b2 = APG_Loc(6);

    % Khởi tạo cấu trúc chứa các đặc trưng PPG
    ppg_feature.Total = zeros(1, 125);

    if error_code == 0
        %% Tính toán các đặc trưng PPG Type 1: Thời gian
        Tm_Oa = (num_a - num_O) * sample_time;
        Tm_Ow = (num_w - num_O) * sample_time;
        Tm_Ob = (num_b - num_O) * sample_time;
        Tm_OS = (num_S - num_O) * sample_time;
        Tm_Oc = (num_c - num_O) * sample_time;
        Tm_Oy = (num_y - num_O) * sample_time;
        Tm_ON = (num_N - num_O) * sample_time;
        Tm_OD = (num_D - num_O) * sample_time;
        Tss = (num_w_next - num_w) * sample_time;
        Tm_Sc = (num_c - num_S) * sample_time;
        Tm_Sd = (num_d - num_S) * sample_time;
        Tm_Se = (num_e - num_S) * sample_time;
        Tm_SD = (num_D - num_S) * sample_time;
        Tm_ND = (num_D - num_N) * sample_time;
        Tm_bb2 = (num_b2 - num_b) * sample_time;
        Tm_bc = (num_c - num_b) * sample_time;
        Tm_bd = (num_d - num_b) * sample_time;
        Tm_wb = (num_b - num_w) * sample_time;
        Tm_wS = (num_S - num_w) * sample_time;
        Tm_wc = (num_c - num_w) * sample_time;
        Tm_wd = (num_d - num_w) * sample_time;
        Tm_wz = (num_z - num_w) * sample_time;
        Tm_ac = (num_c - num_a) * sample_time;

        % Lưu trữ các đặc trưng về thời gian vào cấu trúc
        ppg_feature.TimeSpan = [
            Tm_Oa, Tm_Ow, Tm_Ob, Tm_OS, Tm_Oc, Tm_Oy, Tm_ON, Tm_OD, Tss,
            Tm_Sc, Tm_Sd, Tm_Se, Tm_SD, Tm_ND, Tm_bb2, Tm_bc, Tm_bd, Tm_wb,
            Tm_wS, Tm_wc, Tm_wd, Tm_wz, Tm_ac
        ];

        %% PPG Feature Type 2: Đặc trưng biên độ PPG
        AMS = ppg(num_S) - ppg(num_O);
        Am_Oa = ppg(num_a) - ppg(num_O);
        Am_Ow = ppg(num_w) - ppg(num_O);
        Am_Ob = ppg(num_b) - ppg(num_O);
        Am_Oc = ppg(num_c) - ppg(num_O);
        Am_Oy = ppg(num_y) - ppg(num_O);
        Am_OO2 = ppg(num_O_next) - ppg(num_O);
        Am_OD = ppg(num_D) - ppg(num_O);
        Am_ON = ppg(num_N) - ppg(num_O);
        Am_NS = ppg(num_S) - ppg(num_N);

        % Tính toán các tỷ lệ và lưu vào cấu trúc
        AI_ON_AMS = Am_ON / AMS;
        AI_OD_AMS = Am_OD / AMS;
        AI_NS_AMS = Am_NS / AMS;
        AI_DS_AMS = (ppg(num_S) - ppg(num_D)) / AMS;

        ppg_feature.Amplitude = [
            AMS, Am_Oa, Am_Ow, Am_Ob, Am_Oc, Am_Oy, Am_OO2, Am_OD, Am_ON, Am_NS,
            AI_ON_AMS, AI_OD_AMS, AI_NS_AMS, AI_DS_AMS
        ];

        %% PPG Feature Type 3: Đặc trưng của VPG và APG
        w = vpg(num_w);
        y = vpg(num_y);
        z = vpg(num_z);
        a = apg(num_a);
        b = apg(num_b);
        c = apg(num_c);
        d = apg(num_d);
        e = apg(num_e);
        cc = vpg(num_c);
        dd = vpg(num_d);

        % Tính toán tỷ lệ giữa các giá trị
        r_z_w = z / w;
        r_y_w = y / w;
        r_cc_w = cc / w;
        r_dd_w = dd / w;
        r_b_a = b / a;
        r_c_a = c / a;
        r_d_a = d / a;
        r_e_a = e / a;
        r_bcde_a = (b - c - d - e) / a;
        r_bcd_a = (b - c - d) / a;

        % Lưu trữ các đặc trưng VPG và APG vào cấu trúc
        ppg_feature.VpgApg = [
            w, y, z, a, b, c, d, e, cc, dd, r_z_w, r_y_w, r_cc_w, r_dd_w,
            r_b_a, r_c_a, r_d_a, r_e_a, r_bcde_a, r_bcd_a
        ];

        %% PPG Feature Type 4: Diện tích sóng
        S_OO = area_calculate(ppg(num_O), num_O, num_O_next, ppg);
        S_OS = area_calculate(ppg(num_O), num_O, num_S, ppg);
        S_Oc = area_calculate(ppg(num_O), num_O, num_c, ppg);
        S_ON = area_calculate(ppg(num_O), num_O, num_N, ppg);

        ppg_feature.WaveformArea = [S_OO, S_OS, S_Oc, S_ON];

        %% PPG Feature Type 5: Diện tích công suất
        power_OS_ppg = power_area_calculate(ppg(num_O), num_O, num_S, ppg);
        power_wS_ppg = power_area_calculate(ppg(num_O), num_w, num_S, ppg);
        power_Sc_ppg = power_area_calculate(ppg(num_O), num_S, num_c, ppg);
        power_Sd_ppg = power_area_calculate(ppg(num_O), num_S, num_d, ppg);

        power_OS_vpg = power_area_calculate(0, num_O, num_S, vpg);
        power_wS_vpg = power_area_calculate(0, num_w, num_S, vpg);
        power_Sc_vpg = power_area_calculate(0, num_S, num_c, vpg);
        power_Sd_vpg = power_area_calculate(0, num_S, num_d, vpg);

        power_OS_apg = power_area_calculate(0, num_O, num_S, apg);
        power_wS_apg = power_area_calculate(0, num_w, num_S, apg);
        power_Sc_apg = power_area_calculate(0, num_S, num_c, apg);
        power_Sd_apg = power_area_calculate(0, num_S, num_d, apg);

        ppg_feature.PowerArea = [
            power_OS_ppg, power_wS_ppg, power_Sc_ppg, power_Sd_ppg,
            power_OS_vpg, power_wS_vpg, power_Sc_vpg, power_Sd_vpg,
            power_OS_apg, power_wS_apg, power_Sc_apg, power_Sd_apg
        ];

        %% PPG Feature Type 6: Tỷ lệ
        r_osc = power_OS_ppg / power_Sc_ppg;
        r_osd = power_OS_ppg / power_Sd_ppg;
        r_osc_vpg = power_OS_vpg / power_Sc_vpg;
        r_osd_vpg = power_OS_vpg / power_Sd_vpg;
        r_osc_apg = power_OS_apg / power_Sc_apg;
        r_osd_apg = power_OS_apg / power_Sd_apg;

        ppg_feature.Ratio = [
            r_osc, r_osd, r_osc_vpg, r_osd_vpg, r_osc_apg, r_osd_apg
        ];

    end
end
