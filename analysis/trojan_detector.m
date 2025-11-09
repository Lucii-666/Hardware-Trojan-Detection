% =====================================================================
% Hardware Trojan Detection via Side-Channel Analysis
% MATLAB Implementation
% 
% This script performs toggle-based side-channel analysis to detect
% hardware Trojans by comparing switching activity between clean and
% infected designs.
%
% Author: Silicon Sprint Team
% Date: November 2025
% =====================================================================

function trojan_detector()
    clc;
    close all;
    
    fprintf('\n');
    fprintf('================================================================================\n');
    fprintf('HARDWARE TROJAN DETECTION - SIDE-CHANNEL ANALYSIS (MATLAB)\n');
    fprintf('================================================================================\n');
    fprintf('\n');
    
    % File paths
    clean_vcd = '../results/alu_clean.vcd';
    trojan_vcd = '../results/alu_trojan.vcd';
    output_dir = '../results';
    
    % Check if files exist
    if ~exist(clean_vcd, 'file')
        error('Clean VCD file not found: %s', clean_vcd);
    end
    if ~exist(trojan_vcd, 'file')
        error('Trojan VCD file not found: %s', trojan_vcd);
    end
    
    % Step 1: Parse VCD files
    fprintf('Step 1: Parsing VCD files...\n');
    clean_data = parse_vcd(clean_vcd);
    trojan_data = parse_vcd(trojan_vcd);
    fprintf('  [OK] Clean design:  %d signals parsed\n', length(fieldnames(clean_data.toggles)));
    fprintf('  [OK] Trojan design: %d signals parsed\n\n', length(fieldnames(trojan_data.toggles)));
    
    % Step 2: Analyze switching activity
    fprintf('Step 2: Analyzing switching activity...\n');
    [deviations, common_signals] = compute_deviations(clean_data.toggles, trojan_data.toggles);
    anomalies = detect_anomalies(deviations, 25.0);
    fprintf('  [DETECTED] Anomalies found (>25%% deviation): %d\n\n', length(anomalies));
    
    % Step 3: Statistical analysis
    fprintf('Step 3: Statistical Analysis\n');
    stats = statistical_analysis(deviations);
    fprintf('  • Mean deviation: %.2f%%\n', stats.mean_dev);
    fprintf('  • Max deviation:  %.2f%%\n', stats.max_dev);
    fprintf('  • Outliers found: %d\n\n', length(stats.outliers));
    
    % Step 4: Generate visualizations
    fprintf('Step 4: Generating visualizations...\n');
    create_comprehensive_report(clean_data.toggles, trojan_data.toggles, deviations, stats, output_dir);
    fprintf('  [INFO] Comprehensive report saved: %s/trojan_detection_report_matlab.png\n\n', output_dir);
    
    % Step 5: Generate text report
    fprintf('Step 5: Generating text report...\n');
    generate_text_report(deviations, stats, anomalies, output_dir);
    fprintf('  [INFO] Text report saved: %s/detection_report_matlab.txt\n\n', output_dir);
    
    % Summary
    fprintf('================================================================================\n');
    fprintf('ANALYSIS COMPLETE\n');
    fprintf('================================================================================\n');
    if length(anomalies) > 0
        fprintf('[ALERT] TROJAN DETECTED - %d suspicious signals identified\n', length(anomalies));
        fprintf('\nTop 3 suspicious signals:\n');
        for i = 1:min(3, length(anomalies))
            fprintf('  %d. %s: %.2f%% deviation\n', i, anomalies(i).signal, anomalies(i).deviation);
        end
    else
        fprintf('[RESULT] No significant anomalies detected\n');
    end
    fprintf('================================================================================\n\n');
end

