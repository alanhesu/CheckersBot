function boards = jumper(board, r, c)
% Instantiate the output array of boards and determine the player
boards = {};
player = board(r, c);
% Set direction
if player == 'W'
    dir = 1;
elseif player == 'B'
    dir = -1;
else
    error('Invalid player');
end
% Check if you can jump left
if (r + 2 * dir < 9 && r + 2 * dir > 0 && c - 2 > 0 ...
                && board(r + 2 * dir, c - 2) == 'x' && board(r + dir, c - 1) ~= 'x')
    tempBoard = board;
    tempBoard(r, c) = 'x';
    tempBoard(r + 2 * dir, c - 2) = player;
    if (tempBoard(r + dir, c - 1) ~= player)
        tempBoard(r + dir, c - 1) = 'x';
    end
    boards = [boards, {tempBoard}];
    % Update boards to also include jumps made from here, however
    boards = [boards, jumper(tempBoard, r + 2 * dir, c - 2)];
end
    % Check if you can jump right
if (r + 2 * dir < 9 && r + 2 * dir > 0 && c + 2 < 9 ...
                && board(r + 2 * dir, c + 2) == 'x' && board(r + dir, c + 1) ~= 'x')
    tempBoard = board;
    tempBoard(r, c) = 'x';
    tempBoard(r + 2 * dir, c + 2) = player;
    if (tempBoard(r + dir, c + 1) ~= player)
        tempBoard(r + dir, c + 1) = 'x';
    end
    % Check for follow-up jumps
    boards = [boards, {tempBoard}];
    boards = [boards, jumper(tempBoard, r + 2 * dir, c + 2)];
end
end