function score = scorer(board, player)
% Instantiate score and starting position based on which side player is
score = 0;
if (player == 'W')
    start = 1;
elseif (player == 'B')
    start = 8;
end
% Iterate through board
for r = 1:8
    for c = 1:8
        % Add points if the player is close to their end
        if board(r, c) == player
            score = score + abs(r - start)^1.5;
        end
    end
end










end