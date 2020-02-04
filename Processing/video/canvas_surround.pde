


void rectWithOutline(float x, float y, float wid, float hi, int top, int right, int bottom, int left, int size){
  
  noStroke();
  rect(x, y, wid, hi);
  
  stroke(0);
  strokeWeight(size);
  
  // draw line on top
  if (top == 1){
    line(x, y, x+wid, y);
  }
  
  // draw a line on the right side
  if (right == 1){
    line(x+wid, y, x+wid, y+ hi);
  }
  
  // draw a line on the bottom
  if (bottom == 1){
    line(x, y+hi, x+wid, y+hi);
  }
  
  // draw a line on the left side
  if (left == 1){
    line(x, y, x, y+hi);
  }
  
  strokeWeight(1);
}

//////////////////////////////////////////////////////////////// TOOL SELECTION ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// draw the outline: tools, properties
void tool_selection_pane(){
  
  fill(130);
  stroke(0);
  strokeWeight(2);
  
  // draw a place for the tools
  rectWithOutline(0, 0, tools_width, height, 0, 1, 0, 0, 2);
  
  textSize(scaledH(16));
  textAlign(CENTER, CENTER);
  // placeholders for tool icons
  for (int i = 0; i < 10; i++){
    noFill();
    rect(tools_width/8, i*tools_width + displayHeight/50 + tools_width/4, tools_width*3/4, tools_width*3/4); // draw surrounding rect

    fill(255);
    icon(i, 4*tools_width/8, i*tools_width + displayHeight/50 + tools_width/4 + tools_width*3/8); // draw icon

    // if mouse is over an icon
    if(mouseX > tools_width/8 && mouseX < 7*tools_width/8 && mouseY > i*tools_width + displayHeight/50 + tools_width/4 && 
      mouseY < i*tools_width + displayHeight/50 + tools_width/4 + tools_width*3/4){
      fill(0, 0, 0, 100);
      rect(tools_width/8, i*tools_width + displayHeight/50 + tools_width/4, tools_width*3/4, tools_width*3/4);
    }

  } 
}


////////////////////////////////////////////////////////////////// FILE OPTIONS /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void file_options(){ // file, edit, insert, help
  
  fill(130);
  
  // x, y, width, height, no line on top, no line on rightm line on bottom, no line on left, strokeWeight(2)
  rectWithOutline(0, 0, width, file_options_height, 0, 0, 1, 0, 2);
  
  fill(255);
  
  textAlign(LEFT, CENTER);
  
  String[] options = {"File", "Edit", "View", "Insert", "Help"};
  
  textSize(scaledH(26));
  
  int dist = 0; // where each of the options starts (after displayWidth/30)
  for (int i = 0; i < options.length; i++){ // put all of the options up
    text(options[i], displayWidth/30 + dist, file_options_height/2); // print the option
    
    // if the option is chosen
    if(fileOptionOpen[i]){
      
      // find the length of the largest string
      float max = 0;
      for(String j : fileOptions[i]){if(textWidth(j) > max){max = textWidth(j);}
      }
      
      fill(150);
      rect(displayWidth/30 + dist, file_options_height, max*1.1, textAscent()*1.25*fileOptions[i].length);
      
      fill(255);
      for(int j = 0; j < fileOptions[i].length; j++){
        text(fileOptions[i][j], displayWidth/30 + dist + max*.05, textAscent()*1.25*j + file_options_height + textAscent()/2);
      }
      
    }
    
    
    
    dist += textWidth(options[i] + "    "); // add x distance for next option
  } 
}


////////////////////////////////////////////////////////////////////////// ZOOM ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void zoom_box(){

  float rectX = width - displayWidth/30 - displayHeight / 200;
  
  float box_wid = displayWidth/30 + displayHeight/200;
  
  fill(180);
  //rect(rectX, displayHeight/200, displayWidth/30, displayHeight/100); // rect for the zoom box
  
  strokeWeight(2);
  rect(rectX, 0, box_wid, displayHeight/50); // rect for the zoom box
  
  textSize(scaledH(26));
  fill(0);
  textAlign(CENTER, CENTER);
  
  text((int)zoom + "%", width - displayWidth/50 - displayHeight / 200, displayHeight/100); // says the zoom percent
  
  triangle(width - displayWidth/200, displayHeight / 130, width - displayWidth/100, displayHeight / 130, width - displayWidth/132.5, displayWidth / 120); // drop-down arrow
  
  // look at mouseClicked() for commands to open and close tray
  
  /////////////////////////////////////////////////////////////////////// ZOOM TRAY ///////////////////////////////////////////////////////////////////////
  if(zoomTrayOpen){ // each option gets displayHeight/60 height
    fill(180);
    rect(rectX, displayHeight/50, box_wid, zoom_options.length * displayHeight/60); // rect for the zoom box
    
    float line_sep = displayHeight/60;
    
    fill(0);
    for (int i = 0; i < zoom_options.length; i++){ // draw separation lines
      
      line(rectX, i*line_sep + displayHeight/50, rectX + box_wid, i*line_sep + displayHeight/50); // make the separation line
      
      // WRITE THE OPTION
      if(zoom_options[i] != -1){
        text((int)zoom_options[i] + "%", (2*rectX + box_wid)/2,  i*line_sep + displayHeight/50 + line_sep/2 ); // write the option
      } else{
        text("Custom", (2*rectX + box_wid)/2,  i*line_sep + displayHeight/50 + line_sep/2 ); // write the option
      }
      
      // REGISTER WHICH OPTION USER WANTS
      if(mouseX > rectX && mouseY > i*line_sep + displayHeight/50 && mouseY < i*line_sep + displayHeight/50 + displayHeight/60){
        fill(0, 0, 0, 100);
        rect(rectX, i*line_sep + displayHeight/50, box_wid, displayHeight/60);
        fill(0, 0, 0, 255);
        
        if(mousePressed && zoom_options[i] != -1){
          zoom = zoom_options[i];
          custom_zoom_on = false;
          zoomTrayOpen = false; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// should this happen?
        } else if(mousePressed){ // if user wants custom zoom
          
          custom_zoom_on = true;
          
        }
          
        use_tools = false;
        
      } // END OF IF STATEMENT
      else if(mousePressed && !(mouseX > rectX && mouseX < rectX + displayWidth/30 && mouseY > displayHeight/200 && mouseY < 3*displayHeight/100)){ // if user clicks off the zoom tray, close it
        zoomTrayOpen = false;
      }
      
    } // END OF FOR LOOP
    
    
    
  } // END OF if(zoomTrayOpen)
  
  if(custom_zoom_on){
    custom_zoom();
  }
  
} // END OF zoom_box()



void outline(){
  
  frame_panel();
  
  tool_selection_pane();
  
  properties();
  
  file_options();
  
  zoom_box();
  
}