
void draw_Pen(ArrayList drawing, float x, float y, float wid, float hi){
  
  float thickness = (float)((ArrayList)drawing.get(0)).get(1);
  ArrayList pen_color = (ArrayList)((ArrayList)drawing.get(0)).get(2);

  strokeWeight(thickness * zoom/100 * wid/(displayWidth/calc_zoom(zoom)));
  
  //stroke(pen_color[0], pen_color[1], pen_color[2], pen_color[3]); // color the line the specified color
  stroke((float)pen_color.get(0), (float)pen_color.get(1), (float)pen_color.get(2), (float)pen_color.get(3)); // color the line the specified color
  
  beginShape(); // draw the line
  noFill();
  
    for (int i = 1; i < drawing.size(); i += 2){   
      vertex((float)drawing.get(i) * wid + x, (float)drawing.get(i+1) * hi + y); // draw a vertex in the line
    }
  
  endShape();
  
}

void draw_Line(ArrayList Line, float x, float y, float wid, float hi){
  
  float thickness = (float)((ArrayList)Line.get(0)).get(1);
  //int[] pen_color = (int[])((ArrayList)Line.get(0)).get(2);
  ArrayList pen_color = (ArrayList)((ArrayList)Line.get(0)).get(2);

  //float x = canvas_x + canvas_scrollX - canvas_wid/2; // x without the -canvas_wid/2 is the center x of the canvas
  //float y = canvas_y + canvas_scrollY - canvas_hi/2; // y without the -canvas_hi/2 is the canter y of the canvas
  
  strokeWeight(thickness * zoom/100 * wid/(displayWidth/calc_zoom(zoom)));
  
  //stroke(pen_color[0], pen_color[1], pen_color[2], pen_color[3]); // color the line the specified color
  stroke((float)pen_color.get(0), (float)pen_color.get(1), (float)pen_color.get(2), (float)pen_color.get(3)); // color the line the specified color
  
  line((float)Line.get(1) * wid + x, (float)Line.get(2) * hi + y, (float)Line.get(3) * wid + x, (float)Line.get(4) * hi + y);
  
  
  
}

void draw_Oval(ArrayList oval, float x, float y, float wid, float hi){
  
  // topmost part of oval is original mouseY
  // leftmost/rightmost part of oval is riginal mouseX
  
  float stroke_thickness = (float)((ArrayList)oval.get(0)).get(1);
  //int[] stroke_color = (int[])((ArrayList)oval.get(0)).get(2);
  ArrayList stroke_color = (ArrayList)((ArrayList)oval.get(0)).get(2);
  //int[] fill_color = (int[])((ArrayList)oval.get(0)).get(3);
  ArrayList fill_color = (ArrayList)((ArrayList)oval.get(0)).get(3);
  
  strokeWeight(stroke_thickness * zoom/100 * wid/(displayWidth/calc_zoom(zoom)));
  
  //stroke(stroke_color[0], stroke_color[1], stroke_color[2], stroke_color[3]);
  stroke((float)stroke_color.get(0), (float)stroke_color.get(1), (float)stroke_color.get(2), (float)stroke_color.get(3));
  fill((float)fill_color.get(0), (float)fill_color.get(1), (float)fill_color.get(2), (float)fill_color.get(3));
  
  ellipseMode(CORNER);
  
  ellipse((float)oval.get(1)* wid + x, (float)oval.get(2)* hi + y, (float)oval.get(3)* wid, (float)oval.get(4)* hi);
  
  ellipseMode(CENTER);
  
}

void draw_Rectangle(ArrayList rectangle, float x, float y, float wid, float hi){
  
  float thickness = (float)((ArrayList)rectangle.get(0)).get(1);
  //int[] pen_color = (int[])((ArrayList)rectangle.get(0)).get(2);
  ArrayList pen_color = (ArrayList)((ArrayList)rectangle.get(0)).get(2);
  //int[] fill_color = (int[])((ArrayList)rectangle.get(0)).get(3);
  ArrayList fill_color = (ArrayList)((ArrayList)rectangle.get(0)).get(3);
  
  strokeWeight(thickness * zoom/100 * wid/(displayWidth/calc_zoom(zoom)));
  
  stroke((float)pen_color.get(0), (float)pen_color.get(1), (float)pen_color.get(2), (float)pen_color.get(3)); // color the line the specified color
  //fill(fill_color[0], fill_color[1], fill_color[2], fill_color[3]);
  fill((float)fill_color.get(0), (float)fill_color.get(1), (float)fill_color.get(2), (float)fill_color.get(3));
  
  rect((float)rectangle.get(1) * wid + x, (float)rectangle.get(2) * hi + y, (float)rectangle.get(3) * wid, (float)rectangle.get(4) * hi);
  
}

void draw_frame(int frame_num, float x, float y, float wid, float hi){
  
  ArrayList frame = (ArrayList)frames.get(frame_num);
    
  int frameType = (int)frame.get(0);
  int hostFrame = (int)frame.get(1);
  
  if(frameType == 1 || frameType == 3){ // if it's a frame or subframe, draw the hostframe "above" it in the hierarchy
    draw_frame(hostFrame, x, y, wid, hi);
  }
  
  
  int type; // draw type
  
  for (int i = 2; i < frame.size(); i++){ // i starts at 2 bc 1st value represents if it's a keyframe, subframe, or frame, 
                                          // 2nd value states which frame it has an alias to (same num as itself if it's a keyframe)
    
    
    type = (int)((ArrayList)((ArrayList)frame.get(i)).get(0)).get(0);
    

    if(type == 2){
      draw_Pen((ArrayList)frame.get(i), x, y, wid, hi);
    }
    
    if(type == 5){
      draw_Line((ArrayList)frame.get(i), x, y, wid, hi);
    }
    if(type == 6){
      draw_Oval((ArrayList)frame.get(i), x, y, wid, hi);
    }
    if(type == 7){
      draw_Rectangle((ArrayList)frame.get(i), x, y, wid, hi);
    }
    
  }
    
  
  strokeWeight(2);
  
}
