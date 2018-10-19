function board = decisionMaker(boards, player)
% Randomize the boards
boards = boards(randperm(length(boards)));
% Now create the opponent's response
if player == 'W'
    opponent = 'B';
elseif player == 'B'
    opponent = 'W';
else
    error('Invalid player')
end
enemyBoards = {};
for x = 1:length(boards)
    enemyBoards{x} = possibleBoards(boards{x}, opponent);
end
% Score them and update board to be the top scorer
scores = zeros(1, length(boards));
for x = 1:length(boards)
    enemyScores = zeros(1, length(enemyBoards{x}));
    for y = 1:length(enemyBoards{x})
        enemyScores(y) = scorer(enemyBoards{x}{y}, opponent);
    end
    enemyAvg = mean(enemyScores);
    scores(x) = scorer(boards{x}, player) - enemyAvg;
end
[~, ind] = max(scores);
% Gets the first random move that has the highest score
board = boards{ind};



end