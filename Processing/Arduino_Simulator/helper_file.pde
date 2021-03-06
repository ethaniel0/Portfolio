float positive(float x){
  
  
  return (sqrt(pow(x, 2)));
}

// takes in two float arrays and appends them
float[] append(float[] a, float[] b) {
    float[] result = new float[a.length + b.length];
    System.arraycopy(a, 0, result, 0, a.length);
    System.arraycopy(b, 0, result, a.length, b.length);
    return result;
}

// takes in two int arrays, appends one to the other
int[] append(int[] a, int[] b) {
    int[] result = new int[a.length + b.length];
    System.arraycopy(a, 0, result, 0, a.length);
    System.arraycopy(b, 0, result, a.length, b.length);
    return result;
}



void snap_to_hole(){ ////////////////////////////// SNAP TO HOLE //////////////////////////////
  
  int[][] breadBoard = breadboard_holes();
  
  boolean got_one = false;
  
  fill(255, 0, 0);
  
  // go through all breadboard holes and see if the mouse is over a hole, put positions over that hole, say that there is a hole
  for (int[] i : breadBoard){
    if ((scales(i[0]) <= mouseX)  && ((scales(i[0]) + scales(19)) >= mouseX) && (scales(i[1]) <= mouseY) && ((scales(i[1]) + scales(18)) >= mouseY)){
     ellipse(scales(i[0]) + scales(10), scales(i[1]) + scales(10), scales(14), scales(14)); 
     
     where_wires_at[0] = scales(i[0]) + scales(10);
     where_wires_at[1] = scales(i[1]) + scales(10);
     got_one = true;
     
     break;
    }

  }
  
  int[][] ah = arduino_holes();
  
  // for every hole in the arduino, find if the mouse is over the hole, if it is say so and lead the wire there
  for (int[] i : ah){
    if ((scales(i[0]) <= mouseX)  && ((scales(i[0]) + scales(19)) >= mouseX) && (scales(i[1]) <= mouseY) && ((scales(i[1]) + scales(18)) >= mouseY)){
       ellipse(scales(i[0]) + scales(10), scales(i[1]) + scales(11), scales(14), scales(14)); 
  
       where_wires_at[0] = scales(i[0]) + scales(10);
       where_wires_at[1] = scales(i[1]) + scales(11);
       got_one = true;
       
       break;
    }
  }
  
  
  // if no hole was found, don't lead it to a hole
  if (!got_one){
    where_wires_at[0] = -1;
    where_wires_at[1] = -1;
    
  }
  
  
}



float[] snap_to_wire_hole(){ /////////////////////////// SNAP TO WIRE HOLE ///////////////////////////
  
  int[][] breadBoard = breadboard_holes();

  float[] hole = {mouseX, mouseY, 18};
  
  fill(255, 0, 0);
  
  for (int[] i : breadBoard){
    if ((scales(i[0]) <= mouseX)  && ((scales(i[0]) + scales(19)) >= mouseX) && (scales(i[1]) <= mouseY) && ((scales(i[1]) + scales(18)) >= mouseY)){

     hole[0] = scales(i[0]) + scales(10);
     hole[1] = scales(i[1]) + scales(10);
     
     break;


    }

  }
  
  int[][] ah = arduino_holes();
  
  for (int[] j : ah){
    if ((scales(j[0]) <= mouseX)  && ((scales(j[0]) + scales(19)) >= mouseX) && (scales(j[1]) <= mouseY) && ((scales(j[1]) + scales(18)) >= mouseY)){

     hole[0] = scales(j[0]) + scales(10);
     hole[1] = scales(j[1]) + scales(11);
     
     break;
     
    }
  }
  
  return hole;
  
}


// draw the backarrow
void backArrow(int x, int y, int len, int wid){ // draw a back arrow
  
  stroke(0);
  line(x, y, x + len, y); // straight line in arrow
  line(x, y, x + (len / 4), y + (wid / 2)); // top line in arrow
  line(x, y, x + (len / 4), y - (wid / 2)); // bottom line in arrow
  
}


