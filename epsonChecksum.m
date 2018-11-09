%% Epson C3 CHECKSUM function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Calculates the checksum of a packet of serial data to detect errors in
% tranmission. This function uses Fletcher's 16-bit checksum algorithm.
%
% INPUTS:
%       data = uint8 vector containing serial data to be checked
%
% OUTPUTS:
%       chksum = vector of two 8-bit checksum bytes
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function definition
function chksum = epsonChecksum(data)
% Argument check
if nargin ~= 1
    error('epsonChecksum:argChk','Requires 1 argument');
end

% Calculate Fletcher checksum
s1 = uint16(0); s2 = uint16(0);
data = uint16(data);

for i=1:length(data)
    s1 = mod(s1 + data(i), 255);
    s2 = mod(s2 + s1, 255);
end

CK1 = 255 - mod(s1 + s2,255);

s1 = mod(s1 + CK1,255);
s2 = mod(s2 + s1,255);

CK2 = 255 - mod(s1 + s2,255);

chksum = uint8([CK1,CK2]);
end