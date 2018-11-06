function coord = initBoardImage(im)
    figure(3);
    imshow(im);    
    coord = {8, 8};
    for r = 1:8
        for c = 1:8
            coord{r,c} = [0,0];
        end
    end

    rMin = 7;
    rMax = 20;
    im_bw = im2bw(im, .5);
    [centers, radii] = imfindcircles(im, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
    viscircles(centers, radii, 'Color', 'b');

    if length(centers) == 24
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