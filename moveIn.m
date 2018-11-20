function moveIn(bool, net)
point = epsonGetPos(net);

if bool
    epsonPoint(net, 1, [x, y, z, u, v, w], [1, 1, 1]);
else
    epsonPoint(net, 1, [x, y, z, u, v, w], [1, 1, 1]);
end
end