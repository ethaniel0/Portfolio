
 //icons

void icon(int type, float x, float y){

  if(type == 0){
    text("Mouse", x, y);
  }
  if(type == 1){
    text("Sele-\nctor", x, y);
  }
  if(type == 2){
    text("Pen", x, y);
  }
  if(type == 3){
    text("Eraser", x, y);
  }
  if(type == 4){
    text("T", x, y);
  }
  if(type == 5){
    text("Line", x, y);
  }
  if(type == 6){
    text("Oval", x, y);
  }
  if(type == 7){
    text("Rect", x, y);
  }
  if(type == 8){
    text("Poly-\nline", x, y);
  }
  if(type == 9){
    text("Paint\nBucket", x, y);
  }


}




// functions


void pen(){
  
  cursor(CROSS);
  
  if(mousePressed){
    if(!drawing){
      ((ArrayList)frames.get(current_frame)).add(new ArrayList()); // add a new arrayList for the line contains points
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add(new ArrayList()); // heading (contains type, thickness, color)
      
      // HEADING
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(2);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(line_thickness);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(new ArrayList(line_colour));
      
      drawing = true;
    }
    
    float canvas_wid = displayWidth/calc_zoom(zoom); // get the canvas width
    float canvas_hi = canvas_wid * (frameRatio[1]/frameRatio[0]);
    
    float x = canvas_x + canvas_scrollX - canvas_wid/2; // x without the -canvas_wid/2 is the center x of the canvas
    float y = canvas_y + canvas_scrollY - canvas_hi/2; // y without the -canvas_hi/2 is the canter y of the canvas
    
    // DATA
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseX is compared to the canvas
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseY-y) / canvas_hi); // send the proportion of where mouseY is compared to the canvas

    
  }
  else{
    drawing = false;
  }
  
}

void line_tool(){

  cursor(CROSS);
  
  float canvas_wid = displayWidth/calc_zoom(zoom); // get the canvas width
  float canvas_hi = canvas_wid * (frameRatio[1]/frameRatio[0]);
  
  float x = canvas_x + canvas_scrollX - canvas_wid/2; // x without the -canvas_wid/2 is the center x of the canvas
  float y = canvas_y + canvas_scrollY - canvas_hi/2; // y without the -canvas_hi/2 is the canter y of the canvas
    
    
  if(mousePressed){
  if(!drawing){
      ((ArrayList)frames.get(current_frame)).add(new ArrayList()); // add a new arrayList for the line contains points
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add(new ArrayList()); // heading (contains type, thickness, color)
      
      // HEADING
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(5);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(line_thickness);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(new ArrayList(line_colour));
      
      
      // DATA start, send where starting points are
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseX is compared to the canvas
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseY-y) / canvas_hi); // send the proportion of where mouseY is compared to the canvas
      
      // send where second points are
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseX is compared to the canvas
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseY-y) / canvas_hi); // send the proportion of where mouseY is compared to the canvas

      drawing = true;
    }
  
  
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).set(3, (mouseX-x) / canvas_wid);
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).set(4, (mouseY-y) / canvas_hi);
    
  }
  else{
   drawing = false; 
  }
  
}


void polyline(){
  cursor(CROSS);
  
}



void oval(){
  cursor(CROSS);
  
  float canvas_wid = displayWidth/calc_zoom(zoom); // get the canvas width
  float canvas_hi = canvas_wid * (frameRatio[1]/frameRatio[0]);
  
  float x = canvas_x + canvas_scrollX - canvas_wid/2; // x without the -canvas_wid/2 is the center x of the canvas
  float y = canvas_y + canvas_scrollY - canvas_hi/2; // y without the -canvas_hi/2 is the canter y of the canvas
    
    
  
  if(mousePressed){
    if(!drawing){
      ((ArrayList)frames.get(current_frame)).add(new ArrayList()); // add a new arrayList for the line contains points
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add(new ArrayList()); // heading (contains type, thickness, color)
      
      // HEADING
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(6);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(line_thickness);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(new ArrayList(line_colour));
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(new ArrayList(shape_fill));
      
      
      // DATA start, send where starting points are
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseX is compared to the canvas
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseY-y) / canvas_hi); // send the proportion of where mouseY is compared to the canvas
      
      // send width and height
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add(0); // send the proportion of where mouseX is compared to the canvas
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add(0); // send the proportion of where mouseY is compared to the canvas
    
    
      drawing = true;
    }
    
    float startX = (float)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(1); // get original x
    float startY = (float)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(2); // get original y
    
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).set(3, ((mouseX-x) / canvas_wid) - startX);
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).set(4, ((mouseY-y) / canvas_hi) - startY);
    
    
    
  }
  else{
    drawing = false;
  }
  
  
  
}

void rectangle(){
  cursor(CROSS);
  
  float canvas_wid = displayWidth/calc_zoom(zoom); // get the canvas width
  float canvas_hi = canvas_wid * (frameRatio[1]/frameRatio[0]);
  
  float x = canvas_x + canvas_scrollX - canvas_wid/2; // x without the -canvas_wid/2 is the center x of the canvas
  float y = canvas_y + canvas_scrollY - canvas_hi/2; // y without the -canvas_hi/2 is the canter y of the canvas
    
    
  
  if(mousePressed){
    if(!drawing){
      ((ArrayList)frames.get(current_frame)).add(new ArrayList()); // add a new arrayList for the line contains points
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add(new ArrayList()); // heading (contains type, thickness, color)
      
      // HEADING
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(7);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(line_thickness);
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(new ArrayList(line_colour));
      ((ArrayList)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(0)).add(new ArrayList(shape_fill));
      
      
      // DATA start, send where starting points are
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseX is compared to the canvas
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseY-y) / canvas_hi); // send the proportion of where mouseY is compared to the canvas
      
      // send width and height
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseX is compared to the canvas
      ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).add((mouseX-x) / canvas_wid); // send the proportion of where mouseY is compared to the canvas
    
    
      drawing = true;
    }
    
    float startX = (float)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(1); // get original x
    float startY = (float)((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).get(2); // get original y
    
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).set(3, ((mouseX-x) / canvas_wid) - startX);
    ((ArrayList)((ArrayList)frames.get(current_frame)).get(((ArrayList)frames.get(current_frame)).size()-1)).set(4, ((mouseY-y) / canvas_hi) - startY);
    
    
  }
  else{
    drawing = false;
  }
  
}

void text_tool(){
  cursor(TEXT);
  
};

void paint_bucket(){
  
  
}

void eraser(){
  
  
}

void selector(){
  
  
}


// tools: mouse, selector, pen, eraser, text, line, oval/circle, rectangle, polyline, paint bucket
void tools(int tool){

  // mouse
  if(tool == 0){
    
  }
  
  // selecter
  if(tool == 1){
    selector();
  }
  
  // pen
  if(tool == 2){ // done
    pen();
  }
  
  // eraser
  if(tool == 3){
    eraser();
  }
  
  // text
  if(tool == 4){
    text_tool();
  }
  
  // line
  if(tool == 5){ // done
    line_tool();
  }
  
  // oval
  if(tool == 6){ // done
    oval();
  }
  
  // rectangle
  if(tool == 7){ // done
    rectangle();
  }
  
  // polyline
  if(tool == 8){
    polyline();
  }
  
  // paint bucket
  if(tool == 9){
    paint_bucket();
  }
  
}