%% VCD Parser
function data = parse_vcd(filepath)
    % Read entire file
    fid = fopen(filepath, 'r');
    if fid == -1
        error('Cannot open file: %s', filepath);
    end
    content = fread(fid, '*char')';
    fclose(fid);
    
    % Initialize
    data.signals = containers.Map('KeyType', 'char', 'ValueType', 'char');
    data.toggles = struct();
    
    % Parse header for signal definitions
    var_pattern = '\$var\s+(\w+)\s+(\d+)\s+(\S+)\s+(\S+)';
    matches = regexp(content, var_pattern, 'tokens');
    
    for i = 1:length(matches)
        identifier = matches{i}{3};
        signal_name = matches{i}{4};
        data.signals(identifier) = signal_name;
        % Clean signal name (remove special chars)
        clean_name = regexprep(signal_name, '[^a-zA-Z0-9_]', '_');
        data.toggles.(clean_name) = 0;
    end
    
    % Parse value changes and count toggles
    lines = strsplit(content, '\n');
    previous_values = containers.Map('KeyType', 'char', 'ValueType', 'char');
    
    for i = 1:length(lines)
        line = strtrim(lines{i});
        if isempty(line)
            continue;
        end
        
        % Single-bit value change (e.g., "0a" or "1a")
        if length(line) >= 2 && ismember(line(1), '01xXzZ')
            value = line(1);
            identifier = line(2:end);
            
            if data.signals.isKey(identifier)
                signal_name = data.signals(identifier);
                clean_name = regexprep(signal_name, '[^a-zA-Z0-9_]', '_');
                
                % Check for toggle
                if previous_values.isKey(identifier)
                    prev_val = previous_values(identifier);
                    if ~strcmp(prev_val, value) && ismember(value, '01') && ismember(prev_val, '01')
                        data.toggles.(clean_name) = data.toggles.(clean_name) + 1;
                    end
                end
                previous_values(identifier) = value;
            end
        end
        
        % Multi-bit value change (e.g., "b0101 a")
        if startsWith(line, 'b')
            parts = strsplit(line);
            if length(parts) >= 2
                value = parts{1}(2:end); % Remove 'b' prefix
                identifier = parts{2};
                
                if data.signals.isKey(identifier)
                    signal_name = data.signals(identifier);
                    clean_name = regexprep(signal_name, '[^a-zA-Z0-9_]', '_');
                    
                    % Count bit-level toggles
                    if previous_values.isKey(identifier)
                        prev_val = previous_values(identifier);
                        toggles = count_bit_toggles(prev_val, value);
                        data.toggles.(clean_name) = data.toggles.(clean_name) + toggles;
                    end
                    previous_values(identifier) = value;
                end
            end
        end
    end
end

%% Count bit toggles in multi-bit values
function toggles = count_bit_toggles(prev_val, curr_val)
    toggles = 0;
    max_len = max(length(prev_val), length(curr_val));
    
    % Pad to same length
    prev_val = [repmat('0', 1, max_len - length(prev_val)), prev_val];
    curr_val = [repmat('0', 1, max_len - length(curr_val)), curr_val];
    
    for i = 1:length(prev_val)
        if ismember(prev_val(i), '01') && ismember(curr_val(i), '01') && prev_val(i) ~= curr_val(i)
            toggles = toggles + 1;
        end
    end
end

%% Compute deviations
function [deviations, common_signals] = compute_deviations(clean_toggles, trojan_toggles)
    clean_fields = fieldnames(clean_toggles);
    trojan_fields = fieldnames(trojan_toggles);
    common_signals = intersect(clean_fields, trojan_fields);
    
    deviations = struct();
    
    for i = 1:length(common_signals)
        signal = common_signals{i};
        clean_count = clean_toggles.(signal);
        trojan_count = trojan_toggles.(signal);
        
        if clean_count > 0
            dev = 100.0 * abs(trojan_count - clean_count) / clean_count;
        elseif trojan_count > 0
            dev = 100.0; % Infinite deviation
        else
            dev = 0.0;
        end
        
        deviations.(signal) = dev;
    end
end

%% Detect anomalies
function anomalies = detect_anomalies(deviations, threshold)
    signal_names = fieldnames(deviations);
    anomalies = [];
    
    for i = 1:length(signal_names)
        signal = signal_names{i};
        dev = deviations.(signal);
        
        if dev > threshold
            anomaly.signal = signal;
            anomaly.deviation = dev;
            anomalies = [anomalies; anomaly];
        end
    end
    
    % Sort by deviation (descending)
    if ~isempty(anomalies)
        [~, idx] = sort([anomalies.deviation], 'descend');
        anomalies = anomalies(idx);
    end
