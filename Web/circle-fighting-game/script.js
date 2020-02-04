window.addEventListener("keydown", keyDown);
window.addEventListener("keyup", keyUp);



var canvas = document.getElementById("canvas");

if (window.innerWidth < window.innerHeight){
     document.getElementById("css").setAttribute("href", "style1.css");
}
else{
 document.getElementById("css").setAttribute("href", "style2.css");
}

var c = canvas.getContext("2d");
//
//
 window.addEventListener("resize", ()=>{
    if (window.innerWidth < window.innerHeight){
     document.getElementById("css").setAttribute("href", "style1.css");
    }
    else{
     document.getElementById("css").setAttribute("href", "style2.css");
    }

   });


canvas.addEventListener("mousedown", mouseDown);
canvas.addEventListener("mouseup", mouseUp);

var mousePressed = false;
var mouseX = 0;
var mouseY = 0;

function mouseDown(){
    var rect = canvas.getBoundingClientRect();
        
    mousePressed = true;
    mouseX = Math.round(event.clientX * (canvas.width/ rect.width));
    mouseY = Math.round(event.clientY * (canvas.height/ rect.height));
    
}
function mouseUp(){
    mousePressed =false;
    
}

//////////// GAME //////////// 

function circleCoords(x, y, angle, radius){

  var x_coord = Math.round(Math.cos(angle)*radius + x);
  var y_coord = Math.round(Math.sin(angle)*radius + y);

  return ([x_coord, y_coord]);

}

//c.translate(canvas.width / 2, canvas.height / 2);

var img = new Image();
img.src = "pictures/shooter.png";
img.onload = function () {};

var b1 = new Image();
b1.src = "pictures/burst1.png";
b1.onload = function () {};

var b2 = new Image();
b2.src = "pictures/burst2.png";
b2.onload = function () {};


var b3 = new Image();
b3.src = "pictures/burst3.png";
b3.onload = function () {};

var b4 = new Image();
b4.src = "pictures/burst4.png";
b4.onload = function () {};

var coin = new Image();
coin.src = "pictures/coin.png";
coin.onload = function () {};

var faster_shooting = new Image();
faster_shooting.src = "pictures/faster_shooting.png";
faster_shooting.onload = function () {};

var viewfinder = new Image();
viewfinder.src = "pictures/viewfinder.png";
viewfinder.onload = function () {};

var strongerBullets = new Image();
strongerBullets.src = "pictures/stronger_bullets.png";
strongerBullets.onload = function () {};

var moreMoney = new Image();
moreMoney.src = "pictures/moreMoney.png";
moreMoney.onload = function () {};

var upgrades = {      // name            value  image           level
    faster_shooting: ["Faster Shooting",   50, faster_shooting, 1],
    viewfinder: ["Viewfinder", 100, viewfinder, 1],
    bulletsThroughEnemies: ["Stronger Bullets", 100, strongerBullets, 1],
    moreCoins: ["More Coins", 150, moreMoney, 1]
}


var highscore = 0;
var mostKills = 0;

var lastScore = 0;
var lastKills = 0;

var pointsEarned = 0;

var playing = false;
//               right, left, space
var keysDown = [false, false, false];

              
var backgroundCircles = []

var DefaultGameVars = {
    bulletThreshhold: 20,
    gameover: false,
    bullets: [],
    enemies: [],
    amo: [0, 2, 4],
    shootSpeed: 25,
    rotateAngle: 0.01,
    rotateSpeed: Math.PI/20,
    enemySpawnSpeed: 600,
    enemyRotateSpeed: Math.PI/360,
    kills: 0,
    level: 1,
    nextLevelUp: 10,
    
    points: 0,
    
    numToBurst: 50,
    burst: false,
    numFromLastBurst: 0,
    burstNum: 0, // frame of the yellow animation
    burstFrameCounter: 0, // for the yellow animation
    
    
    viewfinder: 0,
    bulletStrength: 1,
    coinMiltiplier: 1
};

