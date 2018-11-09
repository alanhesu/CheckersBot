%% Epson C3 SERIAL CLOSE function
% Georgia Tech ME 4451 - ROBOTICS
% FALL 2012
%--------------------------------------------------------------------------
% Closes existing serial connections
%
% INPUTS:
%       None
% OUTPUTS:
%       None
%--------------------------------------------------------------------------
% OTHER INFORMATION:
%       -instrfind returns all serial objects in memory, and is used to 
%        close duplicate serial objects that can arise
%--------------------------------------------------------------------------

%% Function definition
function netClose()
a = instrfind;  % find all connections

if isempty(a)
    disp('No existing connections open.')
else
    disp('Closing existing serial connections...')
    fclose(a);
    delete(a);
    clear a;
end

end
