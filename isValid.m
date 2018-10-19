function valid = isValid(board, player, move)
% Instantiate variables
stRow = move(1);
stCol = move(2);
finRow = move(3);
finCol = move(4);
valid = true;
% Check player input and set direction
if player == 'W'
    dir = 1;
elseif player == 'B'
    dir = -1;
else
    error('Invalid Player')
end
% Check all indices are between 1 and 8
if (stRow > 8 || stRow < 1 || stCol > 8 || stCol < 1 || finRow > 8 ...
    || finRow < 1 || finCol > 8 || finCol < 1)
    valid = false;
end
% Check that the starting position holds player piece
if board(stRow, stCol) ~= player
    valid = false;
end
% Check that the final position is empty
if board(finRow, finCol) ~= 'x'
    valid = false;
end
% Check that the jump is diagonal
if abs(finRow - stRow) ~= abs(finCol - stCol)
    valid = false;
end
% Check that the jump is in the right direction
if (finRow - stRow)/dir <= 0
    valid = false;
end
% Check that the jump is by less than 3
if abs(finRow - stRow) > 2
    valid = false;
end
% If the jump is by 2, check that it doesn't jump over a space
if abs(finRow - stRow) == 2
    if (board((stRow + finRow)/2, (stCol + finCol)/2) == 'x')
        valid = false;
    end
end
end