function installUpgrade(upg){
    if (upg == 0){ // faster shooting
        if (DefaultGameVars.bulletThreshhold > 2){
            DefaultGameVars.bulletThreshhold --;
            
            pointsEarned -= upgrades.faster_shooting[1];
            
            upgrades.faster_shooting[1] += 50;
            upgrades.faster_shooting[3] ++;
            
        }
        else if (DefaultGameVars.bulletThreshhold == 2){
            DefaultGameVars.bulletThreshhold --;
            upgrades.faster_shooting[1] = "NA";
        }

    }
    
    if (upg == 1){ // viewfinder
        pointsEarned -= upgrades.viewfinder[1];
        DefaultGameVars.viewfinder = 1;
        upgrades.viewfinder[1] += 100;
        upgrades.viewfinder[3] ++;
    }
    
    if (upg == 2){ // stronger bullets
        DefaultGameVars.bulletStrength ++;
        pointsEarned -= upgrades.bulletsThroughEnemies[1];
        upgrades.bulletsThroughEnemies[1] += 50;
        upgrades.bulletsThroughEnemies[3] ++;
    }
    
    if (upg == 3){ // more money
        DefaultGameVars.coinMultiplier *= 1.5;
        
        pointsEarned -= upgrades.bulletsThroughEnemies[1];
        upgrades.coinMultiplier[1] = Math.round(upgrades.viewfinder[1]*1.5);
        upgrades.coinMultiplier[3] ++;
    }
}

var gameVars = JSON.parse(JSON.stringify(DefaultGameVars));

function keyUp(){

  var key = event.key;

  if (key == "ArrowRight"){
    keysDown[0] = false;
  }
  if (key == "ArrowLeft"){
    keysDown[1] = false;
  }
  if (key == " "){
    keysDown[2] = false;
  }
    
if (key == "b"){keysDown[3] = false;}

}

