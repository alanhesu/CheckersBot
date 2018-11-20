function coord = initBoardImage(im)
    coord = {8, 8};
    for r = 1:8
        for c = 1:8
            coord{r,c} = [0,0];
        end
    end

    [mask1, blue] = blueMask(im);
	[mask2, red] = redMask(im);
	rMin = 7;
	rMax = 20;
% 	imshow(im);
% 	hold on;
	[centersBlue, radiiBlue] = imfindcircles(blue, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
	[centersRed, radiiRed] = imfindcircles(red, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
 	viscircles(centersBlue, radiiBlue, 'Color', 'b');	
	viscircles(centersRed, radiiRed, 'Color', 'r');

    if length(centersBlue) == 12 && length(centersRed) == 12
		centers = [centersBlue; centersRed];
        topRight = [max(centers(:,1)), min(centers(:,2))];
        botLeft = [min(centers(:,1)), max(centers(:,2))];
        
        x = linspace(botLeft(1), topRight(1), 8);
        y = linspace(topRight(2), botLeft(2), 8);
        for r = 1:8
            for c = 1:8
                coord{r, c} = [x(c), y(r)];
                viscircles(coord{r, c}, 5);
            end
        end
    end
end