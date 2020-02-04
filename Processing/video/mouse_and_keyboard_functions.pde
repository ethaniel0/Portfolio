

void mouseClicked(){
  
  // animation page
  if(page == 1){
    
  
    //////// ZOOM ////////
    float zoomRectX = width - displayWidth/30 - displayHeight / 200;
    // register if user presses zoom box
    if(mouseX > zoomRectX && mouseX < zoomRectX + displayWidth/30 && mouseY > displayHeight/200 && mouseY < 3*displayHeight/100){
      //zoomTrayOpen = !zoomTrayOpen;
      if(zoomTrayOpen){
        zoomTrayOpen = false;
      }
      else{
       zoomTrayOpen = true; 
      }
    }
    
    ////// FILE OPTIONS /////
    String[] options = {"File", "Edit", "View", "Insert", "Help"};
  
    textSize(scaledH(26));
    
    int dist = 0;
    for (int i = 0; i < options.length; i++){
      
      // test if user is pressing on the option
      if(mouseX > displayWidth/30 + dist && mouseX < displayWidth/30 + dist + textWidth(options[i]) && mouseY < displayHeight/50){
        Arrays.fill(fileOptionOpen, 0, i, false); // set all options before that option to false
        Arrays.fill(fileOptionOpen, i+1, 5, false); // set all option after that option to false
        fileOptionOpen[i] = !fileOptionOpen[i]; // set the option chosen to true or false
      }
      
      dist += textWidth(options[i] + "    ");
    }
    
    if(mouseY > displayHeight/50){
      Arrays.fill(fileOptionOpen, false); // set all options to false
    }
    
    
    ///// TOOLS /////
    for (int i = 0; i < 10; i++){

      // if mouse is over an icon
      if(mouseX > tools_width/8 && mouseX < 7*tools_width/8 && mouseY > i*tools_width + displayHeight/50 + tools_width/4 && 
         mouseY < i*tools_width + displayHeight/50 + tools_width/4 + tools_width*3/4){
        tool_in_use = i;
      }

    } 
    
    /////// FRAME PANEL ///////
    // if user clicks on an unused frame, promp which type of frame
    for (int i = frames.size(); i <  width/frame_width; i++){ // not current frames
    
      if(mouseX > tools_width + properties_width +(i*frame_width) && mouseX < tools_width + properties_width +(i*frame_width) + frame_width && 
         mouseY > frameHeight && mouseY < frameHeight+frame_width*2){
        //addFramesFromNone(i);
        frameTypePrompt = !frameTypePrompt;
        frameTypePromptX = tools_width + properties_width + (i*frame_width) + frame_width;
        frameTypePromptFrameNum = i + (int)(frame_scroll/frame_width);
      }
      
    }
    
    // frame type prompt
  
     textSize(scaledH(18));
     float startX = frameTypePromptStartX;
     float y = frameHeight-displayHeight/150 - displayHeight/12;
   
     float line = 0;
   if(frameTypePrompt){
     for (int i = 0; i < 4; i++){
       
       line = y + (i+1)*textAscent()*1.8;
       
       if(mouseX > startX && mouseX < startX + frameTypePromptWidth && mouseY > line - textAscent()/2 && mouseY < line+textAscent()/2){
         addFramesFromNone(frameTypePromptFrameNum, i);
         frameTypePrompt = false;
         current_frame = frameTypePromptFrameNum;
       }
       
     }
    }
    
   // if user clicks on a used frame
   for (int i = 1; i <  frames.size(); i++){ // not current frames
    
      if(mouseX > tools_width + properties_width +(i*frame_width) && mouseX < tools_width + properties_width +(i*frame_width) + frame_width && 
         mouseY > frameHeight && mouseY < frameHeight+frame_width*2 && mouseButton == RIGHT){
        //addFramesFromNone(i);
        usedFramePrompt = !usedFramePrompt;
        usedFramePromptX = tools_width + properties_width + (i*frame_width) + frame_width;
        usedFramePromptFrameNum = i + (int)(frame_scroll/frame_width);
      }
      
    }
    
  if(usedFramePrompt){
    
    startX = usedFramePromptX;
    y = frameHeight-displayHeight/150 - displayHeight/20;
    
    for (int i = 0; i < 1; i++){
       
       line = y + (i+1)*textAscent()*1.8;
       
       if(mouseX > startX - frameTypePromptWidth/2 && mouseX < startX + frameTypePromptWidth/2 && mouseY > line - textAscent()/2 && mouseY < line+textAscent()/2){
         deleteFrame(usedFramePromptFrameNum);
         usedFramePrompt = false;
         
       }
       
     }
    
    
  }
    
   // play/pause button
   
   float bottomY = height - framePanelSliderHeight; // top of where an icon can be
  
   float spaceY = height - bottomY; // x-coord space between the preview box and the bottom of the window
    
   float spaceX = frameSliderLeftSide - tools_width - properties_width;
    
   startX = tools_width + properties_width; // leftmost part of where a botton could go
   if(mouseX > startX + spaceX / 2 - spaceX/20 && mouseX < startX + spaceX / 2 + spaceY/2 + spaceX/10 && mouseY > bottomY){ // if user clicks on play/pause, play/pause
        
        video_playing = !video_playing;
        
    }
   
   // next thing
    
  } // page 1
}


void keyPressed(){ // for all ctrl-letter, key = letter position in the alphabet (ctrl-a = 1, ctrl-b = 2, ctrl-z = 26)
  
  if(key == 26){ // Control+Z
    
    if(((ArrayList)frames.get(current_frame)).size() > 2){ // if there are still drawings on the frame
      ((ArrayList)frames.get(current_frame)).remove(((ArrayList)frames.get(current_frame)).size()-1); // delete the most recent drawing on that frame
    }
    
  } // end of if(Ctrl+Z)
  
  if(key == 19){
    
    save_file();
    
  }
  
}


void moveButtonX(Float x, float y, float minX, float maxX, float circleRadius){
  
  if(mousePressed && mouseX > x - circleRadius && mouseX < x + circleRadius && mouseY > y - circleRadius && mouseY < y + circleRadius && x > minX && x < maxX){
    
    x = (Float)(float)mouseX;
    
    
  }
  
  
  
}