function gamePart(){
    
    function levelUp(){
        gameVars.level ++;
        gameVars.enemySpawnSpeed *= 0.7;
        gameVars.enemyRotateSpeed *= 1.1;
    }

    function showShooter(){
        
        

        c.rotate(gameVars.rotateAngle);

        
        if (gameVars.viewfinder == 1){
          c.beginPath();
          c.moveTo(0, 0); 
          c.lineTo(0, -canvas.height * 1.5);
          c.strokeStyle = "red";
          c.stroke();
            c.strokeStyle = "black";
      }

      if (!gameVars.burst){
        c.drawImage(img, - 25, - 41, 50, 66);
      }
      else{
         gameVars. burstFrameCounter ++;
          if (gameVars.burstNum == 1){
              c.drawImage(b1, - 25, - 41, 50, 66); 
              if (gameVars.burstFrameCounter == 20){
                gameVars.burstNum ++;
              }
          }
          if (gameVars.burstNum == 2){
              c.drawImage(b2, - 25, - 41, 50, 66); 
              if (gameVars.burstFrameCounter == 40){
                gameVars.burstNum ++;
              }
          }
          if (gameVars.burstNum == 3){
              c.drawImage(b3, - 25, - 41, 50, 66); 
              if (gameVars.burstFrameCounter == 60){
                gameVars.burstNum ++;
              }
          }
          if (gameVars.burstNum == 4){
              c.drawImage(b4, - 25, - 41, 50, 66); 
              if (gameVars.burstFrameCounter == 80){
                  gameVars.burstNum = 1;
                  gameVars.burstFrameCounter = 0;
              }
          }
          
      }
        
      



      c.rotate(-gameVars.rotateAngle);

      if (keysDown[0]){
        gameVars.rotateAngle = (gameVars.rotateAngle + gameVars.rotateSpeed) % (2*Math.PI);
      }

      if (keysDown[1]){
        gameVars.rotateAngle = (gameVars.rotateAngle - gameVars.rotateSpeed) % (2*Math.PI);
      }

    }

    function drawAmo(){

      for (var i = 0; i < gameVars.amo.length; i++){
        c.beginPath();
        var xy = circleCoords(0, 0, gameVars.amo[i], 60);
        c.arc(xy[0] , xy[1], 5, 0, Math.PI * 2, false);
        gameVars.amo[i] = (gameVars.amo[i]+0.1) % (Math.PI * 2);

        c.fillStyle = "black";
        c.fill();
        c.stroke();

      }



    }
    
    function showEnemiesKilled(){
        
        
        c.font = "30px Arial";
        
        var message = gameVars.kills + "  ";
        var messageLen = c.measureText(message).width;
        
        
        // draw white background       
        c.beginPath();
        c.rect(canvas.width/2 - messageLen - 50, -canvas.height/2, messageLen + 50, 40);
        c.fillStyle = "white";
        c.fill();
        c.stroke();
                         
        
        c.beginPath();
            
        c.arc(canvas.width/2-messageLen - 30, -canvas.height/2 + 20, 15, 0, 2*Math.PI, false);
        c.fillStyle = "blue";
        c.fill();       
        c.stroke();
        
        c.fillStyle = "black";
        c.fillText(message, canvas.width/2 - messageLen - 5, -canvas.height/2 + 30);          
                  
        
            
        
        
    }
    
    setTimeout(makeEnemies, gameVars.enemySpawnSpeed);
    function makeEnemies(){

      //              angle                         size                                 radius  
      gameVars.enemies.push([Math.random() * 2 * Math.PI, Math.round(Math.random() * 5 + 10), Math.round(canvas.width / 2)]);

        if (playing){
            setTimeout(makeEnemies, gameVars.enemySpawnSpeed);
        }
    }
    function drawEnemies(){


      for (var i = 0; i < gameVars.enemies.length; i++){

        c.beginPath();

        var xy = circleCoords(0, 0, gameVars.enemies[i][0], gameVars.enemies[i][2]);
        c.arc(xy[0] , xy[1], gameVars.enemies[i][1], 0, Math.PI * 2, false);


        c.fillStyle = "blue";
        c.fill();
        c.stroke();

        if (gameVars.enemies[i][2] - gameVars.enemies[i][1] <= 23){
            gameVars.gameover = true;
        }

        gameVars.enemies[i][2] -= 0.5;
        gameVars.enemies[i][0] = (gameVars.enemies[i][0] + gameVars.enemyRotateSpeed) % (2*Math.PI);

        for (var j = gameVars.bullets.length - 1; j >= 0; j--){
            var x = gameVars.bullets[j][0] * gameVars.bullets[j][2];
            var y = gameVars.bullets[j][1] * gameVars.bullets[j][2]


            if(x + 5 >= xy[0]-gameVars.enemies[i][1] && x-5 <= xy[0]+gameVars.enemies[i][1] && y+5 >= xy[1]-gameVars.enemies[i][1] && y-5 <= xy[1]+gameVars.enemies[i][1]){
                
                    gameVars.enemies.splice(i, 1);
                    if (gameVars.bullets[j][3] == 1){
                        gameVars.bullets.splice(j, 1);
                    }
                    else{
                        gameVars.bullets[j][3] --;
                    }
                    gameVars.kills ++;
                    gameVars.points += gameVars.coinMiltiplier / gameVars.level;
                    gameVars.numFromLastBurst ++;
                if (gameVars.kills % gameVars.nextLevelUp == 0){
                    levelUp();
                    gameVars.nextLevelUp = Math.round(gameVars.nextLevelUp);
                }
                if (gameVars.numFromLastBurst % gameVars.numToBurst == 0){
                    gameVars.burst = true;
                    gameVars.burstNum = 1;
                }

            }

        }

          
      }

    }
    function shoot(){

        if (keysDown[2]){

            if (gameVars.bullets.length == 0 || gameVars.bullets[gameVars.bullets.length - 1][2] > gameVars.bulletThreshhold){
                var horizX = Math.round(Math.cos(gameVars.rotateAngle - Math.PI/2) * gameVars.shootSpeed);
                var vertX = Math.round(Math.sin(gameVars.rotateAngle - Math.PI/2) * gameVars.shootSpeed);
        
          //                           dx     dy   len   bullet strength
                gameVars.bullets.push([horizX, vertX, 0, gameVars.bulletStrength + 0]);
        }

      }
        
    if (gameVars.burst && keysDown[3]){
        
        for (var i = 0; i < 2*Math.PI; i += Math.PI / 12){
            gameVars.bullets.push([Math.cos(i), Math.sin(i), 0, gameVars.bulletStrength + 0]);
            
        }
        
        gameVars.numToBurst *= 2;
        gameVars.numFromLastBurst = 0;
        
        
        gameVars.burst = false;

    }   

      for (var i = 0; i < gameVars.bullets.length; i++){

        c.beginPath();
        c.arc(gameVars.bullets[i][0] * gameVars.bullets[i][2], gameVars.bullets[i][1] * gameVars.bullets[i][2], 5, 0, 7, false);

        c.fillStyle = "black";
        c.fill();
        c.stroke();

        gameVars.bullets[i][2] += 1;

        if (gameVars.bullets[i][2] * gameVars.bullets[i][0] > canvas.width || gameVars.bullets[i][2] * gameVars.bullets[i][0] < -canvas.width || gameVars.bullets[i][2] * gameVars.bullets[i][1] > canvas.height || gameVars.bullets[i][2] * gameVars.bullets[i][1] < -canvas.height){
          gameVars.bullets.splice(i, 1);
        }

        for (var j = 0; j < gameVars.enemies.length; j++){
          var xy = circleCoords(0, 0, gameVars.enemies[j][0], gameVars.enemies[j][2]);
          var rad = gameVars.enemies[j][2];

        }

      }




    }
    function gameOver(){
        playing = false;
        if (gameVars.level > highscore){
            highscore = gameVars.level;
            mostKills = gameVars.kills;
        }
        lastScore = gameVars.level;
        lastKills = gameVars.kills;
        
        pointsEarned += Math.round(gameVars.points);
        
//        gameVars.enemies = [];
        
        gameVars = JSON.parse(JSON.stringify(DefaultGameVars));
        gameVars.enemies = [];
//        console.log(gameVars);
        
        c.translate(-canvas.width/2, -canvas.height/2);
        
        titleScreenUpdate = setInterval(titleScreen, 1000/60);

    }

    updateInterval = setInterval(update, 1000/60);
    function update(){
        
        c.clearRect(-canvas.width, -canvas.height, 2*canvas.width, 2*canvas.height);

        c.font = "30px Arial";
        c.fillStyle = "black";
        c.fillText("Level " + gameVars.level, -canvas.width/2 + 30, -canvas.height/2 + 30);

        c.fillText(Math.round(gameVars.points), -c.measureText(Math.round(gameVars.points)).width/2, -canvas.height/2 + 30);
        
        shoot();

        drawAmo();
        
        showShooter();

        drawEnemies();
        
        showEnemiesKilled();

        if (gameVars.gameover){
            clearInterval(updateInterval);
            gameOver();
        }
    }
    
}

