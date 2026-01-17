%% Secure Communication System with Spread Spectrum and Encryption
% ELE 3126 - Communication Systems
% IA-4 Group Assignment
% Author: Manikanta Gonugondla
% Date: November 2025

clear all;
close all;
clc;

%% Add paths
addpath(genpath('../'));

%% Simulation Parameters
fprintf('=== Secure Communication System Simulation ===\n\n');

% Message Parameters
message_length = 100;                    % Number of bits
Eb_N0_dB = -10:2:20;                    % SNR range in dB
Eb_N0_linear = 10.^(Eb_N0_dB/10);

% Spreading Parameters
spreading_factor = 31;                   % Length of PN sequence (chips per bit)
pn_seed = 13;                           % Seed for PN sequence generator

% Encryption Parameters
encryption_key = 'SecureKey2025';        % Encryption key
use_encryption = true;                   % Toggle encryption

% Jamming Parameters
jamming_power_dB = 10;                   % Jammer power in dB
jamming_enabled = true;                 % Toggle jamming

%% Generate Random Binary Message
rng(42); % For reproducibility
message_bits = randi([0 1], 1, message_length);

fprintf('Original Message Length: %d bits\n', message_length);
fprintf('Spreading Factor: %d chips/bit\n', spreading_factor);
fprintf('Encryption: %s\n', string(use_encryption));
fprintf('\n');

%% Encryption (if enabled)
if use_encryption
    encrypted_bits = encrypt_message(message_bits, encryption_key);
    fprintf('Message encrypted successfully!\n');
else
    encrypted_bits = message_bits;
    fprintf('No encryption applied.\n');
end

%% Generate PN Sequence for Spreading
pn_sequence = generate_pn_sequence(spreading_factor, pn_seed);
fprintf('PN Sequence generated with seed: %d\n', pn_seed);

%% DSSS Modulation
spread_signal = dsss_transmitter(encrypted_bits, pn_sequence);
fprintf('DSSS Spreading completed. Signal length: %d chips\n', length(spread_signal));

%% Initialize BER arrays
BER_uncoded = zeros(size(Eb_N0_dB));
BER_coded_no_encryption = zeros(size(Eb_N0_dB));
BER_coded_with_encryption = zeros(size(Eb_N0_dB));
BER_with_jamming = zeros(size(Eb_N0_dB));

fprintf('\nStarting BER simulation over SNR range...\n');

%% Simulation Loop over different SNR values
for idx = 1:length(Eb_N0_dB)
    fprintf('Processing SNR = %d dB... ', Eb_N0_dB(idx));
    
    % Calculate noise power
    signal_power = mean(abs(spread_signal).^2);
    noise_power = signal_power / Eb_N0_linear(idx);
    
    % Scenario 1: Uncoded (no spreading, no encryption)
    noisy_uncoded = message_bits + sqrt(noise_power) * randn(size(message_bits));
    received_uncoded = noisy_uncoded > 0.5;
    BER_uncoded(idx) = sum(received_uncoded ~= message_bits) / message_length;
    
    % Scenario 2: DSSS without encryption
    spread_no_enc = dsss_transmitter(message_bits, pn_sequence);
    noisy_signal_no_enc = add_channel_noise(spread_no_enc, noise_power, false, 0);
    received_no_enc = dsss_receiver(noisy_signal_no_enc, pn_sequence);
    BER_coded_no_encryption(idx) = sum(received_no_enc ~= message_bits) / message_length;
    
    % Scenario 3: DSSS with encryption (no jamming)
    noisy_signal = add_channel_noise(spread_signal, noise_power, false, 0);
    despread_signal = dsss_receiver(noisy_signal, pn_sequence);
    decrypted_bits = decrypt_message(despread_signal, encryption_key);
    BER_coded_with_encryption(idx) = sum(decrypted_bits ~= message_bits) / message_length;
    
    % Scenario 4: DSSS with encryption and jamming
    noisy_signal_jammed = add_channel_noise(spread_signal, noise_power, true, jamming_power_dB);
    despread_jammed = dsss_receiver(noisy_signal_jammed, pn_sequence);
    decrypted_jammed = decrypt_message(despread_jammed, encryption_key);
    BER_with_jamming(idx) = sum(decrypted_jammed ~= message_bits) / message_length;
    
    fprintf('Done!\n');
end

fprintf('\nSimulation completed!\n');

%% Save Results
results_path = '../results/';
save([results_path 'simulation_results.mat'], 'Eb_N0_dB', 'BER_uncoded', ...
     'BER_coded_no_encryption', 'BER_coded_with_encryption', 'BER_with_jamming', ...
     'message_bits', 'encrypted_bits', 'spread_signal', 'pn_sequence');

fprintf('Results saved to: %s\n', results_path);

%% Generate Plots
fprintf('\nGenerating plots...\n');
plot_results(Eb_N0_dB, BER_uncoded, BER_coded_no_encryption, ...
             BER_coded_with_encryption, BER_with_jamming, ...
             message_bits, encrypted_bits, spread_signal, pn_sequence, results_path);

fprintf('\n=== Simulation Complete! ===\n');
fprintf('Check the results folder for generated figures.\n');
