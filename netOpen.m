%% Epson C3 SERIAL OPEN function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Initializes tcp/ip communication with the Epson controller
%
% INPUTS:
%       ip = IP address of the Epson controller as a string, e.g.
%            '192.168.0.1'
%       port = TCP/IP port to connect with, e.g. port = 80
% OUTPUTS:
%       netObj = tcpip port object for use in write and read functions
%--------------------------------------------------------------------------       
% OTHER INFORMATION:
%       None
%--------------------------------------------------------------------------

%% Function Definition
function netObj = netOpen(ip, port)
netClose;    % close existing connections

% Create serial object
netObj = tcpip(ip,port,'NetworkRole','client');
set(netObj,'Timeout',1);

% Open and display port information
fopen(netObj);
disp(netObj);

end

