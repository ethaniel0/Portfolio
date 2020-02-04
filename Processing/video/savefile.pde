



void save_file(){
  
  selectOutput("Select a file to write to:", "fileSelected");
  
  //println(file_name);
  
  
  
  
  
  
  // pa = Processing Animation
  
  
  
  /*
  Things to save:
  
  frame ratio
  frame rate
  frames
  
  
  */
  
  
}

void fileSelected(File selection) {
  if (selection == null) {
    
  } else {
    
    
    
    String[] things = {frameRatio[0] + " " + frameRatio[1],
                     frame_rate+"",
                      frames.toString()}; // save whatever needs saving
    
   
    
    file_name = "" + selection.getAbsolutePath();
    
    saveStrings(file_name + ".pad", things); // save to test.pad
  }

}