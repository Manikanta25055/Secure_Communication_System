function plot_results(Eb_N0_dB, BER_uncoded, BER_coded_no_encryption, ...
                      BER_coded_with_encryption, BER_with_jamming, ...
                      message_bits, encrypted_bits, spread_signal, pn_sequence, save_path)
% PLOT_RESULTS Generates all visualization plots for the simulation
%
% Inputs:
%   Eb_N0_dB                   - SNR values in dB
%   BER_uncoded                - BER without coding
%   BER_coded_no_encryption    - BER with DSSS only
%   BER_coded_with_encryption  - BER with DSSS and encryption
%   BER_with_jamming           - BER with DSSS, encryption, and jamming
%   message_bits               - Original message
%   encrypted_bits             - Encrypted message
%   spread_signal              - Spread spectrum signal
%   pn_sequence                - PN sequence
%   save_path                  - Path to save figures

    %% Figure 1: BER Performance Comparison
    figure('Position', [100, 100, 900, 600]);
    semilogy(Eb_N0_dB, BER_uncoded, 'r-o', 'LineWidth', 2, 'MarkerSize', 8);
    hold on;
    semilogy(Eb_N0_dB, BER_coded_no_encryption, 'b-s', 'LineWidth', 2, 'MarkerSize', 8);
    semilogy(Eb_N0_dB, BER_coded_with_encryption, 'g-^', 'LineWidth', 2, 'MarkerSize', 8);
    semilogy(Eb_N0_dB, BER_with_jamming, 'm-d', 'LineWidth', 2, 'MarkerSize', 8);
    grid on;
    xlabel('E_b/N_0 (dB)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Bit Error Rate (BER)', 'FontSize', 12, 'FontWeight', 'bold');
    title('BER Performance Comparison', 'FontSize', 14, 'FontWeight', 'bold');
    legend('Uncoded (No DSSS)', 'DSSS Only', 'DSSS + Encryption', ...
           'DSSS + Encryption + Jamming', 'Location', 'southwest', 'FontSize', 10);
    set(gca, 'FontSize', 11);
    saveas(gcf, [save_path 'ber_performance.png']);
    saveas(gcf, [save_path 'ber_performance.fig']);
    
    %% Figure 2: Message Visualization
    figure('Position', [150, 150, 1200, 700]);
    
    subplot(3,1,1);
    stem(message_bits(1:min(50, length(message_bits))), 'b', 'LineWidth', 1.5, 'MarkerSize', 6);
    grid on;
    ylim([-0.2 1.2]);
    xlabel('Bit Index', 'FontSize', 11);
    ylabel('Bit Value', 'FontSize', 11);
    title('Original Message Bits (First 50 bits)', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    subplot(3,1,2);
    stem(encrypted_bits(1:min(50, length(encrypted_bits))), 'r', 'LineWidth', 1.5, 'MarkerSize', 6);
    grid on;
    ylim([-0.2 1.2]);
    xlabel('Bit Index', 'FontSize', 11);
    ylabel('Bit Value', 'FontSize', 11);
    title('Encrypted Message Bits (First 50 bits)', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    subplot(3,1,3);
    % Show first bit spread with PN sequence
    first_bit_spread = spread_signal(1:length(pn_sequence));
    stem(first_bit_spread, 'g', 'LineWidth', 1.5, 'MarkerSize', 6);
    grid on;
    xlabel('Chip Index', 'FontSize', 11);
    ylabel('Amplitude', 'FontSize', 11);
    title('First Bit After DSSS Spreading', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    saveas(gcf, [save_path 'message_visualization.png']);
    saveas(gcf, [save_path 'message_visualization.fig']);
    
    %% Figure 3: PN Sequence Properties
    figure('Position', [200, 200, 1200, 600]);
    
    subplot(2,2,1);
    stem(pn_sequence, 'k', 'LineWidth', 1.5, 'MarkerSize', 6);
    grid on;
    xlabel('Chip Index', 'FontSize', 11);
    ylabel('Amplitude', 'FontSize', 11);
    title('PN Sequence (Bipolar)', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    subplot(2,2,2);
    autocorr_pn = xcorr(pn_sequence, 'coeff');
    stem(-(length(pn_sequence)-1):(length(pn_sequence)-1), autocorr_pn, 'b', 'LineWidth', 1.5);
    grid on;
    xlabel('Lag', 'FontSize', 11);
    ylabel('Autocorrelation', 'FontSize', 11);
    title('PN Sequence Autocorrelation', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    subplot(2,2,3);
    % Power Spectral Density
    [psd, freq] = pwelch(pn_sequence, [], [], [], 1, 'centered');
    plot(freq, 10*log10(psd), 'r', 'LineWidth', 2);
    grid on;
    xlabel('Normalized Frequency', 'FontSize', 11);
    ylabel('PSD (dB)', 'FontSize', 11);
    title('PN Sequence Power Spectral Density', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    subplot(2,2,4);
    histogram(pn_sequence, 20, 'FaceColor', 'g', 'EdgeColor', 'k');
    grid on;
    xlabel('Amplitude', 'FontSize', 11);
    ylabel('Count', 'FontSize', 11);
    title('PN Sequence Distribution', 'FontSize', 12, 'FontWeight', 'bold');
    set(gca, 'FontSize', 10);
    
    saveas(gcf, [save_path 'pn_sequence_analysis.png']);
    saveas(gcf, [save_path 'pn_sequence_analysis.fig']);
    
    %% Figure 4: Spreading Effect Visualization
    figure('Position', [250, 250, 1200, 600]);
    
    subplot(2,1,1);
    % Show a few bits before spreading
    bits_to_show = 5;
    bipolar_bits = 2*message_bits(1:bits_to_show) - 1;
    stairs(0:bits_to_show, [bipolar_bits bipolar_bits(end)], 'b', 'LineWidth', 2);
    grid on;
    xlabel('Bit Duration', 'FontSize', 11);
    ylabel('Amplitude', 'FontSize', 11);
    title('Original Message (First 5 Bits - Bipolar)', 'FontSize', 12, 'FontWeight', 'bold');
    ylim([-1.5 1.5]);
    set(gca, 'FontSize', 10);
    
    subplot(2,1,2);
    % Show spread signal for same bits
    spread_length = bits_to_show * length(pn_sequence);
    plot(spread_signal(1:spread_length), 'g', 'LineWidth', 1.5);
    hold on;
    % Mark bit boundaries
    for i = 1:bits_to_show
        xline(i*length(pn_sequence), 'r--', 'LineWidth', 1.5);
    end
    grid on;
    xlabel('Chip Index', 'FontSize', 11);
    ylabel('Amplitude', 'FontSize', 11);
    title('Spread Signal (First 5 Bits)', 'FontSize', 12, 'FontWeight', 'bold');
    legend('Spread Signal', 'Bit Boundaries', 'Location', 'best');
    set(gca, 'FontSize', 10);
    
    saveas(gcf, [save_path 'spreading_effect.png']);
    saveas(gcf, [save_path 'spreading_effect.fig']);
    
    %% Figure 5: Processing Gain Illustration
    figure('Position', [300, 300, 900, 600]);
    
    processing_gain_dB = 10*log10(length(pn_sequence));
    
    % Show spectrum before and after spreading
    subplot(2,1,1);
    % Approximate spectrum of original signal (narrow)
    f = linspace(-0.5, 0.5, 1000);
    original_spectrum = sinc(f * 10).^2;
    plot(f, 10*log10(original_spectrum/max(original_spectrum)), 'b', 'LineWidth', 2);
    grid on;
    xlabel('Normalized Frequency', 'FontSize', 11);
    ylabel('Power (dB)', 'FontSize', 11);
    title('Original Signal Spectrum (Narrowband)', 'FontSize', 12, 'FontWeight', 'bold');
    ylim([-40 5]);
    set(gca, 'FontSize', 10);
    
    subplot(2,1,2);
    % Spectrum after spreading (wider, lower power density)
    spread_spectrum = sinc(f * 10 / length(pn_sequence)).^2;
    plot(f, 10*log10(spread_spectrum/max(spread_spectrum)) - processing_gain_dB, 'g', 'LineWidth', 2);
    grid on;
    xlabel('Normalized Frequency', 'FontSize', 11);
    ylabel('Power (dB)', 'FontSize', 11);
    title(sprintf('Spread Spectrum (Wideband) - Processing Gain: %.1f dB', processing_gain_dB), ...
          'FontSize', 12, 'FontWeight', 'bold');
    ylim([-40 5]);
    set(gca, 'FontSize', 10);
    
    saveas(gcf, [save_path 'processing_gain.png']);
    saveas(gcf, [save_path 'processing_gain.fig']);
    
    fprintf('All plots saved successfully!\n');
    
end
