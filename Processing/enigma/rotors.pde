

String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";  // reference alphabet (right side of rotor is the alphabet in order)
String rotor0 = "EKMFLGDQVZNTOWYHXUSPAIBRCJ";    // wiring of first rotor
String rotor1 = "BDFHJLCPRTXVZNYEIWGAKMUSQO";    // wiring of 2nd rotor
String rotor2 = "AJDKSIRUXBLHWTMCQGZNPYFVOE";    // wiring of third rotor
String reflector = "YRUHQSLDPXNGOKMIEBFZCWVJAT"; // wiring of reflector

// states the letter (numerically) that each letter reflects to in the reflector
//int[] reflector = {24,17,20,7,16,18,11,3,15,23,13,6,14,10,12,8,4,1,5,25,2,22,21,9,0,19};


void set_rotors(){
  
  rotor0 = rotor0.substring(rotor_settings[0],26) + rotor0.substring(0, rotor_settings[0]);
  rotor1 = rotor1.substring(rotor_settings[1],26) + rotor1.substring(0, rotor_settings[1]);
  rotor2 = rotor2.substring(rotor_settings[2],26) + rotor2.substring(0, rotor_settings[2]);
  
}

int forward_rotors(int letter){
  
  //alphabet = alphabet.substring(

  letter = alphabet.indexOf(rotor0.substring(letter,letter+1)); // takes letter into left part of rotor, matches it up the the right part of the rotor

  letter = alphabet.indexOf(rotor1.substring(letter,letter+1)); // takes letter into left part of rotor, matches it up the the right part of the rotor

  letter = alphabet.indexOf(rotor2.substring(letter,letter+1)); // takes letter into left part of rotor, matches it up the the right part of the rotor
  
  return letter;
  
}


int through_reflector(int letter){
  
  letter = alphabet.indexOf(reflector.substring(letter,letter+1)); // gets the corresponding letter and finds its index its match
  return letter;
  
}

int backward_rotors(int letter){

  letter = rotor0.indexOf(alphabet.substring(letter,letter+1)); // gets the letter from the right part of the rotor and matche it up to the left part of the rotor
  
  letter = rotor1.indexOf(alphabet.substring(letter,letter+1)); // gets the letter from the right part of the rotor and matche it up to the left part of the rotor

  letter = rotor2.indexOf(alphabet.substring(letter,letter+1)); // gets the letter from the right part of the rotor and matche it up to the left part of the rotor

    
  
  return letter;
  
}

void turn_rotor(){
  
    // turn the rotor
  rotor_settings[0] = (rotor_settings[0]+1)%26;
  
  // if rotor 1 went from z to a, turn the 2nd rotor
  if(rotor_settings[0] == 0){
    rotor_settings[1] = (rotor_settings[1]+1)%26;
  }
  
  // if there's a triple kchunk, triple kchunk
   if(rotor_settings[0] == 0 && rotor_settings[1] == 0){
    rotor_settings[2] = (rotor_settings[2]+1)%26;
  }
  
}

///////////////// PUTS ALL ROTOR STUFF TOGETHER /////////////////
int all_rotors_together(int letter){
  
  
  set_rotors();
  
  // get the letter that pops out
  int result =  backward_rotors(through_reflector(forward_rotors(letter))); // go forward, through the reflector, and back out to get the result
  
  turn_rotor();
  
  return result;
  
}



///////////// FOR DISPLAYING THE ROTORS /////////////
int rotor_y = 330;

// display the rotors
void disp_rotors(){
  
  // display the rotors
  for (int i = 0; i < 3; i++){
    
    int x = i*250 + 450;
    
    fill(255);
    rect(x, 150, 100, 300);
    
    textSize(64);
    
    // main letter
    fill(0);
    text(letters[rotor_settings[i]], x + 35, rotor_y);
    
    // letters before and in front
    textSize(42);
    text(letters[(rotor_settings[i]+25)%26], x + 40, rotor_y - 80);
    
    text(letters[(rotor_settings[i]+1)%26], x + 40, rotor_y + 80);
    
  }
  
}