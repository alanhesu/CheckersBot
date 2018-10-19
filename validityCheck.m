function valid = validityCheck(board, player, move)
% Length is 4 -> only need to check for that move
if length(move) == 4
    valid = isValid(board, player, move);
    % Length is 6 -> two moves, one intermediate state
elseif length(move) == 6
    move1 = move(1:4);
    move2 = move(3:6);
    tempBoard = board;
    tempBoard(move(3), move(4)) = player;
    valid = isValid(board, player, move1) && isValid(tempBoard, player, move2);
    % Length is 8 -> three moves, two intermediate states
elseif length(move) == 8
    move1 = move(1:4);
    move2 = move(3:6);
    move3 = move(5:8);
    tempBoard = board;
    tempBoard2 = board;
    tempBoard(move(3), move(4)) = player;
    tempBoard(move(3), move(4)) = player;
    tempBoard2(move(5), move(6)) = player;
    valid = isValid(board, player, move1) ...
        && isValid(tempBoard, player, move2) && isValid(tempBoard2, player, move3);
else
    % Length can't be anything else
    valid = false;
end
end