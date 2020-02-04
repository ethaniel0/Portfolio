


void setup(){
  
  size(1500, 1500);
  
}

String[] letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};

int[] rotor_settings = {0, 0, 0};
int[] rotor_order = {0, 1, 2};

void get_next_letter(int rotor, String letter){
  
  // first rotor
  if(rotor == 0){
    

    
  }
  
  // second rotor
  if(rotor == 1){
    
    
  }
  
  // third rotor
  if(rotor == 2){
    
    
  }
  
  
}


void body(){
  
  fill(50);
  rect(100, 100, 1300, 1300);
  
  disp_rotors();
  
}





void draw(){
  background(200);
  body();
  
  println(all_rotors_together(0));
  
  //println((-6+26)%26);
  
}