function board = getBoardImage(im, coord)
	board = char(8, 8);
	for r = 1:8
		for c = 1:8
			board(r,c) = 'x';
		end
	end
% 	figure;
 	%imshow(im);
    %hold on
	[sizeX, sizeY, sizeZ] = size(im);
	[rowsInImage, columnsInImage] = meshgrid(1:sizeY, 1:sizeX);
	
	[mask1, blue] = blueMask(im);
	[mask2, red] = redMask(im);
	rMin = 7;
	rMax = 20;
	
    board = getPieces(board, red, coord, 'R', rMin, rMax);
	board = getPieces(board, blue, coord, 'B', rMin, rMax);
end

function board = getPieces(board, im, coord, color, rMin, rMax)
	[centers, radii] = imfindcircles(im, [rMin, rMax], 'EdgeThreshold', .1, 'Method', 'TwoStage', 'Sensitivity', .87);
	
	if ~isempty(radii)
		avgRad = mean(radii);
		for r = 1:8
			for c = 1:8
				for i = 1:length(centers(:,1))
					if norm(coord{r, c} - centers(i,:)) < avgRad
						board(r,c) = color;
						viscircles(centers, radii, 'Color', color);
					end
				end
			end
		end
	end	
end