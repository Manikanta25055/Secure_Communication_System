function decrypted_bits = decrypt_message(encrypted_bits, key)
% DECRYPT_MESSAGE Decrypts binary message using XOR cipher
%
% Inputs:
%   encrypted_bits - Encrypted binary message (1 x N)
%   key            - Decryption key (string)
%
% Output:
%   decrypted_bits - Decrypted binary message (1 x N)
%
% Uses XOR operation with the same pseudo-random key stream

    message_length = length(encrypted_bits);
    
    % Generate pseudo-random key stream from the key (must match encryption)
    key_hash = sum(double(key));  % Simple hash of the key
    rng(key_hash);  % Use hash as seed
    
    % Generate key stream of same length as message
    key_stream = randi([0 1], 1, message_length);
    
    % XOR decryption (same as encryption for XOR cipher)
    decrypted_bits = xor(encrypted_bits, key_stream);
    
end
