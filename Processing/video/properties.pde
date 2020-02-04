void line_thickness_chooser(float lineX, float lineWidth, float y){
  strokeWeight(2);
  //draw the line that ranges in thickness
  stroke((float)line_colour.get(0), (float)line_colour.get(1), (float)line_colour.get(2));
  weightRangeLine(lineX, y, lineX + lineWidth, y, 1, 10, 0.5);
  // circle that user drags to change thickness
  strokeWeight(2);
  fill(0, 0, 0, 0);              // max line thickness is 50
  ellipse(lineX + lineWidth * (line_thickness/50), y, properties_width/30, properties_width/30);
  
  if(mousePressed && mouseY > y - properties_width/30 && mouseY < y + properties_width/30 && mouseX > lineX && mouseX < lineX + lineWidth){
       
    float percentage = (mouseX - lineX)/lineWidth;
    line_thickness = percentage*50;
         
  }
  
}

void line_alpha_chooser(float lineX, float lineWidth, float y){
  strokeWeight(10); // line with different alpha colorations
  gradientLine(lineX, y, lineX + lineWidth, y, color(255, 255, 255, 0), color((float)line_colour.get(0), (float)line_colour.get(1), (float)line_colour.get(2)));
  
  strokeWeight(2);
  stroke(0);
  fill(0, 0, 0, 0); // circle for the alpha (transparentness) selector
  ellipse(lineX + lineWidth * (((float)line_colour.get(3))/255) - 1, y, properties_width/30, properties_width/30);
  
  if(mousePressed && mouseY > y - properties_width/30 && mouseY < y + properties_width/30 && mouseX > lineX && mouseX < lineX + lineWidth){
       
    float percentage = (mouseX - lineX)/lineWidth;
    line_colour.set(3, percentage*255);
         
  }
  
}

void line_color_chooser(float lineX, float lineWidth, float y){
  strokeWeight(10); // line with different colors
  linearRGBGradient(lineX, y, lineWidth);
  
  strokeWeight(2);
  stroke(0);
  fill(0, 0, 0, 0); // circle for the alpha (transparentness) selector
  ellipse(lineX + lineWidth * color_choose_x, y, properties_width/30, properties_width/30);
  
  if(mousePressed && mouseY > y - properties_width/30 && mouseY < y + properties_width/30 && mouseX > lineX && mouseX < lineX + lineWidth){
    
    color_choose_x = (mouseX-lineX)/lineWidth;
    
    float[] rgb = gradientColors(mouseX - lineX, lineWidth);
    
    line_colour.set(0, rgb[0]);
    line_colour.set(1, rgb[1]);
    line_colour.set(2, rgb[2]);
    
  }  
  
}

void color_brightness_chooser(float x1, float y1, float lineHeight){
  
  strokeWeight(10); // line with different alpha colorations
  gradientLine(x1, y1, x1, y1+lineHeight, color(255, 255, 255), color(0));
  
  ArrayList mocklineColor = new ArrayList(line_colour);
  
  if(mousePressed && mouseX > x1-g.strokeWeight && mouseX < x1 + g.strokeWeight && mouseY > y1 && mouseY < y1+lineHeight){
    rgbContrast = ((mouseY-y1)/lineHeight)*255;
  }
  
  strokeWeight(2);
  stroke(0);
  fill(0, 0, 0, 0); // circle for the alpha (transparentness) selector
  ellipse(x1, y1 + lineHeight*(rgbContrast/255), properties_width/30, properties_width/30);
  
  
  
}

float[] gradientColors(float x, float wid) {

  float red = 0;
  float green = 0;
  float blue = 0;

  if (x <= wid/6) {
    red = 255;
    green = (6*255*x)/wid;
    blue = 0;
    float[] result = {red, green, blue};
    return result;
  }
  if (x > wid/6 && x <= wid/3) {
    red = -(6*255*x)/wid + 510;
    green = 255;
    blue = 0;
    float[] result = {red, green, blue};
    return result;
  }
  if (x > wid/3 && x <= wid/2) {
    red = 0;
    green = 255;
    blue = (6*255*x)/wid - 2*255;
    float[] result = {red, green, blue};
    return result;
  }
  if (x > wid/2 && x <= 2*wid/3) {
    red = 0;
    green = -(6*255*x)/wid + 4*255;
    blue = 255;
    float[] result = {red, green, blue};
    return result;
  }
  if (x > 2*wid/3 && x <= 5*wid/6) {
    red = (6*255*x)/wid - 4*255;
    green = 0;
    blue = 255;
    float[] result = {red, green, blue};
    return result;
  }
  if (x > 5*wid/6) {
    red = 255;
    green = 0;
    blue = -(6*255*x)/wid + 6*255;
    float[] result = {red, green, blue};
    return result;
  }
  //println(red + " " + green + " " + blue);


  float[] result = {red, green, blue};
  return result;
}


void inOutBox(){
  // box that houses the >>> or <<<
  strokeWeight(2);
  fill(100);
  rect(tools_width+properties_width, file_options_height, -displayWidth/40, displayWidth/80);
  
  textAlign(CENTER, CENTER);
  
  textSize(scaledH(32));
  fill(255);
  
  if(properties_in){ // have the arrows point to if the box will go out or in
    properties_width = displayWidth/40;
    text(">>>", tools_width+properties_width - displayWidth/80, file_options_height + displayWidth/240);
  }
  else{
    properties_width = displayWidth/8;
    text("<<<", tools_width+properties_width - displayWidth/80, file_options_height + displayWidth/240);
  }
  
  if(mouseX < tools_width + properties_width && mouseX > tools_width+properties_width - displayWidth/40 && mouseY > file_options_height  && mouseY < file_options_height + displayWidth/80){
    
    fill(0, 0, 0, 100);
    rect(tools_width+properties_width, file_options_height, -displayWidth/40, displayWidth/80);
    
    if(mousePressed){
      properties_in = !properties_in;
    } 
  }
}

void properties(){
  
  strokeWeight(2);

  fill(180);
  rect(tools_width, file_options_height, properties_width, height - file_options_height);
  
  float lineX = tools_width + properties_width/10;
  float lineWidth = properties_width*.8;
  float yBase = file_options_height; // part of the equation that determines y that's common for all lines
  float yVar = (height - file_options_height)/10; // the part of y that determines the height (not the base that's common between all)

  strokeWeight(line_thickness); // line that represents the line
  stroke((float)line_colour.get(0), (float)line_colour.get(1), (float)line_colour.get(2));
  line (lineX, yBase + yVar, lineX + lineWidth, yBase + yVar);


  line_thickness_chooser(lineX, lineWidth, yBase + 1.5*yVar);
  line_alpha_chooser(lineX, lineWidth, yBase + 2*yVar);
  line_color_chooser(lineX, lineWidth, yBase+2.5*yVar);
  color_brightness_chooser(lineX + lineWidth, yBase + 2.8*yVar, yVar*1.5);
  
  inOutBox();
  
}