int[][] breadboard_holes(){
  strokeWeight(1);
  
  int[][] hole_positions = {{652, 287}, {652, 312}, {652, 337}, {652, 362}, {652, 387}, // left rows
                            {676, 287}, {676, 312}, {676, 337}, {676, 362}, {676, 387},
                            
                            {652, 438}, {652, 463}, {652, 488}, {652, 513}, {652, 538},
                            {677, 438}, {677, 463}, {677, 488}, {677, 513}, {677, 538},
                          
                            {652, 589}, {652, 614}, {652, 639}, {652, 664}, {652, 689},
                            {677, 589}, {677, 614}, {677, 639}, {677, 664}, {677, 689},
                          
                            {652, 740}, {652, 765}, {652, 790}, {652, 815}, {652, 840},
                            {677, 740}, {677, 765}, {677, 790}, {677, 815}, {677, 840},
                          
                        
                            {1105, 287}, {1105, 312}, {1105, 337}, {1105, 362}, {1105, 387}, // right rows
                            {1130, 287}, {1130, 312}, {1130, 337}, {1130, 362}, {1130, 387},
                            
                            {1105, 438}, {1105, 463}, {1105, 488}, {1105, 513}, {1105, 538},
                            {1130, 438}, {1130, 463}, {1130, 488}, {1130, 513}, {1130, 538},
                          
                            {1105, 589}, {1105, 614}, {1105, 639}, {1105, 664}, {1105, 689},
                            {1130, 589}, {1130, 614}, {1130, 639}, {1130, 664}, {1130, 689},
                          
                            {1105, 740}, {1105, 765}, {1105, 790}, {1105, 815}, {1105, 840},
                            {1130, 740}, {1130, 765}, {1130, 790}, {1130, 815}, {1130, 840},
                          
                            {752, 237}, {777, 237}, {802, 237}, {827, 237}, {852, 237}, // left big section
                            {752, 262}, {777, 262}, {802, 262}, {827, 262}, {852, 262},
                            {752, 287}, {777, 287}, {802, 287}, {827, 287}, {852, 287},
                            {752, 312}, {777, 312}, {802, 312}, {827, 312}, {852, 312},
                            {752, 337}, {777, 337}, {802, 337}, {827, 337}, {852, 337},
                            {752, 363}, {777, 363}, {802, 363}, {827, 363}, {852, 363},
                            {752, 388}, {777, 388}, {802, 388}, {827, 388}, {852, 388},
                            {752, 413}, {777, 413}, {802, 413}, {827, 413}, {852, 413},
                            {752, 438}, {777, 438}, {802, 438}, {827, 438}, {852, 438},
                            {752, 463}, {777, 463}, {802, 463}, {827, 463}, {852, 463},
                            {752, 488}, {777, 488}, {802, 488}, {827, 488}, {852, 488},
                            {752, 513}, {777, 513}, {802, 513}, {827, 513}, {852, 513},
                            {752, 538}, {777, 538}, {802, 538}, {827, 538}, {852, 538},
                            {752, 563}, {777, 563}, {802, 563}, {827, 563}, {852, 563},
                            {752, 588}, {777, 588}, {802, 588}, {827, 588}, {852, 588},
                            {752, 614}, {777, 614}, {802, 614}, {827, 614}, {852, 614},
                            {752, 639}, {777, 639}, {802, 639}, {827, 639}, {852, 639},
                            {752, 664}, {777, 664}, {802, 664}, {827, 664}, {852, 664},
                            {752, 689}, {777, 689}, {802, 689}, {827, 689}, {852, 689},
                            {752, 714}, {777, 714}, {802, 714}, {827, 714}, {852, 714},
                            {752, 739}, {777, 739}, {802, 739}, {827, 739}, {852, 739},
                            {752, 764}, {777, 764}, {802, 764}, {827, 764}, {852, 764},
                            {752, 789}, {777, 789}, {802, 789}, {827, 789}, {852, 789},
                            {752, 814}, {777, 814}, {802, 814}, {827, 814}, {852, 814},
                            {752, 839}, {777, 839}, {802, 839}, {827, 839}, {852, 839},
                            {752, 865}, {777, 865}, {802, 865}, {827, 865}, {852, 865},
                            {752, 890}, {777, 890}, {802, 890}, {827, 890}, {852, 890},
                          
                            {928, 237}, {953, 237}, {978, 237}, {1003, 237}, {1028, 237}, // right big section
                            {928, 262}, {953, 262}, {978, 262}, {1003, 262}, {1028, 262},
                            {928, 287}, {953, 287}, {978, 287}, {1003, 287}, {1028, 287},
                            {928, 312}, {953, 312}, {978, 312}, {1003, 312}, {1028, 312},
                            {928, 337}, {953, 337}, {978, 337}, {1003, 337}, {1028, 337},
                            {928, 363}, {953, 363}, {978, 363}, {1003, 363}, {1028, 363},
                            {928, 388}, {953, 388}, {978, 388}, {1003, 388}, {1028, 388},
                            {928, 413}, {953, 413}, {978, 413}, {1003, 413}, {1028, 413},
                            {928, 438}, {953, 438}, {978, 438}, {1003, 438}, {1028, 438},
                            {928, 463}, {953, 463}, {978, 463}, {1003, 463}, {1028, 463},
                            {928, 488}, {953, 488}, {978, 488}, {1003, 488}, {1028, 488},
                            {928, 513}, {953, 513}, {978, 513}, {1003, 513}, {1028, 513},
                            {928, 538}, {953, 538}, {978, 538}, {1003, 538}, {1028, 538},
                            {928, 563}, {953, 563}, {978, 563}, {1003, 563}, {1028, 563},
                            {928, 588}, {953, 588}, {978, 588}, {1003, 588}, {1028, 588},
                            {928, 614}, {953, 614}, {978, 614}, {1003, 614}, {1028, 614},
                            {928, 639}, {953, 639}, {978, 639}, {1003, 639}, {1028, 639},
                            {928, 664}, {953, 664}, {978, 664}, {1003, 664}, {1028, 664},
                            {928, 689}, {953, 689}, {978, 689}, {1003, 689}, {1028, 689},
                            {928, 714}, {953, 714}, {978, 714}, {1003, 714}, {1028, 714},
                            {928, 739}, {953, 739}, {978, 739}, {1003, 739}, {1028, 739},
                            {928, 764}, {953, 764}, {978, 764}, {1003, 764}, {1028, 764},
                            {928, 789}, {953, 789}, {978, 789}, {1003, 789}, {1028, 789},
                            {928, 814}, {953, 814}, {978, 814}, {1003, 814}, {1028, 814},
                            {928, 839}, {953, 839}, {978, 839}, {1003, 839}, {1028, 839},
                            {928, 865}, {953, 865}, {978, 865}, {1003, 865}, {1028, 865},
                            {928, 890}, {953, 890}, {978, 890}, {1003, 890}, {1028, 890}};

  
  return hole_positions;
  
}

int[][] arduino_holes(){
  
  int[][] holes = {
{548, 415, 17},  // unknown pin
{548, 441, 16},  // unknown pin
{548, 467, 15},  // AREF pin
{548, 493, 14},  // ground pin
{548, 519, 13},  // 13 pin
{548, 545, 12},  // 12 pin
{548, 571, 11},  // ~11 pin
{548, 597, 10},  // ~10 pin
{548, 623, 9},  // ~9 pin
{548, 649, 8},  // 8 pin

{547, 692, 7},  // 7 pin
{547, 718, 6},  // ~6 pin
{547, 744, 5},  // ~5 pin
{547, 770, 4},  // 4 pin
{547, 796, 3},  // ~3 pin
{547, 822, 2},  // 2 pin
{547, 848, 1},  // 1 (tx) pin -- serial communication to computer
{547, 874, 0}}; // 0 (rx) pin -- serial communication to arduino

return holes;
  
}