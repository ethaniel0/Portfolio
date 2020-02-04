



void speed_toggle(){
  
  strokeWeight(1);
  noFill();
  rect(200, 580, width - 400, 40);
  
}

void settings_buttons(){
 
  back_button();
  
}


void mousePressed(){
  
  if (on_render){
    
    int rectx = 250;
    int recty = 125;
    
    int x1 = width - 28 - rectx;
    int y1 = 28;
    
    int x2 = x1 + rectx;
    int y2 = y1 + recty;
    
    
    if (mousePressed && curve_made && mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2){
    
    make_obj = true;
   
    }
  }
  
  
  
}