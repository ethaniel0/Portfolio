
var canvas = document.getElementById("canvas");
var ctx = canvas.getContext("2d");

var npCanvas = document.getElementById("next-piece");
var npCtx = npCanvas.getContext("2d");

window.addEventListener("keydown", keyDown);
window.addEventListener("keyup", keyUp);

/*

scoring:
single line clear = 40 * level
double line clear = 100 * level
triple line clear = 300 * level
tetris = 1200 * level

hard drop = # lines dropped

*/




///////////////// PIECES //////////////////

var line = {
    
    0: [[-1, 0], [0,0], [1,0], [2,0]],
    1: [[0, 1], [0, 0], [0, -1], [0, -2]],
    2: [[-1, 0], [0,0], [1,0], [2,0]],
    3: [[0, 1], [0, 0], [0, -1], [0, -2]],
    color: "orange"
};

var square = {
    
    
    0: [[0, 0], [0, -1], [1, 0], [1, -1]],
    1: [[0, 0], [0, -1], [1, 0], [1, -1]],
    2: [[0, 0], [0, -1], [1, 0], [1, -1]],
    3: [[0, 0], [0, -1], [1, 0], [1, -1]],
    color: "red"
    
};

var tPiece = {
    0: [[-1, 0],[0, 0], [1, 0], [0, 1]],
    1: [[-1, 0],[0, 0], [0, -1], [0, 1]],
    2: [[-1, 0],[0, 0], [1, 0], [0, -1]],
    3: [[1, 0],[0, 0], [0, -1], [0, 1]],
    color: "yellow"
};

var rightz = {
    0: [[0,0],[1,0],[0,1],[-1,1]],
    1: [[0, 0], [1, 0], [0, -1], [1, 1]],
    2: [[0,0],[1,0],[0,1],[-1,1]],
    3: [[0, 0], [1, 0], [0, -1], [1, 1]],
    color: "green"
};

var leftz = {
    
    0: [[-1,-1],[0,-1],[0,0],[1,0]],
    1: [[0,1],[0,0],[1,0],[1,-1]],
    2: [[-1,-1],[0,-1],[0,0],[1,0]],
    3: [[0,1],[0,0],[1,0],[1,-1]],
    color: "cyan"
    
};

var rightl = {
    
    0: [[-1,0],[0,0],[1,0],[-1,1]],
    1: [[0,-1],[0,0],[0,1],[-1,-1]],
    2: [[-1,0],[0,0],[1,0],[1,-1]],
    3: [[0,-1],[0,0],[0,1],[1, 1]],
    color: "blue"
    
};

var leftl = {
    
    0: [[1,0],[0,0],[-1,0],[1,1]],
    1: [[0,-1],[0,0],[0,1],[-1,1]],
    2: [[-1,0],[0,0],[1,0],[-1,-1]],
    3: [[0,-1],[0,0],[0,1],[1,-1]],
    color: "purple"
    
};

var score = 0;
var lines = 0;

var board = []
for (var y = 0; y < 20; y++){
    board.push([[" "],[" "],[" "],[" "],[" "],[" "],[" "],[" "],[" "],[" "]]);
}


function drawShape(shape, x, y, rot){
    
    ctx.beginPath();
    
    for (var i = 0; i < 4; i++){
        ctx.rect(shape[rot][i][0] + x, shape[rot][i][1] + y, 45, 45)
    }
    
    ctx.fillStyle = shape["color"];
    ctx.fill();
    ctx.stroke();

}

function drawCp(cp){
    
    ctx.beginPath();
    
    for (var i = 0; i < 4; i++){
        
        ctx.rect((cp[i][0] + cp["x"])*45, (cp[i][1] + cp["y"])*45, 45, 45);
        
    }
    
    ctx.fillStyle = cp["color"];
    ctx.fill();
    ctx.stroke();
    
    
}

function drawNextPiece(np){
    
//    console.log(np);
    
    npCtx.clearRect(0, 0, npCanvas.width, npCanvas.height);
    
    npCtx.beginPath();
    
    for (var i = 0; i < 4; i++){
        
        npCtx.rect((np[i][0] + 2)*npCanvas.width/5, (np[i][1] + 2)*npCanvas.width/5, npCanvas.width/5, npCanvas.width/5);
        
    }
    
    npCtx.fillStyle = np["color"];
    npCtx.fill();
    npCtx.stroke();

    

    
    

}

