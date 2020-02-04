float[][] append(float[][] a, float[][] b) {
    float[][] result = new float[a.length + b.length][];
    System.arraycopy(a, 0, result, 0, a.length);
    System.arraycopy(b, 0, result, a.length, b.length);
    return result;
}





float[][] things = {};




boolean curve_made = false;



void get_press(){ // how the user draws the circle
  
  if (mousePressed && !curve_made && !just_redone){
    
    float[][] give = {{mouseX, mouseY}};
    
    float[][] t = append(things, give);
    
    things = t;

    
  }
  
 
  
}

boolean just_redone = false;

void mouseReleased(){ // completes the loop if the user hasn't done so
  
  if (!curve_made && !just_redone){
  float[][] release = {things[0]};
  
  float[][] t = append(things, release);
  
  things = t;
  
  curve_made = true;
  
  }
  
  if (just_redone){
   
    just_redone = false;
    
  }
  
  
}

void draw_buttons(){
  
  redo_loop_b();
  
  ready_for_topology_b();
  
  to_settings();
}