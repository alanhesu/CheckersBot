function setUp
% Set up the checkers board
board = ['x', 'W', 'x', 'W', 'x', 'W', 'x', 'W'
        'W', 'x', 'W', 'x', 'W', 'x', 'W', 'x'
        'x', 'W', 'x', 'W', 'x', 'W', 'x', 'W'
        'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
        'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
        'B', 'x', 'B', 'x', 'B', 'x', 'B', 'x'
        'x', 'B', 'x', 'B', 'x', 'B', 'x', 'B'
        'B', 'x', 'B', 'x', 'B', 'x', 'B', 'x'];
    
% Initialize the Arduino
if ~isempty(instrfind)
	fclose(instrfind);
	delete(instrfind);
end
s = serial('COM5');
set(s, 'BaudRate', 9600);
fopen(s);
% Move out
moveIn(false);
% Player plays as white
person = 'W';
% Start the game
gameCont = true;
turn = 1;
disp(board);
fprintf('\n');
while gameCont
    % Take turns
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
            % Wait 20 seconds
            pause(20);
            % Update the board
            board = readBoard();
            % Determine if the game is over after the player moves
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
            % Move in
            moveIn(true);
            % CPU makes its move
            newBoard = decisionMaker(board, player);
            makeMove(board, newBoard, player, s);
            board = newBoard;
            % Move out
            moveOut(false);
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
% Close the Arduino
fclose(s);
delete(s);
clear s;
end