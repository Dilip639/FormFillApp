
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Game logic variables
    int[][] board = new int[4][4];
    int score = 0;
    boolean gameOver = false;
    boolean won = false;
    String message = "";
    
    // Get session attributes
    int[][] sessionBoard = (int[][]) session.getAttribute("board");
    Integer sessionScore = (Integer) session.getAttribute("score");
    Boolean sessionGameOver = (Boolean) session.getAttribute("gameOver");
    Boolean sessionWon = (Boolean) session.getAttribute("won");
    
    String action = request.getParameter("action");
    String direction = request.getParameter("direction");
    
    // Initialize new game
    if ("newGame".equals(action) || sessionBoard == null) {
        board = new int[4][4];
        score = 0;
        gameOver = false;
        won = false;
        addRandomTile(board);
        addRandomTile(board);
        message = "New game started! Use arrow keys or buttons to move tiles.";
    } else {
        // Load existing game state
        board = sessionBoard;
        score = sessionScore != null ? sessionScore : 0;
        gameOver = sessionGameOver != null ? sessionGameOver : false;
        won = sessionWon != null ? sessionWon : false;
    }
    
    // Process move
    if (direction != null && !gameOver) {
        int[][] newBoard = copyBoard(board);
        int oldScore = score;
        
        switch (direction) {
            case "up":
                moveUp(newBoard);
                break;
            case "down":
                moveDown(newBoard);
                break;
            case "left":
                moveLeft(newBoard);
                break;
            case "right":
                moveRight(newBoard);
                break;
        }
        
        // Check if move was valid
        if (!boardsEqual(board, newBoard)) {
            board = newBoard;
            addRandomTile(board);
            
            // Check for 2048 tile
            if (!won && has2048(board)) {
                won = true;
                message = "🎉 Congratulations! You reached 2048!";
            }
            
            // Check game over
            if (isGameOver(board)) {
                gameOver = true;
                message = "Game Over! No more moves available.";
            }
        }
    }
    
    // Save game state
    session.setAttribute("board", board);
    session.setAttribute("score", score);
    session.setAttribute("gameOver", gameOver);
    session.setAttribute("won", won);
    
    // Helper methods
    %>
    
    <%!
    private void addRandomTile(int[][] board) {
        List<int[]> emptyCells = new ArrayList<>();
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (board[i][j] == 0) {
                    emptyCells.add(new int[]{i, j});
                }
            }
        }
        
        if (!emptyCells.isEmpty()) {
            Random rand = new Random();
            int[] cell = emptyCells.get(rand.nextInt(emptyCells.size()));
            board[cell[0]][cell[1]] = rand.nextDouble() < 0.9 ? 2 : 4;
        }
    }
    
    private int[][] copyBoard(int[][] board) {
        int[][] copy = new int[4][4];
        for (int i = 0; i < 4; i++) {
            System.arraycopy(board[i], 0, copy[i], 0, 4);
        }
        return copy;
    }
    
    private boolean boardsEqual(int[][] board1, int[][] board2) {
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (board1[i][j] != board2[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }
    
    private void moveLeft(int[][] board) {
        for (int i = 0; i < 4; i++) {
            int[] row = board[i];
            int[] newRow = new int[4];
            int pos = 0;
            
            // Move non-zero tiles to the left
            for (int j = 0; j < 4; j++) {
                if (row[j] != 0) {
                    newRow[pos++] = row[j];
                }
            }
            
            // Merge adjacent equal tiles
            for (int j = 0; j < 3; j++) {
                if (newRow[j] != 0 && newRow[j] == newRow[j + 1]) {
                    newRow[j] *= 2;
                    newRow[j + 1] = 0;
                }
            }
            
            // Move merged tiles to the left again
            int[] finalRow = new int[4];
            pos = 0;
            for (int j = 0; j < 4; j++) {
                if (newRow[j] != 0) {
                    finalRow[pos++] = newRow[j];
                }
            }
            
            board[i] = finalRow;
        }
    }
    
    private void moveRight(int[][] board) {
        // Reverse, move left, reverse again
        reverseRows(board);
        moveLeft(board);
        reverseRows(board);
    }
    
    private void moveUp(int[][] board) {
        transpose(board);
        moveLeft(board);
        transpose(board);
    }
    
    private void moveDown(int[][] board) {
        transpose(board);
        reverseRows(board);
        moveLeft(board);
        reverseRows(board);
        transpose(board);
    }
    
    private void transpose(int[][] board) {
        for (int i = 0; i < 4; i++) {
            for (int j = i + 1; j < 4; j++) {
                int temp = board[i][j];
                board[i][j] = board[j][i];
                board[j][i] = temp;
            }
        }
    }
    
    private void reverseRows(int[][] board) {
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 2; j++) {
                int temp = board[i][j];
                board[i][j] = board[i][3 - j];
                board[i][3 - j] = temp;
            }
        }
    }
    
    private boolean has2048(int[][] board) {
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (board[i][j] == 2048) {
                    return true;
                }
            }
        }
        return false;
    }
    
    private boolean isGameOver(int[][] board) {
        // Check for empty cells
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (board[i][j] == 0) {
                    return false;
                }
            }
        }
        
        // Check for possible merges
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                int current = board[i][j];
                if ((i > 0 && board[i-1][j] == current) ||
                    (i < 3 && board[i+1][j] == current) ||
                    (j > 0 && board[i][j-1] == current) ||
                    (j < 3 && board[i][j+1] == current)) {
                    return false;
                }
            }
        }
        
        return true;
    }
    
    private String getTileColor(int value) {
        switch (value) {
            case 2: return "#eee4da";
            case 4: return "#ede0c8";
            case 8: return "#f2b179";
            case 16: return "#f59563";
            case 32: return "#f67c5f";
            case 64: return "#f65e3b";
            case 128: return "#edcf72";
            case 256: return "#edcc61";
            case 512: return "#edc850";
            case 1024: return "#edc53f";
            case 2048: return "#edc22e";
            default: return "#3c3a32";
        }
    }
    
    private String getTextColor(int value) {
        return value <= 4 ? "#776e65" : "#f9f6f2";
    }
    %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2048 Game</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #faf8ef 0%, #f2e6d9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .game-container {
            background: #bbada0;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
        }
        
        .game-header {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .game-header h1 {
            color: #776e65;
            font-size: 3em;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .game-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        
        .score-box {
            background: #bbada0;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-align: center;
            min-width: 80px;
        }
        
        .score-box .label {
            font-size: 0.8em;
            text-transform: uppercase;
            font-weight: bold;
        }
        
        .score-box .value {
            font-size: 1.5em;
            font-weight: bold;
        }
        
        .game-board {
            background: #bbada0;
            border-radius: 10px;
            padding: 10px;
            position: relative;
            margin-bottom: 20px;
        }
        
        .board-row {
            display: flex;
            margin-bottom: 10px;
        }
        
        .board-row:last-child {
            margin-bottom: 0;
        }
        
        .tile {
            width: 80px;
            height: 80px;
            background: #cdc1b4;
            border-radius: 5px;
            margin-right: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            font-weight: bold;
            transition: all 0.15s ease-in-out;
        }
        
        .tile:last-child {
            margin-right: 0;
        }
        
        .controls {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .control-row {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        
        .control-btn {
            padding: 15px 20px;
            background: #8f7a66;
            color: #f9f6f2;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.15s ease-in-out;
            min-width: 60px;
        }
        
        .control-btn:hover {
            background: #9f8a76;
        }
        
        .control-btn:active {
            background: #7f6a56;
        }
        
        .new-game-btn {
            width: 100%;
            padding: 15px;
            background: #f67c5f;
            color: #f9f6f2;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.15s ease-in-out;
        }
        
        .new-game-btn:hover {
            background: #f68c6f;
        }
        
        .message {
            text-align: center;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }
        
        .message.success {
            background: #edf7ed;
            color: #2e7d32;
            border: 2px solid #4caf50;
        }
        
        .message.error {
            background: #fdeaea;
            color: #c62828;
            border: 2px solid #f44336;
        }
        
        .message.info {
            background: #e3f2fd;
            color: #1565c0;
            border: 2px solid #2196f3;
        }
        
        .instructions {
            background: #f9f6f2;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        
        .instructions h3 {
            color: #776e65;
            margin-bottom: 10px;
        }
        
        .instructions p {
            color: #776e65;
            line-height: 1.5;
            margin-bottom: 8px;
        }
        
        @media (max-width: 480px) {
            .tile {
                width: 60px;
                height: 60px;
                font-size: 1.5em;
            }
            
            .game-header h1 {
                font-size: 2em;
            }
            
            .control-btn {
                padding: 12px 15px;
                font-size: 0.9em;
            }
        }
    </style>
</head>
<body>
    <div class="game-container">
        <div class="game-header">
            <h1>2048</h1>
        </div>
        
        <div class="game-info">
            <div class="score-box">
                <div class="label">Score</div>
                <div class="value"><%= score %></div>
            </div>
            <div class="score-box">
                <div class="label">Best</div>
                <div class="value">0</div>
            </div>
        </div>
        
        <% if (!message.isEmpty()) { %>
        <div class="message <%= won ? "success" : (gameOver ? "error" : "info") %>">
            <%= message %>
        </div>
        <% } %>
        
        <div class="game-board">
            <% for (int i = 0; i < 4; i++) { %>
            <div class="board-row">
                <% for (int j = 0; j < 4; j++) { %>
                <div class="tile" style="background-color: <%= getTileColor(board[i][j]) %>; color: <%= getTextColor(board[i][j]) %>;">
                    <%= board[i][j] == 0 ? "" : board[i][j] %>
                </div>
                <% } %>
            </div>
            <% } %>
        </div>
        
        <div class="controls">
            <div class="control-row">
                <form method="post" style="display: inline;">
                    <input type="hidden" name="direction" value="up">
                    <button type="submit" class="control-btn" <%= gameOver ? "disabled" : "" %>>↑</button>
                </form>
            </div>
            <div class="control-row">
                <form method="post" style="display: inline;">
                    <input type="hidden" name="direction" value="left">
                    <button type="submit" class="control-btn" <%= gameOver ? "disabled" : "" %>>←</button>
                </form>
                <form method="post" style="display: inline;">
                    <input type="hidden" name="direction" value="down">
                    <button type="submit" class="control-btn" <%= gameOver ? "disabled" : "" %>>↓</button>
                </form>
                <form method="post" style="display: inline;">
                    <input type="hidden" name="direction" value="right">
                    <button type="submit" class="control-btn" <%= gameOver ? "disabled" : "" %>>→</button>
                </form>
            </div>
        </div>
        
        <form method="post">
            <input type="hidden" name="action" value="newGame">
            <button type="submit" class="new-game-btn">🎮 New Game</button>
        </form>
        
        <div class="instructions">
            <h3>🎯 How to Play:</h3>
            <p>• Use the arrow buttons to move tiles</p>
            <p>• When two tiles with the same number touch, they merge into one</p>
            <p>• Try to create a tile with the number 2048 to win!</p>
            <p>• Keep playing for a higher score after reaching 2048</p>
        </div>
    </div>
    
    <script>
        // Add keyboard support
        document.addEventListener('keydown', function(e) {
            if (<%= gameOver %>) return;
            
            let direction = '';
            switch(e.key) {
                case 'ArrowUp':
                    direction = 'up';
                    break;
                case 'ArrowDown':
                    direction = 'down';
                    break;
                case 'ArrowLeft':
                    direction = 'left';
                    break;
                case 'ArrowRight':
                    direction = 'right';
                    break;
                default:
                    return;
            }
            
            e.preventDefault();
            
            // Create and submit form
            const form = document.createElement('form');
            form.method = 'post';
            form.style.display = 'none';
            
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'direction';
            input.value = direction;
            
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        });
        
        // Add tile animation
        document.addEventListener('DOMContentLoaded', function() {
            const tiles = document.querySelectorAll('.tile');
            tiles.forEach(tile => {
                if (tile.textContent.trim() !== '') {
                    tile.style.transform = 'scale(1.1)';
                    setTimeout(() => {
                        tile.style.transform = 'scale(1)';
                    }, 150);
                }
            });
        });
    </script>
</body>
</html>

