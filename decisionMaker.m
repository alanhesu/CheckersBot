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
% Score them and update board to be the top scorer
scores = zeros(1, length(boards));
rawScores = zeros(1, length(boards));
enemyAvg = zeros(1, length(boards));
for x = 1:length(boards)
    enemyBoards{x} = possibleBoards(boards{x}, opponent);
    enemyScores = zeros(1, length(enemyBoards{x}));
    for y = 1:length(enemyBoards{x})
        enemyScores(y) = scorer(enemyBoards{x}{y}, opponent);
%         futureBoards = {};
%         futureBoards{y} = possibleBoards(enemyBoards{x}{y}, player);
%         futureScores = zeros(1, length(futureBoards{y}));
%         for z = 1:length(futureBoards{y})
%             futureScores(z) = scorer(futureBoards{z}, player);
%         end
%         futureAvg = mean(futureScores);
    end
    % Assume the enemy makes a decent move
    if length(enemyScores) == 1
        enemyScore(x) = enemyScore;
    elseif length(enemyScores) > 10
        enemyScore(x) = mean(maxk(enemyScores, 3));
    else
        enemyScore(x) = mean(maxk(enemyScores, 2));
    end
    rawScores(x) = scorer(boards{x}, player);
    scores(x) = rawScores(x) - enemyScore(x);
end
[~, ind] = max(scores);
% Gets the first random move that has the highest score
board = boards{ind};


end