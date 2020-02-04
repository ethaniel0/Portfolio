




void custom_zoom(){
  
  // used to initialize the placement of the custom zoom box
  if(custom_zoom_coords[0] < 0){
    custom_zoom_coords[0] = width/2;
  }
  if(custom_zoom_coords[1] - displayHeight/40< 0){
    custom_zoom_coords[1] = height/2;
  }
  

  
  float x = custom_zoom_coords[0];
  float y = custom_zoom_coords[1];
  float wid = displayWidth/8;
  float hi = displayHeight/10;
  
  rectMode(CENTER);
  
  fill(200);
  rect(x, y, wid, hi);
  
  line(x - wid/2, y - hi/4, x + wid/2, y - hi/4);
  
  rectMode(CORNER);
  
  // top part
  fill(255, 0, 0);
  rect(x+wid/2, y-hi/2, -hi/4, hi/4);
  fill(0);
  textSize(scaledH(45));
  text("X", x+wid/2 - hi/8.5, y-hi/2 + hi/9);
  
  ///////////////////////////////////////////////////////////// WINDOW DRAGGING /////////////////////////////////////////////////////////////
  // if user wants to drag the window, set it to do so
  if(mousePressed && mouseX > x-wid/2 && mouseX < x+wid/2 && mouseY > y-hi/2&& mouseY < y-hi/4){
    custom_zoom_drag = true;
    
    custom_zoom_latch_coords[0] = mouseX;
    custom_zoom_latch_coords[1] = mouseY;
  }
  
  if(mouseX > x-wid/2 && mouseX < x+wid/2 && mouseY > y-hi/2&& mouseY < y+hi/2){
   use_tools = false; 
  }
  
  // if the window is being dragged
  if(custom_zoom_drag){
    
    custom_zoom_coords[0] += mouseX - custom_zoom_latch_coords[0];
    custom_zoom_coords[1] += mouseY - custom_zoom_latch_coords[1];
      
    custom_zoom_latch_coords[0] = mouseX;
    custom_zoom_latch_coords[1] = mouseY;
  }
  
  // stop dragging the window if the mouse isn't pressed
  if(!mousePressed){
    custom_zoom_drag = false;
  }
  
  // if user clicks x, close the window
  if(mousePressed && mouseX > x+wid/2 - hi/4 && mouseX < x+wid && mouseY > y-hi/2 && mouseY < y-hi/4){
    custom_zoom_on = false;
  }
  
  /////////////////////////////////////////////////////////// ACTUAL ZOOM CONTROL /////////////////////////////////////////////////////////
  
  textSize(scaledH(26));
  text("Zoom", x-wid/4, y);
  
  
  
}