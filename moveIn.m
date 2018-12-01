function moveIn(bool, net)

% x goes from -600 to -300
% y goes from -200 to 200

if bool
    epsonPoint(net, 1, [-450, 0, 260, 90, 0, -180], [1, 1, 1]);
else
    epsonPoint(net, 1, [-450, -250, 260, 90, 0, -180], [1, 1, 1]);
end
pause(2)
end