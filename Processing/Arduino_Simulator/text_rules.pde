

void rules(){
  
  // backspace
  if (key == BACKSPACE){
    
    
    if (text.length() > 0 && cursor_text_place > -1){
     
      if (cursor_text_place < text.length() - 1){
        text = text.substring(0, cursor_text_place) + text.substring(cursor_text_place + 1, text.length());
        cursor_text_place -= 1;
        cursor_placement[0] -= textWidth(text.charAt(cursor_text_place));
        
      }
      else if (text.length() == 1){
       text = "";
       cursor_placement[0] = 36;
       cursor_text_place -= 1;
      }
      
      else if (cursor_text_place == text.length() - 1){
        text = text.substring(0, text.length() - 1);
        cursor_text_place -= 1;
        cursor_placement[0] -= textWidth(text.charAt(cursor_text_place));
        
      }

     }
  } 
  
  // enter
  else if (key == ENTER || key == RETURN){
 
    cursor_text_place += 1;
    line ++;
    max_line ++;
    
    // if it's not the end of a line, there isn't a linebreak, and the end of a line isnt: ;, {, or }
    if (text.length() > 1 && text.charAt(cursor_text_place - 1) != '\n' && text.charAt(cursor_text_place - 1) != ';' && text.charAt(cursor_text_place - 1) != '{' && text.charAt(cursor_text_place - 1) != '}'){
      
     top_text = "missing semicolon, line " + (line - 1); 
    }
    
    if (cursor_text_place - 1 == text.length() - 1){
      text += "\n";
      
      cursor_placement[0] = 40;
      cursor_placement[1] += down * 1.51;
    }
    
    else{
      String pt1 = text.substring(0, cursor_text_place + 1);
      String pt2 = text.substring(cursor_text_place+1, text.length());
  
      text = pt1 + "\n" + pt2;
      cursor_placement[0] = 40;
      cursor_placement[1] += down * 1.51;

    }
  }
  
  else if (key == TAB){

    cursor_text_place += 4;
    
    if (cursor_text_place - 4 == text.length() - 1){
      text += "    ";
      
      cursor_placement[0] += textWidth("    ");

    }
    
    else{
      String pt1 = text.substring(0, cursor_text_place - 3);
      String pt2 = text.substring(cursor_text_place - 3, text.length());
  
      text = pt1 + "      " + pt2;
      cursor_placement[0] += textWidth("    ");

    }
  }
  
  else if (keyCode == LEFT){
    if (cursor_text_place > -1){
      
      cursor_text_place -= 1;
      if (text.charAt(cursor_text_place + 1) == '\n'){
        
        
        cursor_placement[0] += textWidth(find_nstring(0, cursor_text_place + 1));
        cursor_placement[1] -= down * 1.51;
        
      }
      else{
        
        if (!moved_one){
            cursor_placement[0] -= textWidth(text.charAt(cursor_text_place + 1)) + 1;
            moved_one = true;
          }
          
          else{
            
            cursor_placement[0] -= textWidth(text.charAt(cursor_text_place + 1));
            
          }
      }
    } 
  }
  
  else if (keyCode == RIGHT){
    if (cursor_text_place < text.length() - 1){
      
      cursor_text_place += 1;
      if (text.charAt(cursor_text_place) == '\n'){
        cursor_placement[0] = 36;
        //cursor_placement[0] += textWidth(find_nstring(0, cursor_text_place));
        cursor_placement[1] += down * 1.51;
      }
      else{
      cursor_placement[0] += textWidth(text.charAt(cursor_text_place));
      }
    } 
  }
  
  else{
    
    if (cursor_text_place == text.length() - 1){
      text += key;
      cursor_text_place += 1;
      cursor_placement[0] += textWidth(key); 
    }
    
    else{
      String pt1 = text.substring(0, cursor_text_place + 1);
      String pt2 = text.substring(cursor_text_place+1, text.length());
  
      text = pt1 + key + pt2;
      cursor_text_place += 1;
      cursor_placement[0] += textWidth(key);
   
    }
  }
  
  
}