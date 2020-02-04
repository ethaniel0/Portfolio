




int line = 1; // tells which line the user is typing on

int max_line = 1; // tells the furthest point of typing

String[][] lines = {}; // contains all the lines

String[] words = {}; // contains all words (separated by spaces)

String text = ""; // the text for each line

String blink = "|"; // the blinker

float[] cursor_placement = {36, 140};

int cursor_text_place = -1;

int num_ns = 0; // number of newline characters?


void blinker(){
  
  // count milliseconds
  int m = millis();
  
  int time = 1000; // how many millis to go one cycle of turning on and off
  
  // if the cursor is to be displayed, display it
  if (m % time > 0 && m % time < time / 2){
    
    text(text, 40, 100 + textAscent() + 5);
    text(blink, cursor_placement[0], cursor_placement[1]);
 
  }
  
  // if the cursor isn't displayed, only display the text
  else{
  text(text, 40, 100 + textAscent() + 5);
  
  }
  
  float lineheight = 100 + textAscent() + 5; // defines how high each line it
  
  // draw line numbers for each line
  for (int i = 1; i <= max_line; i++){
    textSize(20);
    text(i, 30 - textWidth(str(i)) - 2, lineheight);
    lineheight += down * 1.51;
    textSize(down);
    
  }
  
  // if there isn't enough room for another letter in the line, roll over to the next line
  if (textWidth(text + "m") > width - 20){
     text += "\n";
     cursor_placement[0] = 40;
     cursor_placement[1] += down * 1.51;
     cursor_text_place += 1;
     line ++;
     max_line ++;

  }

}

int find_ns(int beginning, int end){ // get the distance (in text characters) between the nearest \n
  
  int num = 0;
  
  for (int i = beginning; i < end; i++){
    
    if (text.charAt(i) != '\n'){
      num ++;
    }
    
    else{
      num = 0;
    }
  }
  
  return num;
  
}

String find_nstring(int beginning, int end){ // get the distance (in text characters) between the nearest \n
  
  String num = "";
  
  for (int i = beginning; i < end; i++){
    
    if (text.charAt(i) != '\n'){
      
      num += text.charAt(i);
    }
    
    else{
      num = "";
    }
  }
  
  return num;
  
}

boolean moved_one = false;

void keyPressed(){

  if (page == 2){
    rules();
  }
}

void cursors(){
  if (mouseX > 10 && mouseX < width - 10 && mouseY > 100 && mouseY < height - 10){
   cursor(TEXT); 
  }
  else{
    cursor(ARROW);
  }
  
}

void outline(){
  
  fill(255);
  rect(30, 100, width - 40, height - 110);
  
}

int[] wordPlaces = {};

void count_words(){
  
  if (text.length() > 7){
    
    for (int i = 0; i < text.length() - 7; i++){

      if ((text.substring(i, i+ 5).equals("setup"))){        
          
      } 
    }
  }
}

int down = ((width + height) / 2) / 40;


void compiler_button(){
  
  strokeWeight(5);
  fill(200, 200, 255);
  ellipse(scales(1100), scales(42), scales(62), scales(62));
  
  fill(255);
  triangle(scales(1090), scales(30), scales(1090), scales(54), scales(1115), scales(42)); 
  
  if (mousePressed && mouseX > scales(1100 - 31) && mouseX < scales(1100 + 31) && mouseY > scales(42 - 31) && mouseY < scales(42 + 31)){
    //println("hello");
    fill(0, 255, 0);
    triangle(scales(1090), scales(30), scales(1090), scales(54), scales(1115), scales(42)); 
      
    compiler();
    
    
  }
}



String top_text = "";


void editor(){
  int grey = 200;
  background(grey, grey, grey);
  
  fill(255);
  stroke(0);
  strokeWeight(5);
  rect(scales(20), scales(20), scales(100), scales(50), 10); // box xurrounding back arrow
  backArrow((int)scales(25), (int)scales(45), (int)scales(91), (int)scales(40)); // back arrow
  
  
  
  
  
  if (mousePressed && mouseX > scales(20) && mouseY > scales(20) &&  mouseX < scales(20 + 100) && mouseY < scales(20 + 50)){
   
    page = 1;
    
  }
  strokeWeight(1);
  
  outline();
  cursors();
  
  int size = ((width + height) / 2) / 40;
  down = size;
  textSize(size);
  fill(0);
  
  String[] clean = {};
  int[] cleans = {};
  words = clean;
  wordPlaces = cleans;
  
  count_words();
  blinker();
  
  for (String[] i : lines){
    println(i[0]);
    
  }
  
  compiler_button();
  fill(255, 0, 0);
  text(top_text, scales(300), scales(40));

  
}





//void test_code(){
  
//  //int screw_ups = 0;
  
//  String line = "";
  
//  for (int i = 0; i < text.length(); i++){
    
//    if (text.charAt(i) != '\n'){ // working

//      line += text.charAt(i);
       
//    }
    
//    else{


      
        
    
//    }
//  }
  
//}