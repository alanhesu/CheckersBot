function makeMove(board, newBoard, player, s)

changed = board ~= newBoard;
[rows, cols] = find(board ~= newBoard);
if player == 'W'
    start = 1;
    dir = 1;
    enemy = 'B';
else
    start = 8;
    dir = -1;
    enemy = 'W';
end
% Pick up the player piece that moved
for i = 1:length(rows)
    if board(rows(i), cols(i)) == player
        moveToSquare(rows(i), cols(i));
        grip(-1, s)        
    end
end
% Set down the player piece that moved
for i = 1:length(rows)
    if newBoard(rows(i), cols(i)) == player
        moveToSquare(rows(i), cols(i));
        grip(1, s)
    end
end
% Remove any captured enemy pieces
for i = 1:length(rows)
    if board(rows(i), cols(i)) == enemy
        moveToSquare(rows(i), cols(i))
        grip(-1, s);
        moveToSide();
        grip(1, s);
    end
end
end