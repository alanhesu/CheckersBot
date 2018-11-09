%% Epson C3 WRITE DATA function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Builds and transmits a packet to the Epson controller over TCP/IP
%
% INPUTS:
%       netObj = Matlab tcpip object connected to robot
%       instrc = instruction code corresponding to Epson functions
%       data = vector containing parameters to be written, [p1,p2,p3,...]
%
% OUTPUTS:
%       None.
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       -If the parameter to be written is a 16 bit value, use
%        the funtion SplitBytes to generate the high and low byte
%       -Packet structure is:
%        [255, 255, datalength, instruction, params0...N, checksum1, checksum2]
%--------------------------------------------------------------------------

%% Function definition
function epsonWrite(netObj, instrc, data)
% Argument check
if nargin ~= 3
    error('epsonWrite:argChk','Requires 3 arguments');
end

% Define packet length, set instruction code
dlength = length(data)+3;

% Calculate checksum
checksum = epsonChecksum([instrc,data]);

% Build instruction packet
packet = uint8([255, 255, dlength, instrc, data, checksum]);

% Write packet to serial object
fwrite(netObj, packet);

end