end

%% Statistical analysis
function stats = statistical_analysis(deviations)
    signal_names = fieldnames(deviations);
    dev_values = zeros(length(signal_names), 1);
    
    for i = 1:length(signal_names)
        dev_values(i) = deviations.(signal_names{i});
    end
    
    stats.mean_dev = mean(dev_values);
    stats.median_dev = median(dev_values);
    stats.std_dev = std(dev_values);
    stats.max_dev = max(dev_values);
    stats.min_dev = min(dev_values);
    stats.q1 = prctile(dev_values, 25);
    stats.q3 = prctile(dev_values, 75);
    stats.iqr = stats.q3 - stats.q1;
    stats.outlier_threshold = stats.q3 + 1.5 * stats.iqr;
    
    % Find outliers
    stats.outliers = [];
    for i = 1:length(signal_names)
        if dev_values(i) > stats.outlier_threshold
            outlier.signal = signal_names{i};
            outlier.deviation = dev_values(i);
            stats.outliers = [stats.outliers; outlier];
        end
    end
end

%% Create comprehensive visualization
function create_comprehensive_report(clean_toggles, trojan_toggles, deviations, stats, output_dir)
    % Create figure with subplots
    fig = figure('Position', [100, 100, 1600, 1000], 'Color', 'white');
    
    % Get common signals
    clean_fields = fieldnames(clean_toggles);
    trojan_fields = fieldnames(trojan_toggles);
    common_signals = intersect(clean_fields, trojan_fields);
    
    % 1. Toggle comparison bar chart (top left - large)
    subplot(2, 3, [1 2]);
    plot_toggle_comparison(clean_toggles, trojan_toggles, common_signals, deviations);
    
    % 2. Deviation distribution (top right)
    subplot(2, 3, 3);
    plot_deviation_distribution(deviations);
    
    % 3. Heatmap (bottom left)
    subplot(2, 3, 4);
    plot_heatmap(clean_toggles, trojan_toggles, common_signals);
    
    % 4. Statistical summary (bottom center)
    subplot(2, 3, 5);
    plot_statistics(stats);
    
    % 5. Top anomalies (bottom right)
    subplot(2, 3, 6);
    plot_top_anomalies(detect_anomalies(deviations, 10.0));
    
    % Overall title
    sgtitle('Hardware Trojan Detection - Side-Channel Analysis Report (MATLAB)', ...
        'FontSize', 16, 'FontWeight', 'bold');
    
    % Save
    saveas(fig, fullfile(output_dir, 'trojan_detection_report_matlab.png'));
    fprintf('  Saved: %s\n', fullfile(output_dir, 'trojan_detection_report_matlab.png'));
end

%% Plot toggle comparison
function plot_toggle_comparison(clean_toggles, trojan_toggles, common_signals, deviations)
    % Get top 15 most active signals
    activity = zeros(length(common_signals), 1);
    for i = 1:length(common_signals)
        activity(i) = clean_toggles.(common_signals{i}) + trojan_toggles.(common_signals{i});
    end
    [~, idx] = sort(activity, 'descend');
    top_signals = common_signals(idx(1:min(15, length(idx))));
    
    % Prepare data
    clean_counts = zeros(length(top_signals), 1);
    trojan_counts = zeros(length(top_signals), 1);
    
    for i = 1:length(top_signals)
        clean_counts(i) = clean_toggles.(top_signals{i});
        trojan_counts(i) = trojan_toggles.(top_signals{i});
    end
    
    % Plot grouped bar chart
    x = 1:length(top_signals);
    bar_width = 0.35;
    
    hold on;
    bar(x - bar_width/2, clean_counts, bar_width, 'FaceColor', [0.18 0.8 0.44], 'DisplayName', 'Clean ALU');
    bar(x + bar_width/2, trojan_counts, bar_width, 'FaceColor', [0.91 0.30 0.24], 'DisplayName', 'Trojan ALU');
    
    % Highlight anomalies
    for i = 1:length(top_signals)
        if deviations.(top_signals{i}) > 25
            plot(i, max(clean_counts(i), trojan_counts(i)) * 1.1, 'r*', 'MarkerSize', 10);
        end
    end
    
    xlabel('Signal Name', 'FontWeight', 'bold');
    ylabel('Toggle Count', 'FontWeight', 'bold');
    title('Toggle Count Comparison (Top 15 Active Signals)', 'FontWeight', 'bold');
    set(gca, 'XTick', x, 'XTickLabel', top_signals, 'XTickLabelRotation', 45);
    legend('Location', 'best');
    grid on;
    hold off;
