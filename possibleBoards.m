function boards = possibleBoards(board, player) 

boards = {};

if (player == 'W')
    dir = 1;
       
elseif (player == 'B')
    dir = -1;
  
else
    error("Invalid Player: " + player);
end

for r = 1:8
    for c = 1:8
        % If a piece is the player's
        if (board(r, c) == player)
            % If the piece can move left
            if (r + dir < 9 && r + dir > 0 && c - 1 > 0 && board(r + dir, c - 1) == 'x')
                tempBoard = board;
                tempBoard(r, c) = 'x';
                tempBoard(r + dir, c - 1) = player;
                boards = [boards, {tempBoard}];
            end
            % Now if the piece can move right
            if (r + dir < 9 && r + dir > 0 && c + 1 < 9 && board(r + dir, c + 1) == 'x')
                tempBoard = board;
                tempBoard(r, c) = 'x';
                tempBoard(r + dir, c + 1) = player;
                boards = [boards, {tempBoard}];
            end
            % Now if the piece can capture left
            if (r + 2 * dir < 9 && r + 2 * dir > 0 && c - 2 > 0 ...
                && board(r + 2 * dir, c - 2) == 'x' && board(r + dir, c - 1) ~= 'x')
                tempBoard = board;
                tempBoard(r, c) = 'x';
                tempBoard(r + 2 * dir, c - 2) = player;
                if (tempBoard(r + dir, c - 1) ~= player)
                    tempBoard(r + dir, c - 1) = 'x';
                end
                boards = [boards, {tempBoard}];
                % Check for follow-up jumps
                boards = [boards, jumper(tempBoard, r + 2 * dir, c - 2)];
            end
            % Now if the piece can capture right
            if (r + 2 * dir < 9 && r + 2 * dir > 0 && c + 2 < 9 ...
                && board(r + 2 * dir, c + 2) == 'x' && board(r + dir, c + 1) ~= 'x')
                tempBoard = board;
                tempBoard(r, c) = 'x';
                tempBoard(r + 2 * dir, c + 2) = player;
                if (tempBoard(r + dir, c + 1) ~= player)
                    tempBoard(r + dir, c + 1) = 'x';
                end
                boards = [boards, {tempBoard}];
                % Check for follow-up jumps
                boards = [boards, jumper(tempBoard, r + 2 * dir, c + 2)];
            end
        end
    end
end
