
// see if a string is an int or not
boolean isInteger(String s) {
    try { 
        Integer.parseInt(s); 
    } catch(NumberFormatException e) { 
        return false; 
    } catch(NullPointerException e) {
        return false;
    }
    // only got here if we didn't return false
    return true;
}


String[][] code_variables = {};

void get_variables(){
  
  // possibilities: int, float, double
  String possible = "";
  for (int i = 0; i < text.length(); i++){  
      
      if (text.substring(i, text.length()).length() >= 3 && text.substring(i, i + 3).equals("int")){ // if the word = "int"
        
        
        
      }
      if (text.substring(i, text.length()).length() >= 5 && text.substring(i, i + 5).equals("float")){ // if the word = "float"
        
        
        
      }
      
      if (text.substring(i, text.length()).length() >= 6 && text.substring(i, i + 6).equals("double")){ // if the word = "double"
        
        
        
      }
              
      
      
  }  // end of loop
  

}



void get_setup(){
  get_variables();
  
  
  
  
}

void get_loop(){
  
  get_variables();
  
  
}



void compiler(){
  
  
     

}