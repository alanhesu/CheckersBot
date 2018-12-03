function won = isWon(board, player)
% Instantiate variables
won = false;
whiteCount = 0;
blackCount = 0;
% Count how many white and black pieces there are
for r = 1:8
    for c = 1:8
        if board(r, c) == 'R'
            whiteCount = whiteCount + 1;
        elseif board(r, c) == 'B'
            blackCount = blackCount + 1;
        end
    end
end
% Count how many white and black pieces made it to the end
whiteEnds = (board(8, 1) == 'R') + (board(8, 3) == 'R') + (board(8, 5) == 'R') + (board(8, 7) == 'R');
blackEnds = (board(1, 2) == 'B') + (board(1, 4) == 'B') + (board(1, 6) == 'B') + (board(1, 8) == 'B');
% White victory conditions
if player == 'R'
    if (whiteEnds == 4 || whiteEnds > blackCount || blackCount == 0)
        won = true;
    end
    % Black victory conditions
elseif player == 'B'
    if (blackEnds == 4 || blackEnds > whiteCount || whiteCount == 0)
        won = true;
    end
else
    error('Invalid Player')
end
end