function score = scorer(board, player)
% Instantiate score and starting position based on which side player is
score = 0;
if player == 'R'
    start = 1;
    fin = 8;
    opponent = 'B';
elseif player == 'B'
    start = 8;
    fin = 1;
    opponent = 'R';
end
% Iterate through board
for r = 1:8
    for c = 1:8
        % Add points if the player is close to their end or if they have a
        % piece
        if board(r, c) == player
            % Add another point for having pieces
            score = score + 1 + abs(r - start);
            % Add additional points if we're on the 8th row
            if r == fin
                score = score + 2;
            end
        elseif board(r, c) ~= 'x'
            % Subtract points if the opponent is close to their end
            score = score - 1 - abs(r - fin);
            if r == start
                score = score - 2;
            end
        end
    end
end
% Boost the score if it results in victory
if isWon(board, player)
    score = 100;
% Lower the score if it results in defeat
elseif isWon(board, opponent)
    score = -100;
end
end