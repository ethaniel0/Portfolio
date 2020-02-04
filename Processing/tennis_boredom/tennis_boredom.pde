
//      red                  blue
int[] player1 = new int[2], player2 = new int[2], score = {0, 0}, games = {0, 0};
float[] prAgs = new float[2], ball = new float[4];

int out = 60, angWid = 100, serviceLine = 400, playerSize = 60, moveBall = 10, moveby = 10, ballWid = 30;

float angBy = 0.1;

boolean serving = true, playing = false, playerToHit = false;


int[] keys = {87, 83, 65, 68, 86, 67, 38, 40, 37, 39, 44, 46};

int[] scoring = {0, 15, 30, 40, 60};


boolean[] keysPressed = {
  false, // w
  false, // s
  false, // a
  false, // d
  false, // v
  false, // c
  
  false, // up
  false, // down
  false, // left
  false, // right
  false, // ,
  false, // .
};

void setup(){
  
  size(2000, 1000);
  
  player1[0] = playerSize;
  player1[1] = height/4;
  
  player2[0] = width-playerSize;
  player2[1] = 3*height/4;
  
  prAgs[0] = 0;
  prAgs[1] = (float)Math.PI;
  
}

void bkg(){
  fill(40, 255, 130);
  rect(out, out, width/2-out, height-2*out);
  rect(width/2, out, width/2-out, height-2*out);
  
  strokeWeight(10);
  stroke(255);
  line(width/2, out, width/2, height-out);
  
  strokeWeight(2);
  line(out, height/2, width-out, height/2);
  line(width/2 - serviceLine, out, width/2 - serviceLine, height-out);
  line(width/2 + serviceLine, out, width/2 + serviceLine, height-out);
 
  strokeWeight(1);
  stroke(0);
  
  frameRate(100);
  
}

void drawPlayers(){ // player1: wasd + qe, player2: arrow keys + shift/slash
  
  fill(0);
  line(player1[0], player1[1], cos(prAgs[0])*angWid + player1[0], sin(prAgs[0])*angWid + player1[1]);
  fill(255, 0, 0);
  ellipse(player1[0], player1[1], playerSize, playerSize);
  
  fill(0);
  line(player2[0], player2[1], cos(prAgs[1])*angWid + player2[0], sin(prAgs[1])*angWid + player2[1]);
  fill(0, 0, 255);
  ellipse(player2[0], player2[1], playerSize, playerSize);

}

void keyPressed(){
  for (int i = 0; i < 12; i++){
    if (keyCode == keys[i]){ keysPressed[i] = true; }
  }
}

void movePlayers(){
  
  if(player1[1] > playerSize/2 && keysPressed[0]) player1[1] -= moveby; // up
  if(player1[1] < height-playerSize/2 && keysPressed[1]) player1[1] += moveby; // down
  if(player1[0] > playerSize/2 && keysPressed[2]) player1[0] -= moveby; // left
  if(player1[0] < width/2-playerSize/2 && keysPressed[3]) player1[0] += moveby; // right
  
  if(player2[1] > playerSize/2 && keysPressed[6]) player2[1] -= moveby; // up
  if(player2[1] < height-playerSize/2 && keysPressed[7]) player2[1] += moveby; // down
  if(player2[0] > width/2 + playerSize/2 && keysPressed[8]) player2[0] -= moveby; // left 
  if(player2[0] < width-playerSize/2 && keysPressed[9])player2[0] += moveby; // right
  
  if(keysPressed[4] && prAgs[0] < Math.PI/2) prAgs[0] += angBy;
  if(keysPressed[5] && prAgs[0] > -Math.PI/2) prAgs[0] -= angBy;
  
  if(keysPressed[10] && prAgs[1] > Math.PI/2) prAgs[1] -= angBy;
  if(keysPressed[11] && prAgs[1] < 3*Math.PI/2) prAgs[1] += angBy;
  
}

void keyReleased(){
  for (int i = 0; i < 12; i++){
    if (keyCode == keys[i]){
      keysPressed[i] = false;
    }
  }
}

void showBall(){
  
  fill(255, 255, 0);
  ellipse(ball[0], ball[1], ballWid, ballWid);
  
  ball[0] += ball[2];
  ball[1] += ball[3];
  
  
  if (ball[0] > width || ball[0] < 0 || ball[1] < 0 || ball[1] > height){
    playing = false;
    playerToHit = !serving;
    if (ball[0] < width/2){
      score[1] ++;
    }else{
      score[0] ++;
    }
    
    if(score[0] == 4){
      score[0] = 0;
      score[1] = 0;
      games[0] ++;
      serving = !serving;
    }
    if(score[1] == 4){
      score[0] = 0;
      score[1] = 0;
      games[1] ++;
      serving = !serving;
    }
    
    
  }
  
  // player1
  if (playerToHit){
    if (sqrt(pow(ball[0] - player1[0], 2) + pow(ball[1] - player1[1], 2)) <= playerSize/2 + ballWid/2){
      ball[2] = cos(prAgs[0]) * moveBall;
      ball[3] = sin(prAgs[0]) * moveBall;
      playerToHit = !playerToHit;
    }
  }
  // player2
  else{
    if (sqrt(pow(ball[0] - player2[0], 2) + pow(ball[1] - player2[1], 2)) <= playerSize/2 + ballWid/2){
      ball[2] = cos(prAgs[1]) * moveBall;
      ball[3] = sin(prAgs[1]) * moveBall;
      playerToHit = !playerToHit;
    }
  }
  
}

void play(){
  
  if(!playing){
    
    if(keyPressed && key == ' '){
      if(serving){
        ball[0] = player1[0];
        ball[1] = player1[1];
        ball[2] = cos(prAgs[0]) * moveBall;
        ball[3] = sin(prAgs[0]) * moveBall;
        playing = true;
      }
      else{
        ball[0] = player2[0];
        ball[1] = player2[1];
        ball[2] = cos(prAgs[1]) * moveBall;
        ball[3] = sin(prAgs[1]) * moveBall;
        playing = true;
      }
    }
    
  }
  
  else{
    showBall();
  }
 
}

void draw(){
  background(200);
  bkg();
  movePlayers();
  drawPlayers();
  play();
  
  fill(0);
  textSize(72);
  textAlign(CENTER);
  text(scoring[score[0]] + ":" + scoring[score[1]], width/2, out-3);
  
  textAlign(LEFT);
  
  text(games[0], 10, out);
  text(games[1], width - 10 - textWidth(games[1]+""), out);

}