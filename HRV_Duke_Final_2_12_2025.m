% Clear workspace and close figures
clear; clc; close all;

%% Load and Process CGM Data (5-minute intervals)
dexcomData = readtable('Dexcom_001.csv', 'VariableNamingRule', 'preserve');
dexcomData.Properties.VariableNames = {'Timestamp', 'CGM'};
dexcomData.Timestamp = datetime(dexcomData.Timestamp, 'InputFormat', 'MM/dd/yyyy HH:mm');

%% Load and Process BVP Data (64 Hz)
bvpData = readtable('BVP_001_Full.csv');
bvpData.Properties.VariableNames = {'Timestamp', 'BVP'};
bvpData.Timestamp = datetime(bvpData.Timestamp, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');

%% Load and Process IBI Data (64 Hz)
ibiData = readtable('IBI_001.csv');
ibiData.Properties.VariableNames = {'Timestamp', 'IBI'};
ibiData.Timestamp = datetime(ibiData.Timestamp, 'InputFormat', 'yyyy-MM-dd HH:mm:ss.SSSSSS');

%% IEEE Figure Formatting Parameters
LineWidth = 1.8;   % Thicker lines for clarity
MarkerSize = 7;    % Larger markers for CGM data
FontSize = 14;     % Standard font size for IEEE
TitleFontSize = 16; % Title size
AxisFontSize = 12; % Axis label font size
FigWidth = 10;     % Width in inches for IEEE figures
FigHeight = 8;     % Height in inches

%% Create IEEE Standard Figure with Colors
figure('Units', 'inches', 'Position', [0, 0, FigWidth, FigHeight]);

% CGM Plot (5-minute intervals, Red)
subplot(3,1,1);
plot(dexcomData.Timestamp, dexcomData.CGM, '-or', 'LineWidth', LineWidth, 'MarkerSize', MarkerSize, ...
    'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r'); % Red circles
title('CGM Readings (5-min Sampling)', 'FontSize', TitleFontSize, 'FontWeight', 'bold');
ylabel('CGM (mg/dL)', 'FontSize', AxisFontSize, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', FontSize, 'LineWidth', 1.2);
xticklabels([]); % Hide x-axis labels for clarity in subplot

% BVP Plot (64 Hz, Blue)
subplot(3,1,2);
plot(bvpData.Timestamp, bvpData.BVP, '-b', 'LineWidth', LineWidth); % Blue continuous line
title('BVP Signal (64 Hz Sampling)', 'FontSize', TitleFontSize, 'FontWeight', 'bold');
ylabel('BVP Amplitude', 'FontSize', AxisFontSize, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', FontSize, 'LineWidth', 1.2);
xticklabels([]); % Hide x-axis labels for clarity in subplot

% IBI Plot (64 Hz, Green)
subplot(3,1,3);
plot(ibiData.Timestamp, ibiData.IBI, '-dg', 'LineWidth', LineWidth, 'MarkerSize', MarkerSize, ...
    'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g'); % Green diamonds
xlabel('Timestamp', 'FontSize', AxisFontSize, 'FontWeight', 'bold');
ylabel('IBI (s)', 'FontSize', AxisFontSize, 'FontWeight', 'bold');
title('IBI Signal (64 Hz Sampling)', 'FontSize', TitleFontSize, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', FontSize, 'LineWidth', 1.2);
xtickformat('MMM dd, HH:mm');

% Improve Layout & Save Figure for IEEE Publications
sgtitle('Raw CGM, BVP, and IBI Signals (IEEE Format)', 'FontSize', TitleFontSize, 'FontWeight', 'bold');
set(gcf, 'Color', 'w');
exportgraphics(gcf, 'IEEE_Standard_Figure_Color.png', 'Resolution', 300);