///////////////// ACTUAL GAME /////////////////
function clear_board(ctx){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
}

var pieces = { // 1 and 4 start on 1, all others start on 0
    0: rightz,
    1: square,
    2: tPiece,
    3: line,
    4: leftz,
    5: rightl,
    6: leftl
};

function setPos(cp, x, y){
    
    for (var i = 0; i < 4; i++){
        cp["x"] += x;
        cp["y"] += y;
    }


}

function random_piece(){
    
    var chosen_piece = Math.round(Math.random() * 6);
    
    attributes = {};
    
    attributes["piece"] = chosen_piece;
    
    // box 1      =     type of piece[with rotation 0][coordinates for first box]
    attributes[0] = pieces[chosen_piece][0][0];
    attributes[1] = pieces[chosen_piece][0][1];
    attributes[2] = pieces[chosen_piece][0][2];
    attributes[3] = pieces[chosen_piece][0][3];
    
    attributes["x"] = 4;
    attributes["y"] = 0;

    
    attributes["rot"] = 0
    
    attributes["color"] = pieces[chosen_piece]["color"]
    
    return attributes;

}

var game_over = false;
//
var level = 1;
var cp = random_piece(); // cp = current piece
var next_piece = random_piece();

var playing_game = false;

var paused = false;
var levelIncreased = false;

var speeds = [48 , 43, 38, 33, 28, 23, 18, 13, 8, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1];

var keyPressed = 0; // 0 = none, 1 = up, 2 = down, 3 = right, 4 = left

function updateGame(ctx, cp){
    
    clear_board(ctx);
    drawBoard();
    drawCp(cp);
    
    document.getElementById("score").innerHTML = "Score: " + score;
    document.getElementById("level").innerHTML = "Level: " + level;
    
    
    
}


function lineClear(){
    
    var numLinesCleared = 0;
    
   for (var y = 0; y < 20; y++){
       var noSpaces = true;
       for (var x = 0; x < 10; x++){
           
           if (board[y][x] == " "){
               noSpaces = false;
               break;
           }

       }
       
       
       if (noSpaces){
           
           board.splice(y,1);
           board.unshift([[" "],[" "],[" "],[" "],[" "],[" "],[" "],[" "],[" "],[" "]]);
           
           numLinesCleared ++;
           lines ++;
           
           if (lines % 10 == 0){
               level ++;
               levelIncreased = true;
           }
           
   
       }
   }
    
//    lines += numLinesCleared;
    
    
    
    if (numLinesCleared == 1){score += 40*level;}
    if (numLinesCleared == 2){score += 100*level;}
    if (numLinesCleared == 3){score += 300*level;}
    if (numLinesCleared == 4){score += 1200*level;}
    
    document.getElementById("lines").innerHTML = "Lines: " + lines;
    
    updateGame(ctx);
    
}

function detectCollision(piece){

    for (var i = 0; i < 4; i++){
        if (piece[i][1] + cp["y"] +1 < 0){continue;}
        if ((piece[i][1] + cp["y"])+1 == 20){return true;}
        if (board[piece[i][1] + cp["y"] +1][piece[i][0] + cp["x"]] != " "){
            return true;
        }
    }

    return false;
}

function drawBoard(){
    
    for (var y = 0; y < 20; y++){
        for (var x = 0; x < 10; x++){
            if (board[y][x] != " "){
                ctx.beginPath();
                ctx.rect(x*canvas.width/10, y*canvas.height/20, 45, canvas.width/10)
                ctx.fillStyle = board[y][x];
                ctx.fill();
                ctx.stroke();
            }
        }
    }
    
}

function addToBoard(cp){
    
    
    for (var i = 0; i < 4; i++){
        
        board[cp[i][1] + cp["y"]][cp[i][0] + cp["x"]] = cp["color"];

    }

}

