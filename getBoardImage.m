function board = getBoardImage(im, coord)
	board = char(8, 8);
% 	figure;
% 	imshow(im);
	[sizeX, sizeY, sizeZ] = size(im);
	[rowsInImage, columnsInImage] = meshgrid(1:sizeY, 1:sizeX);
	
	rMin = 12;
	rMax = 40;
	im_hsv = rgb2hsv(im);
	[centers, radii] = imfindcircles(im, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
% 	viscircles(centers, radii, 'Color', 'b');
	
    if ~isempty(radii)
        avgRad = mean(radii);
        for r = 1:8
            for c = 1:8			
                board(r,c) = 'x';
                for i = 1:length(centers(:,1))			
                    if norm(coord{r, c} - centers(i,:)) < avgRad
                        circlePixels = (rowsInImage - centers(i,1)).^2 + (columnsInImage - centers(i,2)).^2 <= (radii(i)*.7).^2;
                        hue = im_hsv(:,:,1);
                        red = im(:,:,1);
                        blue = im(:,:,3);
                        if mean(mean(red(circlePixels))) > mean(mean(blue(circlePixels)))
                            board(r,c) = 'R';
                            viscircles(centers(i,:), radii(i), 'Color', 'r');
                        else
                            board(r,c) = 'B';
                            viscircles(centers(i,:), radii(i), 'Color', 'b');
                        end
                    end
                end
            end            
        end
    end
end