function keyDown(){

    var key = event.key;
    
    if (event.keyCode == 13){
        playing = true;
            clearInterval(titleScreenUpdate);
            c.translate(canvas.width / 2, canvas.height / 2);
            gamePart();
    }

    if (key == "ArrowRight"){keysDown[0] = true;}
    if (key == "ArrowLeft"){keysDown[1] = true;}
    if (key == " "){keysDown[2] = true;}
    
    if(gameVars.gameover && key == "r"){
//        console.log("restart");
        c.clearRect(-canvas.width, -canvas.height, 2*canvas.width, 2*canvas.height);
        gameVars.gameover = false;
        
        document.getElementById("gameOverText").innerHTML = '';
        gameVars.enemySpawnSpeed = 1000;
        gameVars.enemyRotateSpeed = Math.PI / 360;
        gameVars.level = 1;
        gameVars.enemies = [];
        gameVars.bullets = [];
        
        gamePart();
    }
    
    if (key == "b"){keysDown[3] = true;}
    
}

//////////// TITLE SCREEN //////////// 


function help_screen(){
}

var TSVs = { // title screen vars
    playButtonHeight: 450,
    enemies: [],
    powerups: { // the levels/specifications for each powerup, not how much each costs
        shootSpeed: 1,
        spray: 1,
        burst: 50,
        
    }
};

function backgroundAnimation(){
    
    if (TSVs.enemies.length < 8){
        if(Math.random() < 0.03){
            var angle = Math.random() * 2 * Math.PI;
            TSVs.enemies.push([angle, Math.cos(angle), Math.sin(angle), canvas.width*1.1]);
        }
    }
    
//    console.log(TSVs.enemies);
    for (var i = TSVs.enemies.length-1; i >= 0; i--){
        
        c.beginPath();
        c.arc(TSVs.enemies[i][1] * TSVs.enemies[i][3] + canvas.width/2, TSVs.enemies[i][2] * TSVs.enemies[i][3] + canvas.height/2, 15, 0, 2*Math.PI, true);
        c.fillStyle = "blue";
        c.fill();
        
        TSVs.enemies[i][3] -= 5;
        
        if (TSVs.enemies[i][3] < 0 && (TSVs.enemies[i][1] * TSVs.enemies[i][3] + canvas.width/2 < -15 || TSVs.enemies[i][1] * TSVs.enemies[i][3] + canvas.width/2 > canvas.width + 15 || TSVs.enemies[i][2] * TSVs.enemies[i][3] + canvas.width/2 < -15 || TSVs.enemies[i][2] * TSVs.enemies[i][3] + canvas.width/2 > canvas.width + 15)){
            TSVs.enemies.splice(i, 1);
        }
    
    }
    
    
    
}

