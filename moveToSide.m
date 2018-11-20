function moveToSide(net)
% Move up
point = epsonGetPos(net);
point(3) = 300;
epsonPoint(net, 1, point, [1, 1, 1]);
outerPos = [-200, 400, 260, 90, 0, -180];
% Move somewhere
epsonPoint(net, 1, outerPos, [1, 1, 1])


end