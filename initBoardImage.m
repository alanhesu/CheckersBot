function coord = initBoardImage(im)
	figure;
	imshow(im);
	
	rMin = 20;
	rMax = 50;
	im_bw = im2bw(im, .5);
	[centers, radii] = imfindcircles(im, [rMin, rMax], 'EdgeThreshold', .1);
	viscircles(centers, radii, 'Color', 'b');
	
	topRight = [max(centers(:,1)), min(centers(:,2))];
	botLeft = [min(centers(:,1)), max(centers(:,2))];
	
	coord = {8, 8};
	x = linspace(botLeft(1), topRight(1), 8);
	y = linspace(topRight(2), botLeft(2), 8);
	for r = 1:8
		for c = 1:8
			coord{r, c} = [x(c), y(r)];
			viscircles(coord{r, c}, 5);
		end
	end
end