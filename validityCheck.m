function valid = validityCheck(board, player, move)
if length(move) == 4
    valid = isValid(board, player, move);
elseif length(move) == 6
    move1 = move(1:4);
    move2 = move(3:6);
    tempBoard = board;
    tempBoard(move(3), move(4)) = player;
    valid = isValid(board, player, move1) && isValid(tempBoard, player, move2);
elseif length(move) == 8
    move1 = move(1:4);
    move2 = move(3:6);
    move3 = move(5:8);
    tempBoard = board;
    tempBoard(move(3), move(4)) = player;
    tempBoard(move(5), move(6)) = player
    valid = isValid(board, player, move1) ...
        && isValid(tempBoard, player, move2) && isValid(tempBoard, player, move3);
else
    valid = false;
end


end