end

%% Plot deviation distribution
function plot_deviation_distribution(deviations)
    signal_names = fieldnames(deviations);
    dev_values = zeros(length(signal_names), 1);
    
    for i = 1:length(signal_names)
        dev_values(i) = deviations.(signal_names{i});
    end
    
    histogram(dev_values, 30, 'FaceColor', [0.20 0.60 0.86]);
    hold on;
    xline(25, 'r--', 'LineWidth', 2, 'Label', 'Threshold (25%)');
    xlabel('Deviation (%)', 'FontWeight', 'bold');
    ylabel('Frequency', 'FontWeight', 'bold');
    title('Deviation Distribution', 'FontWeight', 'bold');
    grid on;
    hold off;
end

%% Plot heatmap
function plot_heatmap(clean_toggles, trojan_toggles, common_signals)
    % Use top 10 signals
    top_signals = common_signals(1:min(10, length(common_signals)));
    
    matrix = zeros(length(top_signals), 3);
    for i = 1:length(top_signals)
        clean = clean_toggles.(top_signals{i});
        trojan = trojan_toggles.(top_signals{i});
        matrix(i, 1) = clean;
        matrix(i, 2) = trojan;
        matrix(i, 3) = abs(trojan - clean);
    end
    
    % Normalize
    matrix_norm = matrix ./ (max(matrix, [], 1) + eps);
    
    imagesc(matrix_norm');
    colormap('hot');
    colorbar;
    set(gca, 'YTick', 1:3, 'YTickLabel', {'Clean', 'Trojan', 'Deviation'});
    set(gca, 'XTick', 1:length(top_signals), 'XTickLabel', top_signals, 'XTickLabelRotation', 45);
    title('Toggle Activity Heatmap (Normalized)', 'FontWeight', 'bold');
end

%% Plot statistics
function plot_statistics(stats)
    axis off;
    
    text_str = sprintf(['STATISTICAL ANALYSIS\n' ...
        '================================\n\n' ...
        'Mean Deviation:    %.2f%%\n' ...
        'Median Deviation:  %.2f%%\n' ...
        'Std Deviation:     %.2f%%\n' ...
        'Max Deviation:     %.2f%%\n\n' ...
        'Quartiles:\n' ...
        '  Q1: %.2f%%\n' ...
        '  Q3: %.2f%%\n' ...
        '  IQR: %.2f%%\n\n' ...
        'Outlier Threshold: %.2f%%\n' ...
        'Outliers Detected: %d'], ...
        stats.mean_dev, stats.median_dev, stats.std_dev, stats.max_dev, ...
        stats.q1, stats.q3, stats.iqr, stats.outlier_threshold, length(stats.outliers));
    
    text(0.1, 0.9, text_str, 'VerticalAlignment', 'top', 'FontName', 'FixedWidth', 'FontSize', 9);
end

%% Plot top anomalies
function plot_top_anomalies(anomalies)
    if isempty(anomalies)
        axis off;
        text(0.5, 0.5, 'No significant anomalies detected', ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 12);
        return;
    end
    
    % Top 10 anomalies
    top_anomalies = anomalies(1:min(10, length(anomalies)));
    signals = {top_anomalies.signal};
    devs = [top_anomalies.deviation];
    
    % Color code by severity
    colors = zeros(length(devs), 3);
    for i = 1:length(devs)
        if devs(i) > 50
            colors(i, :) = [0.91 0.30 0.24]; % Red
        elseif devs(i) > 25
            colors(i, :) = [0.95 0.61 0.07]; % Orange
        else
            colors(i, :) = [0.20 0.60 0.86]; % Blue
        end
    end
    
    barh(1:length(devs), devs, 'FaceColor', 'flat', 'CData', colors);
    hold on;
    xline(25, 'r--', 'LineWidth', 2);
    xline(50, 'r--', 'LineWidth', 2);
    
    set(gca, 'YTick', 1:length(signals), 'YTickLabel', signals);
    xlabel('Deviation (%)', 'FontWeight', 'bold');
    title('Top Anomalous Signals', 'FontWeight', 'bold');
    grid on;
    hold off;
end

%% Generate text report
function generate_text_report(deviations, stats, anomalies, output_dir)
    filepath = fullfile(output_dir, 'detection_report_matlab.txt');
    fid = fopen(filepath, 'w', 'n', 'UTF-8');
    
    fprintf(fid, '================================================================================\n');
    fprintf(fid, 'HARDWARE TROJAN DETECTION REPORT (MATLAB)\n');
    fprintf(fid, 'Side-Channel Analysis via Switching Activity\n');
    fprintf(fid, '================================================================================\n\n');
    fprintf(fid, 'Report Generated: %s\n\n', datestr(now));
    
    % Statistical summary
    fprintf(fid, '--------------------------------------------------------------------------------\n');
    fprintf(fid, 'STATISTICAL SUMMARY\n');
    fprintf(fid, '--------------------------------------------------------------------------------\n');
    signal_names = fieldnames(deviations);
    fprintf(fid, 'Total Signals Analyzed: %d\n', length(signal_names));
    fprintf(fid, 'Mean Deviation: %.2f%%\n', stats.mean_dev);
    fprintf(fid, 'Median Deviation: %.2f%%\n', stats.median_dev);
    fprintf(fid, 'Standard Deviation: %.2f%%\n', stats.std_dev);
    fprintf(fid, 'Maximum Deviation: %.2f%%\n', stats.max_dev);
    fprintf(fid, 'IQR-based Outlier Threshold: %.2f%%\n\n', stats.outlier_threshold);
    
    % Anomaly detection
    fprintf(fid, '--------------------------------------------------------------------------------\n');
    fprintf(fid, 'ANOMALY DETECTION RESULTS (25%% Threshold)\n');
    fprintf(fid, '--------------------------------------------------------------------------------\n');
    fprintf(fid, 'Anomalies Detected: %d\n\n', length(anomalies));
    
    if ~isempty(anomalies)
        fprintf(fid, '%-6s %-30s %-15s %s\n', 'Rank', 'Signal Name', 'Deviation', 'Status');
        fprintf(fid, '--------------------------------------------------------------------------------\n');
        for i = 1:length(anomalies)
            status = 'CRITICAL';
            if anomalies(i).deviation <= 50
                status = 'WARNING';
            end
            fprintf(fid, '%-6d %-30s %6.2f%%        %s\n', ...
                i, anomalies(i).signal, anomalies(i).deviation, status);
        end
    end
    
    fprintf(fid, '\n');
    
    % Conclusion
    fprintf(fid, '--------------------------------------------------------------------------------\n');
    fprintf(fid, 'CONCLUSION\n');
    fprintf(fid, '--------------------------------------------------------------------------------\n');
    
    if ~isempty(anomalies)
        fprintf(fid, '⚠ TROJAN DETECTED\n\n');
        fprintf(fid, 'Evidence: %d signals show abnormal switching activity\n', length(anomalies));
        fprintf(fid, 'above the 25%% deviation threshold, indicating the presence of\n');
        fprintf(fid, 'stealthy hardware modifications in the Trojan design.\n\n');
        fprintf(fid, 'Most suspicious signal: %s with %.2f%% deviation\n', ...
            anomalies(1).signal, anomalies(1).deviation);
    else
        fprintf(fid, '[RESULT] NO TROJAN DETECTED\n\n');
        fprintf(fid, 'No significant deviations found between clean and test designs.\n');
    end
    
    fprintf(fid, '\n================================================================================\n');
    fclose(fid);
end
