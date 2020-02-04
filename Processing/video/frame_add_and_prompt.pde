
void find_nearest_hostframe(){
  
  for (int i = current_frame; i > -1; i--){ // search every frame including and before the current frame for the nearest hostframe
    
    if((int)((ArrayList)frames.get(i)).get(0) == 2 || (int)((ArrayList)frames.get(i)).get(0) == 3){ // see if it's a hostframe
      
      nearest_hostframe = i;
      
      break; // once the nearest hostframe is found, stop searching through all frames
      
    }
    
  }
 
}


void addFramesFromNone(int index, int type){ // adds blank frames and keyframe
  
  // types: 0 = frame, 1 = blank keyframe, 2 = keyframe, 3 = subframe
  
  int alreadyThere = frames.size();
  
  for (int i = alreadyThere; i < index; i++){
    
    frames.add(new ArrayList());
    
    ((ArrayList)frames.get(i)).add(1); // add frames
    ((ArrayList)frames.get(i)).add(nearest_hostframe);
    
  }
  
  if(type == 0){ // frame
    frames.add(new ArrayList((ArrayList)frames.get(alreadyThere-1)));
    ((ArrayList)frames.get(index)).set(0, 1); // add frames
    ((ArrayList)frames.get(index)).set(1, nearest_hostframe);
  }
  if(type == 1){ // blank keyframe
    frames.add(new ArrayList());
    ((ArrayList)frames.get(index)).add(2); // set to be the type
    ((ArrayList)frames.get(index)).add(index);
  }
  
  if(type == 2){ // keyframe
    frames.add(new ArrayList((ArrayList)frames.get(alreadyThere-1)));
    ((ArrayList)frames.get(index)).set(0, 2); // add frames
    ((ArrayList)frames.get(index)).set(1, index);
  }
  
  if(type == 3){ // subframe
    frames.add(new ArrayList());
    ((ArrayList)frames.get(index)).add(3); // add frames
    ((ArrayList)frames.get(index)).add(nearest_hostframe);
  }
  
  
}




void promptFrameType(float x){
  
  float startX = 0;
  float promptHeight = displayHeight/12;
  float bottomRectY = frameHeight-displayHeight/150;
  
  fill(200);
  stroke(0);
  
  if(x >= tools_width  + properties_width + frameTypePromptWidth/2 && x <= width - frameTypePromptWidth/2){ // if it's in a spot where the rectangle and triangle don't need to be shifted
    startX = x - frameTypePromptWidth/2;
    //triangle(x, frameHeight, x + frameTypePromptWidth/2, frameHeight-displayHeight/150, x - frameTypePromptWidth/2, frameHeight-displayHeight/150);
    
    //rect(x - frameTypePromptWidth/2, frameHeight-displayHeight/150,  frameTypePromptWidth, -displayHeight/15);
    
    beginShape();
    vertex(x, frameHeight); // bottom vertex
    vertex(x + frameTypePromptWidth/2, bottomRectY); // bottom right corner of rect
    vertex(x + frameTypePromptWidth/2, bottomRectY - promptHeight); // top right corner of rect
    vertex(x - frameTypePromptWidth/2, bottomRectY - promptHeight); // top left corner of rect
    vertex(x - frameTypePromptWidth/2, bottomRectY); // bottom left corner of rect
    vertex(x, frameHeight); // bottom vertex
    endShape();
    
  }
  else if(x < tools_width  + properties_width + frameTypePromptWidth/2){ // if x is really far left
    
    startX = tools_width + properties_width;

    beginShape();
    vertex(x, frameHeight); // bottom vertex
    vertex(tools_width + properties_width, bottomRectY); // bottom left corner of rect
    vertex(tools_width + properties_width, bottomRectY - promptHeight); // top left corner of rect
    vertex(tools_width + properties_width + frameTypePromptWidth, bottomRectY - promptHeight); // top right corner of rect
    vertex(tools_width + properties_width + frameTypePromptWidth, bottomRectY); // bottom right corner of rect
    vertex(x, frameHeight); // bottom vertex
    endShape();
    
    
  }
  else if(x > width - frameTypePromptWidth/2){ // if x is really far to the right
    
    startX = width - frameTypePromptWidth;
    
    beginShape();
    vertex(x, frameHeight);
    vertex(width, bottomRectY); // bottom right corner of rect
    vertex(width, bottomRectY - promptHeight); // top right corner of rect
    vertex(width - frameTypePromptWidth, bottomRectY - promptHeight); // top left corner of rect
    vertex(width - frameTypePromptWidth, bottomRectY);  // bottom left corner of rect
    vertex(x, frameHeight); // bottom vertex
    endShape();
  }
  
 frameTypePromptStartX = startX;
  
 String[] options = {"Frame", "Blank Keyframe", "Keyframe", "Subframe"};
  
 textSize(scaledH(18)); 
 fill(0);
 
 float y = bottomRectY - promptHeight;
 
 float line = 0;
 
 for (int i = 0; i < options.length; i++){
   
   line = y + (i+1)*textAscent()*1.8;
   
   fill(0, 0, 0, 255);
   text(options[i], startX + frameTypePromptWidth/20, line);
   
   if(mouseX > startX && mouseX < startX + frameTypePromptWidth && mouseY > line - textAscent()/2 && mouseY < line+textAscent()/2){
     fill(0, 0, 0, 100);
     noStroke();
     rect(startX, line - textAscent()/2*1.5, frameTypePromptWidth, textAscent()*1.5);
     
   }
   
 }
 
 // close the prompt if user clicks away
 if(mousePressed && !(mouseX > startX && mouseX < startX + frameTypePromptWidth && mouseY > bottomRectY - promptHeight && mouseY < frameHeight)){
   frameTypePrompt = false;
 }
  
  
}


