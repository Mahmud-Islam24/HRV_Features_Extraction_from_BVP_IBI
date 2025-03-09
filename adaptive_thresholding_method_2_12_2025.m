%% 
% Load BVP signal
data = readtable('BVP_002.csv');  % Replace with your file name
bvp_signal = data.bvp;        % Adjust column name if necessary
fs = 64;                      % Sampling frequency in Hz

% Limit the signal for plotting (e.g., first 10 seconds)
signal_length = 100* fs;  % 10 seconds
bvp_signal = bvp_signal(1:signal_length);
time = (1:signal_length) / fs;  % Time vector for 10 seconds

% Step 1: Smooth the signal to reduce noise
window_size = round(0.1 * fs);  % 0.1-second window
hr_smoothed = movmean(bvp_signal, window_size);

% Step 2: Wavelet decomposition for denoising and peak enhancement
[c, l] = wavedec(hr_smoothed, 5, 'sym4');  % Symlet wavelet decomposition
hr_denoised = wrcoef('a', c, l, 'sym4', 5);  % Reconstruct using approximation coefficients

% Step 3: Dynamic thresholding (adaptive mean and std in sliding windows)
dynamic_window = fs * 2;  % 2-second window for dynamic thresholding
num_windows = floor(length(hr_denoised) / dynamic_window);
dynamic_thresholds = zeros(num_windows, 1);

locs_dynamic = [];
for i = 1:num_windows
    % Define window range
    start_idx = (i - 1) * dynamic_window + 1;
    end_idx = min(i * dynamic_window, length(hr_denoised));
    window_data = hr_denoised(start_idx:end_idx);
    
    % Calculate mean and std dynamically
    window_mean = mean(window_data);
    window_std = std(window_data);
    threshold = window_mean + 0.5 * window_std;
    dynamic_thresholds(i) = threshold;
    
    % Find peaks within the window
    [pks, locs] = findpeaks(window_data, 'MinPeakHeight', threshold, ...
                            'MinPeakDistance', fs * 0.6);  % Minimum distance: 0.6s
    locs_dynamic = [locs_dynamic; locs + start_idx - 1];  % Adjust indices for full signal
end

% Step 4: Compare with traditional thresholding
fixed_threshold = mean(hr_denoised) + 0.5 * std(hr_denoised);  % Fixed threshold
[pks_fixed, locs_fixed] = findpeaks(hr_denoised, 'MinPeakHeight', fixed_threshold, ...
                                    'MinPeakDistance', fs * 0.6);

% Identify missed peaks
missed_peaks_traditional = setdiff(locs_dynamic, locs_fixed);  % Peaks missed by traditional method

% Visualization
figure;

% Raw smoothed signal
subplot(3, 1, 1);
plot(time, hr_smoothed, 'b', 'LineWidth', 1.2);
title('Raw Smoothed Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Traditional fixed thresholding
subplot(3, 1, 2);
plot(time, hr_denoised, 'b', 'LineWidth', 1.2);
hold on;
plot(locs_fixed / fs, hr_denoised(locs_fixed), 'ro', 'MarkerSize', 6, 'LineWidth', 1.5);
title('Traditional Fixed Thresholding with Wavelet Denoising');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Denoised Signal', 'Traditional Peaks', 'Location', 'best');
grid on;

% Dynamic thresholding with missed peaks highlighted
subplot(3, 1, 3);
plot(time, hr_denoised, 'b', 'LineWidth', 1.2);
hold on;
plot(locs_dynamic / fs, hr_denoised(locs_dynamic), 'go', 'MarkerSize', 6, 'LineWidth', 1.5);
plot(missed_peaks_traditional / fs, hr_denoised(missed_peaks_traditional), 'mx', 'MarkerSize', 8, 'LineWidth', 1.5);
title('Dynamic Thresholding with Wavelet Denoising and Missed Peaks Highlighted');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Denoised Signal', 'Dynamic Peaks', 'Missed Peaks (Traditional)', 'Location', 'best');
grid on;
            