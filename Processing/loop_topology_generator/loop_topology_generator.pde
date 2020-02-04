import nervoussystem.obj.*;



void setup(){
  
 size(1200, 1200, P3D); 
  
 smooth();
}



boolean on_draw = true;
boolean on_render = false;
boolean on_settings = false;


float rotx = 0;
float roty = 0;
float rotz = 0;

float panx = width / 2;
float pany = height / 2;

float zoom = 600;

boolean make_obj = false;

int randnum = (int)random(1, 1000000);

void draw(){
  
  background(200);
  
  if (on_draw){
    
    get_press();
    
    for (int i = 0; i < things.length - 1; i++){
      
      line(things[i][0], things[i][1], things[i+1][0], things[i+1][1]);
      
    }
    
    draw_buttons();
    
    
    
  }
  
  if (on_settings){
    
    
    speed_toggle();
    
    settings_buttons();
    
    
  }
  
  if (on_render){
    
    lights();
    
    get_key();
    
    translate(panx, pany, zoom);
    
    rotateX(rotz);
    rotateY(rotx);
    rotateZ(roty);
    
    vertices();
    
    obj_button();
    
    
    
    
  }
  
  if (make_obj){
    
    beginRecord("nervoussystem.obj.OBJExport", "C:\\Users\\ethan\\Desktop\\" + randnum + ".obj"); 
    
    draw_vertices();
    
    endRecord();
    
    make_obj = false;
    
  }
  
  
  
  
  
  
}