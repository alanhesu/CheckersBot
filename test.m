net = netOpen('192.168.0.1',2000);
flushinput(net);

point1 = [125, 450, 500, 90, 90, 0];
config1 = [1,1,1];

point2 = [-50.5, 300, 400.9, 90, 0, -180];
config2 = [1,1,1];

epsonPoint(net,1,point1,config1);
epsonPoint(net,1,point2,config2);



%netClose()