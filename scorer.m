function score = scorer(board, player)
% Instantiate score and starting position based on which side player is
score = 0;
if player == 'W'
    start = 1;
    fin = 8;
    opponent = 'B';
elseif player == 'B'
    start = 8;
    fin = 1;
    opponent = 'W';
end
% Iterate through board
for r = 1:8
    for c = 1:8
        % Add points if the player is close to their end
        if board(r, c) == player
            score = score + abs(r - start)^1.2;
        elseif board(r, c) ~= 'x'
            % Subtract points if the opponent is close to their end
            score = score - abs(r - fin)^1.2;
        end
    end
end
% Lower the score if it results in defeat
if isWon(board, opponent)
    score = -1000;
end
end