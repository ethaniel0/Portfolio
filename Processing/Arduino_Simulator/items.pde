
float[][] being_used = {};

////////////////////////////// Items To Put On The Arduino //////////////////////////////

boolean left = true;

float wire_curve = 6;

void jump_wire(float x1, float y1, float x2, float y2, float choice, float curve){ //////////////////////////// jump wire ////////////////////////////
  
  strokeWeight(5);
  fill(255);
  stroke(255, 140, 0);
  
  ellipse(x1, y1, scales(14), scales(14)); 
  ellipse(x2, y2, scales(14), scales(14)); 
  noFill();
  
  if (choice == 1){
    bezier(x1, y1, x1 - (positive(y1 - y2) / curve), y1 - (positive(x1 - x2) / curve), x2 - (positive(y1 - y2) / curve), y2 - (positive(x1 - x2) / curve), x2, y2);
  }
  
  else if (choice == 0){
    bezier(x1, y1, x1 + (positive(y1 - y2) / curve), y1 + (positive(x1 - x2) / curve), x2 + (positive(y1 - y2) / curve), y2 + (positive(x1 - x2) / curve), x2, y2);
  }
  
}

void get_jump_wire(float x1, float y1, float x2, float y2){
  
  strokeWeight(5);
  fill(255);
  stroke(255, 140, 0);
  
  ellipse(x1, y1, scales(14), scales(14)); 
  ellipse(x2, y2, scales(14), scales(14)); 
  noFill();
  

  if (keyPressed && keyCode == ALT){
    
    if (left){
      bezier(x1, y1, x1 + (positive(y1 - y2) / wire_curve), y1 + (positive(x1 - x2) / wire_curve), x2 + (positive(y1 - y2) / wire_curve), y2 + (positive(x1 - x2) / wire_curve), x2, y2);
      left = false;
      delay(100);
    }
    
    else if (!left){
      bezier(x1, y1, x1 - (positive(y1 - y2) / wire_curve), y1 - (positive(x1 - x2) / wire_curve), x2 - (positive(y1 - y2) / wire_curve), y2 - (positive(x1 - x2) / wire_curve), x2, y2);
      left = true;
      delay(100);
    }
  }
  
  else{
    if (left == true){
      bezier(x1, y1, x1 - (positive(y1 - y2) / wire_curve), y1 - (positive(x1 - x2) / wire_curve), x2 - (positive(y1 - y2) / wire_curve), y2 - (positive(x1 - x2) / wire_curve), x2, y2);
    }
    
    if (left == false){
      bezier(x1, y1, x1 + (positive(y1 - y2) / wire_curve), y1 + (positive(x1 - x2) / wire_curve), x2 + (positive(y1 - y2) / wire_curve), y2 + (positive(x1 - x2) / wire_curve), x2, y2);
    }
    
  }
  
  // edit the curvature of the wire
  if (keyPressed && (keyCode == UP || keyCode == SHIFT)){
    wire_curve -= .1;
  }
  else if (keyPressed && (keyCode == DOWN || keyCode == CONTROL)){
    wire_curve += .1;
  }
  
}


void LED(float x1, float y1, float x2, float y2){ //////////////////////////////// LED ////////////////////////////////
  
  strokeWeight(5);
  stroke(70,130,180);
  
  fill(255);
  ellipse(x1, y1, scales(14), scales(14)); 
  ellipse(x2, y2, scales(14), scales(14)); 
  line(x1, y1, x2, y2);
  
  int ledWidth = 16;
  
  fill(led_color[0], led_color[1], led_color[2]);
  ellipse((x1 + x2) / 2, (y1 + y2) / 2, scales(ledWidth), scales(ledWidth)); 
  
}

////////////////////////// End Of Items To Put On The Arduino //////////////////////////

int[] arduino_holes_being_used = {};

float[] where_wires_at = new float[2];


boolean adding = false;

float[] snaps = {};

void set_up_wires(){ ////////////////// set up the wires //////////////////
  
  if (where_wires_at[0] != -1){
    if (mousePressed){
      
      adding = true;
      
      snaps = snap_to_wire_hole();
      
      // jumpwire
      if (modchoice == 1){
        get_jump_wire(where_wires_at[0], where_wires_at[1], snaps[0], snaps[1]);
      }
      
      // led
      if (modchoice == 2){
        LED(where_wires_at[0], where_wires_at[1], snaps[0], snaps[1]);
      }
      
    }
  }
  
  
  if (!mousePressed){
    snap_to_hole();
  }
  
}

int arduino_using = 18;