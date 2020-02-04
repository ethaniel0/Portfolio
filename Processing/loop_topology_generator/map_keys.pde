



float rotby = .05;

float panby = 5;


void get_key(){
  
  
  
  
  if (keyPressed){
    
    if (keyCode == UP){ // rotate
      roty += rotby; 
    }
    if (keyCode == DOWN){
      roty -= rotby;
    }
    if (keyCode == LEFT){
      rotx -= rotby;
    }
    if (keyCode == RIGHT){
      rotx += rotby; 
    }
    if (key == ','){
      rotz -= rotby;
    }
    if (key == '.'){
      rotz += rotby;
    }
    
    
    if (key == 'w'){ // pan
      pany -= panby;
    }
    if (key == 's'){
      pany += panby;
    }
    if (key == 'a'){
      panx -= panby;
    }
    if (key == 'd'){
      panx += panby;
    }
    
    
    
    if (keyCode == SHIFT){
      zoom += panby;
    }
    if (keyCode == CONTROL){
      zoom -= panby;
    }
    
    
    
  } 
}