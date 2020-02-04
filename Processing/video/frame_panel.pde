
void slider(){
  
  int moveX = frameSliderLeftSide; // leftmost side of the scrollbar
  
  noStroke();
  fill(200);
  rect(moveX, height - framePanelSliderHeight, width - moveX, framePanelSliderHeight); // background of slider
  

  fill(100);
  rect(moveX + frame_scroll, height - framePanelSliderHeight, framePanelSliderWidth, framePanelSliderHeight); // actual part of slider that slides
  
  if(mousePressed &&!frameSliderOn && mouseX > moveX + frame_scroll && mouseX < moveX + frame_scroll + framePanelSliderWidth && 
     mouseY > height - framePanelSliderHeight){ // if used clicks on slider and the slider wasn't clicked the frame before, initialize
    frameSliderOn = true;
    frameSliderMouse = mouseX;
  }
  
  if(!mousePressed){ // stop moving the slideronce the person isn't clicking anymore
    frameSliderOn = false;
  }

  if(frameSliderOn){ // move the slider if the person wants to move the slider
    
    float dist = mouseX - frameSliderMouse;
    
    if(dist < 0 && frame_scroll > 0){
      frame_scroll += dist;
    }
    else if(dist > 0 && frame_scroll < width - framePanelSliderWidth - tools_width){
      frame_scroll += dist;
    }
    frameSliderMouse = mouseX;
    
    if(frame_scroll < 0){
      frame_scroll = 0;
    }
    if(frame_scroll > width - framePanelSliderWidth - moveX){
      frame_scroll = width - framePanelSliderWidth - moveX;
    }
    
    use_tools = false;
    
  }
  
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void frame(float x, float y, int identifier, boolean current){ // draws frame in 
  
  // for identifier: 0 = unused, 1 = used, 2 = keyframe
  
  stroke(0);
  strokeWeight(2);
  
  fill(220);
  if(current){
    fill(0, 200, 255);
  }
  
  if(identifier == 0){ // if unused, darken the frame so it's more out of the way
    fill(130);
  }
  
  rect(x, y, frame_width, frame_width*2, 5);
  
  if(identifier == 2){ // if it's a keyframe, draw a circle in the middle
    
    fill(0);
    ellipse(x + frame_width/2, y + frame_width, frame_width/2, frame_width/2);
    
  }
  
  if(identifier == 3){ // if it's a subframe, draw a square in the middle
    
    noFill();
    rect(x + frame_width/4, y + frame_width/2, frame_width/2, frame_width);
    fill(0);
 
    
  }
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void preview(int frame, float x, float y){
  
  //float rect_height = height - framePanel_height + displayWidth/40; // height of th preview box
  
  fill(255);
  triangle(x, y, x, y + displayHeight/100, x + displayHeight/80, y + displayHeight/100); // draw triangle to make it look nice
  rect(x, y + displayHeight/100, 3*frame_width, (3*frame_width) * (frameRatio[1]/frameRatio[0])); // draw frame (will be updated later)
  draw_frame(frame, x, y + displayHeight/100, 3*frame_width, (3*frame_width) * (frameRatio[1]/frameRatio[0]));
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void show_time(){ // puts a mark and the time for every second that passes
  
  // frame width = displayWidth/100
  // toolbar width = tools_width
  
  int num_marks = (int) Math.ceil((width-tools_width) / frame_width / frame_rate);
  
  textSize(scaledH(26));
  textAlign(LEFT, CENTER);
  
  fill(255);
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i < num_marks; i++){
    float x = (i+1)*(frame_rate)*frame_width + tools_width + properties_width - frame_scroll%width; // get the x value for the line and number
    
    line(x, height - framePanel_height, x, height - framePanel_height + displayHeight/40); // draw line(int)((ArrayList)frames.get(i)).get(1)
    text((i+1), x+displayWidth/300, height - framePanel_height + displayHeight/80); // draw corresponding number
  }
 
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void play_video_buttons(){
  
  fill(255);
  
  //float bottomY =  (frameHeight + frame_width*2) + displayHeight/100 + 3*frame_width * (frameRatio[1]/frameRatio[0]); // bottom of the preview boxes
  
  float bottomY = height - framePanelSliderHeight;
  
  float spaceY = height - bottomY; // x-coord space between the preview box and the bottom of the window
  
  float spaceX = frameSliderLeftSide - tools_width - properties_width;
  
  float startX = tools_width + properties_width; // leftmost part of where a botton could go
  
  float btn_wid = spaceY/2; // button width
  
  int numButtons = 2;
  
  if(mouseX > startX + spaceX / numButtons - spaceX/20 - btn_wid/2 && mouseX < startX + spaceX / numButtons + btn_wid + spaceX/10 - btn_wid/2 && mouseY > bottomY){
      
      fill(100);
      rect(startX + spaceX / numButtons - spaceX/20 - btn_wid/2 , bottomY, btn_wid + spaceX/10, framePanelSliderHeight);
      
  }
  
  if(!video_playing){
    
    fill(255);
    triangle(startX + spaceX/numButtons - btn_wid/2, height - 3*spaceY/4, 
    startX + spaceX/numButtons- btn_wid/2, height - spaceY/4, 
    startX + spaceX / numButtons + btn_wid/2, height - spaceY/2); // play button
  
  }
  else{
  
    float pause_wid = 650;
    fill(255);
    rect(startX + spaceX/numButtons - btn_wid/2, height - 3*spaceY/4, displayWidth/pause_wid, btn_wid); // left rect of the pause button
  
    rect(startX + spaceX/numButtons + spaceY/2 - displayWidth/pause_wid - btn_wid/2, height - 3*spaceY/4, displayWidth/pause_wid, btn_wid); // right rect of the pause button
  
  }
  
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void frame_panel_resize(){

  if(mouseX > tools_width + properties_width && mouseY > height - framePanel_height - displayHeight/200 && mouseY < height - framePanel_height + displayHeight/200){
    cursor(MOVE);

    if(mousePressed){

      frame_panel_drag = true;
    }
  }


  if(frame_panel_drag){

    framePanel_height = height - mouseY;

  }

  if(!mousePressed){
    frame_panel_drag = false;
  }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void frame_panel(){
  
  // rectmode is LEFT
  
  stroke(0);
  
  fill(30);
  rect(tools_width + properties_width, height - framePanel_height, width - tools_width, framePanel_height); // background of the frame panel

  int type = 0;

  for (int i = 0; i <  frames.size(); i++){ // current frames
    
    type = (int)((ArrayList)frames.get(i)).get(0);
    
    if(i == current_frame){
      frame(tools_width + properties_width +(i*frame_width) - frame_scroll, frameHeight, type, true);
    }
    else{
      frame(tools_width + properties_width +(i*frame_width) - frame_scroll, frameHeight, type, false);
    }
  
  
    if(i > 2 && (type == 2 || type == 3)){
      if((int)((ArrayList)frames.get(i-1)).get(0) != 0 && (int)((ArrayList)frames.get(i-1)).get(0) != 3 && 
      (int)((ArrayList)frames.get(i-2)).get(0) != 0 && (int)((ArrayList)frames.get(i-2)).get(0) != 3){
        
        preview(i, tools_width + properties_width +(i*frame_width) - frame_scroll, frameHeight + frame_width*2); 
      }
    }
    
    
    if(mousePressed && mouseX > tools_width + properties_width+(i*frame_width) && mouseX < tools_width + properties_width +(i*frame_width) + frame_width && 
       mouseY > frameHeight && mouseY < frameHeight+frame_width*2){
      current_frame = i;
    } 
  }
  
  
  for (int i = frames.size(); i <  width/frame_width; i++){ // not current frames

    frame(tools_width+ + properties_width + (i*frame_width) - frame_scroll, frameHeight, 0, false); 
  }
  
  preview(0, tools_width + properties_width, frameHeight + frame_width*2);
  
  show_time();
  
  if(frameTypePrompt){

   promptFrameType(frameTypePromptX); 
  }
  if(usedFramePrompt){

    usedFramePromptOpts(usedFramePromptX);
  }
  
  slider();
  
  play_video_buttons();


  frame_panel_resize();

 
}