var wasPressed = false;
function titleScreen(){
    
    if (!mousePressed){
        wasPressed = false;
    }
    
    function showScores(){
        c.font = "30px Arial";
        c.fillStyle = "black";
        c.fillText("High Score: Level " + highscore , 30, 250);
        c.fillText("                    " + mostKills + " Kills", 30, 290);

        c.fillText("Last Score: Level " + lastScore , canvas.width - c.measureText("Last Score: Level " + lastScore).width - 20, 250);

        c.fillText("                    " + lastKills + " Kills", canvas.width - c.measureText("                    " + lastKills + " Kills").width - 20, 290);
    
    }
    
    function playButton(){
         c.font = "50px Arial";
        c.fillStyle = "black";
        var PlayTextx = (canvas.width - c.measureText("Play").width)/2;
        c.fillText("Play", PlayTextx, TSVs.playButtonHeight);

        if (mousePressed && mouseX >= PlayTextx && mouseX <= PlayTextx + c.measureText("Play").width && mouseY <= TSVs.playButtonHeight && mouseY >= TSVs.playButtonHeight-46){
            playing = true;
            gameVars = JSON.parse(JSON.stringify(DefaultGameVars));
            gameVars.enemies = [];
            clearInterval(titleScreenUpdate);
            c.translate(canvas.width / 2, canvas.height / 2);
            gamePart();
        }
    
        
    }
    
    function card(x, y, wid, hi, text, value, image){
        c.beginPath();
        c.rect(x, y, wid, hi);
        c.fillStyle = "yellow";
        c.fill();
        c.stroke();
        
        c.font = wid/8 + "px Arial";
        c.fillStyle = "black";
        c.fillText(text, x + wid/2 - c.measureText(text).width/2, y + hi/6);
        
        c.fillText("$"+value, x + wid/2 - c.measureText("$"+value).width/2, y + hi - hi/6);
        
        c.drawImage(image, x + wid/2 - (wid*3/4.5)/2, y + hi/2 - (wid)/2, wid * 3/4.5, wid*3/4.5 * image.height/image.width);
        
//        c.drawImage(image, x, y, 50, 50);
//        c.drawImage(image, x, y);
        
        
        

    }  
    
    function store(){
        
        var i = 0;
        for (var key in upgrades){
            
            card(i*150  + canvas.width/5 - 150/4, 500, 150, 300, upgrades[key][0], upgrades[key][1], upgrades[key][2]);
            
            if ((!wasPressed) && mousePressed && mouseX > i*150  + canvas.width/5 - 150/4 && mouseX < i*150  + canvas.width/5 - 150/4 + 150 && mouseY > 500 && mouseY < 800){
                if (pointsEarned >= upgrades[key][1]){
                    installUpgrade(i);
                    wasPressed = true;
                
                }
            }
            
            i++;
        }
        
        
        
      
        
    }

    c.clearRect(0, 0, canvas.width, canvas.height);
    
    backgroundAnimation();
    
        
    c.drawImage(coin, 20, 150, 50, 50); 
    
    c.font = "100px Arial";
    c.fillStyle = "black";
    c.fillText("Circle Shooter", (canvas.width - c.measureText("Circle Shooter").width)/2, 100);
    
    c.font = "30px Arial";
    c.fillText(pointsEarned, 80, 185);
    
    playButton();
    
    showScores();
    
    
    
    // STORE
        // viewfinder: 100 coins for straight, 800 for curved
        // faster shooting: possible until bulet threshhold = 1, 50 * (num upgrades) coins for each
        // bullets that can shoot through multiple enemies, 100 * (num upgrades) coins for each
        // drop upgrades -- upgrades that are like enemies but a different color, drop in with enemies, shoot them to use them and they don't kill you if they hit you
            // time freeze or slow down
            // bullet threshhold of 0
            // more coins per enemy
            // bigger bullets
    
    store();
    
    
    
    

    
}


titleScreenUpdate = setInterval(titleScreen, 1000/60);















































