close all;
clear;

cam = webcam('HD 720P Webcam');
while(true)
	im = snapshot(cam);
	imshow(im);
	hold on;
	[~, filtered] = webcamMask(im);
	rMin = 12;
	rMax = 40;
% 	[centers, radii] = imfindcircles(filtered, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
%  	viscircles(centers, radii, 'Color', 'b');
end