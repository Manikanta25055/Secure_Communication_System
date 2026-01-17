function encrypted_bits = encrypt_message(message_bits, key)
% ENCRYPT_MESSAGE Encrypts binary message using XOR cipher
%
% Inputs:
%   message_bits - Binary message to encrypt (1 x N)
%   key          - Encryption key (string)
%
% Output:
%   encrypted_bits - Encrypted binary message (1 x N)
%
% Uses XOR operation with a pseudo-random key stream derived from the key

    message_length = length(message_bits);
    
    % Generate pseudo-random key stream from the key
    key_hash = sum(double(key));  % Simple hash of the key
    rng(key_hash);  % Use hash as seed
    
    % Generate key stream of same length as message
    key_stream = randi([0 1], 1, message_length);
    
    % XOR encryption
    encrypted_bits = xor(message_bits, key_stream);
    
end
