

/////////////////////////////////////////////////////////////////////// DRAWPAD ///////////////////////////////////////////////////////////////////////
void redo_loop_b(){ // makes the canvas clear and drawable again
  
  int rectx = 250;
  int recty = 125;
  
  int x1 = 28;
  int y1 = 28;
  
  int x2 = x1 + rectx;
  int y2 = y1 + recty;
  
  strokeWeight(1);
  fill(255);
  rect(x1, y1, rectx, recty);
  
  fill(0);
  textSize(36);
  text("Redo Loop", ((rectx / 2) + x1) - (textWidth("Redo Loop") / 2), 100);
  
  
  if (mousePressed && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    curve_made = false;
    
    float[][] blank = {};
    things = blank;
    
    just_redone = true;
  
  }
  
  if ((!mousePressed) && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    fill(0, 0, 0, 100);
    rect(x1, y1, rectx, recty);
  
  }
  
  
}


void ready_for_topology_b(){ // tells the computer to start making the map
  
  int rectx = 250;
  int recty = 125;
  
  int x1 = width - 28 - rectx;
  int y1 = 28;
  
  int x2 = x1 + rectx;
  int y2 = y1 + recty;
  
  strokeWeight(1);
  fill(255);
  rect(x1, y1, rectx, recty);
  
  fill(0);
  textSize(36);
  text("Ready for Map", ((rectx / 2) + x1) - (textWidth("Ready for Map") / 2), 100);
  
  
  if (mousePressed && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    on_draw = false;
    on_render = true;
    on_settings = false;
   
  }
  
  if ((!mousePressed) && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    fill(0, 0, 0, 100);
    rect(x1, y1, rectx, recty);
  
  }
  
  
}


void to_settings(){
  
  int rectx = 250;
  int recty = 125;
  
  int x1 = 28;
  int y1 = 160;
  
  int x2 = x1 + rectx;
  int y2 = y1 + recty;
  
  strokeWeight(1);
  fill(255);
  rect(x1, y1, rectx, recty);
  
  fill(0);
  textSize(36);
  text("Settings", ((rectx / 2) + x1) - (textWidth("Settings") / 2), 234);
  
  
  if (mousePressed && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    on_draw = false;
    on_render = false;
    on_settings = true;
  
  }
  
  if ((!mousePressed)&& mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    fill(0, 0, 0, 100);
    rect(x1, y1, rectx, recty);
  
  }
}

////////////////////////////////////////////////////////////////////// SETTINGS //////////////////////////////////////////////////////////////////////


void back_button(){
  
  int rectx = 250;
  int recty = 125;
  
  int x1 = 28;
  int y1 = 28;
  
  int x2 = x1 + rectx;
  int y2 = y1 + recty;
  
  strokeWeight(1);
  fill(255);
  rect(x1, y1, rectx, recty);
  
  fill(0);
  textSize(36);
  text("<---", ((rectx / 2) + x1) - (textWidth("<---") / 2), 100);
  
  
  if (mousePressed && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    on_draw = true;
    on_render = false;
    on_settings = false;
  
  }
  
  if ((!mousePressed) && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    fill(0, 0, 0, 100);
    rect(x1, y1, rectx, recty);
  
  }
  
  
}


///////////////////////////////////////////////////////////////////// RENDERING /////////////////////////////////////////////////////////////////////

void obj_button(){
  
  rotateX(-rotx);
  rotateY(-roty);
  rotateZ(-rotz);
  
  int rectx = 250;
  int recty = 125;
  
  int x1 = width - 28 - rectx;
  int y1 = 28;
  
  int x2 = x1 + rectx;
  int y2 = y1 + recty;
  
  strokeWeight(1);
  fill(255);
  rect(x1, y1, rectx, recty);
  
  fill(0);
  textSize(36);
  text("Make OBJ File", ((rectx / 2) + x1) - (textWidth("Make OBJ File") / 2), 100);
  
  
  //if (mousePressed && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
  //  make_obj = true;
   
  //}
  
  if ((!mousePressed) && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    fill(0, 0, 0, 100);
    rect(x1, y1, rectx, recty);
  
  }
  
}