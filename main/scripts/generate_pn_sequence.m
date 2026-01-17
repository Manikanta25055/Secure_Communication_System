function pn_sequence = generate_pn_sequence(length, seed)
% GENERATE_PN_SEQUENCE Generates a Pseudo-Noise sequence
%
% Inputs:
%   length - Length of the PN sequence (number of chips)
%   seed   - Seed value for random generation
%
% Output:
%   pn_sequence - Bipolar PN sequence (-1, +1)
%
% Uses Linear Feedback Shift Register (LFSR) concept for generation

    % Set random seed for reproducibility
    rng(seed);
    
    % Generate random binary sequence
    binary_sequence = randi([0 1], 1, length);
    
    % Convert to bipolar format (-1, +1)
    pn_sequence = 2*binary_sequence - 1;
    
    % Normalize to ensure unit power
    pn_sequence = pn_sequence / sqrt(mean(pn_sequence.^2));
    
end
