function setUp

board = ['x', 'W', 'x', 'W', 'x', 'W', 'x', 'W'
        'W', 'x', 'W', 'x', 'W', 'x', 'W', 'x'
        'x', 'W', 'x', 'W', 'x', 'W', 'x', 'W'
        'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
        'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
        'B', 'x', 'B', 'x', 'B', 'x', 'B', 'x'
        'x', 'B', 'x', 'B', 'x', 'B', 'x', 'B'
        'B', 'x', 'B', 'x', 'B', 'x', 'B', 'x'];
    
% board = ['xxxxxxxx'
%         'xxxxWxWx'
%         'xWxxxWxx'
%         'xxxxxxxx'
%         'xxxBxBxx'
%         'xxxxBxxx'
%         'xxxxxxxx'
%         'xxxxxxxx'];

person = input('Would you like to play as W or B?\n', 's');
while (~(person == 'W' || person == 'B'))
    person = input('Please input W or B.', 's');
end


gameCont = true;
turn = 1;
disp(board);
fprintf('\n');
while gameCont
    if mod(turn, 2) == 1
        player = 'W';
    else
        player = 'B';
    end
    
    % If it's the player's turn, update the board with the player's move
    if player == person
        % Check that the player actually has moves
        if isempty(possibleBoards(board, player))
            gameCont = false;
            disp('Stalemate');
        else 
            move = input(['What is your move?', ...
                '\nInsert a vector of the form [stRow, stCol, finRow, finCol]\n'...
                'If you can capture again, do [row1, col1, row2, col2, row3, col3...\n']);
            % Ensure move is legal
            validMove = validityCheck(board, player, move);
            while ~validMove
               move = input(['Invalid move. Insert a vector of the form [stRow, stCol, finRow, finCol]\n'...
                   'If you can capture again, do [row1, col1, row2, col2, row3, col3...\n']);
               validMove = validityCheck(board, player, move);
            end
            % Update the board
            board = playerMove(board, player, move(1), move(2), move(3), move(4));
            if length(move) > 4
                board = playerMove(board, player, move(3), move(4), move(5), move(6));
            end
            if length(move) > 6
                board = playerMove(board, player, move(5), move(6), move(7), move(8));
            end
            if isWon(board, player)
                gameCont = false;
                disp('You win - congratulations!');
            end
        end
    else
        % Get all possible moves (if there are none, terminate)
        boards = possibleBoards(board, player);
        if isempty(boards)
            gameCont = false;
            disp('Stalemate')
        else
            % This is where to decide the CPU move
            % Randomize the moves
            boards = boards(randperm(length(boards)));
            scores = zeros(1, length(boards));
            for x = 1:length(boards)
                scores(x) = scorer(boards{x}, player);
            end
            [~, ind] = max(scores);
            % Gets the first random move that has the highest score
            
            board = boards{ind};
            % board = boards{1};
            if isWon(board, player)
                gameCont = false;
                disp('Game over. Try again?');
            end
        end
    end
    
    % Either way, print the board and increment move
    disp(board)
    fprintf('\n')
    turn = turn + 1;
end









end