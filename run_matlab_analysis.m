% Quick runner script for Hardware Trojan Detection
% Just run this file in MATLAB!

clear all;
close all;
clc;

fprintf('\n');
fprintf('========================================\n');
fprintf('Hardware Trojan Detection - MATLAB\n');
fprintf('========================================\n');
fprintf('\n');

% Change to analysis directory
cd('analysis');

% Run the detector
try
    trojan_detector();
    fprintf('\nAnalysis completed successfully!\n');
    fprintf('Check the results/ folder for outputs.\n');
catch ME
    fprintf('\nError occurred: %s\n', ME.message);
    fprintf('Make sure VCD files exist in results/ folder\n');
end

% Return to project root
cd('..');

fprintf('\n');
