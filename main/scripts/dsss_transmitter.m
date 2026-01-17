function spread_signal = dsss_transmitter(data_bits, pn_sequence)
% DSSS_TRANSMITTER Direct Sequence Spread Spectrum Transmitter
%
% Inputs:
%   data_bits    - Binary data bits to transmit (1 x N)
%   pn_sequence  - Pseudo-noise spreading sequence (1 x L)
%
% Output:
%   spread_signal - Spread spectrum signal (1 x N*L)
%
% The function spreads each data bit by multiplying with the PN sequence

    % Convert binary bits to bipolar format (-1, +1)
    bipolar_data = 2*data_bits - 1;
    
    % Get lengths
    num_bits = length(data_bits);
    spreading_factor = length(pn_sequence);
    
    % Initialize output
    spread_signal = zeros(1, num_bits * spreading_factor);
    
    % Spread each bit with PN sequence
    for i = 1:num_bits
        start_idx = (i-1) * spreading_factor + 1;
        end_idx = i * spreading_factor;
        
        % Multiply data bit with entire PN sequence
        spread_signal(start_idx:end_idx) = bipolar_data(i) * pn_sequence;
    end
    
end
