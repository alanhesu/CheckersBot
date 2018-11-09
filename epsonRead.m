%% Epson C3 READ DATA function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Sends a read command to the Epson robot over TCP/IP
%
% INPUTS:
%       netObj = Matlab tcpip object connected to robot
%       instrc = instruction code indicating what data to read
%
% OUTPUTS:
%       data = ouput packet from Epson
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       -If the parameter to be written is a 16 bit value, use
%        the funtion SplitBytes to generate the high and low byte
%       -Returned packet structure is:
%        [255, 255, datalength, datavalue0...N, checksum1, checksum2]
%--------------------------------------------------------------------------

%% Function definition
function data = epsonRead(netObj, instrc)
% Argument check
if nargin ~= 2
    error('epsonRead:argChk','Requires 2 arguments');
end

% Send read packet to Epson
epsonWrite(netObj,instrc,0);

% Read in data packet from Epson
while 1
    if netObj.BytesAvailable >= 2
        start(1:2) = fread(netObj, 2);
        if start(1) == 255 && start(2) == 255
            plength = fread(netObj,1);
            packet(1) = plength;
            packet(2:plength+1) = fread(netObj,plength);
            CK = epsonChecksum(packet(2:end-2));
            if CK ~= packet(end-1:end)
                data = [];
                disp('Corrupted packet received')
                fprintf('Calculated checksum: %u %u\n',CK(1), CK(2));
                fprintf('Received checksum: %u %u\n',packet(end-1),packet(end));
                break;
            else
                data = packet(2:end-2);
                break;
            end
        end
    end
    pause(0.01)
end
end