void usedFramePromptOpts(float x){ // used frame prompt options
  
  float startX = 0;
  float promptHeight = displayHeight/20;
  float bottomRectY = frameHeight-displayHeight/150;
  
  fill(200);
  stroke(0);
  
  if(x >= tools_width  + properties_width + frameTypePromptWidth/2 && x <= width - frameTypePromptWidth/2){ // if it's in a spot where the rectangle and triangle don't need to be shifted
    startX = x - frameTypePromptWidth/2;
    //triangle(x, frameHeight, x + frameTypePromptWidth/2, frameHeight-displayHeight/150, x - frameTypePromptWidth/2, frameHeight-displayHeight/150);
    
    //rect(x - frameTypePromptWidth/2, frameHeight-displayHeight/150,  frameTypePromptWidth, -displayHeight/15);
    
    beginShape();
    vertex(x, frameHeight); // bottom vertex
    vertex(x + frameTypePromptWidth/2, bottomRectY); // bottom right corner of rect
    vertex(x + frameTypePromptWidth/2, bottomRectY - promptHeight); // top right corner of rect
    vertex(x - frameTypePromptWidth/2, bottomRectY - promptHeight); // top left corner of rect
    vertex(x - frameTypePromptWidth/2, bottomRectY); // bottom left corner of rect
    vertex(x, frameHeight); // bottom vertex
    endShape();
    
  }
  else if(x < tools_width  + properties_width + frameTypePromptWidth/2){ // if x is really far left
    
    startX = tools_width + properties_width;

    beginShape();
    vertex(x, frameHeight); // bottom vertex
    vertex(tools_width + properties_width, bottomRectY); // bottom left corner of rect
    vertex(tools_width + properties_width, bottomRectY - promptHeight); // top left corner of rect
    vertex(tools_width + properties_width + frameTypePromptWidth, bottomRectY - promptHeight); // top right corner of rect
    vertex(tools_width + properties_width + frameTypePromptWidth, bottomRectY); // bottom right corner of rect
    vertex(x, frameHeight); // bottom vertex
    endShape();
    
    
  }
  else if(x > width - frameTypePromptWidth/2){ // if x is really far to the right
    
    startX = width - frameTypePromptWidth;
    
    beginShape();
    vertex(x, frameHeight);
    vertex(width, bottomRectY); // bottom right corner of rect
    vertex(width, bottomRectY - promptHeight); // top right corner of rect
    vertex(width - frameTypePromptWidth, bottomRectY - promptHeight); // top left corner of rect
    vertex(width - frameTypePromptWidth, bottomRectY);  // bottom left corner of rect
    vertex(x, frameHeight); // bottom vertex
    endShape();
  }
  
 String[] options = {"Delete", "Make Subframe"};
  
 textSize(scaledH(18)); 
 fill(0);
 
 float y = bottomRectY - promptHeight;
 
 float line = 0;
 
 for (int i = 0; i < options.length; i++){
   
   line = y + (i+1)*textAscent()*1.8;
   
   fill(0, 0, 0, 255);
   text(options[i], startX + frameTypePromptWidth/20, line);
   
   if(mouseX > startX && mouseX < startX + frameTypePromptWidth && mouseY > line - textAscent()/2 && mouseY < line+textAscent()/2){
     fill(0, 0, 0, 100);
     noStroke();
     rect(startX, line - textAscent()/2*1.5, frameTypePromptWidth, textAscent()*1.5);
     
   }
   
 }
 
 // close the prompt if user clicks away
 if(mousePressed && !(mouseX > startX && mouseX < startX + frameTypePromptWidth && mouseY > bottomRectY - promptHeight && mouseY < frameHeight)){
   usedFramePrompt = false;
 }
  
  
}



void deleteFrame(int frame_num){
  
  frames.remove(frame_num);
  
  if(current_frame >= frame_num){
    current_frame --;
  }
  
  
}