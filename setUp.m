function setUp
% Set up the checkers board
board = ['x', 'R', 'x', 'R', 'x', 'R', 'x', 'R'
        'R', 'x', 'R', 'x', 'R', 'x', 'R', 'x'
        'x', 'R', 'x', 'R', 'x', 'R', 'x', 'R'
        'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
        'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
        'B', 'x', 'B', 'x', 'B', 'x', 'B', 'x'
        'x', 'B', 'x', 'B', 'x', 'B', 'x', 'B'
        'B', 'x', 'B', 'x', 'B', 'x', 'B', 'x'];
    
%% Initialize the Arduino

% if ~isempty(instrfind)
% 	fclose(instrfind);
% 	delete(instrfind);
% end
s = serial('COM3');
set(s, 'BaudRate', 9600);
fopen(s);
%% Initialize the camera
clear('cam')
cam = webcam('HD 720P Webcam');
%%
% Connect to the Epson
net = netOpen('192.168.0.1', 2000);
flushinput(net);
%%
for r = 1:8
	for c = 1:8
		coord{r,c} = [0,0];
	end
end
while coord{1,1} == [0,0]
    % grab the camera image and store it in a local temporary file
%     urlwrite(url,img_file,'Authentication','Basic','Username',user,'Password',pass);
    % show the camera image and delete the local temporary file
%     cam_capture = imread(img_file);
	cam_capture = snapshot(cam);
    %[~, im] = webcamMask(cam_capture);
	coord = initBoardImage(cam_capture);			
end

%%
% Move out
moveIn(false, net);
% Player plays as red
person = 'R';
% Start the game
gameCont = true;
turn = 1;
disp(board);
fprintf('\n');
while gameCont
    % Take turns
    if mod(turn, 2) == 1
        player = 'R';
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
            % Wait 10 seconds
            pause(10);
            % Update the board
            im = snapshot(cam);
            imshow(im);
            board = getBoardImage(im, coord);
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
            moveIn(true, net);
            % CPU makes its move
            newBoard = decisionMaker(boards, player);
            makeMove(board, newBoard, player, s, net);
            board = newBoard;
            % Move out
            moveToSide(net);
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
%% Close the Arduino
fclose(s);
delete(s);
clear s;
end