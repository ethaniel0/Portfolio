



float[][] vertices = {};

int speed = 200;

int center = 0;
int moving = center + 1;

void add_vertices(){
  
  int max = things.length;
  
  for (int i = 0; i < speed; i ++){
    
    if (max - moving > 1){
      
      float midpointx = (things[center][0] + things[moving][0]) / 2;
      float midpointy = (things[center][1] + things[moving][1]) / 2;
      float zdir = sqrt(pow((things[center][0] - things[moving][0]), 2) + pow((things[center][1] - things[moving][1]), 2));
      
      float[][] appnd = {{midpointx, midpointy, zdir}};
      float[][] newv = append(vertices, appnd);
      
      vertices = newv;
      
      moving ++;
      
      
      
    }
    
    else{
      
     center ++; 
     moving = center + 1;
      
    }
    
    
    
  }
  
}



void draw_vertices(){
  
  
  fill(0, 100, 255);
  
  noStroke();
  
  beginShape(TRIANGLE_FAN);
  
    for (int i = 0; i < vertices.length; i++){
      
      vertex(vertices[i][0], vertices[i][1], vertices[i][2]);
      
    }

  endShape();
  

  
}

void vertices(){
  
  add_vertices();
  
  draw_vertices();
  
  
}