%%
% Run this section to set up serial communication once the Arduino has been
% connected
if ~isempty(instrfind)
	fclose(instrfind);
	delete(instrfind);
end
s = serial('COM10');
set(s, 'BaudRate', 9600);
fopen(s);
%%
% Run this section to close the serial port
fclose(s);
delete(s);
clear s;