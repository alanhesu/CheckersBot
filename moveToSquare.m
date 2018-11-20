function moveToSquare(row, col, net)

pos = epsonGetPos(net);
pos(3) = 300;
epsonPoint(net, 1, pos, [1, 1, 1]);

centre = [-425, 0];
del = 25.4 * 1.5;
zero_zero = [centre(1) + 4.5*del, centre(2) - 4.5 * del];
x = zero_zero(1) - row*del;
y = zero_zero(2) + col*del;

% Move over the square
epsonPoint(net, 1, [x, y, 300, 90, 0, -180], [1, 1, 1]);
% Then move down
pause(0.5);
epsonPoint(net, 1, [x, y, 150, 90, 0, -180], [1, 1, 1]);


end