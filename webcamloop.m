
%cam = webcam('HD 720P Webcam');
while(true)
	im = snapshot(cam);	
	[mask1, blue] = blueMask(im);
	[mask2, red] = redMask(im);
	rMin = 7;
	rMax = 20;
	imshow(im);
	hold on;
	[centersBlue, radiiBlue] = imfindcircles(blue, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
	[centersRed, radiiRed] = imfindcircles(red, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
 	viscircles(centersBlue, radiiBlue, 'Color', 'b');	
	viscircles(centersRed, radiiRed, 'Color', 'r');
	hold off;
	pause(0.1);
end