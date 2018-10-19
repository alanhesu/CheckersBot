function board = playerMove(board, player, stRow, stCol, finRow, finCol)
% isValid is called before this, so move is guaranteed to be legal
% If jump takes place, capture
if abs(finRow - stRow) == 2 && board((stRow + finRow)/2, (stCol + finCol)/2) ~= player
    board((stRow + finRow)/2, (stCol + finCol)/2) = 'x';
end
% Regardless of that, always update final and ending positions
board(stRow, stCol) = 'x';
board(finRow, finCol) = player;
end