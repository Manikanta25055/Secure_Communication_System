function received_bits = dsss_receiver(received_signal, pn_sequence)
% DSSS_RECEIVER Direct Sequence Spread Spectrum Receiver
%
% Inputs:
%   received_signal - Received spread spectrum signal (1 x N*L)
%   pn_sequence     - Pseudo-noise spreading sequence (1 x L)
%
% Output:
%   received_bits   - Despread binary data bits (1 x N)
%
% The function despreads the signal by correlating with the PN sequence

    spreading_factor = length(pn_sequence);
    signal_length = length(received_signal);
    num_bits = signal_length / spreading_factor;
    
    % Initialize output
    received_bits = zeros(1, num_bits);
    
    % Despread each bit by correlation with PN sequence
    for i = 1:num_bits
        start_idx = (i-1) * spreading_factor + 1;
        end_idx = i * spreading_factor;
        
        % Extract the chip sequence for this bit
        chip_sequence = received_signal(start_idx:end_idx);
        
        % Correlate with PN sequence (despread)
        correlation = sum(chip_sequence .* pn_sequence);
        
        % Decision: if correlation is positive, bit is 1, else 0
        if correlation > 0
            received_bits(i) = 1;
        else
            received_bits(i) = 0;
        end
    end
    
end
