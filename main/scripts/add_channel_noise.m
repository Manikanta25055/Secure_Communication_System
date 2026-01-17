function noisy_signal = add_channel_noise(signal, noise_power, jamming_enabled, jamming_power_dB)
% ADD_CHANNEL_NOISE Adds AWGN and optional jamming to the signal
%
% Inputs:
%   signal            - Input signal
%   noise_power       - Noise power (variance)
%   jamming_enabled   - Boolean flag for jamming
%   jamming_power_dB  - Jamming signal power in dB
%
% Output:
%   noisy_signal - Signal with noise and optional jamming

    signal_length = length(signal);
    
    % Add AWGN (Additive White Gaussian Noise)
    noise = sqrt(noise_power) * randn(1, signal_length);
    noisy_signal = signal + noise;
    
    % Add jamming if enabled
    if jamming_enabled
        % Generate narrowband jamming signal (tone jammer)
        jamming_power_linear = 10^(jamming_power_dB/10);
        t = 1:signal_length;
        jamming_freq = 0.1;  % Normalized frequency
        jamming_signal = sqrt(jamming_power_linear) * sin(2*pi*jamming_freq*t);
        
        noisy_signal = noisy_signal + jamming_signal;
    end
    
end
