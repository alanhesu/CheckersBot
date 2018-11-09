%% Epson C3 TRANSMIT POINT function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Sends a packet containing the next desired point for the Epson e-e
%
% INPUTS:
%       netObj = Matlab tcpip object connected to robot
%       movetype = integer selecting Epson motion command, where
%           1 = 'Go' command
%           2 = 'Move' command
%           3 = 'Move continuous' command
%       point = vector containing coordinates [x,y,z,u,v,w] in mm and deg
%       config = vector of arm configuration,[coord,elbow,wrist], where
%           coord = 1 (right-handed) or 2 (left-handed) coord system,
%           elbow = 1 (elbow above/plus) or 2 (elbow below/minus)
%           wrist = 1 (no wrist flip) or 2 (wrist flip)
%
% OUTPUTS:
%       None.
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       -More movetypes can be added by creating more cases in teh Epson
%        code, see documentation for more info
%       -See Epson C3 manual for limits on coordinates and how to specify
%        robot configuration
%--------------------------------------------------------------------------

%% Function definition
function epsonPoint(netObj, movetype, point, config)
% Argument check
if nargin ~= 4
    error('epsonPoint:argChk','Requires 4 arguments');
end

% Build data vector

instrc = movetype;
% convert the sign information for each axis into single number
signs = sign(point) == -1*ones(1,6);
signs_encoded = uint16(signs * 2.^(numel(signs)-1:-1:0).');
signs_encoded_split = epsonSplitBytes(signs_encoded);

point = round(abs(point)*10);
point16 = [epsonSplitBytes(point(1)),epsonSplitBytes(point(2)),epsonSplitBytes(point(3))...
    epsonSplitBytes(point(4)),epsonSplitBytes(point(5)),epsonSplitBytes(point(6))];
data = [point16, signs_encoded_split, config];

% Write to Epson controller
epsonWrite(netObj,instrc,data);

end