%% Epson C3 READ DATA function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Sends a read command to the Epson robot over TCP/IP
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
%        [255, 255, datalength, instruction, params0...N]
%--------------------------------------------------------------------------

%% Function definition
function currentPos = epsonGetPos(netObj)
% Argument check
if nargin ~= 1
    error('epsonGetPos:argChk','Requires 1 argument');
end

% Request data packet, translate to position
instrc = 4;
data = epsonRead(netObj,instrc);
signs = epsonMergeBytes(data(16:17));

x = int16(epsonMergeBytes(data(1:2)))*(-1)^(int16(bitget(signs,6)));
y = int16(epsonMergeBytes(data(3:4)))*(-1)^(int16(bitget(signs,5)));
z = int16(epsonMergeBytes(data(5:6)))*(-1)^(int16(bitget(signs,4)));
u = int16(epsonMergeBytes(data(7:8)))*(-1)^(int16(bitget(signs,3)));
v = int16(epsonMergeBytes(data(9:10)))*(-1)^(int16(bitget(signs,2)));
w = int16(epsonMergeBytes(data(11:12)))*(-1)^(int16(bitget(signs,1)));
currentPos = [x,y,z,u,v,w];
currentPos = double(currentPos)/10;

end