
float[][] append(float[][] a, float[][] b) {
    float[][] result = new float[a.length + b.length][];
    System.arraycopy(a, 0, result, 0, a.length);
    System.arraycopy(b, 0, result, a.length, b.length);
    return result;
}

// gives back 3/4 of the display height
int roundDown(int num){
  
  int goby = displayHeight / 4;
  
  // if the height/4 is an int, return the int
  if (num % goby == 0){
    return num - goby; 
  }
  
  // else, round it
  else{
    
    int goDownBy = num - goby;
    int realGoDownBy = (int) abs(goDownBy);
    
    return num - realGoDownBy;
    
  }

}

PImage code_symbol;
PImage arduino_cartoon;
PImage arduino_pic;
PImage breadboard; 
PImage sua_bac; 

void setup(){
  code_symbol = loadImage("Code_symbol.png");
  arduino_cartoon = loadImage("arduino_cartoon.png");
  arduino_pic = loadImage("arduino_pic.png");
  breadboard = loadImage("breadboard_cartoon.png");
  sua_bac = loadImage("ard_sim_bac.tif");
  
  
}


void settings(){
  
  int square_window = roundDown(displayHeight);
  
  size(square_window, square_window);
  
}


/*
page 1 = cover page
page 2 = code
page 3 = set up arduino
page 4 = simulate arduino

*/

// returns the lize of things scaled to the original size of the window
float scales(float num){
  return height / (1200 / num);
}

int page = 1;

int[] led_color = {255, 0, 0};

void coverPage(){
  background(245, 245, 220);
  
  // title text
  textSize(150);
  text("Arduino Simulator", scales(75), scales(130)); // title of the page
  
  noStroke();
  
  int build_bheight = height / 2;
  
  fill(20, 155, 60);
  
  // code button
  rect(scales(55), scales(600), scales(394), scales(166)); // button to build code
  
  fill(0, 0, 100);
  textSize(height / 10);
  text("code", scales(115), scales(build_bheight - 30)); // text in button to set up code
  
  // image of the code symbol
  image(code_symbol, scales(102), scales(830), scales(300), scales(300)); // image of code symbol
   
  fill(0, 0, 100);
  rect(scales(693), scales(600), scales(394), scales(166)); // button to set up the arduino
  
  // set up arduino
  fill(20, 155, 60);
  textSize(height / (1500 / 65.5));
  text("Set Up Arduino", scales(700), scales(705)); // text in button to set up arduino
  
  // arduino picture
  image(arduino_cartoon, scales(692), scales(830), scales(400), scales(300));
 
  // text editor
  if (mousePressed && mouseX > scales(55) && mouseX < scales(55 + 394) && mouseY < scales(build_bheight) && mouseY > scales(build_bheight - 155)){
    
    page = 2;

  }
  
  // simulator
  if (mousePressed && mouseX > scales(693) && mouseX < scales(693 + 394) && mouseY < scales(build_bheight) && mouseY > scales(build_bheight - 155)){
    
    page = 3;
 
  }
  
}


void mouseReleased(){
  
  if (adding){
      
    adding = false;
     
    if (left){
      float[][] add = {{where_wires_at[0], where_wires_at[1], snaps[0], snaps[1], modchoice, 1, wire_curve}}; // x1, y1, x2, y2, wire/led, left/right (for wire), wire curve (for wire)
      being_used = append(being_used, add);
      
    }
    
    if (!left){
      float[][] add = {{where_wires_at[0], where_wires_at[1], snaps[0], snaps[1], modchoice, 0, wire_curve}};
      being_used = append(being_used, add);
      
    }
    
    left = true;
    wire_curve = 6;

  }
  
}


int frame = 0;

void set_up_arduino(){
  
  // arduino simulator background
  image(sua_bac, 0, 0, width, height);
  
  fill(255);
  stroke(0);
  rect(scales(20), scales(20), scales(100), scales(50), 10); // box xurrounding back arrow
  strokeWeight(5);
  backArrow((int)scales(25), (int)scales(45), (int)scales(91), (int)scales(40)); // back arrow


  set_up_wires();
  
  for (float[] i : being_used){
    
    if (i[0] > 1 && i[1] > 1){
      if (i[i.length - 3] == 1){ // it it's a wire
        
        jump_wire(i[0], i[1], i[2], i[3], i[i.length - 2], i[i.length - 1]);
      }
      
      if (i[i.length - 3] == 2){ // if its an led
      
        LED(i[0], i[1], i[2], i[3]);
      
      }
     
    }

  }
  
  // tab that gives the user the option to choose wire/LED
  things_tab();
  
  // if the user clicks the backbutton, go to the first page
  if (mousePressed && mouseX > scales(20) && mouseY > scales(20) &&  mouseX < scales(20 + 100) && mouseY < scales(20 + 50)){
    page = 1;
  }
  
}

void draw(){
  
  // main page
  if (page == 1){
    coverPage();
  }
  
  // text editor
  if (page == 2){
   editor();  
  }
  
  // arduino editor
  if (page == 3){
    set_up_arduino();
    open_ttab();
  }

  println(arduino_holes_being_used);
  
  
}