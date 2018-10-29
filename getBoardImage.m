function board = getBoardImage(im, coord)
	board = char(8, 8);
	figure;
	imshow(im);
	[sizeX, sizeY, sizeZ] = size(im);
	[rowsInImage, columnsInImage] = meshgrid(1:sizeY, 1:sizeX);
	
	rMin = 20;
	rMax = 50;
	im_hsv = rgb2hsv(im);
	[centers, radii] = imfindcircles(im, [rMin, rMax], 'EdgeThreshold', .1);
	viscircles(centers, radii, 'Color', 'b');
	
	avgRad = mean(radii);
	for r = 1:8
		for c = 1:8			
			board(r,c) = 'x';
			for i = 1:length(centers(:,1))			
				if norm(coord{r, c} - centers(i,:)) < avgRad
					circlePixels = (rowsInImage - centers(i,1)).^2 + (columnsInImage - centers(i,2)).^2 <= radii(i).^2;
					value = im_hsv(:,:,3);
					if mean(mean(value(circlePixels))) > .5
						board(r,c) = 'W';
					else
						board(r,c) = 'B';
				end
			end
		end
	end
end