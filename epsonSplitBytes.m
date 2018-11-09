%% Epson C3 SPLIT BYTES function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Takes a decimal input value and represents it as two 8-bit bytes, a high 
% and low byte, as required for writing to serial
%
% INPUTS:
%       value = decimal value to convert
%
% OUTPUTS:
%       bytes = vector containing two uint8 values, [LowByte, HighByte]
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function bytes = epsonSplitBytes(value)

LowByte = bitand(value,255);       % bitmask to keep lower 8 bits
HighByte = bitand(value,65280);    % bitmask to keep higher 8 bits
HighByte = bitshift(HighByte,-8);  % shift bits to the right

bytes = uint8([LowByte, HighByte]); % assemble vector with two bytes
end