function keyDown(event){
    
    var key = event.key;
    
    
    if (playing_game){
        
    
        if (key == "ArrowLeft"){ // left
            
             var canMove = true;
            for (var i = 0; i < 4; i++){
                if(cp[i][0] + cp["x"] - 1 < 0 || board[cp[i][1] + cp["y"]][cp[i][0] + cp["x"] - 1] != " "){
                    canMove = false;
                    break;
                }
            }

            if(canMove){
                cp["x"] --;
                
                clear_board(ctx);
                drawBoard();
                drawCp(cp);
            }
            
            
        }

        if (key == "ArrowUp"){ // up
            
            var rot = (cp["rot"] + 1)%4;
            
//            var p0 = pieces[cp["piece"]][rot][0];
//            var p1 = pieces[cp["piece"]][rot][1];
//            var p2 = pieces[cp["piece"]][rot][2];
//            var p3 = pieces[cp["piece"]][rot][3];
//            
//            if (!(p0[1] < 0 || p1[1] < 0 || p3[1] < 0 || p4[1] < 0)){
                cp["rot"] = (cp["rot"] + 1)%4;
            
                cp[0] = pieces[cp["piece"]][rot][0];
                cp[1] = pieces[cp["piece"]][rot][1];
                cp[2] = pieces[cp["piece"]][rot][2];
                cp[3] = pieces[cp["piece"]][rot][3];

                clear_board(ctx);
                drawBoard();
                drawCp(cp);
//            }
            
            

          

        }

        if (key == "ArrowRight"){ // right
            
            var canMove = true;
            for (var i = 0; i < 4; i++){
                if(cp[i][0] + cp["x"] + 1 > 9 || board[cp[i][1] + cp["y"]][cp[i][0] + cp["x"] + 1] != " "){
                    canMove = false;
                    break;
                }
            }

            if(canMove){
                cp["x"] ++;
                
                clear_board(ctx);
                drawBoard();
                drawCp(cp);
            }
        }

        if (key == "ArrowDown"){ // down
            
            var canMove = true;
            
            for (var i = 0; i < 4; i++){
                if (cp[i][1] + cp["y"] + 1 > 19 || board[cp[i][1] + cp["y"] + 1][cp[i][0] + cp["x"]] != " "){
                    canMove = false;
                    break;
                }
            }
            
            if (canMove){
                cp["y"] ++;

                clear_board(ctx);
                drawBoard();
                drawCp(cp);
            }

        }
        
        if (key == " "){
            
            
            var canMove = true;
            
            while (canMove){
                for (var i = 0; i < 4; i++){
                    if (cp[i][1] + cp["y"] + 1 > 19 || board[cp[i][1] + cp["y"] + 1][cp[i][0] + cp["x"]] != " "){
                        canMove = false;
                        break;
                    }
                }
                if (canMove){
                    cp["y"] ++;
                    score ++;
                }
            }

            
            updateGame(ctx, cp);
            
        }

    }

    
}

function keyUp(){
}

function detect_pause(){
    
    var pause_button = document.getElementById('pause');

    pause_button.onclick = function() {
        paused = !paused;
        console.log(paused);
    };
    
    
}

function tetris(){

    drawCp(cp);


    function fall_down(){
        
        console.log(1000 * (speeds[level-1]/60));
        
        if (!paused){
            

            if(!detectCollision(cp)){
                cp["y"] ++;
                clear_board(ctx);
                drawBoard();
                drawCp(cp);
            }
            else{

                addToBoard(cp);
                cp = next_piece;
                next_piece = random_piece();
                lineClear();

            }

            drawNextPiece(next_piece);
            
            if (levelIncreased){
                clearInterval(fall_down);
                setInterval(fall_down, 1000 * (speeds[level-1]/60));
                levelIncreased = false;
            }
        
        }
    
        
    }
    

    detect_pause();
    
    setInterval(fall_down, 1000 * (speeds[level-1]/60));
        
    

   
        
        

       
    
    
}






//////////////////// PLAY GAME////////////////////

function detect_play(){
    
    var play_button = document.getElementById('play-button');

    play_button.onclick = function() {
        
        play_button.innerHTML = "";
        
        playing_game = true;
        
        tetris();
    };
    
    
}
detect_play();

//////////////// PAUSE FUNCTION ///////////////////






//////////////////////////////////////////////////




