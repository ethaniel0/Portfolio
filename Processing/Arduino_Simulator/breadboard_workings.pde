/*

                                            -----    -----   
                                       +-   -----    -----   +-
 |                                     ||   -----    -----   ||
 |                                     ||   -----    -----   ||
 | AREF                                ||   -----    -----   ||
 | GND     -                           ||   -----    -----   ||
 | 13      +                           ||   -----    -----   ||
 | 12      +                           ||   -----    -----   ||
 | 11      +                           ||   -----    -----   ||
 | 10      +                           ||   -----    -----   ||
 | 9       +                           ||   -----    -----   ||
 | 8       +                           ||   -----    -----   ||
                                       ||   -----    -----   ||
                                       ||   -----    -----   ||
 | 7       +                           ||   -----    -----   ||
 | 6       +                           ||   -----    -----   ||
 | 5       +                           ||   -----    -----   ||
 | 4       +                           ||   -----    -----   ||
 | 3       +                           ||   -----    -----   ||
 | 2       +                           ||   -----    -----   ||
 | TX - 1  +                           ||   -----    -----   ||
 | RX - 0  +                           ||   -----    -----   ||
                                       ||   -----    -----   ||
                                       ||   -----    -----   ||
                                       ||   -----    -----   ||
                                       +-   -----    -----   +-
                                            -----    -----   

rows are connected horizontlly
sides are connected vertically all the way down

*/

/*548, 415},  // unknown pin
{548, 441},  // unknown pin
{548, 467},  // AREF pin
{548, 493},  // ground pin
{548, 519},  // 13 pin
{548, 545},  // 12 pin
{548, 571},  // ~11 pin
{548, 597},  // ~10 pin
{548, 623},  // ~9 pin
{548, 649},  // 8 pin

{547, 692},  // 7 pin
{547, 718},  // ~6 pin
{547, 744},  // ~5 pin
{547, 770},  // 4 pin
{547, 796},  // ~3 pin
{547, 822},  // 2 pin
{547, 848},  // 1 (tx) pin -- serial communication to computer
{547, 874}}; // 0 (rx) pin -- serial communication to arduino
*/




void flow(){
  float[][] paths = {};
  
  for (float[] i : being_used){ // finds arduino pins (not ground pin)
    if ((i[0] >= scales(548) && i[0] <= scales(548 + 18) && i[1] >= scales(493) && i[0] <= scales(874 + 22)) || (i[2] >= scales(548) && i[2] <= scales(548 + 18) && i[3] >= scales(493) && i[3] <= scales(874 + 22))){
      
      float[][] add = {{i[0], i[1], i[2], i[3], 1}};
      append(paths, add);
    }
    

  }
}

float[][] charges = {};

//void get_charges(){
  
//  for (float[] i : being_used){ // goes through being used -- finds wires and leds
    
//    if (i[0] > 1 && i[1] > 1){
//      if (i[i.length - 3] == 1){ // it it's a wire
        
//        jump_wire(i[0], i[1], i[2], i[3], i[i.length - 2], i[i.length - 1]);
        
//        if (i[0] == 547 || i[0] == 548){ // arduino holes
          
//          if ((i[0] == 548 && i[1] -= 493) || (i[2] == 548 && i[3] == 493)){
//            float[] charge = {1, i[0], i[1], 0, i[0], i[1], 0); // wire, x1, y1, charge, x2, y2, charge)
//            append(charges, charge);
//          }
          
//          else{
//            float[] charge = {1, i[0], i[1], 1, i[0], i[1], 1); // wire, x1, y1, charge, x2, y2, charge)
//            append(charges, charge);
//          }
          
//        }
        
        
        
//      }
      
//        }
//      }
      
      
//      if (i[i.length - 3] == 2){ // if its an led
      
//        LED(i[0], i[1], i[2], i[3]);
      
//      }
     
    

//}
 