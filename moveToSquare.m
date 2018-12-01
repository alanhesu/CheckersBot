function moveToSquare(row, col, net)

pos = epsonGetPos(net);
pos(3) = 300;
epsonPoint(net, 1, pos, [1, 1, 1]);

centre = [-450, 5];
del = 25.4 * 1.1875;
zero_zero = [centre(1) + 4.5*del, centre(2) - 4.5 * del];
x = zero_zero(1) - col*del;
y = zero_zero(2) + row*del;

% Move over the square
epsonPoint(net, 1, [x, y, 300, 90, 0, -180], [1, 1, 1]);
pause(0.75);
% Then move down to 150
epsonPoint(net, 1, [x, y, 150, 90, 0, -180], [1, 1, 1]);
%pause(2)


end