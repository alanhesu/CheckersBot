close all;
clear;

cam = webcam('HD 720P Webcam');
while(true)
	im = snapshot(cam);	
	[~, blue] = blueMask(im);
	[~, red] = redMask(im);
	filtered = blue | red;
	imshow(filtered);
	hold on;
	rMin = 10;
	rMax = 20;
	[centers, radii] = imfindcircles(filtered, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
 	viscircles(centers, radii, 'Color', 'b');
	hold off;
	pause(0.1);
end