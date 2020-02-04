


// deault canvas sizes: 16x9, 4x3
// default: 4x3


float calc_zoom(float percent){
  // 100%, canvas width is at displayWidth/3
  //50%, canvas width is at displayWidth/6
  // 3 = 100/(100/3)
  // 50 = 100/(50/3)
  
  return 100/(percent/3);
}

void canvas(){
  
  noStroke();
  
  fill(255);
  rectMode(CENTER); // draw the canvas in the center
  
  float canvas_wid = displayWidth/calc_zoom(zoom); // get the canvas width
  float canvas_hi = canvas_wid * (frameRatio[1]/frameRatio[0]);
  float x = canvas_x + canvas_scrollX;
  float y = canvas_y + canvas_scrollY;
  rect(x, y, canvas_wid, canvas_hi); // draw the canvas, height is calculated based on dimensions
  
  rectMode(CORNER); // move back to normal rect mode
  
  draw_frame(current_frame, x - canvas_wid/2, y - canvas_hi/2, canvas_wid, canvas_hi);
  
  if(mouseX > x - canvas_wid/2 && mouseX < x + canvas_wid/2 &&
     mouseY > y - (canvas_wid * (frameRatio[1]/frameRatio[0]))/2 && mouseY < y + (canvas_wid * (frameRatio[1]/frameRatio[0]))/2 && mouseY < height-framePanel_height){
     use_tools = true;
  }
  else{
    use_tools = false;
  }
  
  if(mouseX < tools_width || mouseY < file_options_height){
    use_tools = false;
  }
  
  if(use_tools){
    tools(tool_in_use);
  }
  
  else{
    cursor(ARROW);
  }
}

void play_animation(){
  
  if(current_frame < frames.size()-1){ // if there are more frames in the animation
    
    frameRate(frame_rate);
    current_frame ++; // increase framerate
    
  }
  else{
    video_playing = false; // if the animation is done playing, stop playing
    frameRate(60);
  }
  
  
  
}